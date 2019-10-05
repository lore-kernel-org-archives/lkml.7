Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4E3C4CED1
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42402222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 04:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoJD5Lqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfJEEij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 00:38:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32820 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfJEEij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 00:38:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so5140081pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 21:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gojjLX+lTwGZmg+qENDnRVGuBFOraGHa2B2vpf7iVZU=;
        b=aoJD5LqfjCMzYKl2Xwu3Wklmzvu7Hh9AhSF/aixsCOh0sn3oS4pK3FjHL/0jBgFAqU
         UQ5M799eRDsX9N3DOgF89P6R8Pt9oHIg9YqJ+u22TNw15lvNiMYLxneCH39xxlCkookY
         E6b9yZ9zR+j8gRX5pq7hv1c5ST9WyOm7pn/Tc8agfncncn9s/5O6d1EohcNBYMSTECtG
         G2XqTK5nejhi/RHWpIa9Z6yjy7Q2U11yrCrnU2Y0iCOtGhQryHhfmlDctxdCueziuQE+
         NY13ZbDKQ+Pk3RIT/g4g2KBOYVDSsQm/LHsKj+9MvSP5JCyPS66DWRYHAJMXVqKMuHzf
         Jg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gojjLX+lTwGZmg+qENDnRVGuBFOraGHa2B2vpf7iVZU=;
        b=Mbbx2pefmEFDdsl+uOb0ssOcX+Es/YDguKBM02Z7e8+HoWEuP81i1yRepQ5OS928hV
         7YbBtnOWffwySbkb8HMtawDDxXEBecLnTyf6eV24eSWcr1fVvDHO0uiTDwX/JP68RrRW
         bNfGzOWOHTitQ+yGceGvbBn+AG5uUTdDMVUIm2HGbu4kqDSgLBMk31xErSSHYvg9QRPM
         pqYBxWPxSeFC1nzpd3za0bdxWokRYZvGAc/0nkNb5/w9O42tmkpbTKotHbfM+PyMUord
         Mshz/cnipCWG1X/n5Z/A659crnUKTv69dNvA+cuYQnmx94wB7cGNy02Ncg7xiVJmeZi/
         3R4A==
X-Gm-Message-State: APjAAAUYAseMVRSVboxBVEn2PDZdh6onzEvZAilIYVHDcANled0eMS/e
        3KJSzUUZBhM92ZWcHMZwxdmlbw==
X-Google-Smtp-Source: APXvYqybrYaoAQQO0OhNSmIB0UUOdfqyJ4Qu//EasKPhAapNYmiKSK5FOIodqcUwgnxNhBbXOE/eTQ==
X-Received: by 2002:a65:5546:: with SMTP id t6mr18868858pgr.441.1570250318244;
        Fri, 04 Oct 2019 21:38:38 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 1sm8310336pff.39.2019.10.04.21.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 21:38:37 -0700 (PDT)
Date:   Fri, 4 Oct 2019 21:38:35 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] dt-bindings: pinctrl: qcom-pmic-gpio: Add support for
 pm6150/pm6150l
Message-ID: <20191005043835.GD6390@tuxbook-pro>
References: <1570188039-22122-1-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570188039-22122-1-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Oct 04:20 PDT 2019, Kiran Gunda wrote:

> Add support for the PM6150 and PM6150L GPIO support to the
> Qualcomm PMIC GPIO binding.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 4 ++++
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> index c32bf32..2f48cca 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
> @@ -23,6 +23,8 @@ PMIC's from Qualcomm.
>  		    "qcom,pms405-gpio"
>  		    "qcom,pm8150-gpio"
>  		    "qcom,pm8150b-gpio"
> +		    "qcom,pm6150-gpio"
> +		    "qcom,pm6150l-gpio"
>  
>  		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
>  		    if the device is on an spmi bus or an ssbi bus respectively
> @@ -100,6 +102,8 @@ to specify in a pin configuration subnode:
>  					     and gpio8)
>  		    gpio1-gpio12 for pm8150b (holes on gpio3, gpio4, gpio7)
>  		    gpio1-gpio12 for pm8150l (hole on gpio7)
> +		    gpio1-gpio10 for pm6150
> +		    gpio1-gpio12 for pm6150l
>  
>  - function:
>  	Usage: required
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index f1fece5..387917c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -1121,6 +1121,8 @@ static int pmic_gpio_remove(struct platform_device *pdev)
>  	{ .compatible = "qcom,pm8150b-gpio", .data = (void *) 12 },
>  	/* pm8150l has 12 GPIOs with holes on 7 */
>  	{ .compatible = "qcom,pm8150l-gpio", .data = (void *) 12 },
> +	{ .compatible = "qcom,pm6150-gpio", .data = (void *) 10 },
> +	{ .compatible = "qcom,pm6150l-gpio", .data = (void *) 12 },
>  	{ },
>  };
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
> 
