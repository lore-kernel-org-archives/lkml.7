Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A4C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E1420866
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578098199;
	bh=tkv0Z1WWzZmRoDuCwRkYxYHbYSuAreajbJb1WQt2Zx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LgnMJZFyU7KJ8uSPWlg67t0su+nxpjn116oCAhuDWnOLiWh0CBM+ZWT7AGAFo6yfZ
	 XIMRlutW4/E13XPdfxzCZjgV0XNVM9f2RXQqijKY3Wgpm2CrARnz5zPvhX7sRXs23v
	 /La+3Kkm7WiyOMJAMT66B1Nt8X1nSgNCRO/DLy+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgADAgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:36:38 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35650 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADAgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:36:38 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so43149507iol.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=onR7Gnh/HEyizscz7/aRTtEnV/BPOWeM3TZPN0CJufc=;
        b=CoyTuSgUTl8C9e+UgbF2CZFxuZrLwuuVH8Akq4yKC/U5zrcA5bsHcuNUpBdiq+3e1Y
         K2O1umnTUIvm6KMLX1glVtjZF9GpqddVE6mffSS9bk2r/UKnOmPER0JlqDmbzAo/gaMk
         RotM/aw20Een4WgP8WbEfhnRdt0cn/2RUh+s4WXagG6GyuQ7fKVgaRflVM2LMlAx2wVG
         /eUZhtr8ok7plxSHshM9dZEkJ+qsn1FRkUJ/55wwI90TCB2KRm51q/di/Y7UE/nKZiuY
         CWfYGhlpEvrp3zEx8ObZrC7N3Xu4gU7mgrsTluULzeriSs3VThCDeGj4PaR0drbpdLXF
         ogLw==
X-Gm-Message-State: APjAAAXXzalBBbwTQX7SlM0qGez8LHwif04g2k//Rea0tEcbzn2iNJAf
        jRwVBPfK3EaheQ3LusjM7c47JlA=
X-Google-Smtp-Source: APXvYqx5YN33AA2+0hntWz61/1OT4w2eeJOCbC8i3Jr9FHyyUJHPH4tD8y3KR6YMSP5DkrJw2vTOeg==
X-Received: by 2002:a6b:7310:: with SMTP id e16mr61250484ioh.107.1578098196786;
        Fri, 03 Jan 2020 16:36:36 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l4sm14968126ioa.9.2020.01.03.16.36.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:36:36 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:36:34 -0700
Date:   Fri, 3 Jan 2020 17:36:34 -0700
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx: drop "fsl,aips-bus"
Message-ID: <20200104003634.GA6058@bogus>
References: <1577696078-21720-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577696078-21720-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 08:58:05AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is no binding doc for "fsl,aips-bus", "simple-bus" is enough
> for aips usage, so drop it.

NAK. The AIPS bus has registers, so 'simple-bus' alone is not enough.

What you should do is change 'aips' node names to 'bus'.

