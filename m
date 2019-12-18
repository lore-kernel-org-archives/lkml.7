Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A41C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94652146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfLRMIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:08:00 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:36828 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLRMIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:08:00 -0500
Received: from tarshish (unknown [10.0.8.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 6D1D44405B0;
        Wed, 18 Dec 2019 14:07:57 +0200 (IST)
References: <1576670430-14226-1-git-send-email-peng.fan@nxp.com>
User-agent: mu4e 1.2.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     linux-arm-kernel@lists.infradead.org
Cc:     "robh+dt\@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland\@arm.com" <mark.rutland@arm.com>,
        "shawnguo\@kernel.org" <shawnguo@kernel.org>,
        "kernel\@pengutronix.de" <kernel@pengutronix.de>,
        "festevam\@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] arm: dts: imx7ulp: fix reg of cpu node
In-reply-to: <1576670430-14226-1-git-send-email-peng.fan@nxp.com>
Date:   Wed, 18 Dec 2019 14:07:57 +0200
Message-ID: <87lfr9suoy.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, Dec 18 2019, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> According to arm cpus binding doc,
> "
>       On 32-bit ARM v7 or later systems this property is
>         required and matches the CPU MPIDR[23:0] register
>         bits.
>
>         Bits [23:0] in the reg cell must be set to
>         bits [23:0] in MPIDR.
>
>         All other bits in the reg cell must be set to 0.
> "
>
> In i.MX7ULP, the MPIDR[23:0] is 0xf00, not 0, so fix it.
> Otherwise there will be warning:
> "DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map"
>
> Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/boot/dts/imx7ulp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> index d37a1927c88e..aa9e50178d6b 100644
> --- a/arch/arm/boot/dts/imx7ulp.dtsi
> +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> @@ -40,7 +40,7 @@
>  		cpu0: cpu@0 {

The address suffix in the node name should update to match 'reg'.

>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
> -			reg = <0>;
> +			reg = <0xf00>;
>  		};
>  	};

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
