Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB5C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA87620675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfCFLF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:05:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:3696 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730281AbfCFLFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:05:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 03:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,447,1544515200"; 
   d="scan'208";a="304839021"
Received: from elena-thinkpad-x1-carbon-6th.fi.intel.com ([10.237.66.140])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2019 03:05:51 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     ebiederm@xmission.com
Cc:     serue@us.ibm.com, keescook@chromium.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 2/3] groups: convert group_info.usage to refcount_t
Date:   Wed,  6 Mar 2019 13:05:48 +0200
Message-Id: <20190306110549.7628-3-elena.reshetova@intel.com>
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

The variable group_info.usage is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in lib/refcount.c
have different memory ordering guarantees than their atomic
counterparts. Please check Documentation/core-api/refcount-vs-atomic.rst
for more information.

Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in
some rare cases it might matter.
Please double check that you don't have some undocumented
memory guarantees for this variable usage.

For the group_info.usage it might make a difference
in following places:
 - put_group_info(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and ACQUIRE ordering on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 include/linux/cred.h | 7 ++++---
 kernel/cred.c        | 2 +-
 kernel/groups.c      | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index ddd45bb74887..cad4b415ae90 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/key.h>
 #include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/uidgid.h>
 #include <linux/sched.h>
 #include <linux/sched/user.h>
@@ -27,7 +28,7 @@ struct inode;
  * COW Supplementary groups list
  */
 struct group_info {
-	atomic_t	usage;
+	refcount_t	usage;
 	int		ngroups;
 	kgid_t		gid[0];
 } __randomize_layout;
@@ -43,7 +44,7 @@ struct group_info {
  */
 static inline struct group_info *get_group_info(struct group_info *gi)
 {
-	atomic_inc(&gi->usage);
+	refcount_inc(&gi->usage);
 	return gi;
 }
 
@@ -53,7 +54,7 @@ static inline struct group_info *get_group_info(struct group_info *gi)
  */
 #define put_group_info(group_info)			\
 do {							\
-	if (atomic_dec_and_test(&(group_info)->usage))	\
+	if (refcount_dec_and_test(&(group_info)->usage))	\
 		groups_free(group_info);		\
 } while (0)
 
diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..49d23bd45a23 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -37,7 +37,7 @@ do {									\
 static struct kmem_cache *cred_jar;
 
 /* init to 2 - one for init_task, one to ensure it is never freed */
-struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
+struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
 
 /*
  * The initial credentials for the initial task
diff --git a/kernel/groups.c b/kernel/groups.c
index daae2f2dc6d4..e8194bbf0dbe 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -24,7 +24,7 @@ struct group_info *groups_alloc(int gidsetsize)
 	if (!gi)
 		return NULL;
 
-	atomic_set(&gi->usage, 1);
+	refcount_set(&gi->usage, 1);
 	gi->ngroups = gidsetsize;
 	return gi;
 }
-- 
2.17.1

