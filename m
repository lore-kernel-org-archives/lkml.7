Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4B5C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E06206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izo3SXym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfLPLJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:09:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37081 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfLPLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:09:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so6741888wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GSwxZqA1p+v3fIchljXoOSOPXRU+x5PdBqx4Li7pnc8=;
        b=izo3SXymVRSx/zAI+IcDTMigV+sq6Wd7JcYeHw99As5psoxVLMP2hcsI3tHbJwGtRI
         C1sl5Vl4ZnUr/g4Lri6/L0G1Ju0FJSX8nD9LjZuQRdgrzwHoo/Ut2Td8QUfkMcUybSdX
         NU7xZlV9yhVGfht/rPWB1BHz+9UV7SQQjY1Ga+C/cD+lxck8sXdO/Ghs0/6CDX5tWdei
         1nHfn4kprePHhxmwL34DXxU9LdEfN7tSGZv3N8yDY+TjCtFJT8NUDa7V4xnZdL2vZK4K
         NrCEHpLB2JVYhVXCTfpGgDw0iZcMyU/Vde4HcItkAUyqkTZSA0oax2At8u69pqDaw+Ss
         nk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GSwxZqA1p+v3fIchljXoOSOPXRU+x5PdBqx4Li7pnc8=;
        b=PPBsVLcsEdqH2Zm2fxQ91l4akj/PxrI3D8eUfBeXslWSwjzAgcoOpvo3G7v9HJhAgN
         s1IfSaPsM2sx/LbU+0JlUuQw2dZ+IU9f1aPgbz9Atr5HDe2Mhab4cAnZVMWa6utNSRlp
         2kpnkQm0cZe/nIVeasHp2S0XlYuAqEdmSoJnzgL4v/BPpKvBYvkSjmxWs14+yvrG1voE
         eKkTUsXL9nqbt4mIxO6tFMHGsfZoF2YyVuU937oIaa1Tabu9IynV3W0rRtL8VYIhhETz
         lHfwG24DIxfWOYVxNw91zEwamn1VKhrnmcm4BtC8fB96mYf9o7vYO3LImt+g24m2v2HW
         TpNA==
X-Gm-Message-State: APjAAAVX8JskUhD+diafkLvnwpdy13cH5dLwsozkfVWP0hVtkpdypEhS
        4kub+h1vxElb9AMfEW4pOUlzaw==
X-Google-Smtp-Source: APXvYqzqbT4cHx/a6uUClyqUgv58zyyf1LeRoaH/ossUkpuxVMrtMTrwQ8kwz8ldw4PfghfhWvf7Iw==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr28690138wrs.369.1576494579832;
        Mon, 16 Dec 2019 03:09:39 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id l3sm21080860wrt.29.2019.12.16.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 03:09:39 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:09:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        Axel Lin <axel.lin@ingics.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: mfd: update TI tps6105x chip bindings
Message-ID: <20191216110939.GJ3601@dell>
References: <20191209140234.6558-1-TheSven73@gmail.com>
 <20191209140234.6558-3-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191209140234.6558-3-TheSven73@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Dec 2019, Sven Van Asbroeck wrote:

> The driver has been extended to optionally get its operational
> mode, regulator init data and LED naming from the devicetree.
> 
> Tree: next-20191118

Please refrain from putting this in the commit message.

> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---

... if you really want to put that in, place it here, so it doesn't
become part of the kernel's Git history.

>  .../devicetree/bindings/mfd/tps6105x.txt      | 47 ++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/tps6105x.txt b/Documentation/devicetree/bindings/mfd/tps6105x.txt
> index 93602c7a19c8..d15763740a3f 100644
> --- a/Documentation/devicetree/bindings/mfd/tps6105x.txt
> +++ b/Documentation/devicetree/bindings/mfd/tps6105x.txt
> @@ -7,11 +7,56 @@ Required properties:
>  - compatible:		"ti,tps61050" or "ti,tps61052"
>  - reg:			Specifies the I2C slave address
>  
> -Example:
> +Optional sub-node:
> +
> +This subnode selects the chip's operational mode.
> +There can be at most one single available subnode.
> +
> +- regulator: presence of this sub-node puts the chip in regulator mode.
> +	see Documentation/devicetree/bindings/regulator/regulator.txt

Relative paths are preferred.

> +- led: presence of this sub-node puts the chip in led mode.
> +	Optional properties:
> +	- function : see ../leds/common.txt
> +	- color    : see ../leds/common.txt
> +	- label    : see ../leds/common.txt

Yes, like this.

> +			(deprecated)
> +
> +Example (GPIO operation only):
> +
> +i2c0 {
> +	tps61052@33 {
> +		compatible = "ti,tps61052";
> +		reg = <0x33>;
> +	};
> +};
> +
> +Example (GPIO + regulator operation):
>  
>  i2c0 {
>  	tps61052@33 {
>  		compatible = "ti,tps61052";
>  		reg = <0x33>;
> +
> +		regulator {
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;
> +		};
> +	};
> +};
> +
> +Example (GPIO + led operation):
> +
> +#include <dt-bindings/leds/common.h>
> +
> +i2c0 {
> +	tps61052@33 {
> +		compatible = "ti,tps61052";
> +		reg = <0x33>;
> +
> +		led {
> +			color = <LED_COLOR_ID_WHITE>;
> +		};
>  	};
>  };

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
