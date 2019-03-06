Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23651C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F293F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfCFLFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:05:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:3696 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfCFLFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:05:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 03:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,447,1544515200"; 
   d="scan'208";a="304839012"
Received: from elena-thinkpad-x1-carbon-6th.fi.intel.com ([10.237.66.140])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2019 03:05:48 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     ebiederm@xmission.com
Cc:     serue@us.ibm.com, keescook@chromium.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 1/3] nsproxy: convert nsproxy.count to refcount_t
Date:   Wed,  6 Mar 2019 13:05:47 +0200
Message-Id: <20190306110549.7628-2-elena.reshetova@intel.com>
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

The variable nsproxy.count is used as pure reference counter.
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

For the nsproxy.count it might make a difference
in following places:
 - put_nsproxy() and switch_task_namespaces(): decrement in
   refcount_dec_and_test() only provides RELEASE ordering
   and ACQUIRE ordering on success vs. fully ordered
   atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 include/linux/nsproxy.h | 6 +++---
 kernel/nsproxy.c        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 2ae1b1a4d84d..90f09ffca20f 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -29,7 +29,7 @@ struct fs_struct;
  * nsproxy is copied.
  */
 struct nsproxy {
-	atomic_t count;
+	refcount_t count;
 	struct uts_namespace *uts_ns;
 	struct ipc_namespace *ipc_ns;
 	struct mnt_namespace *mnt_ns;
@@ -75,14 +75,14 @@ int __init nsproxy_cache_init(void);
 
 static inline void put_nsproxy(struct nsproxy *ns)
 {
-	if (atomic_dec_and_test(&ns->count)) {
+	if (refcount_dec_and_test(&ns->count)) {
 		free_nsproxy(ns);
 	}
 }
 
 static inline void get_nsproxy(struct nsproxy *ns)
 {
-	atomic_inc(&ns->count);
+	refcount_inc(&ns->count);
 }
 
 #endif
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index f6c5d330059a..5bfe69194621 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -31,7 +31,7 @@
 static struct kmem_cache *nsproxy_cachep;
 
 struct nsproxy init_nsproxy = {
-	.count			= ATOMIC_INIT(1),
+	.count			= REFCOUNT_INIT(1),
 	.uts_ns			= &init_uts_ns,
 #if defined(CONFIG_POSIX_MQUEUE) || defined(CONFIG_SYSVIPC)
 	.ipc_ns			= &init_ipc_ns,
@@ -52,7 +52,7 @@ static inline struct nsproxy *create_nsproxy(void)
 
 	nsproxy = kmem_cache_alloc(nsproxy_cachep, GFP_KERNEL);
 	if (nsproxy)
-		atomic_set(&nsproxy->count, 1);
+		refcount_set(&nsproxy->count, 1);
 	return nsproxy;
 }
 
@@ -225,7 +225,7 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 	p->nsproxy = new;
 	task_unlock(p);
 
-	if (ns && atomic_dec_and_test(&ns->count))
+	if (ns && refcount_dec_and_test(&ns->count))
 		free_nsproxy(ns);
 }
 
-- 
2.17.1

