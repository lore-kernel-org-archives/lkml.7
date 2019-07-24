Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6FBC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81B32190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563966819;
	bh=5/y1hhDYq8XOZKIhQOx1PKrERYltNYVDKnL3158aB6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fksIeYjtiov1+Cw0Kb7BwgNw5I3933Wc8pQgbWuMKfArO74JMGWYxnmOF6E40aHcM
	 gqDl1aoYyB0t6zzEKXQ/GeFD+Y4VcREf85nakKiTvVbaPZfMps1py0MUnGGCWwINtU
	 podDp2FHaTXyWaJRXwi6/eLas0Nu73kHSDKbn+P4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfGXLNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfGXLNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:13:36 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA592190F;
        Wed, 24 Jul 2019 11:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563966814;
        bh=5/y1hhDYq8XOZKIhQOx1PKrERYltNYVDKnL3158aB6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o63dKY7gmPoLMlPwWmTjsaF0E6vvrfbRChrcIfn1uENGMU4qIVFHms765aBdgaQoN
         Ek64RM9AUVkKpj1sLpM7xJktKOfK63n46leGLUb2uG2q+mXl4LONpPlesGFf+eu9Dp
         u85dtwUxPiOiwToAk+we+sdyVkh81jiD17xSiaRo=
Received: by mail-lf1-f41.google.com with SMTP id h28so31646617lfj.5;
        Wed, 24 Jul 2019 04:13:34 -0700 (PDT)
X-Gm-Message-State: APjAAAUMQ3kAPYURZ+kLrqqmnmvt4lHiihO70auywBF2INNDoRSwtsUR
        YgFLYiV1bg5D+Ogc8MlXRYzUcNsiNpRZQuTBDnM=
X-Google-Smtp-Source: APXvYqwESEIOvcf70daSpwIqf11GEHlkm1uvDfKQSkJrORyYpKpAECse1JBT3/KtsMH1xOMwAc/+BWP0Hnw8jR6wBh8=
X-Received: by 2002:a19:48c5:: with SMTP id v188mr37332583lfa.69.1563966812710;
 Wed, 24 Jul 2019 04:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190722185938.9043-1-linux.amoon@gmail.com> <20190722185938.9043-5-linux.amoon@gmail.com>
In-Reply-To: <20190722185938.9043-5-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 24 Jul 2019 13:13:21 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeiKP-MfaO4LpQ=iXZn14gM3vwR8U18yLGfhHt6pjvvCA@mail.gmail.com>
Message-ID: <CAJKOXPeiKP-MfaO4LpQ=iXZn14gM3vwR8U18yLGfhHt6pjvvCA@mail.gmail.com>
Subject: Re: [RFC/RFT 4/5] phy: exynos5-usbdrd: PIPE3 tune signal
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
> Tune USB3.0 (PIPE3) PHY TX signal for high and supper
> speed data transfer.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 54a513ca15e4..4f16c4f82ae5 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -124,8 +124,10 @@
>
>  #define EXYNOS5_DRD_PHYPARAM1                  0x20
>
> -#define PHYPARAM1_PCS_TXDEEMPH_MASK            (0x1f << 0)
> -#define PHYPARAM1_PCS_TXDEEMPH                 (0x1c)
> +#define PHYPARAM1_TX0_TERM_OFFSET(x)           __set(x, 30, 26)
> +#define PHYPARAM1_TX_SWING_FULL(x)             __set(x, 18, 12)
> +#define PHYPRAAM1_PCS_TX_DEEMPH_6DB(x)         __set(x, 11, 6)
> +#define PHYPRAAM1_PCS_TX_DEEMPH_3P5DB(x)       __set(x, 5, 0)
>
>  #define EXYNOS5_DRD_PHYTERM                    0x24
>
> @@ -360,10 +362,16 @@ static void exynos5_usbdrd_pipe3_init(struct exynos5_usbdrd_phy *phy_drd)
>  {
>         u32 reg;
>
> -       reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
>         /* Set Tx De-Emphasis level */
> -       reg &= ~PHYPARAM1_PCS_TXDEEMPH_MASK;
> -       reg |=  PHYPARAM1_PCS_TXDEEMPH;
> +       reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
> +               /* Transmitter Termination Offset */
> +       reg |=  PHYPARAM1_TX0_TERM_OFFSET(0x5) |
> +               /* Tx Amplitude (Full Swing mode) */
> +               PHYPARAM1_TX_SWING_FULL(0x3F) |
> +               /* Tx De-Emphasis at 6 dB */
> +               PHYPRAAM1_PCS_TX_DEEMPH_6DB(0x20) |
> +               /* Tx De-Emphasis at 3.5 dB */
> +               PHYPRAAM1_PCS_TX_DEEMPH_3P5DB(0x15);

How did you get the value? Why you are changing existing values to default ones?

Best regards,
Krzysztof

>         writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
>
>         reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYTEST);
> --
> 2.22.0
>
