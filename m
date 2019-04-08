Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F90C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF6F20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfDHP74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:59:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50960 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfDHP74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:59:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4A7315AB;
        Mon,  8 Apr 2019 08:59:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13AE83F557;
        Mon,  8 Apr 2019 08:59:53 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:59:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 3/7] arm64: Use arch_timer_read_counter instead of
 arch_counter_get_cntvct
Message-ID: <20190408155951.GO6139@lakrids.cambridge.arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-4-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408154907.223536-4-marc.zyngier@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:49:03PM +0100, Marc Zyngier wrote:
> Only arch_timer_read_counter will guarantee that workarounds are
> applied. So let's use this one instead of arch_counter_get_cntvct.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 8ad119c3f665..6190a60388cf 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -493,7 +493,7 @@ static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
>  {
>  	int rt = ESR_ELx_SYS64_ISS_RT(esr);
>  
> -	pt_regs_write_reg(regs, rt, arch_counter_get_cntvct());
> +	pt_regs_write_reg(regs, rt, arch_timer_read_counter());
>  	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
>  }
>  
> @@ -665,7 +665,7 @@ static void compat_cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
>  {
>  	int rt = (esr & ESR_ELx_CP15_64_ISS_RT_MASK) >> ESR_ELx_CP15_64_ISS_RT_SHIFT;
>  	int rt2 = (esr & ESR_ELx_CP15_64_ISS_RT2_MASK) >> ESR_ELx_CP15_64_ISS_RT2_SHIFT;
> -	u64 val = arch_counter_get_cntvct();
> +	u64 val = arch_timer_read_counter();
>  
>  	pt_regs_write_reg(regs, rt, lower_32_bits(val));
>  	pt_regs_write_reg(regs, rt2, upper_32_bits(val));
> -- 
> 2.20.1
> 
