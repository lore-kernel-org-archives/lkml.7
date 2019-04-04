Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED697C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BEF20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jDdKyJG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfDDImy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:42:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51860 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDImy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YQkG4An7S3gNP3xb4741BPQpWaI9T3KSNvtrc6UwxWI=; b=jDdKyJG1DBcpFM3jvyUtQXETM
        U7VfIArhE+dzw4NNrirKkZ2Fz1rodRby8SIUhDujxpXFeuvFuRgq9ZlfxpFxZUB5HF/629fnfTqOH
        GAZUgjXUDfc0buxNPuLkLd9CQLrnUs+0d7QtdVQ9T85Ihcg0eSlObpUvQmNWIR6nkYVOWZpUWTHL5
        so4Y8KAF70C/jSEfhJvCAXTl9YSSazWpGZLp27tTPWeR2FI1/cn4F/Ovau2n96fBPIpNohfPvqDCi
        HxZsz1VRkNdV+rhKHgUhZYXTEROjbxMNTJYSyL73a7sl13eOxH0oZL9kjN0QOOc3FbVuu8/5TUXTy
        ssPX5YgSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBxxT-0001LK-2S; Thu, 04 Apr 2019 08:42:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97ACC203C13E0; Thu,  4 Apr 2019 10:42:49 +0200 (CEST)
Date:   Thu, 4 Apr 2019 10:42:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] sched/core: expand sched_getaffinity(2) to return number
 of CPUs
Message-ID: <20190404084249.GS4038@hirez.programming.kicks-ass.net>
References: <20190403200809.GA13876@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403200809.GA13876@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:08:09PM +0300, Alexey Dobriyan wrote:
> Currently there is no easy way to get the number of CPUs on the system.

And this patch doesn't change that :-) Still, it does the right thing
and I like it.

The point is that nr_cpu_ids is the length of the bitmap, but does not
contain information on how many CPUs are in the system. Consider the
case where the bitmap is sparse.

> Applications are divided into 2 groups:
> One group allocates buffer and call sched_getaffinity(2) once. It works
> but either underallocate or overallocates and in the future such application
> will become buggy as Linux will start working on even more SMP-ier systems.
> 
> Glibc in particular shipped with 1024 CPUs support maximum at some point
> which is quite surprising as glibc maitainers should know better.
> 
> Another group dynamically grow buffer until cpumask fits. This is
> inefficient as multiple system calls are done.
> 
> Nobody seems to parse "/sys/devices/system/cpu/possible".
> Even if someone does, parsing sysfs is much slower than necessary.

True; but I suppose glibc already does lots of that anyway, right? It
does contain the right information.

> Patch overloads sched_getaffinity(len=0) to simply return "nr_cpu_ids".
> This will make gettting CPU mask require at most 2 system calls
> and will eliminate unnecessary code.
> 
> len=0 is chosen so that
> * passing zeroes is the simplest thing
> 
> 	syscall(__NR_sched_getaffinity, 0, 0, NULL)
> 
>   will simply do the right thing,
> 
> * old kernels returned -EINVAL unconditionally.
> 
> Note: glibc segfaults upon exiting from system call because it tries to
> clear the rest of the buffer if return value is positive, so
> applications will have to use syscall(3).
> Good news is that it proves noone uses sched_getaffinity(pid, 0, NULL).

This also needs a manpage update. And I'm missing the libc people on Cc.

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  kernel/sched/core.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4942,6 +4942,9 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
>  	int ret;
>  	cpumask_var_t mask;
>  
> +	if (len == 0)
> +		return nr_cpu_ids;
> +
>  	if ((len * BITS_PER_BYTE) < nr_cpu_ids)
>  		return -EINVAL;
>  	if (len & (sizeof(unsigned long)-1))
