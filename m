Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744A1C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1D32190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563966482;
	bh=NMg0QCsJC3/2f/uN8qBfJZP1rBSoVJP+rvK+9apy9F8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NKgf7MI64BOQi+nISzHw4x+00EMRU48tsnGAOZOUidkYQmEdV59v5gvEgm1YD9JtW
	 jVYvt3R+trhYIJNnNCmgxpoy9MheUhOUWWQOHtjmFIY5DRHRPni/i7lR+3VVhf2iuO
	 RxAf1DK2gIGkJRRIpmcGXCiCyoofXD2F86C4F2vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfGXLIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfGXLIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:08:00 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5092190F;
        Wed, 24 Jul 2019 11:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563966479;
        bh=NMg0QCsJC3/2f/uN8qBfJZP1rBSoVJP+rvK+9apy9F8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kuv7CzoWZ2PUkv0kq5ib89n+yneoQtuEPd9KcNzeSJDPuA8SbBOrCpp/FySGOiRGy
         BWgqJo61ANj5vZtRa70lEASikhL2l2mStCYG3hchr7Hxm4dd0GA1gvthYuuAhmP3rW
         9eCoYKqkYo9bK5HD7XiQZiYxHH6tjsKuJPu7Myl4=
Received: by mail-lj1-f170.google.com with SMTP id x25so44146216ljh.2;
        Wed, 24 Jul 2019 04:07:58 -0700 (PDT)
X-Gm-Message-State: APjAAAVIqZWUKg+nn6Ono7TahWk9MWfxrG4aJtR0cedVkc5Em3p+eMee
        SH9qJR7lCTGq9VSYAAmRDFv7p0BRC7343LdyN34=
X-Google-Smtp-Source: APXvYqzUq7GrisNxdgqufanV1x9vUxFnKwDNQX0DwX6U6exWVoC39l63jdg66SzoGOFToYFLWYrTDGvoVo150eCwKr8=
X-Received: by 2002:a2e:124b:: with SMTP id t72mr43134559lje.143.1563966477162;
 Wed, 24 Jul 2019 04:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190722185938.9043-1-linux.amoon@gmail.com> <20190722185938.9043-3-linux.amoon@gmail.com>
In-Reply-To: <20190722185938.9043-3-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 24 Jul 2019 13:07:46 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc_3ZPB5F9gvnLTZOkry=acyo9_TBq62D6rjk=gYDZaNw@mail.gmail.com>
Message-ID: <CAJKOXPc_3ZPB5F9gvnLTZOkry=acyo9_TBq62D6rjk=gYDZaNw@mail.gmail.com>
Subject: Re: [RFC/RFT 2/5] phy: exynos5-usbdrd: add missing tuning of the
 phyutmi signal
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
> Add missing tuning of phyutmi controls to enter suspend and
> resume state.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 32 ++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 3c14bf7718c1..135114d51bc1 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -42,7 +42,13 @@
>
>  #define EXYNOS5_DRD_PHYUTMI                    0x08
>
> +#define PHYUTMI_TXBITSTUFFENH                  BIT(8)
> +#define PHYUTMI_TXBITSTUFFEN                   BIT(7)
>  #define PHYUTMI_OTGDISABLE                     BIT(6)
> +#define PHYUTMI_IDPULLUP                       BIT(5)
> +#define PHYUTMI_DRVVBUS                                BIT(4)
> +#define PHYUTMI_DPPULLDOWN                      BIT(3)
> +#define PHYUTMI_DMPULLDOWN                      BIT(2)
>  #define PHYUTMI_FORCESUSPEND                   BIT(1)
>  #define PHYUTMI_FORCESLEEP                     BIT(0)
>
> @@ -402,6 +408,23 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
>                 LINKSYSTEM_FLADJ(0x20);
>         writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_LINKSYSTEM);
>
> +       reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYUTMI);
> +       /* High-Byte Transmit Bit-Stuffing Enable */
> +       reg |= PHYUTMI_TXBITSTUFFENH;

How this is related with suspend and resume?

> +       /* Low-Byte Transmit Bit-Stuffing Enable */
> +       reg |= PHYUTMI_TXBITSTUFFEN;

The same.

> +       /* release force_sleep & force_suspend */
> +       reg &= ~(PHYUTMI_FORCESLEEP | PHYUTMI_FORCESUSPEND);

Really, why?

> +       /* DP/DM Pull Down Disable */
> +       reg &= ~(PHYUTMI_DMPULLDOWN | PHYUTMI_DPPULLDOWN);

Care to explain why?

> +       /* drvvbus controller signal controls the VBUS valid comparator */
> +       reg &= ~PHYUTMI_OTGDISABLE;

Makes sense, but how is it connected with suspend and resume? It's the
default, BTW...

> +       /* controller signal controls the VBUS Valid comparator */
> +       reg |= PHYUTMI_DRVVBUS;

Again, you are setting the defaults...

> +       /* Enable ID Sampling */
> +       reg |= PHYUTMI_IDPULLUP;

The same...

> +       writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYUTMI);

Does not look good. For UTMI Phy, this will be overwritten few lines
later with exynos5_usbdrd_utmi_init().

> +
>         reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM0);
>         /* Select PHY CLK source */
>         reg &= ~PHYPARAM0_REF_USE_PAD;
> @@ -452,9 +475,14 @@ static int exynos5_usbdrd_phy_exit(struct phy *phy)
>         if (ret)
>                 return ret;
>
> -       reg =   PHYUTMI_OTGDISABLE |
> +       reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYUTMI);
> +       reg |=  PHYUTMI_OTGDISABLE |
>                 PHYUTMI_FORCESUSPEND |
> -               PHYUTMI_FORCESLEEP;
> +               PHYUTMI_FORCESLEEP |
> +               PHYUTMI_DMPULLDOWN |
> +               PHYUTMI_DPPULLDOWN;
> +       reg &= ~(PHYUTMI_DRVVBUS | PHYUTMI_IDPULLUP |
> +               PHYUTMI_TXBITSTUFFENH | PHYUTMI_TXBITSTUFFEN);

No, it looks like random code... why you want to update the register
instead of overwrite it?

Best regards,
Krzysztof

>         writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYUTMI);
>
>         /* Resetting the PHYCLKRST enable bits to reduce leakage current */
> --
> 2.22.0
>
