Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79A6C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCD92053B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMahdVvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfLKHU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:20:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44027 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfLKHU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:20:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so1328871pfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 23:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zt7dD+G6CZ7JiW/OTyZRbi+QrgrCgEMr0EtbdbVOEvo=;
        b=iMahdVvUtYzRqHNMafgKcr6aoqiCK7vmp3iXqmihp+FGIvNpLfNq/m2YTqfRe+k0Nq
         kOgT74Udrg0WLXHns+nS0rhaInQiPaL9iouYgxrdAT5bAbwQwwHN7S42aW0rt0G1wpVs
         /PzhtlbQuD9V6KkI5xOMC+fLmXXzxU2ho0S1E2oQPsyEFtfcJcHC/MlIeQGN+c7/OaEP
         j+KfHH8baHU9oSpk3Qwwr3Y2ZIl0C0iSDFuYhCH9ASpnb4HysTH5LLb1HCrL+cuu5s09
         6X8ZfQDg/XjLZW35aWVypgrT6JPBCcSgHQctQRkYClbxNQ21QZSwiFPBs9bCmQwV34g3
         VOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zt7dD+G6CZ7JiW/OTyZRbi+QrgrCgEMr0EtbdbVOEvo=;
        b=WeU004JqzDnfKgoVvwE2rt3iiAGXLJ2tvsYEPHgbiySgYleZH+WILExSlY6tYpn6hq
         CgoI+xY929NO7GzaAr3izmBnbZ4QkFVjsjNStFt0o6MgCElLcqgUvvSOfq44KqhZXl8a
         i7+RYONpKJlpUskDFVEV4+oEp69Nsl/DZBrLj5gp6k/tbc58kgVSNjnPSqJCKvmxtIhA
         or2hUlmqRflNKwYa95JbozpAR8a69F2Nx+j+xClczvDVLxcAij23FMd+UxBNIQqy5RPE
         8SaX8ihkjZtsDBAhC5OdDwiLU9rdxrWwgLkuGICA1ZBOu9oPh50XKc3uLLe73me85T5d
         xo1g==
X-Gm-Message-State: APjAAAWnHFLRx9m7IYWZwDo6XFHFw7cG7m/fIoQtB4hTwFTdDF+SRazO
        hGf5zibBDdnzWLl0KGAiNSCXww==
X-Google-Smtp-Source: APXvYqw4cxozBp2uimntGWWy0jZ4dci8RUXiHQpPyTXnBRm14alWbArUZIe+OL2WJ+qkqlQdnpm8Ug==
X-Received: by 2002:a63:684a:: with SMTP id d71mr2442865pgc.27.1576048856072;
        Tue, 10 Dec 2019 23:20:56 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x4sm1496180pfx.68.2019.12.10.23.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 23:20:55 -0800 (PST)
Date:   Tue, 10 Dec 2019 23:20:53 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module device
 node
Message-ID: <20191211072053.GH3143381@builder>
References: <0101016ed018cde9-da3dc3e0-de6e-4b18-9add-bc6f88511ab2-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016ed018cde9-da3dc3e0-de6e-4b18-9add-bc6f88511ab2-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Dec 00:48 PST 2019, Rakesh Pillai wrote:

> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on sc7180 soc.
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> This change is dependent on the below set of changes
> arm64: dts: sc7180: Add qupv3_0 and qupv3_1 (https://lore.kernel.org/patchwork/patch/1150367/)

Why?

> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  4 ++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 27 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 189254f..8a6a760 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -248,6 +248,10 @@
>  	status = "okay";
>  };
>  
> +&wifi {
> +	status = "okay";

Please conclude on the representation of the "skip-hyp-mem-assign" and
add it here, rather than in a subsequent patch - which implies that this
patch doesn't work on its own.

> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
>  &qup_i2c2_default {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 666e9b9..40c9971 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -42,6 +42,12 @@
>  			compatible = "qcom,cmd-db";
>  			no-map;
>  		};
> +
> +		wlan_fw_mem: wlan_fw_region@93900000 {

wlan_fw_mem: memory@93900000 {

> +			compatible = "removed-dma-pool";
> +			no-map;
> +			reg = <0 0x93900000 0 0x200000>;
> +		};
>  	};
>  
>  	cpus {
> @@ -1119,6 +1125,27 @@
>  				#clock-cells = <1>;
>  			};
>  		};
> +
> +		wifi: wifi@18800000 {
> +			status = "disabled";
> +			compatible = "qcom,wcn3990-wifi";
> +			reg = <0 0x18800000 0 0x800000>;
> +			reg-names = "membase";
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

No iommus in sc7180?

Regards,
Bjorn

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
