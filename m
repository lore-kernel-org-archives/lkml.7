Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469D12081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqMGDM8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCGRYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:24:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46287 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCGRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:24:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id g6so11931819pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rh2XNeZUURGL/NuLObxZbVkc7Eo4bF12QN3mIc3mknQ=;
        b=qqMGDM8AEi7lwxQ1wGor7bhOInOov/1DNg8y8jNgyzylDf6cQKNs/NCmjAKwkbShDh
         G9LQK9hyyWWf13ixcR4z6PtUauM4S+z820kmzvp3Kf8U/qmghqua3FpJPyTBv5LNAOaA
         U+K//hEL+9cNyva/438d2dmqBrSp9yqT0MRwTQeIoSFIA9OHZITTRP14PqkTcjoypvFn
         gxIiU0Ryn5gPAIsEm+slvMyhRSF9ilLUfrjTK+XtelEfdqIIpOCRlynqdp7CIIs5PpnK
         eqTyhlawlUDT1IdagZ5En9Au+ITUp1n/Fkb4ZpWQoitRIheDzxw7VgqqJiT6DjvNvCof
         s9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rh2XNeZUURGL/NuLObxZbVkc7Eo4bF12QN3mIc3mknQ=;
        b=rVRycpIEqhYHn9yPzFRJuh3ICovo5j3GxvvQeTcMg6TScDTTaNffT8gu3pbA/63pil
         f4H6MMHjk8bM8euWdHTlqp8WR7tQbCPmcxIcaPK8H6S3yo8aTBymj3KLUriqwK3WPZa0
         jV70wttdrcEJVptoCnPYH5QdtOjf1S7d6a+fQsJGaXShJGOn0VQwF1GJLT/4CmT0+b8b
         TAIqv+GsUULp6oGs4PuOfLqFYVRV9N9FR/UdW4RyrunVUdT4xvNLKjzQqRnCdKWsySDI
         nj43k4m+Lmy3BxTX7JPXM30RrqhmLeFvQ6rR12xU9vgtl7Pj0LvWMLNsHkqp9pSsexLB
         RD8A==
X-Gm-Message-State: APjAAAVU+xk4UJ/JXOe06A0PeSHYQsjM1tFz27d0ev8KQfFvFoCN+vGn
        QnKXIB1XKuHCoyG+TLwlY2kG
X-Google-Smtp-Source: APXvYqzNzJErs7/tmr6d0MUsI417nGkodTXryo8PTy0/+E5NP5EkZIh/C+XAUd0H7KLI7yfwfavrvQ==
X-Received: by 2002:a17:902:9341:: with SMTP id g1mr14169246plp.80.1551979474959;
        Thu, 07 Mar 2019 09:24:34 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:740f:d61c:f9e8:217e:aed4:aa31])
        by smtp.gmail.com with ESMTPSA id f125sm12201488pfc.91.2019.03.07.09.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 09:24:34 -0800 (PST)
Date:   Thu, 7 Mar 2019 22:54:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: bitmain: Add GPIO support for BM1880 SoC
Message-ID: <20190307172426.GA9268@Mani-XPS-13-9360>
References: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:20:21PM +0530, Manivannan Sadhasivam wrote:
> Add GPIO support for Bitmain BM1880 SoC based on Designware APB GPIO
> controller IP. IP exposes 3 GPIO controllers with a total of 72 pins.
> 

Applied for v5.2 with Linus's Reviewed-by tag.

Thanks,
Mani

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/bitmain/bm1880.dtsi | 54 +++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
> index 55a4769e0de2..e4da4ec6a5ee 100644
> --- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
> +++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
> @@ -80,6 +80,60 @@
>  			#interrupt-cells = <3>;
>  		};
>  
> +		gpio0: gpio@50027000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x0 0x50027000 0x0 0x400>;
> +
> +			porta: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				snps,nr-gpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		gpio1: gpio@50027400 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x0 0x50027400 0x0 0x400>;
> +
> +			portb: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				snps,nr-gpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		gpio2: gpio@50027800 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x0 0x50027800 0x0 0x400>;
> +
> +			portc: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				snps,nr-gpios = <8>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
>  		uart0: serial@58018000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x0 0x58018000 0x0 0x2000>;
> -- 
> 2.17.1
> 
