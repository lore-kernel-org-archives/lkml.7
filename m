Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C69C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D92206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404047AbfIEUuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:50:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfIEUt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:49:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i5yhW-0001ju-Cd; Thu, 05 Sep 2019 22:49:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D629D1C0DFA;
        Thu,  5 Sep 2019 22:49:53 +0200 (CEST)
Date:   Thu, 05 Sep 2019 20:49:53 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: refs/heads/sched/urgent] sched/core: Fix uclamp ABI bug, clean
 up and robustify sched_read_attr() ABI logic and code
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156771659375.12994.2048966043175352998.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the refs/heads/sched/urgent branch of tip:

Commit-ID:     1251201c0d34fadf69d56efa675c2b7dd0a90eca
Gitweb:        https://git.kernel.org/tip/1251201c0d34fadf69d56efa675c2b7dd0a90eca
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 04 Sep 2019 09:55:32 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Sep 2019 19:51:30 +02:00

sched/core: Fix uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and code

Thadeu Lima de Souza Cascardo reported that 'chrt' broke on recent kernels:

  $ chrt -p $$
  chrt: failed to get pid 26306's policy: Argument list too long

and he has root-caused the bug to the following commit increasing sched_attr
size and breaking sched_read_attr() into returning -EFBIG:

  a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")

The other, bigger bug is that the whole sched_getattr() and sched_read_attr()
logic of checking non-zero bits in new ABI components is arguably broken,
and pretty much any extension of the ABI will spuriously break the ABI.
That's way too fragile.

Instead implement the perf syscall's extensible ABI instead, which we
already implement on the sched_setattr() side:

 - if user-attributes have the same size as kernel attributes then the
   logic is unchanged.

 - if user-attributes are larger than the kernel knows about then simply
   skip the extra bits, but set attr->size to the (smaller) kernel size
   so that tooling can (in principle) handle older kernel as well.

 - if user-attributes are smaller than the kernel knows about then just
   copy whatever user-space can accept.

Also clean up the whole logic:

 - Simplify the code flow - there's no need for 'ret' for example.

 - Standardize on 'kattr/uattr' and 'ksize/usize' naming to make sure we
   always know which side we are dealing with.

 - Why is it called 'read' when what it does is to copy to user? This
   code is so far away from VFS read() semantics that the naming is
   actively confusing. Name it sched_attr_copy_to_user() instead, which
   mirrors other copy_to_user() functionality.

 - Move the attr->size assignment from the head of sched_getattr() to the
   sched_attr_copy_to_user() function. Nothing else within the kernel
   should care about the size of the structure.

With these fixes the sched_getattr() syscall now nicely supports an
extensible ABI in both a forward and backward compatible fashion, and
will also fix the chrt bug.

As an added bonus the bogus -EFBIG return is removed as well, which as
Thadeu noted should have been -E2BIG to begin with.

Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Acked-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
Link: https://lkml.kernel.org/r/20190904075532.GA26751@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 78 ++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 010d578..df9f1fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5105,37 +5105,40 @@ out_unlock:
 	return retval;
 }
 
-static int sched_read_attr(struct sched_attr __user *uattr,
-			   struct sched_attr *attr,
-			   unsigned int usize)
+/*
+ * Copy the kernel size attribute structure (which might be larger
+ * than what user-space knows about) to user-space.
+ *
+ * Note that all cases are valid: user-space buffer can be larger or
+ * smaller than the kernel-space buffer. The usual case is that both
+ * have the same size.
+ */
+static int
+sched_attr_copy_to_user(struct sched_attr __user *uattr,
+			struct sched_attr *kattr,
+			unsigned int usize)
 {
-	int ret;
+	unsigned int ksize = sizeof(*kattr);
 
 	if (!access_ok(uattr, usize))
 		return -EFAULT;
 
 	/*
-	 * If we're handed a smaller struct than we know of,
-	 * ensure all the unknown bits are 0 - i.e. old
-	 * user-space does not get uncomplete information.
+	 * sched_getattr() ABI forwards and backwards compatibility:
+	 *
+	 * If usize == ksize then we just copy everything to user-space and all is good.
+	 *
+	 * If usize < ksize then we only copy as much as user-space has space for,
+	 * this keeps ABI compatibility as well. We skip the rest.
+	 *
+	 * If usize > ksize then user-space is using a newer version of the ABI,
+	 * which part the kernel doesn't know about. Just ignore it - tooling can
+	 * detect the kernel's knowledge of attributes from the attr->size value
+	 * which is set to ksize in this case.
 	 */
-	if (usize < sizeof(*attr)) {
-		unsigned char *addr;
-		unsigned char *end;
+	kattr->size = min(usize, ksize);
 
-		addr = (void *)attr + usize;
-		end  = (void *)attr + sizeof(*attr);
-
-		for (; addr < end; addr++) {
-			if (*addr)
-				return -EFBIG;
-		}
-
-		attr->size = usize;
-	}
-
-	ret = copy_to_user(uattr, attr, attr->size);
-	if (ret)
+	if (copy_to_user(uattr, kattr, kattr->size))
 		return -EFAULT;
 
 	return 0;
@@ -5145,20 +5148,18 @@ static int sched_read_attr(struct sched_attr __user *uattr,
  * sys_sched_getattr - similar to sched_getparam, but with sched_attr
  * @pid: the pid in question.
  * @uattr: structure containing the extended parameters.
- * @size: sizeof(attr) for fwd/bwd comp.
+ * @usize: sizeof(attr) that user-space knows about, for forwards and backwards compatibility.
  * @flags: for future extension.
  */
 SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
-		unsigned int, size, unsigned int, flags)
+		unsigned int, usize, unsigned int, flags)
 {
-	struct sched_attr attr = {
-		.size = sizeof(struct sched_attr),
-	};
+	struct sched_attr kattr = { };
 	struct task_struct *p;
 	int retval;
 
-	if (!uattr || pid < 0 || size > PAGE_SIZE ||
-	    size < SCHED_ATTR_SIZE_VER0 || flags)
+	if (!uattr || pid < 0 || usize > PAGE_SIZE ||
+	    usize < SCHED_ATTR_SIZE_VER0 || flags)
 		return -EINVAL;
 
 	rcu_read_lock();
@@ -5171,25 +5172,24 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	if (retval)
 		goto out_unlock;
 
-	attr.sched_policy = p->policy;
+	kattr.sched_policy = p->policy;
 	if (p->sched_reset_on_fork)
-		attr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
+		kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
 	if (task_has_dl_policy(p))
-		__getparam_dl(p, &attr);
+		__getparam_dl(p, &kattr);
 	else if (task_has_rt_policy(p))
-		attr.sched_priority = p->rt_priority;
+		kattr.sched_priority = p->rt_priority;
 	else
-		attr.sched_nice = task_nice(p);
+		kattr.sched_nice = task_nice(p);
 
 #ifdef CONFIG_UCLAMP_TASK
-	attr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
-	attr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
+	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
+	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
 #endif
 
 	rcu_read_unlock();
 
-	retval = sched_read_attr(uattr, &attr, size);
-	return retval;
+	return sched_attr_copy_to_user(uattr, &kattr, usize);
 
 out_unlock:
 	rcu_read_unlock();
