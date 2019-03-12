Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB2214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAXFgJeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCLCfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:35:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39894 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfCLCfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:35:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id p8so954768wrq.6;
        Mon, 11 Mar 2019 19:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3wMeIYDHFPCDSec/vs9fah6iy98pJ3kn5/N76rO+vI=;
        b=qAXFgJeYvSLxt3UnWixuiOwE3JC47i3kaoh3YgsIvtj58uXrGCfiwF4jw9di2I5Qph
         ldN08FrLNRxRweCHDhGMu73v5r61NxebvwPNr3kxEqlhx2kBFv4to2lWonkXyKkb+to6
         rXm7byY6aTs8xwtv+8yn2g3BoqagrsjthcPSpqUgCI0OUzA0W/wCdswhdNxBTvxJCEsW
         2rSLOjsC7HDNGE7xOh1iO3T8ThQqU+KFtY21JzeNWSOozoXGLWuWalV9VtKTNDAjyktw
         SrcZviFHHnMdky+1HFr9X/g9zbYRsccVTMBzqAftq1gQrzNnIxXvq+zTx1MtfakysJJa
         b0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3wMeIYDHFPCDSec/vs9fah6iy98pJ3kn5/N76rO+vI=;
        b=Wt+5xvhxEaGxjVknEjAkF2Ek0RFpOh9v8KQ3vzh30Zl2H9K0yKtcPhDh1F16PEecZL
         hua4ZcuGIdCUgoyb1mUH3VQQWR6dB8tOdRLLDsn9GDwGgrZJLT73pA6Dox95gmDHm8Uq
         RrbsxiTKYrkpvOQuHlABZbqXCiwFnSSHAvMp7HhgDFkRHQMsBsiwoZad2qnF5Rqpmkei
         SmJFWiry33pjyCEJtOcHOLfzoOYC9WDnOebDyQgWiZKEwgWEDsGVEZ3l/HlPEqsvn1ki
         hsUaR0s1tv7r4eMvPbYA7vG0W6/BrydGIVh3cHAA3fsaLiwNC8DOuOgdutNPhF2CUL1N
         Ok/Q==
X-Gm-Message-State: APjAAAVa4+PvESdYI5RydqBlgeuXJvnt08lMclJulApLQS3P33P3WWmu
        3+CHz1ees8W8tK9/yBvmXOLnlCYHRdKeDFU1re8=
X-Google-Smtp-Source: APXvYqyDtwHPU/h6/Hga4dPqCUOb5T60EKmzNEYqoIAldTnvyeLX0tu+ddHyxOoBsNkQ2dDX3EjalZnlg7yIoDxcRn8=
X-Received: by 2002:adf:e548:: with SMTP id z8mr22782471wrm.52.1552358136399;
 Mon, 11 Mar 2019 19:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190311213124.29325-1-angus@akkea.ca>
In-Reply-To: <20190311213124.29325-1-angus@akkea.ca>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 11 Mar 2019 19:35:25 -0700
Message-ID: <CAHQ1cqEHr1mB2EH3-fJPrYa+nkcWPPjmCTjSt-XsDnJp-SCf+w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq: enable the thermal management
 unit (TMU)
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, daniel.baluta@nxp.com,
        agx@sigxcpu.org, dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 2:35 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> These are the TMU nodes from the NXP vendor kernel
>

Hey Angus,

TMU block supports multiple thermal zones and vendor kernel doesn't
really account for that (see below). Latest version of the driver in
thermal tree now actually supports that feature (mulit-sensor), so I
think the code in DT should reflect that as well. I recently submitted
a series adding HWMON integration for TMU
(https://lore.kernel.org/lkml/20190222200508.26325-1-andrew.smirnov@gmail.com/T/#u)
and this is my take on this patch:

https://github.com/ndreys/linux/commit/09931e3d60af0a74377307b433db97da1be31570

All of the code there is up for grabs, if you feel like using it.

> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 83 +++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 9155bd4784eb..087620c6e17f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/power/imx8mq-power.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
>  #include "imx8mq-pinfunc.h"
>
>  / {
> @@ -89,6 +90,7 @@
>                         reg = <0x0>;
>                         enable-method = "psci";
>                         next-level-cache = <&A53_L2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 A53_1: cpu@1 {
> @@ -210,6 +212,87 @@
>                                 #interrupt-cells = <2>;
>                         };
>
> +                       tmu: tmu@30260000 {
> +                               compatible = "fsl,imx8mq-tmu";
> +                               reg = <0x30260000 0x10000>;
> +                               interrupt = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +                               little-endian;
> +                               fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
> +                               fsl,tmu-calibration = <0x00000000 0x00000023
> +                                                      0x00000001 0x00000029
> +                                                      0x00000002 0x0000002f
> +                                                      0x00000003 0x00000035
> +                                                      0x00000004 0x0000003d
> +                                                      0x00000005 0x00000043
> +                                                      0x00000006 0x0000004b
> +                                                      0x00000007 0x00000051
> +                                                      0x00000008 0x00000057
> +                                                      0x00000009 0x0000005f
> +                                                      0x0000000a 0x00000067
> +                                                      0x0000000b 0x0000006f
> +
> +                                                      0x00010000 0x0000001b
> +                                                      0x00010001 0x00000023
> +                                                      0x00010002 0x0000002b
> +                                                      0x00010003 0x00000033
> +                                                      0x00010004 0x0000003b
> +                                                      0x00010005 0x00000043
> +                                                      0x00010006 0x0000004b
> +                                                      0x00010007 0x00000055
> +                                                      0x00010008 0x0000005d
> +                                                      0x00010009 0x00000067
> +                                                      0x0001000a 0x00000070
> +
> +                                                      0x00020000 0x00000017
> +                                                      0x00020001 0x00000023
> +                                                      0x00020002 0x0000002d
> +                                                      0x00020003 0x00000037
> +                                                      0x00020004 0x00000041
> +                                                      0x00020005 0x0000004b
> +                                                      0x00020006 0x00000057
> +                                                      0x00020007 0x00000063
> +                                                      0x00020008 0x0000006f
> +
> +                                                      0x00030000 0x00000015
> +                                                      0x00030001 0x00000021
> +                                                      0x00030002 0x0000002d
> +                                                      0x00030003 0x00000039
> +                                                      0x00030004 0x00000045
> +                                                      0x00030005 0x00000053
> +                                                      0x00030006 0x0000005f
> +                                                      0x00030007 0x00000071>;
> +                               #thermal-sensor-cells =  <0>;

As per #thermal-sensor-cells must be 1 (see
Documentation/devicetree/bindings/thermal/qoriq-thermal.txt), since as
I mentioned above there are multiple thermal zones (CPU, GPU, VPU).

> +                       };
> +
> +                       thermal-zones {
> +                               cpu-thermal {
> +                                       polling-delay-passive = <250>;
> +                                       polling-delay = <2000>;
> +                                       thermal-sensors = <&tmu>;

Ditto.

Thanks,
Andrey Smirnov
