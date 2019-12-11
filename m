Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2C4C2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C99214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHk2+4mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfLKGmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 01:42:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40374 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfLKGmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:42:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so1285485pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 22:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3Pv1FvyrRTmg3SlVKuyuXg4XFdZ+s0KbsG+H/OpoI0=;
        b=dHk2+4mpc/AxIXHPMINqxAIlDymrVI8uRVbiNj5IKUXb70wtxsif7Crkx0FR/n1WJH
         p6NaJnXzhai/zbD06OKZJ2LKZs6z+WmjaQxvuCiRKSL6N4RfUF8Ra78RkHo59S3ubqX9
         KxueP6g6Rqo8AyR0Oan25Cy4wnXxKua35yp4Xs388DQt5dsMnM9xyk+rMojo3z/NW4lA
         u2Y763gNArz4lXoHZl+Oy6PPxiO25WW3OzcqJTa8qU0rizAyu094RSco9vzeB28YnDtd
         Vv+YL4+eP0AjQACASkOF6EGRBDjHQ2sWlMe2U5aZp4VyhUn1/fd/CLLnrbH2bgKq3ovX
         Be3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3Pv1FvyrRTmg3SlVKuyuXg4XFdZ+s0KbsG+H/OpoI0=;
        b=PsiFxaTzkzE05Nz93DJ9dCBJHAury6Qqc6S4UMiXXsOcclY3vDjUPpxYbud55kMFqy
         EmIxUhXPTjZwqZka+ZWW6o/1qnT2GSRXmefyUKunwb2tVcRTbLsz5xBERl8+wh1asCB5
         OdgAiU95TmogciDHZwbjjkKFxwv8NXW9AjGNkrHbtZmWDPO5cmG5TXBxT/nrqaMX8/0s
         eY5GUCOBVXiQD3tpx4ChsyCmEHhbQZ1TbjsvRJWun5/DwAFa1ywr/4A3Qbc+KbiLbMiI
         9MuBwx5EKeXoO+nZJAazdZuW/bWdy1PJryx0auCu6nqXlZkxm8Ev6poSCh3CU8uNZ02O
         ioPw==
X-Gm-Message-State: APjAAAWz6B41s/e8hQqcaR0zA0OdHaMG6iguR/EXa0CePCFPgjFcu2TZ
        STs8QWKVS42vtUQ8GcsXkMEznw==
X-Google-Smtp-Source: APXvYqwxY9itd3dX5um974Cg31klBt8vPQm0Z8kxUemdP/NFJkXgmvUBY361z7dVUrkRHcV24uVTFA==
X-Received: by 2002:aa7:9197:: with SMTP id x23mr2083246pfa.163.1576046530735;
        Tue, 10 Dec 2019 22:42:10 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e188sm1336701pfe.113.2019.12.10.22.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 22:42:10 -0800 (PST)
Date:   Tue, 10 Dec 2019 22:42:07 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, mka@chromium.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] arm64: dts: sc7180: Fix indentation/ordering of qspi
 nodes in sc7180-idp
Message-ID: <20191211064207.GE3143381@builder>
References: <20191210163530.1.I69a6c29e08924229d160b651769c84508a07b3c6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210163530.1.I69a6c29e08924229d160b651769c84508a07b3c6@changeid>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Dec 16:35 PST 2019, Douglas Anderson wrote:

> The qspi pinctrl nodes had the wrong intentation and sort ordering and
> the main qspi node was placed down in the pinctrl section.  Fix.
> 
> Fixes: ba3fc6496366 ("arm64: dts: sc7180: Add qupv3_0 and qupv3_1")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Both patches merged, with improved spelling and r-b from Rajendra.

Thanks,
Bjorn

> ---
> 
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 73 +++++++++++++------------
>  1 file changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 189254f5ae95..5eab3a282eba 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -232,6 +232,20 @@ vreg_bob: bob {
>  	};
>  };
>  
> +&qspi {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qspi_clk &qspi_cs0 &qspi_data01>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <25000000>;
> +		spi-tx-bus-width = <2>;
> +		spi-rx-bus-width = <2>;
> +	};
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -250,6 +264,29 @@ &uart8 {
>  
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
> +&qspi_clk {
> +	pinconf {
> +		pins = "gpio63";
> +		bias-disable;
> +	};
> +};
> +
> +&qspi_cs0 {
> +	pinconf {
> +		pins = "gpio68";
> +		bias-disable;
> +	};
> +};
> +
> +&qspi_data01 {
> +	pinconf {
> +		pins = "gpio64", "gpio65";
> +
> +		/* High-Z when no transfers; nice to park the lines */
> +		bias-pull-up;
> +	};
> +};
> +
>  &qup_i2c2_default {
>  	pinconf {
>  		pins = "gpio15", "gpio16";
> @@ -364,39 +401,3 @@ pinconf {
>  	};
>  };
>  
> -&qspi {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&qspi_clk &qspi_cs0 &qspi_data01>;
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <25000000>;
> -		spi-tx-bus-width = <2>;
> -		spi-rx-bus-width = <2>;
> -	};
> -};
> -
> -&qspi_cs0 {
> -		pinconf {
> -			pins = "gpio68";
> -			bias-disable;
> -		};
> -};
> -
> -&qspi_clk {
> -		pinconf {
> -			pins = "gpio63";
> -			bias-disable;
> -		};
> -};
> -
> -&qspi_data01 {
> -		pinconf {
> -			pins = "gpio64", "gpio65";
> -
> -			/* High-Z when no transfers; nice to park the lines */
> -			bias-pull-up;
> -		};
> -};
> -- 
> 2.24.0.525.g8f36a354ae-goog
> 
