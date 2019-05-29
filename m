Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F007CC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C176D2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAr10vNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfE2ICE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:02:04 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50907 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfE2ICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:02:04 -0400
Received: by mail-it1-f194.google.com with SMTP id a186so2228188itg.0;
        Wed, 29 May 2019 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNs/DjgSkhhFm41DuwpPA/uTnvP0iIX8DGGy2jep3vs=;
        b=iAr10vNL8vVbcFz5e/0feLbnzig1ZJRkH/UI2N3ULbh+IM1tfloN9izTztmcEXmqZ3
         enReLIKCSXVRr0lz/V8j2GGj4eXDcdtmHWcUYAQAa15SGM3HyDsXI0FDYiVaxBpp224v
         CnQMfj1BRWPeLLig7KSGXj8EvB2V3PFCfJsdFK5CQy8mRZXUSskt3Kw5aZ09Pw/OAlry
         R4UYssHcp3eYRM4IeHSE4di1x8mVm5uyttSAPOcwgCmNExG7CJI8h4fK1QeV71sgZnb0
         3yWGuHIYwj77ycNMx91lFQql3rB6jNPMbVPMASi57/5MNSPlugzSRd/rJK2K0WH3F62C
         mImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNs/DjgSkhhFm41DuwpPA/uTnvP0iIX8DGGy2jep3vs=;
        b=aDUkOyg5UXw0fIfEzbXn+IWv2PdmUTMuuP+rXXydzm6nlb4RV2YbFmzI7pTHMqqQc2
         tXtly21g4T3/KnSrLZS4bFTB3zGCzq4E7Y0l0j+49TzG5/znHtMOB1LrAOcU4Jh5Ml/x
         TS30uyypnHdeUtmeolLQwXDS8p55Ra4iS1WFdp7EWCWnrKW914RjAU7+ltoZXfMIFsUU
         w1DVL757aTWlgI3loGo2sa92+GSGaeh1Tw5LzISK8JaqFTIHPeV0tuNGW5nXhDhK60+O
         0si5iTYQP7RRPR9PnMKRiFpnXlNATWUwj35sMnNZljBVdlAtxqJxGa8iLxxRwfQkpRwB
         YiEw==
X-Gm-Message-State: APjAAAVYQ5CsnfTKCKLtM6EACHgq+L2uOrb4jphh6QHDOCjR7P4p3bp/
        drG3qJ+l95dtooSoMnz+1oJYDoGVfgde5HuFWHg=
X-Google-Smtp-Source: APXvYqwvFd41OFIbocvUXGP2j7aAAJZCHWUTEAAnUQhiZs6NcfAOpnpbPn3BvlRNusg/hlvVCetJWfwvuEZhJvkEJj0=
X-Received: by 2002:a24:4dd4:: with SMTP id l203mr6122816itb.118.1559116923334;
 Wed, 29 May 2019 01:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190529065948.5492-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190529065948.5492-1-andrew.smirnov@gmail.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Wed, 29 May 2019 16:01:51 +0800
Message-ID: <CAL411-qcHLFL6ATCqHw_jCZDiHvsF32WZM5dJGCC4C0vyiGvwQ@mail.gmail.com>
Subject: Re: [PATCH] usb: phy: mxs: Disable external charger detect in mxs_phy_hw_init()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-usb@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 3:01 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Since this driver already handles changer detction state, copy the
> workaround code currently residing in arch/arm/mach-imx/anatop.c into
> this drier to consolidate the places modifying it.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>
> The intent of this patch is to consolidate all of the code maipulating
> charge detection state to a signle place and if this patch is agreed
> upon I plan to follow it up with this change:
>
> https://github.com/ndreys/linux/commit/7248f2b85b4706760fd33d2ff970e2ea12d3bea7
>
> Thanks,
> Andrey Smirnov
>
>  drivers/usb/phy/phy-mxs-usb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index 1b1bb0ad40c3..6fa16ab31e2e 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -63,6 +63,7 @@
>
>  #define ANADIG_USB1_CHRG_DETECT_SET            0x1b4
>  #define ANADIG_USB1_CHRG_DETECT_CLR            0x1b8
> +#define ANADIG_USB2_CHRG_DETECT_SET            0x214
>  #define ANADIG_USB1_CHRG_DETECT_EN_B           BIT(20)
>  #define ANADIG_USB1_CHRG_DETECT_CHK_CHRG_B     BIT(19)
>  #define ANADIG_USB1_CHRG_DETECT_CHK_CONTACT    BIT(18)
> @@ -250,6 +251,19 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
>         if (mxs_phy->data->flags & MXS_PHY_NEED_IP_FIX)
>                 writel(BM_USBPHY_IP_FIX, base + HW_USBPHY_IP_SET);
>
> +       if (mxs_phy->regmap_anatop) {
> +               unsigned int reg = mxs_phy->port_id ?
> +                       ANADIG_USB1_CHRG_DETECT_SET :
> +                       ANADIG_USB2_CHRG_DETECT_SET;
> +               /*
> +                * The external charger detector needs to be disabled,
> +                * or the signal at DP will be poor
> +                */
> +               regmap_write(mxs_phy->regmap_anatop, reg,
> +                            ANADIG_USB1_CHRG_DETECT_EN_B |
> +                            ANADIG_USB1_CHRG_DETECT_CHK_CHRG_B);
> +       }
> +
>         mxs_phy_tx_init(mxs_phy);
>
>         return 0;
> --
> 2.21.0
>

Reviewed-by: Peter Chen <peter.chen@nxp.com>