> 
> Scirpt:
> sed -i 's/compatible = "fsl,aips-bus", "simple-bus";/compatible = "simple-bus";/'
> arch/arm/boot/dts/imx*
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/boot/dts/imx25.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx31.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx50.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx51.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx53.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
>  arch/arm/boot/dts/imx6sl.dtsi  | 4 ++--
>  arch/arm/boot/dts/imx6sll.dtsi | 4 ++--
>  arch/arm/boot/dts/imx6sx.dtsi  | 6 +++---
>  arch/arm/boot/dts/imx6ul.dtsi  | 4 ++--
>  arch/arm/boot/dts/imx6ull.dtsi | 2 +-
>  arch/arm/boot/dts/imx7s.dtsi   | 6 +++---
>  12 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index 40b95a290bd6..3b7a0b249d80 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -76,7 +76,7 @@
>  		ranges;
>  
>  		aips@43f00000 { /* AIPS1 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x43f00000 0x100000>;
> @@ -333,7 +333,7 @@
>  		};
>  
>  		aips@53f00000 { /* AIPS2 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x53f00000 0x100000>;
> diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
> index 6b62f0745b82..b0e7e3bf8a1a 100644
> --- a/arch/arm/boot/dts/imx31.dtsi
> +++ b/arch/arm/boot/dts/imx31.dtsi
> @@ -64,7 +64,7 @@
>  		};
>  
>  		aips@43f00000 { /* AIPS1 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x43f00000 0x100000>;
> @@ -226,7 +226,7 @@
>  		};
>  
>  		aips@53f00000 { /* AIPS2 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x53f00000 0x100000>;
> diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
> index 0bfe7c91d0eb..961de09b571d 100644
> --- a/arch/arm/boot/dts/imx50.dtsi
> +++ b/arch/arm/boot/dts/imx50.dtsi
> @@ -102,7 +102,7 @@
>  		ranges;
>  
>  		aips@50000000 { /* AIPS1 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x50000000 0x10000000>;
> @@ -390,7 +390,7 @@
>  		};
>  
>  		aips@60000000 {	/* AIPS2 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x60000000 0x10000000>;
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index dea86b98e9c3..86708688371b 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -159,7 +159,7 @@
>  		};
>  
>  		aips@70000000 { /* AIPS1 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x70000000 0x10000000>;
> @@ -441,7 +441,7 @@
>  		};
>  
>  		aips@80000000 {	/* AIPS2 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x80000000 0x10000000>;
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index ed341cfd9d09..f46a83c7d2c4 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -223,7 +223,7 @@
>  		};
>  
>  		aips@50000000 { /* AIPS1 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x50000000 0x10000000>;
> @@ -655,7 +655,7 @@
>  		};
>  
>  		aips@60000000 {	/* AIPS2 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x60000000 0x10000000>;
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index e6b4b8525f98..9b7635e9cf3c 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -295,7 +295,7 @@
>  		};
>  
>  		aips-bus@2000000 { /* AIPS1 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02000000 0x100000>;
> @@ -936,7 +936,7 @@
>  		};
>  
>  		aips-bus@2100000 { /* AIPS2 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02100000 0x100000>;
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 59c54e6ad09a..4b4f22217dfe 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -144,7 +144,7 @@
>  		};
>  
>  		aips1: aips-bus@2000000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02000000 0x100000>;
> @@ -787,7 +787,7 @@
>  		};
>  
>  		aips2: aips-bus@2100000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02100000 0x100000>;
> diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
> index a1bc5bb31756..fac8f22255aa 100644
> --- a/arch/arm/boot/dts/imx6sll.dtsi
> +++ b/arch/arm/boot/dts/imx6sll.dtsi
> @@ -145,7 +145,7 @@
>  		};
>  
>  		aips1: aips-bus@2000000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02000000 0x100000>;
> @@ -664,7 +664,7 @@
>  		};
>  
>  		aips2: aips-bus@2100000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02100000 0x100000>;
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 59bad60a47dc..4499be62c8bb 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -236,7 +236,7 @@
>  		};
>  
>  		aips1: aips-bus@2000000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02000000 0x100000>;
> @@ -831,7 +831,7 @@
>  		};
>  
>  		aips2: aips-bus@2100000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02100000 0x100000>;
> @@ -1189,7 +1189,7 @@
>  		};
>  
>  		aips3: aips-bus@2200000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02200000 0x100000>;
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index d9fdca12819b..63d276fc2477 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -205,7 +205,7 @@
>  		};
>  
>  		aips1: aips-bus@2000000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02000000 0x100000>;
> @@ -772,7 +772,7 @@
>  		};
>  
>  		aips2: aips-bus@2100000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02100000 0x100000>;
> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
> index b7e67d121322..633fa08bc972 100644
> --- a/arch/arm/boot/dts/imx6ull.dtsi
> +++ b/arch/arm/boot/dts/imx6ull.dtsi
> @@ -52,7 +52,7 @@
>  / {
>  	soc {
>  		aips3: aips-bus@2200000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x02200000 0x100000>;
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 139ab9b98472..552b14be14a1 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -317,7 +317,7 @@
>  		};
>  
>  		aips1: aips-bus@30000000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x30000000 0x400000>;
> @@ -669,7 +669,7 @@
>  		};
>  
>  		aips2: aips-bus@30400000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x30400000 0x400000>;
> @@ -809,7 +809,7 @@
>  		};
>  
>  		aips3: aips-bus@30800000 {
> -			compatible = "fsl,aips-bus", "simple-bus";
> +			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0x30800000 0x400000>;
> -- 
> 2.16.4
> 
