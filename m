Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AD1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6002206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmWnxkSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfGaM4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:56:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37724 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfGaM4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:56:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so11254673ljn.4;
        Wed, 31 Jul 2019 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibb9l9pCzIPRO+qO4A9wjd4O5BSt2O3HIIkOx8g91QE=;
        b=dmWnxkSGqzJLdXtRSEMnp2346Q5fNymYmV9Q0cYScy4XLd+85hWOnQNs75lW0PNdwi
         s+cUZbR31z+McMivRqz/ET13p8j7d13H8ixyBqYdGa01zT7PikehyrI8kfDVPwYS9GZ/
         zFYiAbkT8SEDQlepklQsZJlRWxVOuLPB7aeZRY6sJxRIzVWQ7zcOtuyLdPKG3zUh5RlI
         0oHbwEACO5U76xqu+E+N3nQGmLmWb6O01Gt+vggt6F6esPtXtzRZImt6fDQjjfjF62J1
         6jJc7IZ/vQE8pseqlqw2VdpZc531GTaaqylI1C2FXgwhnUbssJN4Uo7PRIKmetfxruYE
         /qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibb9l9pCzIPRO+qO4A9wjd4O5BSt2O3HIIkOx8g91QE=;
        b=ZaPzxSs2b5LTnk8cPbJS1quD7HJ0gk9a2mm+dNi5r6p8p8GC2pBPrHeSaoNFVAr55W
         u/0kCy3W4B6n6PXQ/aHllwOIl49PLXZgS0E/bUy4o33ByDewXWOVy5Ufz7Ql1zS1vrFT
         nEu7k9hbD9IdLgQmPs+62TDW32rIS6VNnirLxbklG2Fpti2ckc1YwKtrhWw147h7ZXjL
         e8AGZiLIItyK6azyNfSQcNk8MPOwNwZsfmxW9xOcJ20Joagzk9NANkHb2WEFk2HOCtVb
         RPtrUPq0cGA7unVtDhtnVcc0xKmm+6ROO+Fjr8vivB+BRvm2VzO2gypts88OCXAiZFNV
         0R3Q==
X-Gm-Message-State: APjAAAWLHPDli1mBZqXdqYelsgb6V1acuv4ptux80tQilxrFm1fdPIfv
        YzErF+UASpNgb+5aGhHvT8a0I2mZ0WxlwhfGPAWNqB+y
X-Google-Smtp-Source: APXvYqwHLa09vrCGuEjsqB9Bo/QP8nZztRJ5LvWsIK2qv5mAo9aSVSVVIUILsK+mjb1tTQ98idf29i7lGxgDBiL/LM8=
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr14146346ljb.211.1564577759040;
 Wed, 31 Jul 2019 05:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190731123750.25670-1-philippe.schenker@toradex.com> <20190731123750.25670-8-philippe.schenker@toradex.com>
In-Reply-To: <20190731123750.25670-8-philippe.schenker@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 31 Jul 2019 09:56:05 -0300
Message-ID: <CAOMZO5B5HnqpLrDjyGtqSQpVXmcoZuGLvCzKVUhwLb-_ZO_Xog@mail.gmail.com>
Subject: Re: [PATCH v2 07/20] ARM: dts: imx7-colibri: fix 1.8V/UHS support
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 9:38 AM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> From: Stefan Agner <stefan.agner@toradex.com>
>
> Add pinmuxing and do not specify voltage restrictions in the
> module level device tree.

It would be nice to explain the reason for doing this.

> Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
>
> Changes in v2: None
>
>  arch/arm/boot/dts/imx7-colibri.dtsi | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index 16d1a1ed1aff..67f5e0c87fdc 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -326,7 +326,6 @@
>  &usdhc1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
> -       no-1-8-v;
>         cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>         disable-wp;
>         vqmmc-supply = <&reg_LDO2>;
> @@ -671,6 +670,28 @@
>                 >;
>         };
>
> +       pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
> +               fsl,pins = <
> +                       MX7D_PAD_SD1_CMD__SD1_CMD       0x5a
> +                       MX7D_PAD_SD1_CLK__SD1_CLK       0x1a
> +                       MX7D_PAD_SD1_DATA0__SD1_DATA0   0x5a
> +                       MX7D_PAD_SD1_DATA1__SD1_DATA1   0x5a
> +                       MX7D_PAD_SD1_DATA2__SD1_DATA2   0x5a
> +                       MX7D_PAD_SD1_DATA3__SD1_DATA3   0x5a
> +               >;
> +       };
> +
> +       pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
> +               fsl,pins = <
> +                       MX7D_PAD_SD1_CMD__SD1_CMD       0x5b
> +                       MX7D_PAD_SD1_CLK__SD1_CLK       0x1b
> +                       MX7D_PAD_SD1_DATA0__SD1_DATA0   0x5b
> +                       MX7D_PAD_SD1_DATA1__SD1_DATA1   0x5b
> +                       MX7D_PAD_SD1_DATA2__SD1_DATA2   0x5b
> +                       MX7D_PAD_SD1_DATA3__SD1_DATA3   0x5b
> +               >;
> +       };

You add the entries for 100MHz and 200MHz, but I don't see them being
referenced anywhere.
