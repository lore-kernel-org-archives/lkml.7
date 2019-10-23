Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5441DCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5BE20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571826478;
	bh=7HIEdTMx0jnSUwqutjIsDTh2T/G2sB7CaCBFg0yG5qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u2IrkBZngtlUTWfQZqRSo0F0i1mhOVL52GjXD+IyL09pVEDKqlEZ/sVvdcAiJH0P6
	 sYyRTp5/38R3JPKVOqUf5G1e+PpAy+mSxlD+DPRm6hAI7fQUnMam6iBmix6SLigFkh
	 oBvZ9cEkUAczUya3GXrYGSc+ln32x4mS3YpZwg9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbfJWK15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:27:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46360 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404405AbfJWK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:27:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id r18so15310772eds.13;
        Wed, 23 Oct 2019 03:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sN1khWqhEdLQ73NvMDu4PylBTsZjnLiQFTCzkxlO2MQ=;
        b=F0u+ehzjT4ae6OiQ4jqVxPd5zPWvOQP8p8fz9TX0JEIN3ItYei2pAC25a4Sf8v5XT8
         5vntyrdAAvA3SDOngyFPP/lICBsDdd14HJ8wPFNoMT2OkGz89XwZet9eLrMO/KNtn1hv
         Vs8f3AqJBy5wfukxCHEk7jXyVh+BCyQdTcu6VVdUL6UzL5lfRLmqiPg+tT5M/e1niwt+
         9Ja4/t5HQwnUN/GiMtUfZo+T0yYHDTxON7ALiJutEJlJLPwYkI+KKEvYbIgi38sG/bIK
         6MoL+JSw4OsHzyKN5YQbhFW8VQZmduuWRV8eahT7X4xIF5skEgnr/wxRp04kbdvx4fQc
         EDXg==
X-Gm-Message-State: APjAAAWtihdFFSqOwAdTfUs3dkSweS89l2WGmV27DrhfBaHW1OqDV1vM
        dWfleWu6IT2fUTshtC1pxwc=
X-Google-Smtp-Source: APXvYqweO7L9OX5pU8/x+P5juNGpeFrV4kxRZI/Y+xaj7+Ve9ixjue5f2pYzFGNYsQIqVVZTlnBVtQ==
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr32249056ejb.206.1571826473749;
        Wed, 23 Oct 2019 03:27:53 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id q2sm681528edh.41.2019.10.23.03.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:27:52 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:27:50 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/36] ARM: samsung: make pm-debug platform independent
