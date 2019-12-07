Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA7C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C52B24673
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575725873;
	bh=9IaAWLB4YM37hZ4K6+hLzc+2+j5HMFfWFGUX46FSuRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YKxF4PFMWAqUIOaR7ay5GTiGR8eUDzV5ppKTRlpaji0YQtpVX5KUCDmuorENJegA+
	 TdVniusVuRlF6OsLu5uV9ZT93ig7MkDuozZuiOklGU2sEsqCwsFTV31OisO+tcPCk/
	 Qwgmn2HY8Rj7bOo1bIxX4TWANQMCETOL7MCImU7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLGNhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 08:37:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfLGNhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 08:37:52 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D4F2467C;
        Sat,  7 Dec 2019 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575725870;
        bh=9IaAWLB4YM37hZ4K6+hLzc+2+j5HMFfWFGUX46FSuRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XOetANLa2aHZVuclnuWNqTAIG3Xje4nos+YX3L8udJ4F9MleOkR8UnlSKNvQ5ONSd
         cM+FZ7DhhM6S/8YDPeATg0M771CyyRMSemIj7Gp3jru5HSdGR54TgMU/KRgs+5ZmA8
         JG5E3T8mG1fvv8UDiflqzXjVp70hAHH7w4IbB9ik=
Received: by mail-lf1-f43.google.com with SMTP id 203so7338380lfa.12;
        Sat, 07 Dec 2019 05:37:50 -0800 (PST)
X-Gm-Message-State: APjAAAXCbOeaHj0IY1f0dsaeaVfu04x1f0ktmX4/scFx3mR+almkYdIQ
        HwFLUtKj6Jbu7pyfFh88m1pr5z1bjM7m5ZPmCg0=
X-Google-Smtp-Source: APXvYqyOF9srqVRZQzGGYzVp/uW2kHgzDvPmYy8GKUsxbHw54dS4knoGV2DrOYoYaX2xML7sWWsLllv4ZTFD6QAEMu0=
X-Received: by 2002:ac2:5dc7:: with SMTP id x7mr10801121lfq.24.1575725868267;
 Sat, 07 Dec 2019 05:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20191207130049.27533-1-hyunki00.koo@gmail.com>
 <20191207130049.27533-2-hyunki00.koo@gmail.com> <20191207132855.GA4384@kozik-lap>
In-Reply-To: <20191207132855.GA4384@kozik-lap>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 7 Dec 2019 14:37:36 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcUXRGa7+ZgSYomo5v_eh=GjqyWYBkzsXUJi0zAPHcOjg@mail.gmail.com>
Message-ID: <CAJKOXPcUXRGa7+ZgSYomo5v_eh=GjqyWYBkzsXUJi0zAPHcOjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip: define EXYNOS_IRQ_COMBINER
To:     Hyunki Koo <hyunki00.koo@gmail.com>
Cc:     linux@armlinux.org.uk, kgene@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Hyunki Koo <hyunki00.koo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Dec 2019 at 14:28, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Dec 07, 2019 at 10:00:48PM +0900, Hyunki Koo wrote:
> > From: Hyunki Koo <hyunki00.koo@samsung.com>
> >
> > Not all exynos device have IRQ_COMBINER.
> > Thus add the config for EXYNOS_IRQ_COMBINER.
> >
> > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > ---
> >  drivers/irqchip/Kconfig  | 7 +++++++
> >  drivers/irqchip/Makefile | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
>
> Hi,
>
> There is no changelog and versioning of this patch so I do not
> understand how it differs with previous. It's a resend? v2? It brings
> the confusion and looks like you're ignoring previous comments.
>
> Looks the same and looks like breaking Exynos platforms in the same way.
>
> If you not want to skip combiner on ARMv8, it makes sense, then please
> follow the approach we did for Pinctrl drivers (PINCTRL_EXYNOS_ARM and
> PINCTRL_EXYNOS_ARM64).
>
> Best regards,
> Krzysztof

Ah, now I see the second patch. Still you break bisect which requires
specific ordering of patches or squashing them into one. Optionally
this could be default=y if ARCH_EXYNOS && ARM. I prefer just squashing
both into one patch in this case.

>
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index ba152954324b..3ed7b7f2ae26 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -499,4 +499,11 @@ config SIFIVE_PLIC
> >
> >          If you don't know what to do here, say Y.
> >
> > +config EXYNOS_IRQ_COMBINER
> > +     bool "Samsung Exynos IRQ combiner support"

Now point it to be visible. Only for COMPILE_TEST

> > +     depends on ARCH_EXYNOS

Since you make it a separate option, make it COMPILE_TEST.

Best regards,
Krzysztof

> > +     help
> > +       Say yes here to add support for the IRQ combiner devices embedded
> > +       in Samsung Exynos chips.
> > +
> >  endmenu
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index e806dda690ea..60d7c7260fc3 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -9,7 +9,7 @@ obj-$(CONFIG_ARCH_BCM2835)            += irq-bcm2835.o
> >  obj-$(CONFIG_ARCH_BCM2835)           += irq-bcm2836.o
> >  obj-$(CONFIG_DAVINCI_AINTC)          += irq-davinci-aintc.o
> >  obj-$(CONFIG_DAVINCI_CP_INTC)                += irq-davinci-cp-intc.o
> > -obj-$(CONFIG_ARCH_EXYNOS)            += exynos-combiner.o
> > +obj-$(CONFIG_EXYNOS_IRQ_COMBINER)    += exynos-combiner.o
> >  obj-$(CONFIG_FARADAY_FTINTC010)              += irq-ftintc010.o
> >  obj-$(CONFIG_ARCH_HIP04)             += irq-hip04.o
> >  obj-$(CONFIG_ARCH_LPC32XX)           += irq-lpc32xx.o
> > --
> > 2.17.1
> >
