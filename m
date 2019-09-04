Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA78C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE51F2339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567593573;
	bh=Si6cPRlu49xqotJXMocb1HiIsOC8fV4BKkS9IkpmHlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cs89xeUmrs+QrNL882dAwG580y46yGzhpC5lGU3gkOUlxXUSds0A/F4LKfmua7Ppz
	 r22L09tP7AzW1Y3XyuV4vNylZzMq4WF8/2srzw3aCYgo4dFI1WwvPB2N9h/ve1YcMW
	 XnqG/eLkRtUVwHzJKJ/wOxNXVYP6wXPQElTgbmnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfIDKjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:39:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33585 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:39:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so2201181wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fqIUP2BVugkcHAJsP9k+9P/D13poZJ2MN/8RBlRpoZg=;
        b=RwR/kkdkEJ4gCMgLbhkif0Hrrm4qKi05huopwEwrplxyDTGzKY36NOoJ5Tpkgwfw/z
         uZtdHhygYzXVb9rxA6vmFslhXkk7Hw4sBVY4QIIpf4eOcnl0FJ8ql9TrEHO3bymrI5+g
         Ng/ddFBvvgUZB2xjYZA58WyFWIR0brWOo3XX7WF/N9qUQsxgIhy1DEoQSufPNIn0Hjzs
         I5Z3NklmityP24CWTSKLuoN+MCU+NKNQIz9t9pbJv9eSCfHomubjM588t9P+0Sh23na+
         8GTD+RjAc/DYS9MxdxxYgYIPR3ToMGMbwhXc1pDJzCHZ+4CYhOMClVNUzqSPnOWWA8Hv
         d30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqIUP2BVugkcHAJsP9k+9P/D13poZJ2MN/8RBlRpoZg=;
        b=uOGz3CAxE7m16RspQvgKXPmqkP9L//f8oidBXYIo3syRL5YFCwCKaDF+FTFFjmAJu4
         16C/Y/mqDYzl0XXbwP3hJkrlM9XwFIDhfZJfyhoWNu6sDivCJNit6a+zGtVbzdY+i98e
         tx5xQwtO0Sab5ODt54A0nL5H1zCgf/XIEgDYqtjEWiO0DciGGvwqzHjCw+xa9Il5dVH/
         6EF/P5TYdoETqiT35pUaTyXIPcNXbfZiJCuT4Mk9RnBxIepTOaZWmsHwAYVHfYmbbn73
         QFXIuX2UhTge3/lsfNyqMn7bWaQnXfHp9/QW+lGskYZVn0+SGTfpyqpYnv88e/xm8MCV
         /19g==
X-Gm-Message-State: APjAAAU3us0VklG8ItFKeXyBRgr6KW/1KCh8MSjb6D9q1nwMia5xYnKy
        cIPclgEgtOYBNnEInqlbMKGtMG9g
X-Google-Smtp-Source: APXvYqwLYH3HsaKCc/LSOP96konGkQPyRSu9NdEyc4QXucV6Fqp8SGQnlDDnljha+Z2JECSE0geOpA==
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr3916848wmb.95.1567593568374;
        Wed, 04 Sep 2019 03:39:28 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b26sm2841744wmj.14.2019.09.04.03.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 03:39:27 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:39:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3] sched/core: Fix uclamp ABI bug, clean up and
 robustify sched_read_attr() ABI logic and code
Message-ID: <20190904103925.GA60962@gmail.com>
References: <20190903171645.28090-1-cascardo@canonical.com>
 <20190903171645.28090-2-cascardo@canonical.com>
 <20190904075532.GA26751@gmail.com>
 <20190904084934.GA117671@gmail.com>
 <20190904085519.GA127156@gmail.com>
 <db065b81-c373-f291-ad48-f556a209cc95@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db065b81-c373-f291-ad48-f556a209cc95@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

> > -v3 attached. Build and minimally boot tested.
> > 
> > Thanks,
> > 
> > 	Ingo
> > 
> 
> This patch fixes the issue (almost).
> 
> LTP's sched_getattr01 passes again. But IMHO the prio 'chrt -p $$'
> should be 0 instead of -65536.

Yeah, I forgot to zero-initialize the structure ...

Does the attached -v4 work any better for you?

Thanks,

	Ingo

===============================>
Date: Wed, 4 Sep 2019 09:55:32 +0200
Subject: [PATCH] sched/core: Fix uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and code

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
 kernel/sched/core.c | 82 +++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 010d578118d6..3c64eb28dd70 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5105,39 +5105,44 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
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
 
-	if (!access_ok(uattr, usize))
+	if (!access_ok(uattr, ksize))
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
-
-		addr = (void *)attr + usize;
-		end  = (void *)attr + sizeof(*attr);
-
-		for (; addr < end; addr++) {
-			if (*addr)
-				return -EFBIG;
-		}
+	kattr->size = min(usize, ksize);
 
-		attr->size = usize;
-	}
-
-	ret = copy_to_user(uattr, attr, attr->size);
-	if (ret)
+	if (copy_to_user(uattr, kattr, kattr->size))
 		return -EFAULT;
 
+	printk("sched_attr_copy_to_user(): copied %d bytes. (ksize: %d, usize: %d)\n", kattr->size, ksize, usize);
+
 	return 0;
 }
 
@@ -5145,20 +5150,18 @@ static int sched_read_attr(struct sched_attr __user *uattr,
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
@@ -5171,25 +5174,24 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
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
