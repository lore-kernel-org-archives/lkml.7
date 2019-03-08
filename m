Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DFD20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hIH4dJUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCHIjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:39:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHIjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u/uytGJIoZ1pDgJLD6BeysxYDLMjvKeAnFkPwxGb0KM=; b=hIH4dJUZrL28NNUrV6uxLRLM4
        UxDNiQACFIoYfMvG7RxyleCgL+t6rex+mFhHN8WYIuVe0BociCXQDEJyjdx3ovxKgEiQviPoPqcog
        cQM6DdnIDXfW2b5rj2jP9EZ8pWlecicOWC+ZEvu7dJf/+7qImUEONYGXMjpHHXgFvQIyS5tErT4Zg
        gxTzgoiiCz/S5lFqrenRrgKXsw+37XJPgFrw/3kUmEOaQIaRvxd+JjMDDcVA6ml0hGuVI4MWL//CV
        pzI+RuXWpIXp5HEuuroQbD+NbtL013lW/pJrET6ZvIJrLnTzbo8coAq65YuiCL1fc2Jhh/0Se9pWE
        9+ec8Vx4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2B2Q-0008Ck-8e; Fri, 08 Mar 2019 08:39:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE00020262FAE; Fri,  8 Mar 2019 09:39:28 +0100 (CET)
Date:   Fri, 8 Mar 2019 09:39:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARCv2: spinlock: remove the extra smp_mb before lock,
 after unlock
Message-ID: <20190308083928.GQ32477@hirez.programming.kicks-ass.net>
References: <1552008946-8008-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552008946-8008-1-git-send-email-vgupta@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:35:46PM -0800, Vineet Gupta wrote:
>  - ARCv2 LLSC based spinlocks smp_mb() both before and after the LLSC
>    instructions, which is not required per lkmm ACQ/REL semantics.
>    smp_mb() is only needed _after_ lock and _before_ unlock.
>    So remove the extra barriers.
>    The reason they were there was mainly historical. At the time of
>    initial SMP Linux bringup on HS38 cores, I was too conservative,
>    given the fluidity of both hw and sw. The last attempt to ditch the
>    extra barrier showed some hackbench regression which is apparently
>    not the case now (atleast for LLSC case, read on...)
> 
>  - EX based spinlocks (!CONFIG_ARC_HAS_LLSC) still needs the extra
>    smp_mb(), not due to lkmm, but due to some hardware shenanigans.
>    W/o that, hackbench triggers RCU stall splat. This is not a "real"
>    Linux use case anyways so I'm not worried about it.
> 
>    | [ARCLinux]# for i in (seq 1 1 5) ; do hackbench; done
>    | Running with 10 groups 400 process
>    | INFO: task hackbench:158 blocked for more than 10 seconds.
>    |       Not tainted 4.20.0-00005-g96b18288a88e-dirty #117
>    | "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    | hackbench       D    0   158    135 0x00000000
>    |
>    | Stack Trace:
>    | watchdog: BUG: soft lockup - CPU#3 stuck for 59s! [hackbench:469]
>    | Modules linked in:
>    | Path: (null)
>    | CPU: 3 PID: 469 Comm: hackbench Not tainted 4.20.0-00005-g96b18288a88e-dirty
>    |
>    | [ECR   ]: 0x00000000 => Check Programmer's Manual
>    | [EFA   ]: 0x00000000
>    | [BLINK ]: do_exit+0x4a6/0x7d0
>    | [ERET  ]: _raw_write_unlock_irq+0x44/0x5c
> 
>  - And while at it, remove the extar smp_mb() from EX based
>    arch_read_trylock() since the spin lock there guarantees a full
>    barrier anyways
> 
>  - For LLSC case, hackbench threads improves with this patch (HAPS @ 50MHz)
> 
>    ---- before ----
>    |
>    | [ARCLinux]# for i in 1 2 3 4 5; do hackbench 10 thread; done
>    | Running with 10 groups 400 threads
>    | Time: 16.253
>    | Time: 16.445
>    | Time: 16.590
>    | Time: 16.721
>    | Time: 16.544
> 
>    ---- after ----
>    |
>    | [ARCLinux]# for i in 1 2 3 4 5; do hackbench 10 thread; done
>    | Running with 10 groups 400 threads
>    | Time: 15.638
>    | Time: 15.730
>    | Time: 15.870
>    | Time: 15.842
>    | Time: 15.729
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
