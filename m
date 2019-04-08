Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05329C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D017120857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfDHQEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:04:40 -0400
Received: from foss.arm.com ([217.140.101.70]:51160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfDHQEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:04:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6388AA78;
        Mon,  8 Apr 2019 09:04:38 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963D83F557;
        Mon,  8 Apr 2019 09:04:36 -0700 (PDT)
Date:   Mon, 8 Apr 2019 17:04:34 +0100
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
Subject: Re: [PATCH 5/7] clocksource/arm_arch_timer: Drop use of static key
 in arch_timer_reg_read_stable
Message-ID: <20190408160433.GQ6139@lakrids.cambridge.arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-6-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408154907.223536-6-marc.zyngier@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:49:05PM +0100, Marc Zyngier wrote:
> Let's start with the removal of the arch_timer_read_ool_enabled
> static key in arch_timer_reg_read_stable. IT is not a fast path,

Nit: s/IT/It/

> and we can simplify things a bit.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/arch_timer.h | 42 +++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index c3762ffcc933..4a06d46def7e 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -77,23 +77,37 @@ struct arch_timer_erratum_workaround {
>  DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
>  		timer_unstable_counter_workaround);
>  
> +/* inline sysreg accessors that make erratum_handler() work */
> +static inline notrace u32 arch_timer_read_cntp_tval_el0(void)
> +{
> +	return read_sysreg(cntp_tval_el0);
> +}
> +
> +static inline notrace u32 arch_timer_read_cntv_tval_el0(void)
> +{
> +	return read_sysreg(cntv_tval_el0);
> +}
> +
> +static inline notrace u64 arch_timer_read_cntpct_el0(void)
> +{
> +	return read_sysreg(cntpct_el0);
> +}
> +
> +static inline notrace u64 arch_timer_read_cntvct_el0(void)
> +{
> +	return read_sysreg(cntvct_el0);
> +}
> +
>  #define arch_timer_reg_read_stable(reg)					\
> -({									\
> -	u64 _val;							\
> -	if (needs_unstable_timer_counter_workaround()) {		\
> -		const struct arch_timer_erratum_workaround *wa;		\
> +	({								\
> +		u64 _val;						\
> +									\
>  		preempt_disable_notrace();				\
> -		wa = __this_cpu_read(timer_unstable_counter_workaround); \
> -		if (wa && wa->read_##reg)				\
> -			_val = wa->read_##reg();			\
> -		else							\
> -			_val = read_sysreg(reg);			\
> +		_val = erratum_handler(read_ ## reg)();			\
>  		preempt_enable_notrace();				\
> -	} else {							\
> -		_val = read_sysreg(reg);				\
> -	}								\
> -	_val;								\
> -})
> +									\
> +		_val;							\
> +	})
>  
>  /*
>   * These register accessors are marked inline so the compiler can
> -- 
> 2.20.1
> 
