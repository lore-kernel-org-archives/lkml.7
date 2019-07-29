Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5B9C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC8B206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfG2Iao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:30:44 -0400
Received: from foss.arm.com ([217.140.110.172]:39876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfG2Ian (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:30:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EF77337;
        Mon, 29 Jul 2019 01:30:42 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62643F575;
        Mon, 29 Jul 2019 01:30:41 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:30:39 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     tglx@linutronix.de, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Remove the unused schedule_user() function
Message-ID: <20190729083039.kwamco7q6glsoo6e@e107158-lin.cambridge.arm.com>
References: <20190727165513.25636-1-devel@etsukata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727165513.25636-1-devel@etsukata.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/19 01:55, Eiichi Tsukata wrote:
> Since commit 02bc7768fe44 ("x86/asm/entry/64: Migrate error and IRQ exit
> work to C and remove old assembly code"), it's no longer used.

It seems to me that powerpc and sparc are still using it?

$ git grep SCHEDULE_USER
arch/powerpc/include/asm/context_tracking.h:#define SCHEDULE_USER bl    schedule_user
arch/powerpc/include/asm/context_tracking.h:#define SCHEDULE_USER bl    schedule
arch/powerpc/kernel/entry_64.S: SCHEDULE_USER
arch/sparc/kernel/rtrap_64.S:# define SCHEDULE_USER schedule_user
arch/sparc/kernel/rtrap_64.S:# define SCHEDULE_USER schedule
arch/sparc/kernel/rtrap_64.S:           call                    SCHEDULE_USER

Cheers

--
Qais Yousef

> 
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
> ---
>  kernel/sched/core.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2b037f195473..0079bebe0086 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3973,25 +3973,6 @@ void __sched schedule_idle(void)
>  	} while (need_resched());
>  }
>  
> -#ifdef CONFIG_CONTEXT_TRACKING
> -asmlinkage __visible void __sched schedule_user(void)
> -{
> -	/*
> -	 * If we come here after a random call to set_need_resched(),
> -	 * or we have been woken up remotely but the IPI has not yet arrived,
> -	 * we haven't yet exited the RCU idle mode. Do it here manually until
> -	 * we find a better solution.
> -	 *
> -	 * NB: There are buggy callers of this function.  Ideally we
> -	 * should warn if prev_state != CONTEXT_USER, but that will trigger
> -	 * too frequently to make sense yet.
> -	 */
> -	enum ctx_state prev_state = exception_enter();
> -	schedule();
> -	exception_exit(prev_state);
> -}
> -#endif
> -
>  /**
>   * schedule_preempt_disabled - called with preemption disabled
>   *
> -- 
> 2.21.0
> 
