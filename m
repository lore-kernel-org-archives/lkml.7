Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E6CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084002084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571825405;
	bh=/9tDO5L20RNslcQOZ4kDH54k+S3+WO0PIP0AINWzF0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OYzBfnTp99LDwTwKYZJj2O126PbGKajqWLd+GbnsjMj03Ymjo85KWMfJOmIFkEduw
	 5PHKx97FlVyFSN9s6pKdDXrsP9Fzytk3d8Cl9ihGju/veagkVjBvmim0ak/6oOtIWA
	 nrEKaLcTNGsQHo98iKhQQqAwMWo4DoZgf63Fl7Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391050AbfJWKKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:10:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36707 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390933AbfJWKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:10:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id h2so15311461edn.3;
        Wed, 23 Oct 2019 03:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9uAybyicxo2gw3uVW8b5qH4zjAAO2fuhAA7FE9Cx2o4=;
        b=dNmhHMJLR/jF1JPq6L+rAJM5ZPx/ySXEUThPVyLrz3yPlRvfF84MkWOVPARfXBs54W
         7Wx4CgWJ1lsVLnS9Rk+DDxm+yuwT7YwxgrdnjhwKX2f8+G0Lq+BB1J0dfSgds5Ds3PvU
         PtpbtffSQ77SYFKzXfFI0a+E7BS0pJC9etE5XXxp4Gz/7KA+m3wWxKxSkhk1wu7iL3qM
         oDbIZqgglTpJ49H7mA/4nJ9t0AERmdrnk1NSnA6xya8Ss1Sjm/c6J48CdGx3jSAFwsCa
         u4tEOu/LCoGJHPGRsq5mGgGzGvvOJPLaQzUZAiYtT+48eorLJodOSA9gc0EhcJAnKNm2
         tJkQ==
X-Gm-Message-State: APjAAAXW4MMex+GLYFZ+Fzu0yFzd2742uV6EQgX+OzZO7oaxc9MFRylQ
        yqgsWOBZQHi45ysKNQ9E5ZmupudC
X-Google-Smtp-Source: APXvYqzvB0tjiJA4qlXPZfegtzIijfOu8E91o8fBax7pqDOSCiZLTLwUav4NEhfcWYA2WrJw96ILPQ==
X-Received: by 2002:a50:fb0d:: with SMTP id d13mr13099867edq.200.1571825401263;
        Wed, 23 Oct 2019 03:10:01 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id o31sm851700edd.17.2019.10.23.03.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:10:00 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:09:58 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 04/36] usb: gadget: s3c-hsudc: remove platform header
 dependency
