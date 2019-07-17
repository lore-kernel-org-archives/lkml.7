Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2FCC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FE520818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGQJyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:54:16 -0400
Received: from foss.arm.com ([217.140.110.172]:45242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQJyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:54:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A16CC28;
        Wed, 17 Jul 2019 02:54:15 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9483A3F71A;
        Wed, 17 Jul 2019 02:54:14 -0700 (PDT)
Subject: Re: [PATCH] arm64: Avoid pointless schedule_preempt_irq() invocations
To:     Thomas Gleixner <tglx@linutronix.de>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <alpine.DEB.2.21.1907171036490.1767@nanos.tec.linutronix.de>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e47e8298-af21-64fa-eac3-6fdfbf11c502@arm.com>
Date:   Wed, 17 Jul 2019 10:54:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907171036490.1767@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2019 09:43, Thomas Gleixner wrote:
> When preempt_count is zero on return from interrupt then
> schedule_preempt_irq() is invoked even if TIF_NEED_RESCHED is not set.
> 
> That does not make sense because schedule_preempt_irq() has to go through a
> full __schedule() for nothing in that case.
> 
> Check TIF_NEED_RESCHED and invoke schedule_preempt_irq() only if set.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Don't we have NEED_RESCHED squashed into preempt count?

  396244692232 ("arm64: preempt: Provide our own implementation of asm/preempt.h")

So the existing check should cover that, unless I'm missing something?

> ---
> Found while staring at some RT wrecakge in that area.
> ---
>  arch/arm64/kernel/entry.S |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -680,6 +680,10 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKIN
>  	orr	x24, x24, x0
>  alternative_else_nop_endif
>  	cbnz	x24, 1f				// preempt count != 0 || NMI return path
> +
> +	ldr	x0, [tsk, #TSK_TI_FLAGS]        // get flags
> +	tbz	x0, #TIF_NEED_RESCHED, 1f      	// needs rescheduling?
> +
>  	bl	preempt_schedule_irq		// irq en/disable is done inside
>  1:
>  #endif
> 
