Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1962CC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E561B2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563966660;
	bh=43ImpNHkkgXC2ZTY8sp81GulxHTTCw7a4isDFujFl1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sr5vNiKNUsnhjO8PKscJxLzRuTMMJHBi8jPj8+XZXMTLxHmUfXwbbLjJb5KZCZ+RK
	 fvO77bGiPiHM7HRHy8d7fE6Jp4m22CYcwsc0iStzLic1nnnFy/f961zqFucu3cKec+
	 d26xWdFVR9thalRmsMgnnYxI5snV9VUe1vQxNA/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfGXLK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfGXLK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:10:57 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A5022ADC;
        Wed, 24 Jul 2019 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563966657;
        bh=43ImpNHkkgXC2ZTY8sp81GulxHTTCw7a4isDFujFl1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V1yaQo+bbXYWPn4Ax4A73Nr2pQsDa3iLl/cW1bxNLchkNkdO306FibgqU+erTmvgK
         EQWEBbekVuJHjxyLZofTRa1+SRu0hr7Wfi72SOTVr/r91zJKuT5kKY3LTbjBflB2LK
         GoLIdBx9pJvxMoMy6c4tPRFHW+mwj92/xdLU5MQw=
Received: by mail-lf1-f54.google.com with SMTP id v85so31632957lfa.6;
        Wed, 24 Jul 2019 04:10:56 -0700 (PDT)
X-Gm-Message-State: APjAAAVEQEpjcAla0xCGJiBVWmegrnn+XXkeefBK9DGJe2ocbxnLnAEq
        GDRUWMGbMZkTGi3oiFdm8fJZhOooljgxjwf5s1Q=
X-Google-Smtp-Source: APXvYqzc4CJMWeH1KfUWwesVwU9M4BdPF96ukfcyOKlGBt8F3mjV1zNEx5786UwPBcNQlTDPzzmpiDAt9db/wwLUDnA=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr36759778lfi.159.1563966655182;
 Wed, 24 Jul 2019 04:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190722185938.9043-1-linux.amoon@gmail.com> <20190722185938.9043-4-linux.amoon@gmail.com>
In-Reply-To: <20190722185938.9043-4-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 24 Jul 2019 13:10:43 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcc_tvKnMEqmEozcEn64EPBmeC6gGOp4XMQqTTmHcXwUA@mail.gmail.com>
Message-ID: <CAJKOXPcc_tvKnMEqmEozcEn64EPBmeC6gGOp4XMQqTTmHcXwUA@mail.gmail.com>
Subject: Re: [RFC/RFT 3/5] phy: exynos5-usbdrd: UTMI tune signal
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 at 20:59, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Tune USB2.0 (UTMI+) TX signal for high speed data transfer.

What is the visible effect? What does this tuning bring?

>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 42 +++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 135114d51bc1..54a513ca15e4 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -33,6 +33,8 @@
>  #define EXYNOS5_FSEL_24MHZ             0x5
>  #define EXYNOS5_FSEL_50MHZ             0x7
>
> +#define __set(v, a, b)  (((v) << (b)) & GENMASK(a, b))
> +
>  /* EXYNOS5: USB 3.0 DRD PHY registers */
>  #define EXYNOS5_DRD_LINKSYSTEM                 0x04
>
> @@ -108,8 +110,17 @@
>  #define EXYNOS5_DRD_PHYPARAM0                  0x1c
>
>  #define PHYPARAM0_REF_USE_PAD                  BIT(31)
> -#define PHYPARAM0_REF_LOSLEVEL_MASK            (0x1f << 26)
> -#define PHYPARAM0_REF_LOSLEVEL                 (0x9 << 26)
> +#define PHYPARAM0_REF_LOSLEVEL(x)              __set(x, 30, 26)
> +#define PHYPARAM0_TXVREFTUNE(x)                        __set(x, 25, 22)
> +#define PHYPARAM0_TXISETUNE(x)                 __set(x, 21, 20)
> +#define PHYPARAM0_TXRESTUNE(x)                 __set(x, 19, 18)
> +#define PHYPARAM0_TXPREEMPPULSETUNE            BIT(17)
> +#define PHYPARAM0_TXPREEMPAMPTUNE(x)           __set(x, 16, 15)
> +#define PHYPARAM0_TXHSXVTUNE(x)                        __set(x, 14, 13)
> +#define PHYPARAM0_TXFSLSTUNE(x)                        __set(x, 12, 9)
> +#define PHYPARAM0_SQRXTUNE(x)                  __set(x, 8, 6)
> +#define PHYPARAM0_OTGTUNE(x)                   __set(x, 5, 3)
> +#define PHYPARAM0_COMPDISTUNE(x)               __set(x, 2, 0)
>
>  #define EXYNOS5_DRD_PHYPARAM1                  0x20
>
> @@ -365,9 +376,30 @@ static void exynos5_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
>         u32 reg;
>
>         reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM0);
> -       /* Set Loss-of-Signal Detector sensitivity */
> -       reg &= ~PHYPARAM0_REF_LOSLEVEL_MASK;
> -       reg |=  PHYPARAM0_REF_LOSLEVEL;
> +               /* Set Loss-of-Signal Detector sensitivity */
> +       reg |= (PHYPARAM0_REF_USE_PAD |
> +               /* Sets the sensitivity level for the Loss-of-Signal detector */
> +               PHYPARAM0_REF_LOSLEVEL(0x9) |
> +               /* Adjusts the high-speed DC level voltage */
> +               PHYPARAM0_TXVREFTUNE(0x3) |
> +               /* Adjust the rise/fal timie of the high-speed waveform */
> +               PHYPARAM0_TXISETUNE(0x1) |
> +               /* Adjusts the driver source impedance */
> +               PHYPARAM0_TXRESTUNE(0x1) |
> +               /* HS Transmitter Pre-Emphasis Duration Control */
> +               PHYPARAM0_TXPREEMPPULSETUNE |
> +               /* HS Transmitter Pre-Emphasis Current Control */
> +               PHYPARAM0_TXPREEMPAMPTUNE(0x0) |
> +               /* Transmitter High-Speed Crossover Adjustment */
> +               PHYPARAM0_TXHSXVTUNE(0x3) |
> +               /* FS/LS Source Impedance Adjustment */
> +               PHYPARAM0_TXFSLSTUNE(0x3) |
> +               /* Squelch Threshold Adjustment */
> +               PHYPARAM0_SQRXTUNE(0x3) |
> +               /* VBUS Valid Threshold Adjustment */
> +               PHYPARAM0_OTGTUNE(0x6) |
> +               /* Disconnect Threshold Adjustment */
> +               PHYPARAM0_COMPDISTUNE(0x6));

You set a bunch of parameters but I am not sure how did you get the values...

Best regards,
Krzysztof

>         writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM0);
>
>         reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
> --
> 2.22.0
>
