Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8458CA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B079921897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mue1fKqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437687AbfJRIxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:53:19 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42639 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfJRIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:53:19 -0400
Received: by mail-vs1-f65.google.com with SMTP id m22so3508413vsl.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFGj7CW4hdUtWSJdWVNaVmZMeTl6mFJ/pi0dDaNSBNI=;
        b=Mue1fKqhFIuquMu+rQdYue5Ab10+aIYtB6Q9/0NGn6yqBrOgXLgFxSg9NHgyKSbFSE
         P/wYniqUzElGGRUAv73GH8vxgzAqIkRFcXnKtK9ERXdptaI+2SGSIs/jXswG4speKbto
         lvoSDiJeqxjuzOzIefrZ/deo7u6TdlJP7VTwxZFuteA/G4mV3V/aqdXyku3K8eU9Xoif
         xAyZGXgX2NNhi62LjQKANeErNlNX/Za8ktqBzNRyqHutbskgjId182FjA9IqnNqFz+zm
         ZXV01E9q9XPvlg0rZAq3Q2UEHuoAvj3+8z07VtkHMPYeXNncwhRl6aFysiNItkIHFYs1
         L2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFGj7CW4hdUtWSJdWVNaVmZMeTl6mFJ/pi0dDaNSBNI=;
        b=mppq6Z0pYPFnc3LoILwaeXpiV5/rCxwsJO6dsQlSXbbEOReFpUYdsBJon8NvQk+nu6
         9gDoPMACpFS5Hab0IjvUeKH50QoM3tAG2/Nk0qmexk9f1+QIiBmmDSlk7l27uf2c2nD2
         Ig6+wxEiNi55BNL+2xBc7CxglEA8YZEnUZgiVLiOZRdapgu4ADCJxO4xmkuIM6FTNgbF
         XmfK1Hswlc3a1zUEaRiOtyKbl0zbDYDOQYvw86j+uy1UHq9DRZq5SKhdUU+G6Se0d+Aq
         YCiNo9jxpRCh0WXHElrxcq7SvSZlyEO5xfJPtFWtnyI24cz0eEoP+yNCK4ir5otKVk4h
         Ek9A==
X-Gm-Message-State: APjAAAWRaIlW/KlVV+8R0+1TIWosdG6swpmCKsqQs6JeEDJ5vBrZ/yIV
        ko6TedifI4s5/m+qpt/6cyd68FFU0elbyie0xq506A==
X-Google-Smtp-Source: APXvYqxx1CtlN+u0DoDjVeLLVdh/4lNPYBI0SFJLfPUK/RX16/kP5dPKuMLW2YkmIBl0ktGJ57HLSuHmNeIqxg0/6RQ=
X-Received: by 2002:a67:ebc2:: with SMTP id y2mr4733668vso.191.1571388797894;
 Fri, 18 Oct 2019 01:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com> <1570857203-49192-7-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1570857203-49192-7-git-send-email-zhouyanjie@zoho.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 10:52:41 +0200
Message-ID: <CAPDyKFo9juNmf6hrcBjzOprS6GwzAPBq8y3ReGu=ry+MdxT9Bg@mail.gmail.com>
Subject: Re: [PATCH 6/6 v2] MMC: JZ4740: Add support for LPM.
To:     Zhou Yanjie <zhouyanjie@zoho.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>, syq@debian.org,
        Linus Walleij <linus.walleij@linaro.org>, armijn@tjaldur.nl,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2019 at 07:19, Zhou Yanjie <zhouyanjie@zoho.com> wrote:
>
> add support for low power mode of Ingenic's MMC/SD Controller.
>
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>

I couldn't find a proper coverletter for the series, please provide
that next time as it really helps review. Additionally, it seems like
you forgot to change the prefix of the patches to "mmc: jz4740" (or at
least you chosed upper case letters), but I will take care of that
this time. So, I have applied the series for next, thanks!

I also have a general question. Should we perhaps rename the driver
from jz4740_mmc.c to ingenic.c (and the file for the DT bindings, the
Kconfig, etc), as that seems like a more appropriate name? No?

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 44a04fe..4cbe7fb 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -43,6 +43,7 @@
>  #define JZ_REG_MMC_RESP_FIFO   0x34
>  #define JZ_REG_MMC_RXFIFO      0x38
>  #define JZ_REG_MMC_TXFIFO      0x3C
> +#define JZ_REG_MMC_LPM         0x40
>  #define JZ_REG_MMC_DMAC                0x44
>
>  #define JZ_MMC_STRPCL_EXIT_MULTIPLE BIT(7)
> @@ -102,6 +103,12 @@
>  #define JZ_MMC_DMAC_DMA_SEL BIT(1)
>  #define JZ_MMC_DMAC_DMA_EN BIT(0)
>
> +#define        JZ_MMC_LPM_DRV_RISING BIT(31)
> +#define        JZ_MMC_LPM_DRV_RISING_QTR_PHASE_DLY BIT(31)
> +#define        JZ_MMC_LPM_DRV_RISING_1NS_DLY BIT(30)
> +#define        JZ_MMC_LPM_SMP_RISING_QTR_OR_HALF_PHASE_DLY BIT(29)
> +#define        JZ_MMC_LPM_LOW_POWER_MODE_EN BIT(0)
> +
>  #define JZ_MMC_CLK_RATE 24000000
>
>  enum jz4740_mmc_version {
> @@ -860,6 +867,22 @@ static int jz4740_mmc_set_clock_rate(struct jz4740_mmc_host *host, int rate)
>         }
>
>         writew(div, host->base + JZ_REG_MMC_CLKRT);
> +
> +       if (real_rate > 25000000) {
> +               if (host->version >= JZ_MMC_X1000) {
> +                       writel(JZ_MMC_LPM_DRV_RISING_QTR_PHASE_DLY |
> +                                  JZ_MMC_LPM_SMP_RISING_QTR_OR_HALF_PHASE_DLY |
> +                                  JZ_MMC_LPM_LOW_POWER_MODE_EN,
> +                                  host->base + JZ_REG_MMC_LPM);
> +               } else if (host->version >= JZ_MMC_JZ4760) {
> +                       writel(JZ_MMC_LPM_DRV_RISING |
> +                                  JZ_MMC_LPM_LOW_POWER_MODE_EN,
> +                                  host->base + JZ_REG_MMC_LPM);
> +               } else if (host->version >= JZ_MMC_JZ4725B)
> +                       writel(JZ_MMC_LPM_LOW_POWER_MODE_EN,
> +                                  host->base + JZ_REG_MMC_LPM);
> +       }
> +
>         return real_rate;
>  }
>
> --
> 2.7.4
>
>
