Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F6AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A4F20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gomqhzoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfEHLpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:45:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50231 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfEHLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:45:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id p21so2880224wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l3GvcY7+LxbIORg1GuBtuIu7AC5wBX2cmnXnWgsKaLM=;
        b=gomqhzozH1rPJo3UJO0LZmi16/eDaOhei9FnFZbmPkMw+Ae+GpcAXhcWY/fbEQ7Mcd
         jfm+RSPSYQH+M2R/mAdCvtQ2z7hEmftDMLlfvH1EQhWzs/Y9dAEcQ0zrv/WMy2Jz/bVI
         s8gRF2XMt7TNmzxX9sRGkt/DlL97XTbncGL8s1KPNtiR4SKKtALPOzi6BQVgtgLyvpdL
         gGO8tvk6um9LyLYMLIV0uOffPgRE0mlHJm+VaQiSUaSiMC149so0mcLKfzNW2Nu54BV9
         ezygmQAuvEgCeK3CrKIz0EqNqgcgwWbLODiLXKjl0ZwSYyRpWJS+esOiqDdy6r5XNqIF
         tDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l3GvcY7+LxbIORg1GuBtuIu7AC5wBX2cmnXnWgsKaLM=;
        b=lg6/ialFxbi/KVil47ARos0VLeWu3AWdWKYGwnA6ZI/CL0ZKjGxBgdASftvTVy0Z7x
         NMCU3yAOvMytsvrBtJhT1/lV9E4b7JuxJhceUE8LgWY+IK08MCLXnWLgifMjIag8x22I
         YucjtxXUNG++BXgBrotNNzAs/+tetnTf7qG/8FOej19jZK7z13PiV9vINJMO6qhwrV3T
         biVK2y/duoRKiwsyrm8l+PWdIjirlEHoTXWF2JYMjMSMEZ55m3NBe7B7cm3ONLgu01wH
         /u/aA/oJA40qI0oQlyuTImSteFvxs2mQWdWzJOR87A4kbYbMmpl8zSvD7HVOPUEW0TU1
         G8oA==
X-Gm-Message-State: APjAAAWxb0rLTyiLQ7JV3ynmX22kYRZhjhbW/35ACSfQM4VNyYH7+44j
        /8seKyXD03pZSruty3ULoVdYpQ==
X-Google-Smtp-Source: APXvYqzbsOXVFvnhQCKFgeir9JCHCmFZIU6UKosT98os4blSJ2GmkYH6+ek8sOTv5dGFKfg8zfirIg==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr2714770wmj.88.1557315899750;
        Wed, 08 May 2019 04:44:59 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id m8sm28373099wrg.18.2019.05.08.04.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:44:58 -0700 (PDT)
Date:   Wed, 8 May 2019 12:44:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: mfd: Add H6 GPADC binding
Message-ID: <20190508114456.GF31645@dell>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
 <20190503072813.2719-6-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503072813.2719-6-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 May 2019, Yangtao Li wrote:

> This patch adds documentation for the H6 GPADC binding.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt   | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> index 86dd8191b04c..eeaf27eb8abd 100644
> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -5,11 +5,22 @@ and sometimes as a touchscreen controller.
>  
>  Required properties:
>    - compatible: "allwinner,sun8i-a33-ths",
> +		"allwinner,sun50i-h6-ths",
>    - reg: mmio address range of the chip,
> -  - #thermal-sensor-cells: shall be 0,
> +  - #thermal-sensor-cells: shall be 0 for sun8i-a33-ths,
> +			   shall be 1 for sun50i-h6-ths,
>    - #io-channel-cells: shall be 0,
>  
> -Example:
> +Optional properties:
> +  - clocks: Must contain an entry for each entry in clock-names.
> +	    See common clock-bindings.txt for details.

Nit: This should be a relative path, like the reset.txt below.

> +  - clock-names: A list of clock names. For sun50i-h6-ths, it must contain
> +		 "bus".
> +  - resets: Must contain an entry for each entry in reset-names.
> +	    See ../reset/reset.txt for details.
> +  - reset-names: For sun50i-h6-ths, it must contain "bus".
> +
> +Example1:
>  	ths: ths@1c25000 {
>  		compatible = "allwinner,sun8i-a33-ths";
>  		reg = <0x01c25000 0x100>;
> @@ -17,6 +28,18 @@ Example:
>  		#io-channel-cells = <0>;
>  	};
>  
> +Example2:
> +	ths: ths@1c25000 {
> +		compatible = "allwinner,sun50i-h6-ths";
> +		reg = <0x05070400 0x100>;
> +		clocks = <&ccu CLK_BUS_THS>;
> +		clock-names = "bus";
> +		resets = <&ccu RST_BUS_THS>;
> +		reset-names = "bus";
> +		#thermal-sensor-cells = <1>;
> +		#io-channel-cells = <0>;
> +       };
> +
>  sun4i, sun5i and sun6i SoCs are also supported via the older binding:
>  
>  sun4i resistive touchscreen controller

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
