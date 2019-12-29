Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 03:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D4620409
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 03:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sz58O9O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfL2DOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 22:14:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33777 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfL2DOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 22:14:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id z16so16714154pfk.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 19:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wEeDhGD9qE9h8SuRwaZIe778VYxrlh346WtNbjw3o7A=;
        b=Sz58O9O3SoPFrI0m7TZzPfCRrFbgwtxnWiGZUQsm/CZShNJZp6hTSgkLqGqaVN3xgS
         w3tBxNoFyC45eJIAYWfbcD2L6ak6bsk4irQUlRCxYimBY8bZLXOknH1mZzQBTe+BROWd
         FzD0BlmpOerV2U0OjKq4FOVEuXCQVDOkmIrm5FaLfRsNXJH/kkuGdxMDmHMEaw+bL65M
         As3plY4XmTjYCoRKPAQKOJpQgb3UBgfQ5eCFfFnJyZxYc/UhxznLXJNpiHpRpPHxTuHh
         +/I5pxb3lkXvVhOs890TiE2C2DSPsYTYP3xljeb+BUvnWYecPftzmPMnenFfA0zMOEaZ
         ImZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wEeDhGD9qE9h8SuRwaZIe778VYxrlh346WtNbjw3o7A=;
        b=TD7POAg6+FWrAc30z7y78EYhYDcUpnehmU7JZkU4hmE5k8zDaGjRbovlqJ+LGZGpC+
         5Fa7gYdibvdCLalzBq1YG+hZMYmHVE3UqM7t+WX6LWB+PW45BfeY/CWsD/N+qX2P5P0g
         /yd+i+AtUMBquPffwPIGSSBTaNVbwApKStAl91++o6ZXsqND/H6/lQYrcUfWWsWktTar
         Of/3Z72I2wwsIYsF44QTMjXEeD/wZgxz2UCLddMQqJyuno3L4oOrMRh+66r0iRSISTEi
         Egjia+HoVoYTGIc2P9gZhjWipn1SpLvVa+LI9+WHEUJNNzlUrpg483L3aH8nhyknSKQA
         8VRw==
X-Gm-Message-State: APjAAAXDGN0tiEixllrFceL2TTqiAXj9aj3/IPOIMB5RXBusJpl+YDDe
        xIdAv8RbXUcj+FjZ+P3UOIwxvw==
X-Google-Smtp-Source: APXvYqyrN5Vts6qPQ1tr8xyRCTf/z7TJ6Nu77KyEYF2HVSsX4g9swQo843iIk+bkqCPSyLGa+Ii0wA==
X-Received: by 2002:a63:2808:: with SMTP id o8mr62765812pgo.39.1577589258899;
        Sat, 28 Dec 2019 19:14:18 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 18sm38826148pfj.3.2019.12.28.19.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 19:14:18 -0800 (PST)
Date:   Sat, 28 Dec 2019 19:14:16 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
Message-ID: <20191229031416.GK3755841@builder>
References: <1577181575-25788-1-git-send-email-pillair@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577181575-25788-1-git-send-email-pillair@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Dec 01:59 PST 2019, Rakesh Pillai wrote:

> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on sc7180 soc.
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> This change is dependent on the below set of changes
> arm64: dts: sc7180: Add qupv3_0 and qupv3_1 (https://lore.kernel.org/patchwork/patch/1150367/)

It would be clearer if you linked to the series instead, but it doesn't
matter at this point, this is merged already.

What doesn't seem to be merged is the addition of the
qcom,msa_fixed_perm property, so I presume I need to hold off on merging
this?

> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  5 +++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 189254f..b2ca143f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -248,6 +248,11 @@
>  	status = "okay";
>  };
>  
> +&wifi {
> +	status = "okay";
> +	qcom,msa_fixed_perm;

As remarked by Rob, properties should be using - instead of _.

> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
>  &qup_i2c2_default {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 666e9b9..7efb97f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -42,6 +42,12 @@
>  			compatible = "qcom,cmd-db";
>  			no-map;
>  		};
> +
> +		wlan_fw_mem: memory@93900000 {
> +			compatible = "removed-dma-pool";
> +			no-map;
> +			reg = <0 0x93900000 0 0x200000>;
> +		};
>  	};
>  
>  	cpus {
> @@ -1119,6 +1125,28 @@
>  				#clock-cells = <1>;
>  			};
>  		};
> +
> +		wifi: wifi@18800000 {
> +			compatible = "qcom,wcn3990-wifi";
> +			reg = <0 0x18800000 0 0x800000>;
> +			reg-names = "membase";
> +			iommus = <&apps_smmu 0xC0 0x1>;

Lowercase 'c' please.

Regards,
Bjorn

> +			interrupts =
> +				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH /* CE0 */ >,
> +				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH /* CE1 */ >,
> +				<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH /* CE2 */ >,
> +				<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH /* CE3 */ >,
> +				<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH /* CE4 */ >,
> +				<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH /* CE5 */ >,
> +				<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH /* CE6 */ >,
> +				<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH /* CE7 */ >,
> +				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH /* CE8 */ >,
> +				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH /* CE9 */ >,
> +				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH /* CE10 */>,
> +				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH /* CE11 */>;
> +			memory-region = <&wlan_fw_mem>;
> +			status = "disabled";
> +		};
>  	};
>  
>  	timer {
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
