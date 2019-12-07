Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBEBC2BBE2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0354B24676
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575725343;
	bh=h2OuwS7wr+vcyzOIsp3qmN766Q2fsuw4ieXO6+Dxin4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Ki+3DjBjZku8EXOocRlBjJ9OHjhzZGcgoe58XzejkskjXNAw0/TFsX2qD2tZxS2x
	 Is5L5V3NVYsCaFHp7EfoFZypF8laFYnMM0EumeC+eNZuMWjX93ztPwD+dS620gUhTW
	 hOLtT71CxlrCah/CcRZGwSqhu+t91r9ebOn8NCjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLGN3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 08:29:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33398 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfLGN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 08:29:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id l63so8416533ede.0;
        Sat, 07 Dec 2019 05:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7y0ZNBEgzv9XawrP/HXbktND1cefPtKyMWBgc9jJ2Vc=;
        b=JZg9BcKcMSya7UussQ+45bJwZwLg7xBRt8yTcjoJdt2IYIHPEfUmS5/RituwfZsthZ
         /8a6JVTY8JK/9RyuYydmlmO+PuNsMgOIqjQIejGl0F2qswcQgPysBWnFC2kyKRMGWbx+
         V2gBUmRuy9y5wWdhHUXs3g/fcYgVLrUpoiCBMj4/icdBmvCEO+6xtqB+kOETzlMxw18J
         +higWDsgclUWirVmK9AWcfjfa73r4D8x1O5ySC8XjgzSVsja6xlo0ZaR3nTWtEH0SV4M
         DRlLBAwi+St/nahL9M20BumF/Of5pkWNur8jd7hAhUW+MTPEZ4GSX4GcuAaYpd6hlxvX
         9RkA==
X-Gm-Message-State: APjAAAVsPWImq+9pH0Q+6BZbbopf9KVNVlb273pKkdyOJvcZbGJWCWf0
        ZjOz3C3rXiue+DlDeY1FMiE=
X-Google-Smtp-Source: APXvYqwRuhyCcWafkNThzuWx6NKR53IU32fzXyZq05AftVy3xEUUe89MpZPIHixera5+axOlKJ1iTg==
X-Received: by 2002:a17:906:2ecd:: with SMTP id s13mr14517103eji.195.1575725338853;
        Sat, 07 Dec 2019 05:28:58 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id rl27sm191361ejb.11.2019.12.07.05.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Dec 2019 05:28:58 -0800 (PST)
Date:   Sat, 7 Dec 2019 14:28:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@gmail.com>
Cc:     linux@armlinux.org.uk, kgene@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Hyunki Koo <hyunki00.koo@samsung.com>
Subject: Re: [PATCH 1/2] irqchip: define EXYNOS_IRQ_COMBINER
Message-ID: <20191207132855.GA4384@kozik-lap>
References: <20191207130049.27533-1-hyunki00.koo@gmail.com>
 <20191207130049.27533-2-hyunki00.koo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191207130049.27533-2-hyunki00.koo@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2019 at 10:00:48PM +0900, Hyunki Koo wrote:
> From: Hyunki Koo <hyunki00.koo@samsung.com>
> 
> Not all exynos device have IRQ_COMBINER.
> Thus add the config for EXYNOS_IRQ_COMBINER.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  drivers/irqchip/Kconfig  | 7 +++++++
>  drivers/irqchip/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>

Hi,

There is no changelog and versioning of this patch so I do not
understand how it differs with previous. It's a resend? v2? It brings
the confusion and looks like you're ignoring previous comments.

Looks the same and looks like breaking Exynos platforms in the same way.

If you not want to skip combiner on ARMv8, it makes sense, then please
follow the approach we did for Pinctrl drivers (PINCTRL_EXYNOS_ARM and
PINCTRL_EXYNOS_ARM64).

Best regards,
Krzysztof


> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index ba152954324b..3ed7b7f2ae26 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -499,4 +499,11 @@ config SIFIVE_PLIC
>  
>  	   If you don't know what to do here, say Y.
>  
> +config EXYNOS_IRQ_COMBINER
> +	bool "Samsung Exynos IRQ combiner support"
> +	depends on ARCH_EXYNOS
> +	help
> +	  Say yes here to add support for the IRQ combiner devices embedded
> +	  in Samsung Exynos chips.
> +
>  endmenu
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e806dda690ea..60d7c7260fc3 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
>  obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
>  obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
> -obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
> +obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
>  obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
>  obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
>  obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
> -- 
> 2.17.1
> 