Message-ID: <20191023102750.GD10630@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-5-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:49PM +0200, Arnd Bergmann wrote:
> The pm-debug code is one of the few things shared between s3c24xx/s3c64xx
> and the newer s5pv210. In order to make s5pv210 independent of plat-samsung,
> change the common bits of this code to no longer reference the s3c specific
> bits.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/include/mach/pm-core.h  |  7 +--
>  arch/arm/mach-s3c64xx/include/mach/pm-core.h  | 44 +---------------
>  arch/arm/mach-s3c64xx/pm.c                    | 50 +++++++++++++++++++
>  arch/arm/mach-s5pv210/pm.c                    |  6 +--
>  .../arm/plat-samsung/include/plat/pm-common.h | 29 +++++------
>  arch/arm/plat-samsung/pm-debug.c              | 23 ++-------
>  arch/arm/plat-samsung/pm.c                    | 10 ++--
>  7 files changed, 80 insertions(+), 89 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/include/mach/pm-core.h b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
> index 5e4ce89d0158..8f87606c4cdc 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/pm-core.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
> @@ -15,6 +15,7 @@
>  
>  static inline void s3c_pm_debug_init_uart(void)
>  {
> +#ifdef CONFIG_SAMSUNG_PM_DEBUG
>  	unsigned long tmp = __raw_readl(S3C2410_CLKCON);
>  
>  	/* re-start uart clocks */
> @@ -24,6 +25,7 @@ static inline void s3c_pm_debug_init_uart(void)
>  
>  	__raw_writel(tmp, S3C2410_CLKCON);
>  	udelay(10);
> +#endif
>  }
>  
>  static inline void s3c_pm_arch_prepare_irqs(void)
> @@ -75,11 +77,6 @@ static inline void s3c_pm_arch_show_resume_irqs(void)
>  				s3c_irqwake_eintmask);
>  }
>  
> -static inline void s3c_pm_arch_update_uart(void __iomem *regs,
> -					   struct pm_uart_save *save)
> -{
> -}
> -
>  static inline void s3c_pm_restored_gpios(void) { }
>  static inline void samsung_pm_saved_gpios(void) { }
>  
> diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
> index bbf79ed28583..33cf242734a0 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
> @@ -20,6 +20,7 @@
>  
>  static inline void s3c_pm_debug_init_uart(void)
>  {
> +#ifdef CONFIG_SAMSUNG_PM_DEBUG
>  	u32 tmp = __raw_readl(S3C_PCLK_GATE);
>  
>  	/* As a note, since the S3C64XX UARTs generally have multiple
> @@ -35,6 +36,7 @@ static inline void s3c_pm_debug_init_uart(void)
>  
>  	__raw_writel(tmp, S3C_PCLK_GATE);
>  	udelay(10);
> +#endif
>  }
>  
>  static inline void s3c_pm_arch_prepare_irqs(void)
> @@ -63,48 +65,6 @@ static inline void s3c_pm_arch_show_resume_irqs(void)
>  #define s3c_irqwake_intallow  0
>  #endif
>  
> -static inline void s3c_pm_arch_update_uart(void __iomem *regs,
> -					   struct pm_uart_save *save)
> -{
> -	u32 ucon = __raw_readl(regs + S3C2410_UCON);
> -	u32 ucon_clk = ucon & S3C6400_UCON_CLKMASK;
> -	u32 save_clk = save->ucon & S3C6400_UCON_CLKMASK;
> -	u32 new_ucon;
> -	u32 delta;
> -
> -	/* S3C64XX UART blocks only support level interrupts, so ensure that
> -	 * when we restore unused UART blocks we force the level interrupt
> -	 * settigs. */
> -	save->ucon |= S3C2410_UCON_TXILEVEL | S3C2410_UCON_RXILEVEL;
> -
> -	/* We have a constraint on changing the clock type of the UART
> -	 * between UCLKx and PCLK, so ensure that when we restore UCON
> -	 * that the CLK field is correctly modified if the bootloader
> -	 * has changed anything.
> -	 */
> -	if (ucon_clk != save_clk) {
> -		new_ucon = save->ucon;
> -		delta = ucon_clk ^ save_clk;
> -
> -		/* change from UCLKx => wrong PCLK,
> -		 * either UCLK can be tested for by a bit-test
> -		 * with UCLK0 */
> -		if (ucon_clk & S3C6400_UCON_UCLK0 &&
> -		    !(save_clk & S3C6400_UCON_UCLK0) &&
> -		    delta & S3C6400_UCON_PCLK2) {
> -			new_ucon &= ~S3C6400_UCON_UCLK0;
> -		} else if (delta == S3C6400_UCON_PCLK2) {
> -			/* as an precaution, don't change from
> -			 * PCLK2 => PCLK or vice-versa */
> -			new_ucon ^= S3C6400_UCON_PCLK2;
> -		}
> -
> -		S3C_PMDBG("ucon change %04x => %04x (save=%04x)\n",
> -			  ucon, new_ucon, save->ucon);
> -		save->ucon = new_ucon;
> -	}
> -}
> -
>  static inline void s3c_pm_restored_gpios(void)
>  {
>  	/* ensure sleep mode has been cleared from the system */
> diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
> index fd6dbb263ed5..a612e9779057 100644
> --- a/arch/arm/mach-s3c64xx/pm.c
> +++ b/arch/arm/mach-s3c64xx/pm.c
> @@ -305,6 +305,56 @@ static void s3c64xx_pm_prepare(void)
>  	__raw_writel(__raw_readl(S3C64XX_WAKEUP_STAT), S3C64XX_WAKEUP_STAT);
>  }
>  
> +#ifdef CONFIG_SAMSUNG_PM_DEBUG
> +void s3c_pm_arch_update_uart(void __iomem *regs, struct pm_uart_save *save)
> +{
> +	u32 ucon;
> +	u32 ucon_clk
> +	u32 save_clk;
> +	u32 new_ucon;
> +	u32 delta;
> +
> +	if (!soc_is_s3c64xx())
> +		return;
> +
> +	ucon = __raw_readl(regs + S3C2410_UCON);
> +	ucon_clk = ucon & S3C6400_UCON_CLKMASK;
> +	sav_clk = save->ucon & S3C6400_UCON_CLKMASK;
> +
> +	/* S3C64XX UART blocks only support level interrupts, so ensure that
> +	 * when we restore unused UART blocks we force the level interrupt
> +	 * settigs. */
> +	save->ucon |= S3C2410_UCON_TXILEVEL | S3C2410_UCON_RXILEVEL;
> +
> +	/* We have a constraint on changing the clock type of the UART
> +	 * between UCLKx and PCLK, so ensure that when we restore UCON
> +	 * that the CLK field is correctly modified if the bootloader
> +	 * has changed anything.
> +	 */
> +	if (ucon_clk != save_clk) {
> +		new_ucon = save->ucon;
> +		delta = ucon_clk ^ save_clk;
> +
> +		/* change from UCLKx => wrong PCLK,
> +		 * either UCLK can be tested for by a bit-test
> +		 * with UCLK0 */
> +		if (ucon_clk & S3C6400_UCON_UCLK0 &&
> +		    !(save_clk & S3C6400_UCON_UCLK0) &&
> +		    delta & S3C6400_UCON_PCLK2) {
> +			new_ucon &= ~S3C6400_UCON_UCLK0;
> +		} else if (delta == S3C6400_UCON_PCLK2) {
> +			/* as an precaution, don't change from
> +			 * PCLK2 => PCLK or vice-versa */
> +			new_ucon ^= S3C6400_UCON_PCLK2;
> +		}
> +
> +		S3C_PMDBG("ucon change %04x => %04x (save=%04x)\n",
> +			  ucon, new_ucon, save->ucon);
> +		save->ucon = new_ucon;
> +	}
> +}
> +#endif
> +
>  int __init s3c64xx_pm_init(void)
>  {
>  	int i;
> diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
> index b336df0c57f3..efdb5a27c060 100644
> --- a/arch/arm/mach-s5pv210/pm.c
> +++ b/arch/arm/mach-s5pv210/pm.c
> @@ -99,8 +99,6 @@ static int s5pv210_suspend_enter(suspend_state_t state)
>  	u32 eint_wakeup_mask = s5pv210_read_eint_wakeup_mask();
>  	int ret;
>  
> -	s3c_pm_debug_init();

Your patch is not equivalent here. If there is a reason behind removal
of UART init (e.g. not needed), I prefer to make it in separate patch.

Rest looks good.

Best regards,
Krzysztof

