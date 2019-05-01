Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80103C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A972063F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556733044;
	bh=c1wj1L2mmEp3b5Zc4h0P4p/sRviKAqQNIMtj49lFokg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HgEqSez3VEQi9ezdsAUK2/Y8sL4UIviedADxS2stfbJwLCpKnmRw0FvIMZp8Q5n6D
	 Q+wNRYlGXLsqfxbkB/8Mkn/Xhj0s7vadsfUcPEVlieJ5q+op2z3VfPY81SQWSX0958
	 WNBEz+kVNsZI3FGfZ/NmbV1O7DTlMHgbFqFe/0dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfEARun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfEARum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:50:42 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4CC2063F;
        Wed,  1 May 2019 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556733041;
        bh=c1wj1L2mmEp3b5Zc4h0P4p/sRviKAqQNIMtj49lFokg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gG+sCU7Pn+mQT5F91kLO8vO2FqssmxCjlJLDuSvhFBgsFLDPE20VbFliRvcxUTqYW
         fVAjvtF/VHvokMcFJ9bJ5f9NiePZ8U7ua4194GOFbGJ191dIFLdVADwBTFhWpXm+Dt
         U/k/vMGI81AXUxcNqct2TGxXPKcnz7hzbnFdBTc0=
Received: by mail-qk1-f178.google.com with SMTP id p19so10594044qkm.10;
        Wed, 01 May 2019 10:50:41 -0700 (PDT)
X-Gm-Message-State: APjAAAU72fu9/sqAXS1JB7Ui8775tD55q5vdVrK0WISnDjVpoS/a2m/r
        llC5mlFwFvlH1RJsei1xIyfUsPlsiYpGJodmUQ==
X-Google-Smtp-Source: APXvYqxaALIZpIXVBCrI5e0AF+QhkCcGm6801hN03DMuRHPJPYGqONfx33oDbS0RZyhIRlVGgu4C1MuY3dbTFHDfvjc=
X-Received: by 2002:a37:5c81:: with SMTP id q123mr39758359qkb.29.1556733040411;
 Wed, 01 May 2019 10:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190423114424.3578-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190423114424.3578-1-yinbo.zhu@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 1 May 2019 12:50:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+4g+inxc+qcC3oLrXuR+L9AMvXFShGaU5Y3iRDsK3P6A@mail.gmail.com>
Message-ID: <CAL_Jsq+4g+inxc+qcC3oLrXuR+L9AMvXFShGaU5Y3iRDsK3P6A@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: ls1028: dtsi: Add esdhc node in dtsi
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 6:42 AM Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Ashish Kumar <Ashish.Kumar@nxp.com>
>
> This patch is to add esdhc node and enable SD UHS-I,
> eMMC HS200 for ls1028ardb/ls1028aqds board.
>
> Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls1028a-qds.dts    |  8 ++++++
>  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 13 +++++++++
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 27 +++++++++++++++++++
>  3 files changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 14c79f4691ea..180e5d2a00d1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -42,6 +42,14 @@
>         status = "okay";
>  };
>
> +&esdhc {
> +       status = "okay";
> +};
> +
> +&esdhc1 {
> +       status = "okay";
> +};
> +
>  &i2c0 {
>         status = "okay";
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index f86b054a74ae..1bfaf4294db4 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -30,6 +30,19 @@
>         };
>  };
>
> +&esdhc {
> +       status = "okay";
> +       sd-uhs-sdr104;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr12;
> +       };
> +
> +&esdhc1 {
> +       status = "okay";
> +       mmc-hs200-1_8v;
> +       };
> +
>  &i2c0 {
>         status = "okay";
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 2896bbcfa3bb..d13cd3fb455b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -274,6 +274,33 @@
>                         status = "disabled";
>                 };
>
> +               esdhc: esdhc@2140000 {

mmc@...

> +                       compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +                       reg = <0x0 0x2140000 0x0 0x10000>;
> +                       interrupts = <0 28 0x4>; /* Level high type */
> +                       clock-frequency = <0>;

Filled in by bootloader? If so, add a comment.

> +                       clocks = <&clockgen 2 1>;
> +                       voltage-ranges = <1800 1800 3300 3300>;
> +                       sdhci,auto-cmd12;
> +                       little-endian;
> +                       bus-width = <4>;
> +                       status = "disabled";
> +               };
> +
> +               esdhc1: esdhc@2150000 {

mmc@...

> +                       compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +                       reg = <0x0 0x2150000 0x0 0x10000>;
> +                       interrupts = <0 63 0x4>; /* Level high type */
> +                       clock-frequency = <0>;
> +                       clocks = <&clockgen 2 1>;
> +                       voltage-ranges = <1800 1800 3300 3300>;
> +                       sdhci,auto-cmd12;
> +                       broken-cd;
> +                       little-endian;
> +                       bus-width = <4>;
> +                       status = "disabled";
> +               };
> +
>                 sata: sata@3200000 {
>                         compatible = "fsl,ls1028a-ahci";
>                         reg = <0x0 0x3200000 0x0 0x10000>,
> --
> 2.17.1
>
