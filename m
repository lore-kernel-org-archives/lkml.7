Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BBAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F3F21BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sF6dihV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfHGLSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:18:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38858 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfHGLSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:18:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so63686804lfj.5;
        Wed, 07 Aug 2019 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iBTa8F4iscBu82+17pzT3Qab/EEBbunWl8afY7niSU=;
        b=sF6dihV43csLq+fA0fDyAkqui6Go9Flk6Ct4EVEwIhwKA+FDOE33TnpFLqnjGA7NYk
         Bkw66KLdBZg3p6Az7vaeWkEJk5FVKfmEPpm533tF5X25Qf68Uzt7D/A5wSTO4s29Fg9x
         jeufz5SpgKdTTxdyA5RF2XNcbctlTFs5RrSVc77DiYB1ouw7p9dYUabMQjidkZdOy+B2
         74bfZsUxEuM15OASr9ocJErtO8WoEO3JH7YBXQZ1d1szuhNWMd9nqsvMMAqtpTzAdsuW
         W0wfCOjOn1qRD5saBPH9tmSI01KGPU7wV0TDt8yOz05FYfYw29xHGEyHrM8Dg2I7Dwdk
         eoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iBTa8F4iscBu82+17pzT3Qab/EEBbunWl8afY7niSU=;
        b=MUxMJJOYU0yewuI3GL+2/5zizyK04FqHfSnQN0BXtMegyxyUYfSkI+CS2a4wxzJauv
         eNa6vQe//tGsyYHePTSzkqsQTfKJ20NRIb08sUnTbWC953vjiRDoe+KFlNVCS879QL2b
         uMzu9h1kYqvCsSnwfrOyQ52pQk8arWe4zTxI7dTXdpMNELzOyr8lI7W+IeJAqIeVvTzI
         34rH2HgbnV91RwnQ2sRzpx/V1H2tQHD7jQgdlUkGAvdkpc5L8VC2Uet/C6iK5IcNpgTT
         qaPFuKteOlYULxBYSAixOtTPqjY6qd9qyc0HBPRFwO6HoQcwdrNh8Bd8ljQtVKjxeoY7
         z2Iw==
X-Gm-Message-State: APjAAAXcJSOSZxEBytMy7BBU+XSClox4W4Nvdc15a7JOuHkeBcaXKRxG
        3Xxsc9C4DDd2g7hd3QoxdOSGpLJSmRsYHNygSUc=
X-Google-Smtp-Source: APXvYqzqCdLDUtnhayzCog26NrhjC5YUt3AaS8RJSxFNakCbMqYeiF7YIxJ4CfOxxBeLe6dzO1HWwkAP+VI5/ixRm20=
X-Received: by 2002:ac2:4a6e:: with SMTP id q14mr5361835lfp.80.1565176732480;
 Wed, 07 Aug 2019 04:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190807082556.5013-1-philippe.schenker@toradex.com> <20190807082556.5013-8-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-8-philippe.schenker@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Aug 2019 08:19:13 -0300
Message-ID: <CAOMZO5CdWmVKXmNSLdbsmnU6_ZKwbeVArtOQzuTg_gtqTUnVag@mail.gmail.com>
Subject: Re: [PATCH v3 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
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

Hi Philippe,

On Wed, Aug 7, 2019 at 5:26 AM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> From: Stefan Agner <stefan.agner@toradex.com>
>
> Add pinmuxing and do not specify voltage restrictions for the usdhc
> instance available on the modules edge connector. This allows to use
> SD-cards with higher transfer modes if supported by the carrier board.
>
> Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>
> ---
>
> Changes in v3:
> - Add new commit message from Stefan's proposal on ML

The commit message has been improved, but there is also another point
I mentioned earlier:

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

This new entry has been added and it is not referenced.

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

Same here.
