Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02144C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F5E26387
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXw9JliX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEaECd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 00:02:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44213 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfEaECd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:02:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id c9so2055653pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 21:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ukEC3MMMF7VZfZKjRmeuoQSQX5eGcJH/5lmeM5Xiv1s=;
        b=VXw9JliX+By7ETjpg/VwT4cIvO5bt9B5kaUNS2hcsP92UbdLa1fgpaQAE/XPqJSi/7
         qBTnZtb9FYsYB/JtGEalVQ7ZZYtdHM4K5tJy44QI1wae6QDJJ6S6xEvY4zV25yXLj0CZ
         2MZqvtdmBIoISzz2bpfpAUYtDs14qrbKfwdwqmhwipBSmelAD2M1dde0La5Nr8hrGpXN
         vSzuF5L7pr/hdm+lHqsgGzCD0/7xwed8vMYeMKe/4H5rC+PljIl3sPxhcohWdzLdxYFR
         D2w+5vzntIcMRodAV6qZV7cE2XYHYiHmQrgogQZ7ubjNO0Lh9y3elutJb5Pb9iO8vsbM
         QB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ukEC3MMMF7VZfZKjRmeuoQSQX5eGcJH/5lmeM5Xiv1s=;
        b=G3prxbe9qgoeF32GZttvwG2KCbNRUAbf/wxUl7Ci3ak2ooCq235Sdv1a2ifQSokQ4e
         /7MqE3omm+YlA+0s3569P/wZ/cyrBhQqgdAiBMqraLyTf4JBpP5JA+HyGFktKJb1FhIR
         vrVejIwSGCF5gEdKaOxNvfltrT5hxr8YnQf44Ri3sL05vLv59lWn5bFpYP8ySC2X45nn
         wxs/EqDH/BovA4ONTaTXQk4WPDn9WO8kllqRLZb3zSQxhIi09QFC4YCJNT7ocNXbEfJl
         UF/yHII02Lym6jxGeJ5BQS8tplQQOc1kbFJJCZ++Zz/nNrDYt16d9N8WBacQhoMidTr/
         ZX4A==
X-Gm-Message-State: APjAAAVdotRGG//iU3Vvd5TJVoQ6pW+Np6bZpjhLF0EDWCZi/fCOziyw
        N/j6gJo3fRAv5vXfBnZG+iYZ4gZk7g==
X-Google-Smtp-Source: APXvYqzvhodd3uafA/IahYHPivWkQXtELuD62p5DCQP+wY6MG98U46yQKwyEMeP2EeyQeZcrUWJbVQ==
X-Received: by 2002:a17:90a:26a9:: with SMTP id m38mr6679956pje.93.1559275352740;
        Thu, 30 May 2019 21:02:32 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:ebf2:a51d:3877:feab:5634])
        by smtp.gmail.com with ESMTPSA id q7sm4348899pjb.0.2019.05.30.21.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 21:02:31 -0700 (PDT)
Date:   Fri, 31 May 2019 09:32:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing PCIe pwr amd rst
 configuration
Message-ID: <20190531040222.GB9641@Mani-XPS-13-9360>
References: <20190530125837.730-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530125837.730-1-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 30, 2019 at 12:58:37PM +0000, Anand Moon wrote:
> This patch add missing PCIe gpio and pinctrl for power (#PCIE_PWR)
> also add PCIe gpio and pinctrl for reset (#PCIE_PERST_L).
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Tested on Rock960 Model A
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> index c7d48d41e184..f5bef6b0fe89 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> @@ -55,9 +55,10 @@
>  
>  	vcc3v3_pcie: vcc3v3-pcie-regulator {
>  		compatible = "regulator-fixed";
> +		gpio = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_drv>;
> +		pinctrl-0 = <&pcie_drv &pcie_pwr>;
>  		regulator-boot-on;
>  		regulator-name = "vcc3v3_pcie";
>  		regulator-min-microvolt = <3300000>;
> @@ -381,9 +382,10 @@
>  };
>  
>  &pcie0 {
> +	ep-gpio = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
>  	num-lanes = <4>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>;
> +	pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;
>  	vpcie3v3-supply = <&vcc3v3_pcie>;
>  	status = "okay";
>  };
> @@ -408,6 +410,16 @@
>  		};
>  	};
>  
> +	pcie {
> +		pcie_pwr: pcie-pwr {
> +			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie_perst_l:pcie-perst-l {
> +			rockchip,pins = <2 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};

Which schematics did you refer? According to Rock960 v2.1 schematics [1], below
is the pin mapping for PCI-E PWR and PERST:

PCIE_PERST - GPIO2_A2
PCIE_PWR - GPIO2_A5

Above mapping holds true for Rock960 version 1.1, 1.2 and 1.3. Also,
rk3399-rock960.dtsi is common for both Rock960 and Ficus boards, so the board
specific parts should go to rk3399-rock960.dts and rk3399-ficus.dts.

Thanks,
Mani

[1] https://dl.vamrs.com/products/rock960/docs/hw/rock960_sch_v12_20180314.pdf
> +	};
> +
>  	sdmmc {
>  		sdmmc_bus1: sdmmc-bus1 {
>  			rockchip,pins =
> -- 
> 2.21.0
> 
