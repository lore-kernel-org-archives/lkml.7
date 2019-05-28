Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771B12070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfE1K6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:58:09 -0400
Received: from foss.arm.com ([217.140.101.70]:55144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfE1K6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:58:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 617C2341;
        Tue, 28 May 2019 03:58:08 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9662E3F59C;
        Tue, 28 May 2019 03:58:07 -0700 (PDT)
Subject: Re: [PATCH RESEND 1/7] sched/core: Fix preempt_schedule() interrupt
 return comment
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
References: <20190528104848.13160-1-valentin.schneider@arm.com>
 <20190528104848.13160-2-valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <73f842f0-b07f-9a6b-cd23-ca3eafad7245@arm.com>
Date:   Tue, 28 May 2019 11:58:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528104848.13160-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duh, forgot to cc the relevant folks on this one...

On 28/05/2019 11:48, Valentin Schneider wrote:
> preempt_schedule_irq() is the one that should be called on return from
> interrupt, clean up the comment to avoid any ambiguity.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 874c427742a9..55ebc2cfb08c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3600,9 +3600,8 @@ static void __sched notrace preempt_schedule_common(void)
>  
>  #ifdef CONFIG_PREEMPT
>  /*
> - * this is the entry point to schedule() from in-kernel preemption
> - * off of preempt_enable. Kernel preemptions off return from interrupt
> - * occur there and call schedule directly.
> + * This is the entry point to schedule() from in-kernel preemption
> + * off of preempt_enable.
>   */
>  asmlinkage __visible void __sched notrace preempt_schedule(void)
>  {
> @@ -3673,7 +3672,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
>  #endif /* CONFIG_PREEMPT */
>  
>  /*
> - * this is the entry point to schedule() from kernel preemption
> + * This is the entry point to schedule() from kernel preemption
>   * off of irq context.
>   * Note, that this is called and return with irqs disabled. This will
>   * protect us against recursive calling from irq.
> 
