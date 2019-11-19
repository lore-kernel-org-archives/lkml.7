Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABCDC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8795B2245B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajcWQiLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfKSTch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:32:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41846 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKSTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:32:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id m4so19759377ljj.8;
        Tue, 19 Nov 2019 11:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gMwxQZ0NGeg1EorIa2meDnvhnfgkvViZuHv3dYidgxs=;
        b=ajcWQiLfE9po51PPLxd3b53VUtVor9+JUkvzHnoUpI/VO7A7+kEmHi3lAhkrCFes89
         gG75UUKyfyr0ANCiemd1klNeCbTeYbTvR1yppysjuU2Y1XOpQvGl9WFxDFJR52BQiAfs
         jr1QH2cTtKQg/56WGCQYtwvXYdXUqYjwcsdCtUwytDllrrrI1PnnjCgRErLuNlnlKDLr
         ON/x/uOemadHum1FrcF6sVqqkpA/QoW0zaDCdddUCMBqN37PysXCGu9AQNpdXpn33bSg
         hyz1Tj9Y+7iTxGvJQtEZtc7tSAA/wjPMHax7SAEthptArmk9mQlLL7SCBiltDiNTzwYJ
         LJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gMwxQZ0NGeg1EorIa2meDnvhnfgkvViZuHv3dYidgxs=;
        b=Aco1SRsKlFdV8nPhWUjZpl0jOpjr7wMe1Mp6sDcuVrjEjeA0iictrCI8J37ACU044a
         1SUjbvUq6H8pBsZD6qBsqrC4c8ckZTt1imSo1dCsFQQ/yniVUhwfkUndv8RGBIJl+JX/
         /S/5MoPLwxQ75QRMk3/a2bBVAgoWlKQqKoRa3L6LBYc5tEbNEs5n4n2hcUaQcTxf93Uf
         h1PzoGKUneuJCcUgyi51CIcTcYZiUxzdwoLS5tx0gJwKLxMoCT1iP2+9qcU4DpcmJ5A+
         3FbFQCtbm8xf649JR63ORvIv4iH31lH/7LiNCT6KvSLw6FeetZinKvSAW9dwlh+upSZr
         0BGg==
X-Gm-Message-State: APjAAAXqZjcUzod9d7Ya3DwFc3xFkRl4dCT2ZomCBvRKSoh8phPdPj19
        vcJ695pjB+3xkNqHat/jN9zbyXWj
X-Google-Smtp-Source: APXvYqzjiSocR9GOXiFu/zz9ZV7iWYsxUSAp/+7quqQcWEl+zsxBDS1SIEfmOBsvrxDpI1OIeb6tiw==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr5655871ljw.74.1574191954093;
        Tue, 19 Nov 2019 11:32:34 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id t8sm11062627lfl.51.2019.11.19.11.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 11:32:33 -0800 (PST)
Subject: Re: [PATCH v1 12/17] arm: tegra: Add clock-cells property to Tegra
 pmc
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-13-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e4cbf86b-07b2-f0a1-141f-facb7340a604@gmail.com>
Date:   Tue, 19 Nov 2019 22:32:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574146234-3871-13-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.11.2019 09:50, Sowjanya Komatineni пишет:
> Tegra pmc has 3 clocks clk_out_1, clk_out_2, clk_out_3 with mux and gate
> for each of these clocks as part of pmc and Tegra pmc is the clock provider
> for these clocks.
> 
> This patch adds #clock-cells property with 1 clock specifier to
> the Tegra pmc node.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 4 +++-
>  arch/arm/boot/dts/tegra124.dtsi | 4 +++-
>  arch/arm/boot/dts/tegra30.dtsi  | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> index 0d7a6327e404..b8f12f24f314 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/memory/tegra114-mc.h>
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/tegra-pmc.h>
>  
>  / {
>  	compatible = "nvidia,tegra114";
> @@ -514,11 +515,12 @@
>  		status = "disabled";
>  	};
>  
> -	pmc@7000e400 {
> +	pmc: pmc@7000e400 {
>  		compatible = "nvidia,tegra114-pmc";
>  		reg = <0x7000e400 0x400>;
>  		clocks = <&tegra_car TEGRA114_CLK_PCLK>, <&clk32k_in>;
>  		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
>  	};
>  
>  	fuse@7000f800 {
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> index 413bfb981de8..d0802c4ae3bf 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/tegra124-car.h>
>  #include <dt-bindings/thermal/tegra124-soctherm.h>
> +#include <dt-bindings/soc/tegra-pmc.h>
>  
>  / {
>  	compatible = "nvidia,tegra124";
> @@ -595,11 +596,12 @@
>  		clocks = <&tegra_car TEGRA124_CLK_RTC>;
>  	};
>  
> -	pmc@7000e400 {
> +	pmc: pmc@7000e400 {
>  		compatible = "nvidia,tegra124-pmc";
>  		reg = <0x0 0x7000e400 0x0 0x400>;
>  		clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
>  		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
>  	};
>  
>  	fuse@7000f800 {
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index 55ae050042ce..4d5e9d0001d3 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/memory/tegra30-mc.h>
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/tegra-pmc.h>
>  
>  / {
>  	compatible = "nvidia,tegra30";
> @@ -714,11 +715,12 @@
>  		status = "disabled";
>  	};
>  
> -	pmc@7000e400 {
> +	pmc: pmc@7000e400 {
>  		compatible = "nvidia,tegra30-pmc";
>  		reg = <0x7000e400 0x400>;
>  		clocks = <&tegra_car TEGRA30_CLK_PCLK>, <&clk32k_in>;
>  		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
>  	};
>  
>  	mc: memory-controller@7000f000 {
> 

What about Tegra20?
