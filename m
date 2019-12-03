Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BF0C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F082073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575411101;
	bh=yV8JD0/MRHN7tQ3o/mx8oneY2Drn3aD4ChTwAw/nX4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o58D6HsGC/zMlV5ra9YD/VVb6RJOZBKEd2MZNgnWTAk5Hxo+Lraal4Bb3wXUA7/Ux
	 9An708lOv5zVEhsmkP3dArzEBHXbOY++U52LVbx2uOwy8VVfgMKcAjplrbgY9OOMtT
	 76Gx2K9O2vIKfcGthfV+gLJAbibio8D2XuGu8se0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfLCWLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:11:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45440 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfLCWLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:11:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id v10so2835663oiv.12;
        Tue, 03 Dec 2019 14:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=477xV8KhxSU4eFJtRC9YkvcLWD2tDbYJIPfmHJ8cs4I=;
        b=lFew31/q93Jl+RjRw6W++MjzuPwAv2yos1eIdY1tct5cGaRm0FmRzQR2DTh7p14fad
         EHxSpfNsoVcyxmBlZkZqvSW96nHIA8xPCiIuD65VYKubY5BeLC77T7PlRbU+RFYhsUIC
         KNU6JEhC29SbDYYpDGIu/PdW80Z3TiYB82paVYR5dWOtPXteKpP2bGQfh0pe4FAs4w+y
         aos7QQ2Q9NTcp3LaNofOVeu4oQGvhua8F/4mK/xedoYxBT104z5hgNwF6czQmtDzdjAo
         maYkmMP3Ui0cVxZZ6Jfins3/L9MJFxHafiW4W68s5zwqp58kq4kA/iwjtF7HXszmllwx
         872w==
X-Gm-Message-State: APjAAAXtcMPQpgalWE6jDYq0z3sM1USnVmcYM/QIt1zWMgfWWvIhGOrZ
        AbPHCj9rMW80MH+ix2hD5Q==
X-Google-Smtp-Source: APXvYqxGOcD+wXxTp7nqGCSZ7mOF2ARYJRHRh1NYspCna0wEbPtu3A+Sk2oM+XjkYzB91ANachrw0Q==
X-Received: by 2002:aca:d80b:: with SMTP id p11mr183106oig.83.1575411098160;
        Tue, 03 Dec 2019 14:11:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm1539410otq.4.2019.12.03.14.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 14:11:37 -0800 (PST)
Date:   Tue, 3 Dec 2019 16:11:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
        allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 15/17] dt-bindings: tegra186-pmc: Add Tegra PMC clock
 bindings
Message-ID: <20191203221137.GC22716@bogus>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-16-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574146234-3871-16-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:50:32PM -0800, Sowjanya Komatineni wrote:
> Document clock bindings for pmc clocks clk_out_1, clk_out_2 and clk_out_3.
> These clocks are part of Tegra PMC block and pmc node is the provider for
> these clocks.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> index 2d89cdc39eb0..4576de92e4cc 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> @@ -12,6 +12,10 @@ Required properties:
>    - "aotag"
>    - "scratch"
>    - "misc" (Only for Tegra194)
> +- #clock-cells : Should be 1 for Tegra30 and higher.
> +  In clock consumers, this cell represents the PMC clock ID.
> +  The assignments may be found in header file
> +  <dt-bindings/soc/tegra-pmc.h>.

Kind of strange the header is shared, but the binding doc is not.

>  
>  Optional properties:
>  - nvidia,invert-interrupt: If present, inverts the PMU interrupt signal.
> @@ -130,3 +134,43 @@ Pinctrl client example:
>  		pinctrl-1 = <&hdmi_on>;
>  		pinctrl-names = "hdmi-on", "hdmi-off";
>  	};
> +
> +== Clock Control ==
> +
> +Tegra PMC has 3 clocks clk_1, clk_2 and clk_3. Each of these clocks has
> +source selection and enable/disable gate.
> +Parent/source for these clocks can be either of clk_m, clk_m_div2, clk_m_div4,
> +or extern clock from Tegra CAR module.
> +
> +Clock configuration example:
> +	pmc: pmc@7000e400 {
> +		compatible = "nvidia,tegra186-pmc";
> +		reg = <0 0x0c360000 0 0x10000>,
> +		      <0 0x0c370000 0 0x10000>,
> +		      <0 0x0c380000 0 0x10000>,
> +		      <0 0x0c390000 0 0x10000>;
> +		reg-names = "pmc", "wake", "aotag", "scratch";
> +		...
> +		#clock-cells = <1>;
> +		...

Once converted to schema, the examples have to compile and this won't. 
They also have to be complete enough to pass validation checks.

> +	};
> +
> +Clock consumer example:
> +	host1x@50000000 {
> +		...
> +		vi@54080000 {
> +		...
> +		assigned-clocks = <&pmc TEGRA_PMC_CLK_OUT_3_MUX>;
> +		assigned-clock-parents = <&tegra_car TEGRA210_CLK_EXTERN3>;

Indentation is wrong.

> +		};
> +		...
> +	};
> +	...
> +	i2c@7000c500 {
> +		cam_sensor {
> +		...
> +		clocks = <&pmc TEGRA_PMC_CLK_OUT_3>;
> +		clock-names = "mclk";

Same here.

> +		...
> +		};
> +	};
> -- 
> 2.7.4
> 
