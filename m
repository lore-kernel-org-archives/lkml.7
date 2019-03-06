Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D8C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9991B20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfCFLGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:06:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:3696 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730287AbfCFLF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:05:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 03:05:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,447,1544515200"; 
   d="scan'208";a="304839037"
Received: from elena-thinkpad-x1-carbon-6th.fi.intel.com ([10.237.66.140])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2019 03:05:54 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     ebiederm@xmission.com
Cc:     serue@us.ibm.com, keescook@chromium.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 3/3] creds: convert cred.usage to refcount_t
Date:   Wed,  6 Mar 2019 13:05:49 +0200
Message-Id: <20190306110549.7628-4-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190306110549.7628-1-elena.reshetova@intel.com>
References: <20190306110549.7628-1-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_t variables are currently used to implement reference
counters with the following properties:
 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows
and underflows. This is important since overflows and underflows
can lead to use-after-free situation and be exploitable.

The variable cred.usage is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in lib/refcount.c
have different memory ordering guarantees than their atomic
counterparts.Please check Documentation/core-api/refcount-vs-atomic.rst
for more information.

Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in
some rare cases it might matter.
Please double check that you don't have some undocumented
memory guarantees for this variable usage.

For the cred.usage it might make a difference
in following places:
 - get_task_cred(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart
 - put_cred(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and ACQUIRE ordering on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 include/linux/cred.h |  8 ++++----
 kernel/cred.c        | 42 +++++++++++++++++++++---------------------
 net/sunrpc/auth.c    |  2 +-
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index cad4b415ae90..ee993333a39e 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -114,7 +114,7 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
  * same context as task->real_cred.
  */
 struct cred {
-	atomic_t	usage;
+	refcount_t	usage;
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	atomic_t	subscribers;	/* number of processes subscribed */
 	void		*put_addr;
@@ -228,7 +228,7 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  */
 static inline struct cred *get_new_cred(struct cred *cred)
 {
-	atomic_inc(&cred->usage);
+	refcount_inc(&cred->usage);
 	return cred;
 }
 
@@ -259,7 +259,7 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return NULL;
-	if (!atomic_inc_not_zero(&nonconst_cred->usage))
+	if (!refcount_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
 	validate_creds(cred);
 	return cred;
@@ -282,7 +282,7 @@ static inline void put_cred(const struct cred *_cred)
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_dec_and_test(&(cred)->usage))
+		if (refcount_dec_and_test(&(cred)->usage))
 			__put_cred(cred);
 	}
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 49d23bd45a23..ceb2f8a2399e 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -43,7 +43,7 @@ struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
  * The initial credentials for the initial task
  */
 struct cred init_cred = {
-	.usage			= ATOMIC_INIT(4),
+	.usage			= REFCOUNT_INIT(4),
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	.subscribers		= ATOMIC_INIT(2),
 	.magic			= CRED_MAGIC,
@@ -102,17 +102,17 @@ static void put_cred_rcu(struct rcu_head *rcu)
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	if (cred->magic != CRED_MAGIC_DEAD ||
-	    atomic_read(&cred->usage) != 0 ||
+	    refcount_read(&cred->usage) != 0 ||
 	    read_cred_subscribers(cred) != 0)
 		panic("CRED: put_cred_rcu() sees %p with"
 		      " mag %x, put %p, usage %d, subscr %d\n",
 		      cred, cred->magic, cred->put_addr,
-		      atomic_read(&cred->usage),
+		      refcount_read(&cred->usage),
 		      read_cred_subscribers(cred));
 #else
-	if (atomic_read(&cred->usage) != 0)
+	if (refcount_read(&cred->usage) != 0)
 		panic("CRED: put_cred_rcu() sees %p with usage %d\n",
-		      cred, atomic_read(&cred->usage));
+		      cred, refcount_read(&cred->usage));
 #endif
 
 	security_cred_free(cred);
@@ -136,10 +136,10 @@ static void put_cred_rcu(struct rcu_head *rcu)
 void __put_cred(struct cred *cred)
 {
 	kdebug("__put_cred(%p{%d,%d})", cred,
-	       atomic_read(&cred->usage),
+	       refcount_read(&cred->usage),
 	       read_cred_subscribers(cred));
 
-	BUG_ON(atomic_read(&cred->usage) != 0);
+	BUG_ON(refcount_read(&cred->usage) != 0);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(cred) != 0);
 	cred->magic = CRED_MAGIC_DEAD;
@@ -160,7 +160,7 @@ void exit_creds(struct task_struct *tsk)
 	struct cred *cred;
 
 	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	       refcount_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	cred = (struct cred *) tsk->real_cred;
@@ -214,7 +214,7 @@ struct cred *cred_alloc_blank(void)
 	if (!new)
 		return NULL;
 
-	atomic_set(&new->usage, 1);
+	refcount_set(&new->usage, 1);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	new->magic = CRED_MAGIC;
 #endif
@@ -260,7 +260,7 @@ struct cred *prepare_creds(void)
 	old = task->cred;
 	memcpy(new, old, sizeof(struct cred));
 
-	atomic_set(&new->usage, 1);
+	refcount_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_group_info(new->group_info);
 	get_uid(new->user);
@@ -337,7 +337,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		get_cred(p->cred);
 		alter_cred_subscribers(p->cred, 2);
 		kdebug("share_creds(%p{%d,%d})",
-		       p->cred, atomic_read(&p->cred->usage),
+		       p->cred, refcount_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
 		atomic_inc(&p->cred->user->processes);
 		return 0;
@@ -428,7 +428,7 @@ int commit_creds(struct cred *new)
 	const struct cred *old = task->real_cred;
 
 	kdebug("commit_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	       refcount_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	BUG_ON(task->cred != old);
@@ -437,7 +437,7 @@ int commit_creds(struct cred *new)
 	validate_creds(old);
 	validate_creds(new);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(refcount_read(&new->usage) < 1);
 
 	get_cred(new); /* we will require a ref for the subj creds too */
 
@@ -502,13 +502,13 @@ EXPORT_SYMBOL(commit_creds);
 void abort_creds(struct cred *new)
 {
 	kdebug("abort_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	       refcount_read(&new->usage),
 	       read_cred_subscribers(new));
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(new) != 0);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(refcount_read(&new->usage) < 1);
 	put_cred(new);
 }
 EXPORT_SYMBOL(abort_creds);
@@ -525,7 +525,7 @@ const struct cred *override_creds(const struct cred *new)
 	const struct cred *old = current->cred;
 
 	kdebug("override_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	       refcount_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	validate_creds(old);
@@ -536,7 +536,7 @@ const struct cred *override_creds(const struct cred *new)
 	alter_cred_subscribers(old, -1);
 
 	kdebug("override_creds() = %p{%d,%d}", old,
-	       atomic_read(&old->usage),
+	       refcount_read(&old->usage),
 	       read_cred_subscribers(old));
 	return old;
 }
@@ -554,7 +554,7 @@ void revert_creds(const struct cred *old)
 	const struct cred *override = current->cred;
 
 	kdebug("revert_creds(%p{%d,%d})", old,
-	       atomic_read(&old->usage),
+	       refcount_read(&old->usage),
 	       read_cred_subscribers(old));
 
 	validate_creds(old);
@@ -667,7 +667,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 	validate_creds(old);
 
 	*new = *old;
-	atomic_set(&new->usage, 1);
+	refcount_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_uid(new->user);
 	get_user_ns(new->user_ns);
@@ -778,7 +778,7 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
 	printk(KERN_ERR "CRED: ->magic=%x, put_addr=%p\n",
 	       cred->magic, cred->put_addr);
 	printk(KERN_ERR "CRED: ->usage=%d, subscr=%d\n",
-	       atomic_read(&cred->usage),
+	       refcount_read(&cred->usage),
 	       read_cred_subscribers(cred));
 	printk(KERN_ERR "CRED: ->*uid = { %d,%d,%d,%d }\n",
 		from_kuid_munged(&init_user_ns, cred->uid),
@@ -852,7 +852,7 @@ void validate_creds_for_do_exit(struct task_struct *tsk)
 {
 	kdebug("validate_creds_for_do_exit(%p,%p{%d,%d})",
 	       tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	       refcount_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	__validate_process_creds(tsk, __FILE__, __LINE__);
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index e7861026b9e5..9538bd5c87af 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -38,7 +38,7 @@ static LIST_HEAD(cred_unused);
 static unsigned long number_cred_unused;
 
 static struct cred machine_cred = {
-	.usage = ATOMIC_INIT(1),
+	.usage = REFCOUNT_INIT(1),
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	.magic = CRED_MAGIC,
 #endif
-- 
2.17.1

