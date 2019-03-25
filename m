Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A545C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE81F206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLLR8dUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfCYKBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:01:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39331 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfCYKBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:01:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so8292412wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/ABStAfZGhtpMZ6It7arWhr9fWHVkwzy7o3trF3PurY=;
        b=WLLR8dUOwbPGiVC39gCUcyonz9HEBCk4lCmqrtQ1T+/fPrp4bteIGkoyaoJOKOhDr9
         c4NI4pGJ8DvTzxTcbJgE8uvrd6hq98KiF6FTjnvTlliUV/4gMVqmsSKT8LT1w+ZPuQUc
         k12LDfDm2j2fPl6cWOHFXweurZCb077KRT8/XmNEeXeqvnPOhn7CLJ3hcOWK8gjjPAtx
         XJCZ90AMOmxXK7l29WeN4KJUX5baUSi/+R0hXiTih3+MEr4Y29QWjJkdSFC/vuvD0Anu
         AmPZfRfVSLhHo5On1nb4F+w/rg1u6cdObOYUO7OXdMcKeDR1/oqfPh/q2IzegjdT7jcK
         0T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/ABStAfZGhtpMZ6It7arWhr9fWHVkwzy7o3trF3PurY=;
        b=sVNNl5gJc1MNjmLV80kTLEFOVz/i3hu/ZlV26LBRujFBChRlqXzIo/a+dR8yLfOeA2
         h2JhmmN9QMy7pnEZOzIO9bq8BLHceNQX+uIpMFLetJeaF76BYG12QlFqoQuZzvgEQEvc
         LwgVqd6Jc8z2FJPJcM3UL+clOXJMJ4VCIGluVSMuMReFxTd60fWMdEgWQhLtk45/mUXb
         2Iuaa9i/YnWjCagh2Vlgd4PWWZh/0Wr1Qxc4LyF1ewFidC8SwzFVctUCWkEur2d28ZQd
         SIGiKGi4sT7Qyg7bAQlgNN+KgpZ1DkFcCMsT6F43kk2Ubc/kEHOOoVUAuFFNQkuALXkU
         HFDw==
X-Gm-Message-State: APjAAAWuITjAXGcNXaj3rtOVcGN3SSVMBWsvrAr9SSQNxW9ZtOVX0s9h
        0mLN+rBxBIBqLVheCl+vd9davw==
X-Google-Smtp-Source: APXvYqwxB4MpJMFGEGacRyimmmIcscKJRYRZQ+oA0dVQ8fWzdrHUC4C6jqFd3bayuNVoYJxM3g3cag==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr4692432wmj.113.1553508111327;
        Mon, 25 Mar 2019 03:01:51 -0700 (PDT)
Received: from dell ([2.27.167.37])
        by smtp.gmail.com with ESMTPSA id y132sm13978047wmg.38.2019.03.25.03.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 03:01:50 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:01:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/8] mfd: axp20x: Add axp20x-led cell
Message-ID: <20190325100148.GA4731@dell>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-3-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190215115013.11098-3-stefan@olimex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019, Stefan Mavrodiev wrote:

> Add axp20x-led cell for AXP20x, AXP221, AXP223, AXP228, AXP803, AXP809
> and AXP813.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  drivers/mfd/axp20x.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 3c97f2c0fdfe..e6ab078f0462 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -610,6 +610,9 @@ static const struct mfd_cell axp20x_cells[] = {
>  		.of_compatible	= "x-powers,axp202-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_usb_power_supply_resources),
>  		.resources	= axp20x_usb_power_supply_resources,
> +	}, {
> +		.name		= "axp20x-led",
> +		.of_compatible	= "x-powers,axp20x-led",
>  	},
>  };
>  
> @@ -636,6 +639,9 @@ static const struct mfd_cell axp221_cells[] = {
>  		.of_compatible	= "x-powers,axp221-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
>  		.resources	= axp22x_usb_power_supply_resources,
> +	}, {
> +		.name		= "axp20x-led",
> +		.of_compatible	= "x-powers,axp20x-led",
>  	},
>  };
>  
> @@ -662,6 +668,9 @@ static const struct mfd_cell axp223_cells[] = {
>  		.of_compatible	= "x-powers,axp223-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
>  		.resources	= axp22x_usb_power_supply_resources,
> +	}, {
> +		.name		= "axp20x-led",
> +		.of_compatible	= "x-powers,axp20x-led",
>  	},
>  };
>  
> @@ -719,6 +728,9 @@ static const struct mfd_cell axp288_cells[] = {
>  		.resources	= axp288_power_button_resources,
>  	}, {
>  		.name		= "axp288_pmic_acpi",
> +	}, {
> +		.name		= "axp20x-led",
> +		.of_compatible	= "x-powers,axp20x-led",
>  	},
>  };
>  
> @@ -741,8 +753,12 @@ static const struct mfd_cell axp803_cells[] = {
>  		.of_compatible	= "x-powers,axp813-ac-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>  		.resources	= axp20x_ac_power_supply_resources,
> +	}, {
> +		.name		= "axp20x-regulator"
> +	}, {
> +		.name		= "axp20x-led",
> +		.of_compatible	= "x-powers,axp20x-led",
>  	},
> -	{	.name		= "axp20x-regulator" },

Nit: Please keep this at the bottom and as a one line entry.

Once fixed, please submit with my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
