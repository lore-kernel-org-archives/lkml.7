Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B7FC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D31820644
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567670579;
	bh=QIAgEuIBQ3OvxSe936atZZLRiS/nbTqydudBXSqG+P8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=AXSYhES/5niyJkzEP8KRdwYagzI5KMMRq2fHwI4b2HZs/T0KelozI4MV5/YEg0Ydt
	 h3rxMTR4kSEiIV7ktGrtizQfBGSFT3Vp5/XhU5NmxS1W9HCFYT15WpJChxqDM48MjX
	 eCFaw+Wn9HyZQXndOgPTVc4AWFYtND04c+pCe+iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbfIEIC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:02:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34444 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbfIEIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:02:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so1559532wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KTMu4sgp4IJ7z/OBVb6oDPkuPfLxATgI0yqleY5JjgI=;
        b=lyJfOPaphG4KaTM6fm8grxBAPnc0WcT0263MldHj0M4dPEYGTwA8TlLU/oX80+CZKO
         C3o3Y9vq0ZtjCVpzqWyBpXuEasnMEKc/wLMEMpCKmk4RV3tuwYZGDcPNyQx8Gzt/7/Aw
         oEdO7CPD+q+geH4omGvNrpjl8gTpUuzgwmXsHk0TSfoyGp1+jRNbOYvIUn2eWGe+VGMp
         bysPuuq0shvXrK3DnVl0uKrq1sMT6QhOf00UVJLTw0toxiqOHw7DhM66fIzh7H3sHNaZ
         rDGbN59LJ6wCqcjs6XvxvK5K5R85N18VSJVeM4/lrgCnQksSLPg/aGo4yKREIcTlep4q
         xFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=KTMu4sgp4IJ7z/OBVb6oDPkuPfLxATgI0yqleY5JjgI=;
        b=eCR/8j5uyrmZFkARMWsH57LN2qAwM7zvvyymjaMI5wJTTnOPt3FG0ePBwPvDxdMCUc
         GdV6gN1EDo/wH3ldvsVoMGp3DVYmQOexdAiKTigv36L5Wscz+7yPuUeEHk2ZH03XsM5x
         KSH62DMj7edxvIVAx5at7B5g/lSlE+QNGxpYKMVfHahF1Uahp5QFj0MYjwYWzm+i6pGL
         IExpXswxVqAHhKx6aRKa8Tnt6bslFOpwEqoXbIoaoQDrpLQG0P9ci98cgNL+G5Lfo4iH
         PPRt8Fm8S2A3I7nsz9C08CAYtN9tCw1TTIVtrP6krNl0IKG8z4afXmszuTcIwzS5tMHO
         zNlQ==
X-Gm-Message-State: APjAAAX488SbBDoq0ZwuDeZ4qOdfGZaBIMYL7XoL1cVMsQO1CuUQbHSO
        SWjpKx5U52dQ0BoruKB3FWI=
X-Google-Smtp-Source: APXvYqwTO0/epSPGoTiureef5Ae732JI2dPkYJYgNrWyK3TzNnakOn5CD1DnNq81+s6ZpWhhQfcwfQ==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr1514983wrn.307.1567670575091;
        Thu, 05 Sep 2019 01:02:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q192sm1932087wme.23.2019.09.05.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 01:02:54 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:02:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20190905080252.GA46303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 1251201c0d34fadf69d56efa675c2b7dd0a90eca sched/core: Fix uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and code

This fixes an ABI bug introduced this cycle, plus fixes a throttling bug.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      sched/core: Fix uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and code

Liangyan (1):
      sched/fair: Don't assign runtime for throttled cfs_rq


 kernel/sched/core.c | 78 ++++++++++++++++++++++++++---------------------------
 kernel/sched/fair.c |  5 ++++
 2 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 010d578118d6..df9f1fe5689b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5105,37 +5105,40 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9cfeaac8bd..500f5db0de0b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4470,6 +4470,8 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	if (likely(cfs_rq->runtime_remaining > 0))
 		return;
 
+	if (cfs_rq->throttled)
+		return;
 	/*
 	 * if we're unable to extend our runtime we resched so that the active
 	 * hierarchy can be throttled
@@ -4673,6 +4675,9 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
+		/* By the above check, this should never be true */
+		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
+
 		runtime = -cfs_rq->runtime_remaining + 1;
 		if (runtime > remaining)
 			runtime = remaining;
