Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F718C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E424320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ai33U1cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfGKP0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:26:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40580 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbfGKP0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:26:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so3208940pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jqKL10SfPBHX8ip9SjN9bbGfYwLa0UEkg7TV5tI+44=;
        b=Ai33U1cb/AuUPGwciTGPKsb8cL0yezdO4orewd1YNIYc2T4/AMDQiliCn4BrgHRPxY
         vEETBjvOfm7iQYPsPTa+4SfomDLYmhdxcvTz8z43WGVQk1PkjHmPEtfSRDdum1qWGHYW
         MSilOaZIxICmIN+BM8S3RqU6CE1wP97gLp0f4vL5ac/XJ4GSOv/Dw/ZfNPpx+FyLRFDR
         VWI5R2VfhQs931xNuTpJdYKo1Adtk3eIbfpi/3aIHkmzSLyHYQZXw9C66524u0DAQNoc
         bBIi9a0w1YREf0fgWqEzGwGfgiMlIKbpF798d0jFtgRmx/8pSEyzkMTr/O32/Ln6sJeN
         yZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jqKL10SfPBHX8ip9SjN9bbGfYwLa0UEkg7TV5tI+44=;
        b=rbvotgckvDrfK6zt/O1KgDm86VyNK1SyFrHqrxPIiauYzY8glMaZ+tV2hDZcB//c/L
         3RoShMHCftqYjbdmLxI1PuvHomiVggjMmqxfmZHx8cjLPNPUDfT/bcmnQZDovG18Bdy+
         E4zh8ZVOd5laxm0c1SgYK4X3QmmHMGa3OBux5CDSZ7qGvoJiMY3H9N9WFDxj4tsO5A1t
         rwJQ/Z8/hX9IiELYlXvPotEMtbvYn0KNk/xENT3J79JVC7MlsxVgWnHO+NDm7IY6r+TF
         5ghh4F9yV/3oQ8jIdDXYm/dgtCAFQOtD/lKMT7wl3otkV4y8Aoph9PhSKgMIzOclPYeP
         TjcA==
X-Gm-Message-State: APjAAAX2Q7sI125VcNfA3zHzgFIavsgLZYEA89Q3XJZtnyKIAaPQUpyi
        fJw0bOCh9xuy2ymIu6+JcWOZeQ==
X-Google-Smtp-Source: APXvYqyi5VNP+LKJHngY4Cs3k5DfNNUN1ljoMrjNS1v+CpK76lG427Jq4WFgS6YE/HD2LWMQMvA0qQ==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr5039813plr.274.1562858765582;
        Thu, 11 Jul 2019 08:26:05 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q19sm7117085pfc.62.2019.07.11.08.26.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:26:04 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:27:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v3 12/14] arm64: dts: qcom: qcs404: Add the clocks for
 APCS mux/divider
Message-ID: <20190711152714.GM7234@tuxbook-pro>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
 <20190625164733.11091-13-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625164733.11091-13-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 09:47 PDT 2019, Jorge Ramirez-Ortiz wrote:

> Specify the clocks that feed the APCS mux/divider instead of using
> default hardcoded values in the source code.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 94471aa31979..9569686dbc41 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -850,6 +850,9 @@
>  			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>  			reg = <0x0b011000 0x1000>;
>  			#mbox-cells = <1>;
> +			clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
> +			clock-names = "aux", "pll";
> +			#clock-cells = <0>;
>  		};
>  
>  		apcs_hfpll: clock-controller@b016000 {
> -- 
> 2.21.0
> 
