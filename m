Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86752C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C96222DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567583739;
	bh=c0+JGTnFmJ1feXS1c2I0pV2LXNexoEBwbvnAohZcxAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lVYMxtFezMSLLkJIZmvrUAmNBVYuFdXS/CZJ2vmA4eQYkif0LvKmovD1dWtJ6MkYC
	 Cza+rjjFPkwvnI+t8UnWhUOnri1ph7+4Xq/I61oCJkAFf4cScdL4WPOnKchpR3pj0G
	 G3edSjRqnW1GcI1QA80L+t6Pg1nru0jbhT65yHog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfIDHzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:55:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41400 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfIDHzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:55:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so20117809wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bGC4vy9qwOG0kdz868DLU/bUuZ0P+dFsEcUWOjjDq5E=;
        b=aPD7E0fWFoD0Re5MUDQ9jsMFsd9e57fapMHTHSO28IvivLwfqKZgJiXS3kgMoi9G0n
         DeOE/d720ORx6f6gobO9KhoU+83SBQp68oKxUlcQDyYWDvi5dvmZvWQpPOp3NeNlnGgj
         QSGBzUYsaNdl0L2AfBjkmF0UzbUvKEzJQoR7je6fB6/7kj0pSodNiDSXQOQdtvYqaNmS
         4V5POC+yOUfdexNatq1pvkyeM2N299PM8nPYsfDWr4RTLgbwJHO0g0fVhsmW66sZ+jD2
         iyo6khaDxx3p8bzozlQXMmDzuwXno+eXSH+oL8yjYR1QL0KaoOSiCbZjxZdi9+h7wOw7
         AEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bGC4vy9qwOG0kdz868DLU/bUuZ0P+dFsEcUWOjjDq5E=;
        b=iTpn47h10QN5UU1p11jDRLAS4wLGpV3jhia6xdOIdcefgvbeqc2ZNUUSKCUPlv6EdX
         PYXj0cdGFRy2PdEtLc9edorjXOT6o0YzcztY9+eOxhKtSRLXVwXuO53pLXWk+J6Ld9NW
         XcfXUZrWG3ld5FWFHI4MxqfL7ZV6jXn/9X8BFv15j/rddgJVw2e46tWQomAn2xE5eb+r
         tUxCnGtk+vQg/9gtOfzO0XuNKB+xwiFZ53Uzo9UJTmntuHr8W0htpJAiXbNkgwZTZYNv
         FywZmTtWYepSjnq1ynjespG3pgIccwnduiQnkPOFGq2nxfCAFdg41cvNvXUHH+aYaH0s
         JTvw==
X-Gm-Message-State: APjAAAU7wqkhsQJQAxkbn7Sk77Yw4KoMXCWsqmC2dDNDn3y6vNSj7pAe
        KFBXSK2Xk69e4MEUD4XxI16iISgC
X-Google-Smtp-Source: APXvYqztnhOV0ocxeVA01qZrdCTMxijSXjolIL7dhbVYy4nuQ1hZrb3Q6vuB5AH7MoYCEDgvQR/cKA==
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr45864581wrg.325.1567583735317;
        Wed, 04 Sep 2019 00:55:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z5sm19191386wrl.33.2019.09.04.00.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 00:55:34 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:55:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] sched/core: Fix uclamp ABI bug, clean up and robustify
 sched_read_attr() ABI logic and code
Message-ID: <20190904075532.GA26751@gmail.com>
References: <20190903171645.28090-1-cascardo@canonical.com>
 <20190903171645.28090-2-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903171645.28090-2-cascardo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:

> After commit a509a7cd7974 (sched/uclamp: Extend sched_setattr() to support
> utilization clamping), using sched_getattr with size 48 will return E2BIG.
> 
> This breaks, for example, chrt.
> $ chrt -p $$
> chrt: failed to get pid 26306's policy: Argument list too long
> $
> 
> With this fix, when using the old size, the utilization clamping values will be
> absent from sched_attr. When using the new size or some larger size, they will
> be present.
> 
> After the fix, chrt works again.
> $ chrt -p $$
> pid 4649's current scheduling policy: SCHED_OTHER
> pid 4649's current scheduling priority: 0
> $
> 
> The drawback with this solution is that userspace will ignore there are
> non-default utilization clamps, but it's arguable whether returning E2BIG in
> this case makes sense when that same userspace doesn't know about those values
> anyway.

a509a7cd7974 breaks the ABI when CONFIG_UCLAMP_TASK=y, so there's really 
no choice here but to fix it.

But this is not the right fix:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5183,8 +5183,10 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  		attr.sched_nice = task_nice(p);
>  
>  #ifdef CONFIG_UCLAMP_TASK
> -	attr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
> -	attr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
> +	if (size >= SCHED_ATTR_SIZE_VER1) {
> +		attr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
> +		attr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
> +	}
>  #endif

The real bug is that the whole sched_read_attr() logic of checking 
non-zero bits in new ABI components is arguably broken, and pretty much 
any extension of the ABI will spuriously break the ABI as you just found 
out. That's way too fragile.

Instead how about something like the patch below? It cleans up the ABI 
logic:

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

With this patch I believe the sched_getattr() syscall now nicely supports 
an extensible ABI in both a forward and backward compatible fashion, and 
will also fix the bug.

As an added bonus the bogus -EFBIG return is removed as well.

This needs to be fixed before v5.3 is released.

NOTE: one additional open question is whether to set attr->size to the 
      *larger* value if the kernel has a newer ABI. This would allow 
      user-space to detect a new ABI.

I've also Cc:-ed perf tooling ABI experts, which handles things in a 
similar fashion. (And if it doesn't or shouldn't then please chime in.)

Thanks,

	Ingo

------
Subject: sched/core: Fix uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and code
From: Ingo Molnar <mingo@kernel.org>
Date: Sat Aug 24 17:41:57 CEST 2019

Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c |   80 ++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

Index: linux/kernel/sched/core.c
===================================================================
--- linux.orig/kernel/sched/core.c
+++ linux/kernel/sched/core.c
@@ -5299,37 +5299,40 @@ out_unlock:
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
+	if (!access_ok(uattr, max(usize, ksize)))
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
-
-		attr->size = usize;
-	}
+	kattr->size = min(usize, ksize);
 
-	ret = copy_to_user(uattr, attr, attr->size);
-	if (ret)
+	if (copy_to_user(uattr, kattr, kattr->size))
 		return -EFAULT;
 
 	return 0;
@@ -5339,20 +5342,18 @@ static int sched_read_attr(struct sched_
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
+	struct sched_attr kattr;
 	struct task_struct *p;
 	int retval;
 
-	if (!uattr || pid < 0 || size > PAGE_SIZE ||
-	    size < SCHED_ATTR_SIZE_VER0 || flags)
+	if (!uattr || pid < 0 || usize > PAGE_SIZE ||
+	    usize < SCHED_ATTR_SIZE_VER0 || flags)
 		return -EINVAL;
 
 	rcu_read_lock();
@@ -5365,25 +5366,24 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pi
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