Message-ID: <20191023100958.GB10630@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-4-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:48PM +0200, Arnd Bergmann wrote:
> There is no real phy driver, so s3c-hsudc just pokes the registers
> itself. Improve this a little by making it a platform data callback
> like we do for gpios.
> 
> There is only one board using this driver, and it's unlikely
> that another would be added, so this is a minimal workaround.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../include/mach/regs-s3c2443-clock.h         | 49 +++++++++++++++++
>  arch/arm/plat-samsung/devs.c                  |  3 +
>  drivers/usb/gadget/udc/s3c-hsudc.c            | 55 ++-----------------
>  include/linux/platform_data/s3c-hsudc.h       |  2 +
>  4 files changed, 58 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
> index 6bf924612b06..682759549e63 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
> @@ -10,6 +10,8 @@
>  #ifndef __ASM_ARM_REGS_S3C2443_CLOCK
>  #define __ASM_ARM_REGS_S3C2443_CLOCK
>  
> +#include <linux/delay.h>
> +
>  #define S3C2443_CLKREG(x)		((x) + S3C24XX_VA_CLKPWR)
>  
>  #define S3C2443_PLLCON_MDIVSHIFT	16
> @@ -184,5 +186,52 @@ s3c2443_get_epll(unsigned int pllval, unsigned int baseclk)
>  	return (unsigned int)fvco;
>  }
>  
> +static inline void s3c_hsudc_init_phy(void)
> +{
> +	u32 cfg;
> +
> +	cfg = readl(S3C2443_PWRCFG) | S3C2443_PWRCFG_USBPHY;
> +	writel(cfg, S3C2443_PWRCFG);
> +
> +	cfg = readl(S3C2443_URSTCON);
> +	cfg |= (S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
> +	writel(cfg, S3C2443_URSTCON);
> +	mdelay(1);
> +
> +	cfg = readl(S3C2443_URSTCON);
> +	cfg &= ~(S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
> +	writel(cfg, S3C2443_URSTCON);
> +
> +	cfg = readl(S3C2443_PHYCTRL);
> +	cfg &= ~(S3C2443_PHYCTRL_CLKSEL | S3C2443_PHYCTRL_DSPORT);
> +	cfg |= (S3C2443_PHYCTRL_EXTCLK | S3C2443_PHYCTRL_PLLSEL);
> +	writel(cfg, S3C2443_PHYCTRL);
> +
> +	cfg = readl(S3C2443_PHYPWR);
> +	cfg &= ~(S3C2443_PHYPWR_FSUSPEND | S3C2443_PHYPWR_PLL_PWRDN |
> +		S3C2443_PHYPWR_XO_ON | S3C2443_PHYPWR_PLL_REFCLK |
> +		S3C2443_PHYPWR_ANALOG_PD);
> +	cfg |= S3C2443_PHYPWR_COMMON_ON;
> +	writel(cfg, S3C2443_PHYPWR);
> +
> +	cfg = readl(S3C2443_UCLKCON);
> +	cfg |= (S3C2443_UCLKCON_DETECT_VBUS | S3C2443_UCLKCON_FUNC_CLKEN |
> +		S3C2443_UCLKCON_TCLKEN);
> +	writel(cfg, S3C2443_UCLKCON);
> +}
> +
> +static inline void s3c_hsudc_uninit_phy(void)
> +{
> +	u32 cfg;
> +
> +	cfg = readl(S3C2443_PWRCFG) & ~S3C2443_PWRCFG_USBPHY;
> +	writel(cfg, S3C2443_PWRCFG);
> +
> +	writel(S3C2443_PHYPWR_FSUSPEND, S3C2443_PHYPWR);
> +
> +	cfg = readl(S3C2443_UCLKCON) & ~S3C2443_UCLKCON_FUNC_CLKEN;
> +	writel(cfg, S3C2443_UCLKCON);
> +}
> +
>  #endif /*  __ASM_ARM_REGS_S3C2443_CLOCK */
>  
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index 1d1fa068d228..6e4c1cb07104 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -40,6 +40,7 @@
>  #include <mach/dma.h>
>  #include <mach/irqs.h>
>  #include <mach/map.h>
> +#include <mach/regs-s3c2443-clock.h>
>  
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
> @@ -1038,6 +1039,8 @@ struct platform_device s3c_device_usb_hsudc = {
>  void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd)
>  {
>  	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usb_hsudc);
> +	pd->phy_init = s3c_hsudc_init_phy;
> +	pd->phy_uninit = s3c_hsudc_uninit_phy;
>  }
>  #endif /* CONFIG_PLAT_S3C24XX */
>  
> diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
> index 858993c73442..d482cbb4bb4d 100644
> --- a/drivers/usb/gadget/udc/s3c-hsudc.c
> +++ b/drivers/usb/gadget/udc/s3c-hsudc.c
> @@ -30,8 +30,6 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  
> -#include <mach/regs-s3c2443-clock.h>
> -
>  #define S3C_HSUDC_REG(x)	(x)
>  
>  /* Non-Indexed Registers */
> @@ -186,53 +184,6 @@ static inline void __orr32(void __iomem *ptr, u32 val)
>  	writel(readl(ptr) | val, ptr);
>  }
>  
> -static void s3c_hsudc_init_phy(void)
> -{
> -	u32 cfg;
> -
> -	cfg = readl(S3C2443_PWRCFG) | S3C2443_PWRCFG_USBPHY;
> -	writel(cfg, S3C2443_PWRCFG);
> -
> -	cfg = readl(S3C2443_URSTCON);
> -	cfg |= (S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
> -	writel(cfg, S3C2443_URSTCON);
> -	mdelay(1);
> -
> -	cfg = readl(S3C2443_URSTCON);
> -	cfg &= ~(S3C2443_URSTCON_FUNCRST | S3C2443_URSTCON_PHYRST);
> -	writel(cfg, S3C2443_URSTCON);
> -
> -	cfg = readl(S3C2443_PHYCTRL);
> -	cfg &= ~(S3C2443_PHYCTRL_CLKSEL | S3C2443_PHYCTRL_DSPORT);
> -	cfg |= (S3C2443_PHYCTRL_EXTCLK | S3C2443_PHYCTRL_PLLSEL);
> -	writel(cfg, S3C2443_PHYCTRL);
> -
> -	cfg = readl(S3C2443_PHYPWR);
> -	cfg &= ~(S3C2443_PHYPWR_FSUSPEND | S3C2443_PHYPWR_PLL_PWRDN |
> -		S3C2443_PHYPWR_XO_ON | S3C2443_PHYPWR_PLL_REFCLK |
> -		S3C2443_PHYPWR_ANALOG_PD);
> -	cfg |= S3C2443_PHYPWR_COMMON_ON;
> -	writel(cfg, S3C2443_PHYPWR);
> -
> -	cfg = readl(S3C2443_UCLKCON);
> -	cfg |= (S3C2443_UCLKCON_DETECT_VBUS | S3C2443_UCLKCON_FUNC_CLKEN |
> -		S3C2443_UCLKCON_TCLKEN);
> -	writel(cfg, S3C2443_UCLKCON);
> -}
> -
> -static void s3c_hsudc_uninit_phy(void)
> -{
> -	u32 cfg;
> -
> -	cfg = readl(S3C2443_PWRCFG) & ~S3C2443_PWRCFG_USBPHY;
> -	writel(cfg, S3C2443_PWRCFG);
> -
> -	writel(S3C2443_PHYPWR_FSUSPEND, S3C2443_PHYPWR);
> -
> -	cfg = readl(S3C2443_UCLKCON) & ~S3C2443_UCLKCON_FUNC_CLKEN;
> -	writel(cfg, S3C2443_UCLKCON);
> -}
> -
>  /**
>   * s3c_hsudc_complete_request - Complete a transfer request.
>   * @hsep: Endpoint to which the request belongs.
> @@ -1188,7 +1139,8 @@ static int s3c_hsudc_start(struct usb_gadget *gadget,
>  
>  	pm_runtime_get_sync(hsudc->dev);
>  
> -	s3c_hsudc_init_phy();
> +	if (hsudc->pd->phy_init)
> +		hsudc->pd->gpio_init();

Copy paste error - phy_init().

Are here (and in previous usb gadget patch) any dependencies? If so, I
would need an ack to take it through samsung-soc.

Best regards,
Krzysztof

>  	if (hsudc->pd->gpio_init)
>  		hsudc->pd->gpio_init();
>  
> @@ -1210,7 +1162,8 @@ static int s3c_hsudc_stop(struct usb_gadget *gadget)
>  
>  	spin_lock_irqsave(&hsudc->lock, flags);
>  	hsudc->gadget.speed = USB_SPEED_UNKNOWN;
> -	s3c_hsudc_uninit_phy();
> +	if (hsudc->pd->phy_uninit)
> +		hsudc->pd->phy_uninit();
>  
>  	pm_runtime_put(hsudc->dev);
>  
> diff --git a/include/linux/platform_data/s3c-hsudc.h b/include/linux/platform_data/s3c-hsudc.h
> index 4dc9b8760166..a170939832d5 100644
> --- a/include/linux/platform_data/s3c-hsudc.h
> +++ b/include/linux/platform_data/s3c-hsudc.h
> @@ -26,6 +26,8 @@ struct s3c24xx_hsudc_platdata {
>  	unsigned int	epnum;
>  	void		(*gpio_init)(void);
>  	void		(*gpio_uninit)(void);
> +	void		(*phy_init)(void);
> +	void		(*phy_uninit)(void);
>  };
>  
>  #endif	/* __LINUX_USB_S3C_HSUDC_H */
> -- 
> 2.20.0
> 
