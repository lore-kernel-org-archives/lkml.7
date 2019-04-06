Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C1BC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C436D21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554534476;
	bh=WZUst9gyTfTPA+ibnZdArO2cZbJ81swoCLnFNEu9Jsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AQtmhztwmbwx9xEdz8VwLEk3WSQinSRufBsC3uZ10aiHPSx32VaXN3n94INA8IDyt
	 JonlkTB8wd3bcm6qBBSGziNEzkqMqs2PKgg/sleYF8j4TbP4/4SJt8LRmKSEwcJdo1
	 mT3/wvxrYEerlmmj1ZGcz+bTkemXE2VZzjpLwEBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDFHHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:07:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35528 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDFHHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:07:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so4256145plp.2;
        Sat, 06 Apr 2019 00:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ws6pD7Qq+qIdFrLaL2qogzUD1/0pmgYWnmgkr6guwP0=;
        b=lpyHD5AWs2SD2ZgcQa0VaLXHwpybbOed8FrYsl3D1y+at9OOk9nl19R2CgdBLmB4al
         WqVfvZHjUGheSr2W+mHKpnTIaHq7tCCvbseid5I2Jp7pcvZG9nH0HHRZV7IgftQvrLZL
         TVib2z86QzCt+jZVqVyZumWSM1npiltYGx6TKbNVLrowYqT7oeYx2XvHJJbzzgykoF0A
         JeWYo2NzNPM6USWt8xFLHT/Sf9MwoxXopb4sid36dehC9Fu70wF5NGMsGjk2seVjxvcX
         P3lrGWnk7zXLhAWSpdb8+L2RECI4aoG38mUmAuJGDaoEmRkacxbmOI/eT54W8AMvPTwu
         F0mg==
X-Gm-Message-State: APjAAAUUXtaseg1nNWN1YCFoDlAZKwjp6wxGXa8I0q06VhB8N9xeiEml
        jHBEMeGIucthMUyE9Rx8/g==
X-Google-Smtp-Source: APXvYqys0XTwhZVtf8q1WSwT9wwPg5H5h2A8R2U7EqGCLNRSspCno+1//GOdBIVw82bfUAAHEp+eYQ==
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr17466575plb.219.1554534469753;
        Sat, 06 Apr 2019 00:07:49 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id q144sm5276731pgq.76.2019.04.06.00.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 00:07:48 -0700 (PDT)
Date:   Sat, 6 Apr 2019 02:07:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v8 02/11] dt-bindings: power: supply: add DT bindings for
 max77650
Message-ID: <20190406070746.GA29624@bogus>
References: <20190403090108.24788-1-brgl@bgdev.pl>
 <20190403090108.24788-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403090108.24788-3-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:00:59AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the battery charger module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> new file mode 100644
> index 000000000000..fef188144386
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -0,0 +1,27 @@
> +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The charger is represented as a sub-node of the PMIC node on the device tree.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-charger"
> +
> +Optional properties:
> +--------------------
> +- min-microvolt:	Minimum CHGIN regulation voltage (in microvolts). Must be
> +			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
> +			4500000, 4600000, 4700000.
> +- current-limit-microamp:	CHGIN input current limit (in microamps). Must
> +				be one of: 95000, 190000, 285000, 380000, 475000.

To repeat what I said on v6, these should be common properties IMO (and 
therefore documented as such).

> +
> +Example:
> +--------
> +
> +	charger {
> +		compatible = "maxim,max77650-charger";
> +		min-microvolt = <4200000>;
> +		curr-lim-microamp = <285000>;
> +	};
> -- 
> 2.21.0
> 
