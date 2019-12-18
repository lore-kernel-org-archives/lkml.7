Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628A4C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3868F2072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj3Ue8r6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLRH4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:56:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41413 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:56:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so960126lfp.8;
        Tue, 17 Dec 2019 23:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zpm+bbtYAcwWy2Wn6SaFwFyPuVEkpHVCpuc/3F/FRUY=;
        b=Tj3Ue8r6fMPYf59EIcD9ZFV13au+99m3LBvJqqyrcZlVwQcYSWpCMD8NTdZBI3447i
         2EWNCpxwlHZYTkF4wx01v8Mt6fFOybeKzXQynBJakPkUnw4XxwPDfGRQ7LsW/Mr4EgF1
         Hjrzmw0zPk+d5srlvGZGJs0vbhvTrmXyTsCpTOwULQq3liaIRQmNdOIoJK3nNVLO5Yyq
         M8Y5wTa91AVDqGxFghywXYUM+FCFgrEQzyZEFmP7y+Mdbf7YktH++8A6QwiHx7WUWkpi
         mfRVCqHYoP1yliiifNOLoxyDBULSXPY8jvE5wqUXziWr1JTczvopwdXKXi1861kodjPt
         JBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zpm+bbtYAcwWy2Wn6SaFwFyPuVEkpHVCpuc/3F/FRUY=;
        b=O/HsPUNKt/IkRqVHCez+9a55VTDMn9ZZbBqelwLxXTMxQSEB5RC051Ic8obnxhxRta
         hrDbz1AAV+UfjI+Rz34POKqOzmEb4Sz+1PkGIsCHcu9JNHkITHRF2GzNxQ9xA+eOL9aa
         jP/jA67fFR8FmkrQNHoaKDO4S6DxhVIFErbO/fEvdXPGM8kenfiOrO0mgJdE0O5dhyHZ
         bdzoZ5rVyIVRWGFd7mpqZJFV9RXsBaCLpU+d/MlbSrLRm2Av8+IM+0dEuPX3IOooHOGs
         UKrCXM37a0asjcYuWmQ1ujE1U9yiSFGRS/RmfM9ephS59To5rmIhE/NdInSqXj5lYkKW
         JfGw==
X-Gm-Message-State: APjAAAWNpiMKb3SGqXgOuErhkZTvNUsrQnirAa6ZT7yy728hcf41v3/S
        ivro6UtCb8wjgnprG+udUk6S5gvk
X-Google-Smtp-Source: APXvYqxMWkYgp88Kq6PpBwqkoYYP30jFZD030byRM5QecwMKflVmZlbheXpLqLsqNu4pV7KXz1x+JA==
X-Received: by 2002:a19:e011:: with SMTP id x17mr808536lfg.59.1576655773754;
        Tue, 17 Dec 2019 23:56:13 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u20sm620436lju.34.2019.12.17.23.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 23:56:13 -0800 (PST)
Subject: Re: [PATCH v4 05/19] dt-bindings: soc: tegra-pmc: Add Tegra PMC clock
 bindings
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-6-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8cd89182-a430-e9f2-bba7-bad23a7960fd@gmail.com>
Date:   Wed, 18 Dec 2019 10:56:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576613046-17159-6-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2019 23:03, Sowjanya Komatineni пишет:
> Tegra PMC has 3 clocks clk_out_1, clk_out_2, and clk_out_3.
> 
> This patch documents PMC clock bindings and adds a header defining
> Tegra PMC clock ids.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 37 +++++++++++++++++++++-
>  include/dt-bindings/soc/tegra-pmc.h                | 15 +++++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/soc/tegra-pmc.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index cb12f33a247f..80cdcad4ab8c 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -21,6 +21,10 @@ Required properties:
>  - clock-names : Must include the following entries:
>    "pclk" (The Tegra clock of that name),
>    "clk32k_in" (The 32KHz clock input to Tegra).
> +- #clock-cells : Should be 1 for Tegra30 and higher.
> +  In clock consumers, this cell represents the PMC clock ID.
> +  The assignments may be found in header file
> +  <dt-bindings/soc/tegra-pmc.h>.
>  
>  Optional properties:
>  - nvidia,invert-interrupt : If present, inverts the PMU interrupt signal.
> @@ -80,11 +84,12 @@ Optional nodes:
>  Example:
>  
>  / SoC dts including file
> -pmc@7000f400 {
> +pmc: pmc@7000f400 {
>  	compatible = "nvidia,tegra20-pmc";
>  	reg = <0x7000e400 0x400>;
>  	clocks = <&tegra_car 110>, <&clk32k_in>;
>  	clock-names = "pclk", "clk32k_in";
> +	#clock-cells = <1>;
>  	nvidia,invert-interrupt;
>  	nvidia,suspend-mode = <1>;
>  	nvidia,cpu-pwr-good-time = <2000>;
> @@ -171,6 +176,7 @@ Example:
>  		reg = <0x0 0x7000e400 0x0 0x400>;
>  		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
>  		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
>  
>  		powergates {
>  			pd_audio: aud {
> @@ -260,6 +266,7 @@ Pad configuration state example:
>  		reg = <0x0 0x7000e400 0x0 0x400>;
>  		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
>  		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
>  
>  		...
>  
> @@ -298,3 +305,31 @@ Pinctrl client example:
>  		pinctrl-1 = <&hdmi_on>;
>  		pinctrl-names = "hdmi-on", "hdmi-off";
>  	};
> +
> +== Clock Control ==
> +
> +Tegra PMC has 3 clocks clk_1, clk_2 and clk_3. Each of these clocks has
> +source selection and enable/disable gate.
> +Parent/source for these clocks can be either of osc, osc_div2, osc_div4,
> +or extern clock from Tegra CAR module.
> +
> +Clock configuration example:
> +	pmc: pmc@7000e400 {
> +		compatible = "nvidia,tegra210-pmc";
> +		reg = <0x0 0x7000e400 0x0 0x400>;
> +		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
> +		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
> +	};
> +
> +Clock consumer example:
> +	i2c@7000c500 {
> +		cam_sensor {
> +			...
> +			clocks = <&pmc TEGRA_PMC_CLK_OUT_3>;
> +			clock-names = "mclk";
> +			assigned-clocks = <&pmc TEGRA_PMC_CLK_OUT_3>;
> +			assigned-clock-parents = <&tegra_car TEGRA210_CLK_EXTERN3>;
> +			...
> +		};
> +	};
> diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
> new file mode 100644
> index 000000000000..f7c866404456
> --- /dev/null
> +++ b/include/dt-bindings/soc/tegra-pmc.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2019-2020, NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_SOC_TEGRA_PMC_H
> +#define _DT_BINDINGS_SOC_TEGRA_PMC_H
> +
> +#define TEGRA_PMC_CLK_OUT_1		0
> +#define TEGRA_PMC_CLK_OUT_2		1
> +#define TEGRA_PMC_CLK_OUT_3		2
> +
> +#define TEGRA_PMC_CLK_MAX		3
> +
> +#endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
> 

The TXT binding should be removed since you converted it to YAML.
