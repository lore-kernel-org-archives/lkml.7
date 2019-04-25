Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CDAC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADFD206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556222274;
	bh=M0klb38CAfwmfeRnmU/cPc3te8MCDlrFMp+XvcriVtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MyWDiHwPaTHrKMOEGo0qsyB9vAhvOEFscSb4a0YQd+VvEpxAwWGoWzDs6Zc0ur5wd
	 YsmQafYxKDhCJyXgE52dEFwk6kKy8yE8ze8DCud5WS542GtbS8dR/YHJfQ/s//4nes
	 d2ND7PCb4c3UXg8VN/Q3ia/DZqPPhI9VgVoEJBq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfDYT5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:57:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42200 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfDYT5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:57:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so1061069oie.9;
        Thu, 25 Apr 2019 12:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+ZqzLPdQ6UxCMOOHKP9B7YQ4swKS1G4qWBFIt51nI0=;
        b=RtvB3vbjrHl40Wwur/LAwQ/2nMZ0nHW0xRTRfe+X+jI9uLlvgLPRn9wadoD5sq9dK+
         oj7qiovxQV3G6eK6cSIwqHWHSqAdyfVuubdsA0qq8vzVQ0t2tIk7TwFirScwfy+HtpAW
         mRtHHgQljJd2YsYQqA9jCtMdEbSyPYcgm6ntlOBJMCpHnFoyh0x15qPm9kc5Pr4W2ZcC
         uBp1Dhe+HlTNKxe8+55hlk8jDUeRVPmQWjmAAv25dD69I/PkzRjGOowXBVcQoyLJq3cX
         p58l/HkxrazIopFNtGAt+Y8ygfmnpaj1GdWxx8uv5ioFe+7VAIj4bNvvaCCzN0Z92NDP
         YEdw==
X-Gm-Message-State: APjAAAUYCxSbY4tFjr4QtWMGDQEHAVJPXo8hs1IUJPy9DWorIc681L7v
        2eGDmRNT7Z6JIQITq5xhSg==
X-Google-Smtp-Source: APXvYqws+IT22HvmUSol1kl5L/dHeIPkCQ71NEVYtJ9VVyntv8s8Sl5K3c2g+pxIBr2jTJOGHYpESw==
X-Received: by 2002:aca:4c47:: with SMTP id z68mr1368440oia.64.1556222272113;
        Thu, 25 Apr 2019 12:57:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p14sm9141466otq.34.2019.04.25.12.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:57:51 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:57:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v6 06/10] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
Message-ID: <20190425195750.GA26031@bogus>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
 <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 04:19:24PM +0200, Lukasz Luba wrote:
> The patch adds description for DT binding for a new Exynos5422 Dynamic
> Memory Controller device.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> new file mode 100644
> index 0000000..133b3cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> @@ -0,0 +1,73 @@
> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
> +
> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
> +memory chips are connected. The driver is to monitor the controller in runtime
> +and switch frequency and voltage. To monitor the usage of the controller in
> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
> +is able to measure the current load of the memory.
> +When 'userspace' governor is used for the driver, an application is able to
> +switch the DMC and memory frequency.
> +
> +Required properties for DMC device for Exynos5422:
> +- compatible: Should be "samsung,exynos5422-bus".
> +- clock-names : the name of clock used by the bus, "bus".
> +- clocks : phandles for clock specified in "clock-names" property.
> +- devfreq-events : phandles for PPMU devices connected to this DMC.
> +- vdd-supply : phandle for voltage regulator which is connected.
> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
> +- operating-points-v2 : phandle for OPPs described in v2 definition.
> +- device-handle : phandle of the connected DRAM memory device. For more
> +	information please refer to Documentation

The memory node(s) should be a child of the memory controller IMO.

> +- devfreq-events : phandles of the PPMU events used by the controller.
> +
> +Example:
> +
> +	ppmu_dmc0_0: ppmu@10d00000 {
> +		compatible = "samsung,exynos-ppmu";
> +		reg = <0x10d00000 0x2000>;
> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +		clock-names = "ppmu";
> +		status = "okay";

Don't show 'status' in examples.

> +		events {
> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +				event-name = "ppmu-event3-dmc0_0";
> +			};
> +		};
> +	};
> +
> +	dmc: memory-controller@10c20000 {
> +		compatible = "samsung,exynos5422-dmc";
> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +			<0x10000000 0x1000>, <0x10030000 0x1000>;
> +		clocks = 	<&clock CLK_FOUT_SPLL>,
> +				<&clock CLK_MOUT_SCLK_SPLL>,
> +				<&clock CLK_FF_DOUT_SPLL2>,
> +				<&clock CLK_FOUT_BPLL>,
> +				<&clock CLK_MOUT_BPLL>,
> +				<&clock CLK_SCLK_BPLL>,
> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +				<&clock CLK_MOUT_MCLK_CDREX>,
> +				<&clock CLK_DOUT_CLK2X_PHY0>,
> +				<&clock CLK_CLKM_PHY0>,
> +				<&clock CLK_CLKM_PHY1>;
> +		clock-names =	"fout_spll",
> +				"mout_sclk_spll",
> +				"ff_dout_spll2",
> +				"fout_bpll",
> +				"mout_bpll",
> +				"sclk_bpll",
> +				"mout_mx_mspll_ccore",
> +				"mout_mx_mspll_ccore_phy",
> +				"mout_mclk_cdrex",
> +				"dout_clk2x_phy0",
> +				"clkm_phy0",
> +			        "clkm_phy1";
> +		status = "okay";
> +		operating-points-v2 = <&dmc_opp_table>;
> +		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
> +				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
> +		operating-points-v2 = <&dmc_opp_table>;
> +		device-handle = <&samsung_K3QF2F20DB>;
> +		vdd-supply = <&buck1_reg>;
> +	};
> -- 
> 2.7.4
> 
