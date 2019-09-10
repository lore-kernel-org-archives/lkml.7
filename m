Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D389CC49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DDD206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt+lQTaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436755AbfIJQKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:10:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38563 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfIJQKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:10:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id c12so13946086lfh.5;
        Tue, 10 Sep 2019 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqFfEPSyt57HyJgTRNjWFPdEaAAXtdhfsQD9TllCPkE=;
        b=Wt+lQTaaGk6pzUmlwB5BiAYmxSlDO46vBfdmUIwYg83Ws9mVY1hvxndBrFIyDtutb+
         b+CiBYLK/0nwX1fK5AOxVgaQmHyBk/KCBbb4X1Ayh96UoR5ifBmMDrfHE0GZbp27rgqa
         bMeqtZ+VyRPo19quamd07pXAQAolxKZ28adC9aNNLRvv+KuuZTiitjjGBW8pJ/Klgulu
         /WaLob/DOTwO/PUkqF9f0qJiWfJNQkH+OkxlvrrRhwkRXkPkjCs1EbX4zBJEKiIw7uDD
         g/xPKTyVsqT2HzpgXb/hjBkoy4H/A38h5su2WI5WHP+d2GWG3uDzm/5qsNL9wwDblHQf
         /LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqFfEPSyt57HyJgTRNjWFPdEaAAXtdhfsQD9TllCPkE=;
        b=sJgvsk3gWGBsN9Yvv9Cn0rjAMwb+0x1UX4KASuuHatb7UXW8YCDW04liMdQqX0Weqs
         V1BKUbmu/SjXsYCE+KgOTTgNPUyplr8QM7tl5dGpzitGefuAa891qmDEh8cZmOUOz4sa
         pF85CdUQwQEYYmSatgBhuXaN3/YXeVMn7gcA1hsX4l5CaTgMQeDF/QR+wff8YwesdZbw
         GE5/SfVFqo65CNw+NRe/PlYId8ngFD8RT/VxIz3mgkvBVkJClSyDWU6IU+vBgGJW+mI5
         39g0aXSZggW3LXT7UgOvte8MXLfFyPxoMKq3lYLkPSDO6Yz5FdhIUC5EbTB4xTC4xn4s
         w3Wg==
X-Gm-Message-State: APjAAAUtCj+VTgWqIutIMw9Azwp3RtR82BfnHm1cbCcAvUQT8tqA6yXA
        3lSMF4v/TCROrFtdl8/6B6/ZlVWRHVkAplWTgMU=
X-Google-Smtp-Source: APXvYqy4Ju69ssa5vOob9oJNZreWvVab2sQCQY0k5c5kzjsbAtMhkA0CX7URyFEMwEg7AAVKyeO88isyJEbqHfTbq8c=
X-Received: by 2002:ac2:47e3:: with SMTP id b3mr20007804lfp.80.1568131834903;
 Tue, 10 Sep 2019 09:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190910155507.491230-1-tinywrkb@gmail.com>
In-Reply-To: <20190910155507.491230-1-tinywrkb@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 10 Sep 2019 13:10:24 -0300
Message-ID: <CAOMZO5Ae=ww1ar7FmgLmxf5jDoPaToBhz_qYMGrG+orP64hJ-w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s max-speed
To:     tinywrkb <tinywrkb@gmail.com>, Jon Nettleton <jon@solid-run.com>,
        Baruch Siach <baruch@tkos.co.il>
Cc:     Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Jon and Baruch

On Tue, Sep 10, 2019 at 12:55 PM tinywrkb <tinywrkb@gmail.com> wrote:
>
> Cubox-i Solo/DualLite carrier board has 100Mb/s magnetics while the
> Atheros AR8035 PHY on the MicroSoM v1.3 CPU module is a 1GbE PHY device.
>
> Since commit 5502b218e001 ("net: phy: use phy_resolve_aneg_linkmode in
> genphy_read_status") ethernet is broken on Cubox-i Solo/DualLite devices.
>
> This adds a phy node to the MicroSoM DTS and a 100Mb/s max-speed limit
> to the Cubox-i Solo/DualLite carrier DTS.
>
> Signed-off-by: tinywrkb <tinywrkb@gmail.com>
> ---
> This patch fixes ethernet on my Cubox-i2-300-D which is limited to 100Mb/s,
> afaik due to the carrier board  magnetics, and was since commit 5502b218e001
> ("net: phy: use phy_resolve_aneg_linkmode in genphy_read_status")
>
> The AR8035 PHY on the CPU module reports to the driver as 1GbE capable
> via MII_BSMR's BMSR_ESTATEN status bit, the auto-negotiation sets the
> speed at 1GbE while the carrier board can't support it.
> Same behavior with the generic phy_device and the at803x drivers.
>
> While the PHY is on the CPU module board I added the max-speed limit to
> the cubox-i carrier DTS as I suspect that if the Solo or DualLite v1.3
> MicroSoM will be connected to a 1GbE capable carrier board then it would
> work correctly with 1GbE.
>
> I can confirm that this commit doesn't break networking on the my
> Cubox-i4Pro Quad (i4P-300-D) with it's 1GbE capable carrier board, and
> was tested separately with the generic phy_device and at803x drivers.
>
>  arch/arm/boot/dts/imx6dl-cubox-i.dts  | 4 ++++
>  arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 9 +++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6dl-cubox-i.dts b/arch/arm/boot/dts/imx6dl-cubox-i.dts
> index 2b1b3e193f53..cfc82513c78c 100644
> --- a/arch/arm/boot/dts/imx6dl-cubox-i.dts
> +++ b/arch/arm/boot/dts/imx6dl-cubox-i.dts
> @@ -49,3 +49,7 @@
>         model = "SolidRun Cubox-i Solo/DualLite";
>         compatible = "solidrun,cubox-i/dl", "fsl,imx6dl";
>  };
> +
> +&ethphy {
> +       max-speed = <100>;
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> index 6d7f6b9035bc..969bc96c3f99 100644
> --- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> @@ -57,6 +57,15 @@
>         phy-reset-duration = <2>;
>         phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
>         status = "okay";
> +       phy-handle = <&ethphy>;
> +       mdio {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               ethphy: ethernet-phy@0 {
> +                       compatible = "ethernet-phy-ieee802.3-c22";
> +                       reg = <0>;
> +               };
> +       };
>  };
>
>  &iomuxc {
> --
> 2.23.0
>
