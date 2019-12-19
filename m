Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D577C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154F4206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uL/liKf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLSPSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:18:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46956 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLSPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:18:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id m26so4210403ljc.13;
        Thu, 19 Dec 2019 07:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LNT4y0iUgVBDizXWfOLm1+a533pA/rTv5vztBKq7EUQ=;
        b=uL/liKf3LNSmPQWMNA2t7irV51zDTNWzR7w8UE99/lHdKIJvXs1s36CS2jGWwyuGcx
         bdjfiis6Dhy/oRwmCKN9c8b7db04mTdYY0uERGIyBD5s54E/DP+ptZS4PIqgwzgl1WIF
         EdSoKqg4fHGknBjqvG9i+TMjmki4i4J+1dDOZJIk4z2S006J4Upuei/fQ1+hFlhLOuMO
         MTCBtDB0Up3OKin3m1fZaSkmqpTX4jF+so8MefxEiUdgVXodTkZsZh57DhNOsq+mSNAE
         hIybMgS71cwYOt//OKd1j8EyHh1kTit67nwRhu02/LR8/0W+ZOgzPQF82zEwK2bNB3kg
         HZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LNT4y0iUgVBDizXWfOLm1+a533pA/rTv5vztBKq7EUQ=;
        b=PWxpOikqwzRX9G4i8IC7ql70gpWTMpluNq+l6m78QlyB5FvSGOmXwpQENnLquVvjB+
         W8ANRAEmo4YoXniFexdlxDRxnxEemuD3vxdT4S7DLoMMaqQs6spw3p0t8qnoK8MGTFmt
         /F+hmNlFRgxDnip5/nNOOFDTqXJb4GQYabZDmhA0b6MnZcJjviGQfKenczCeYdSqovMD
         vmDwOUiNhPB/W6LxG4VxfbBX5nEZxED/B9bP/HKrm6nmf4nciLCYILnJgNpevotf+GAM
         rug/+pBEg4EEhxNaGOAZd4XrZZFojPAzfIE5WQiK1UDCPVr5AE8B8GAMs+WvJUPzLnEB
         l5eA==
X-Gm-Message-State: APjAAAWfBgofiDkFyd8V0x4CCGJ1yRGGQuYatG/VOfBxKp02pMYgCWn0
        h+GAy+M0LDX7x98pojtZjSmb0Kp2
X-Google-Smtp-Source: APXvYqx40ioU2/Y2bkJCKC4oYRnXUHgiHEBJ24aq8akQm99RVo6h8YqY5wODk7+auHn0z3SQhUgagw==
X-Received: by 2002:a2e:6a03:: with SMTP id f3mr6264560ljc.232.1576768700408;
        Thu, 19 Dec 2019 07:18:20 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q13sm3602493ljj.63.2019.12.19.07.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 07:18:19 -0800 (PST)
Subject: Re: [PATCH v1 2/4] usb: phy: tegra: Hook up init/shutdown callbacks
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191218175313.16235-1-digetx@gmail.com>
 <20191218175313.16235-3-digetx@gmail.com> <20191219130126.GE1440537@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d33642af-bbfc-9041-6069-5f5bfc2a95b5@gmail.com>
Date:   Thu, 19 Dec 2019 18:18:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219130126.GE1440537@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.12.2019 16:01, Thierry Reding пишет:
> On Wed, Dec 18, 2019 at 08:53:11PM +0300, Dmitry Osipenko wrote:
>> Generic PHY provides init/shutdown callbacks which allow USB-host drivers
>> to abstract PHY's hardware management in a common way. This change allows
>> to remove Tegra-specific PHY handling from the ChipIdea driver.
>>
>> Note that ChipIdea's driver shall be changed at the same time because it
>> turns PHY ON without the PHY's initialization and this doesn't work now,
>> resulting in a NULL dereference of phy->freq because it's set during of
>> the PHY's initialization.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/usb/chipidea/ci_hdrc_tegra.c |   9 --
>>  drivers/usb/phy/phy-tegra-usb.c      | 165 +++++++++++++++++----------
>>  2 files changed, 102 insertions(+), 72 deletions(-)
>>
>> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
>> index 0c9911d44ee5..7455df0ede49 100644
>> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
>> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
>> @@ -83,13 +83,6 @@ static int tegra_udc_probe(struct platform_device *pdev)
>>  		return err;
>>  	}
>>  
>> -	/*
>> -	 * Tegra's USB PHY driver doesn't implement optional phy_init()
>> -	 * hook, so we have to power on UDC controller before ChipIdea
>> -	 * driver initialization kicks in.
>> -	 */
>> -	usb_phy_set_suspend(udc->phy, 0);
>> -
>>  	/* setup and register ChipIdea HDRC device */
>>  	udc->data.name = "tegra-udc";
>>  	udc->data.flags = soc->flags;
>> @@ -109,7 +102,6 @@ static int tegra_udc_probe(struct platform_device *pdev)
>>  	return 0;
>>  
>>  fail_power_off:
>> -	usb_phy_set_suspend(udc->phy, 1);
>>  	clk_disable_unprepare(udc->clk);
>>  	return err;
>>  }
>> @@ -119,7 +111,6 @@ static int tegra_udc_remove(struct platform_device *pdev)
>>  	struct tegra_udc *udc = platform_get_drvdata(pdev);
>>  
>>  	ci_hdrc_remove_device(udc->dev);
>> -	usb_phy_set_suspend(udc->phy, 1);
>>  	clk_disable_unprepare(udc->clk);
>>  
>>  	return 0;
>> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
>> index ea7ef1dc0b42..15bd253d53c9 100644
>> --- a/drivers/usb/phy/phy-tegra-usb.c
>> +++ b/drivers/usb/phy/phy-tegra-usb.c
>> @@ -238,23 +238,6 @@ static int utmip_pad_open(struct tegra_usb_phy *phy)
>>  {
>>  	int ret;
>>  
>> -	phy->pad_clk = devm_clk_get(phy->u_phy.dev, "utmi-pads");
>> -	if (IS_ERR(phy->pad_clk)) {
>> -		ret = PTR_ERR(phy->pad_clk);
>> -		dev_err(phy->u_phy.dev,
>> -			"Failed to get UTMIP pad clock: %d\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	phy->pad_rst = devm_reset_control_get_optional_shared(
>> -						phy->u_phy.dev, "utmi-pads");
>> -	if (IS_ERR(phy->pad_rst)) {
>> -		ret = PTR_ERR(phy->pad_rst);
>> -		dev_err(phy->u_phy.dev,
>> -			"Failed to get UTMI-pads reset: %d\n", ret);
>> -		return ret;
>> -	}
>> -
>>  	ret = clk_prepare_enable(phy->pad_clk);
>>  	if (ret) {
>>  		dev_err(phy->u_phy.dev,
>> @@ -315,6 +298,18 @@ static int utmip_pad_close(struct tegra_usb_phy *phy)
>>  	return ret;
>>  }
>>  
>> +static void ulpi_close(struct tegra_usb_phy *phy)
>> +{
>> +	int err;
>> +
>> +	err = gpio_direction_output(phy->reset_gpio, 1);
>> +	if (err < 0) {
>> +		dev_err(phy->u_phy.dev,
>> +			"ULPI reset GPIO %d direction not asserted: %d\n",
>> +			phy->reset_gpio, err);
>> +	}
>> +}
>> +
>>  static void utmip_pad_power_on(struct tegra_usb_phy *phy)
>>  {
>>  	unsigned long val, flags;
>> @@ -761,14 +756,19 @@ static int ulpi_phy_power_off(struct tegra_usb_phy *phy)
>>  	return gpio_direction_output(phy->reset_gpio, 0);
>>  }
>>  
>> -static void tegra_usb_phy_close(struct tegra_usb_phy *phy)
>> +static void tegra_usb_phy_close(struct usb_phy *u_phy)
>>  {
>> -	if (!IS_ERR(phy->vbus))
>> -		regulator_disable(phy->vbus);
>> +	struct tegra_usb_phy *phy = container_of(u_phy, struct tegra_usb_phy,
>> +						 u_phy);
>>  
>> -	if (!phy->is_ulpi_phy)
>> +	if (phy->is_ulpi_phy)
>> +		ulpi_close(phy);
>> +	else
>>  		utmip_pad_close(phy);
>>  
>> +	if (!IS_ERR(phy->vbus))
>> +		regulator_disable(phy->vbus);
>> +
>>  	clk_disable_unprepare(phy->pll_u);
>>  }
>>  
>> @@ -788,7 +788,7 @@ static int tegra_usb_phy_power_off(struct tegra_usb_phy *phy)
>>  		return utmi_phy_power_off(phy);
>>  }
>>  
>> -static int	tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
>> +static int tegra_usb_phy_suspend(struct usb_phy *x, int suspend)
>>  {
>>  	struct tegra_usb_phy *phy = container_of(x, struct tegra_usb_phy, u_phy);
>>  	if (suspend)
>> @@ -801,54 +801,25 @@ static int ulpi_open(struct tegra_usb_phy *phy)
>>  {
>>  	int err;
>>  
>> -	phy->clk = devm_clk_get(phy->u_phy.dev, "ulpi-link");
>> -	if (IS_ERR(phy->clk)) {
>> -		err = PTR_ERR(phy->clk);
>> -		dev_err(phy->u_phy.dev, "Failed to get ULPI clock: %d\n", err);
>> -		return err;
>> -	}
>> -
>> -	err = devm_gpio_request(phy->u_phy.dev, phy->reset_gpio,
>> -		"ulpi_phy_reset_b");
>> -	if (err < 0) {
>> -		dev_err(phy->u_phy.dev, "Request failed for GPIO %d: %d\n",
>> -			phy->reset_gpio, err);
>> -		return err;
>> -	}
>> -
>>  	err = gpio_direction_output(phy->reset_gpio, 0);
>>  	if (err < 0) {
>>  		dev_err(phy->u_phy.dev,
>> -			"GPIO %d direction not set to output: %d\n",
>> +			"ULPI reset GPIO %d direction not deasserted: %d\n",
>>  			phy->reset_gpio, err);
>>  		return err;
>>  	}
>>  
>> -	phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
>> -	if (!phy->ulpi) {
>> -		dev_err(phy->u_phy.dev, "Failed to create ULPI OTG\n");
>> -		err = -ENOMEM;
>> -		return err;
>> -	}
>> -
>> -	phy->ulpi->io_priv = phy->regs + ULPI_VIEWPORT;
>>  	return 0;
>>  }
>>  
>> -static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
>> +static int tegra_usb_phy_init(struct usb_phy *u_phy)
>>  {
>> +	struct tegra_usb_phy *phy = container_of(u_phy, struct tegra_usb_phy,
>> +						 u_phy);
>>  	unsigned long parent_rate;
>>  	int i;
>>  	int err;
>>  
>> -	phy->pll_u = devm_clk_get(phy->u_phy.dev, "pll_u");
>> -	if (IS_ERR(phy->pll_u)) {
>> -		err = PTR_ERR(phy->pll_u);
>> -		dev_err(phy->u_phy.dev,
>> -			"Failed to get pll_u clock: %d\n", err);
>> -		return err;
>> -	}
>> -
>>  	err = clk_prepare_enable(phy->pll_u);
>>  	if (err)
>>  		return err;
>> @@ -884,8 +855,17 @@ static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
>>  	if (err < 0)
>>  		goto fail;
>>  
>> +	err = tegra_usb_phy_power_on(phy);
>> +	if (err)
>> +		goto close_phy;
>> +
>>  	return 0;
>>  
>> +close_phy:
>> +	if (phy->is_ulpi_phy)
>> +		ulpi_close(phy);
>> +	else
>> +		utmip_pad_close(phy);
>>  fail:
>>  	clk_disable_unprepare(phy->pll_u);
>>  	return err;
>> @@ -1134,22 +1114,77 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
>>  		tegra_phy->vbus = ERR_PTR(-ENODEV);
>>  	}
>>  
>> -	tegra_phy->u_phy.dev = &pdev->dev;
>> -	err = tegra_usb_phy_init(tegra_phy);
>> -	if (err < 0)
>> +	tegra_phy->pll_u = devm_clk_get(&pdev->dev, "pll_u");
>> +	err = PTR_ERR_OR_ZERO(tegra_phy);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Failed to get pll_u clock: %d\n", err);
>>  		return err;
>> +	}
>>  
>> +	if (tegra_phy->is_ulpi_phy) {
>> +		tegra_phy->clk = devm_clk_get(&pdev->dev, "ulpi-link");
>> +		err = PTR_ERR_OR_ZERO(tegra_phy->clk);
>> +		if (err) {
>> +			dev_err(&pdev->dev,
>> +				"Failed to get ULPI clock: %d\n", err);
>> +			return err;
>> +		}
>> +
>> +		err = devm_gpio_request(&pdev->dev, tegra_phy->reset_gpio,
>> +			"ulpi_phy_reset_b");
>> +		if (err < 0) {
>> +			dev_err(&pdev->dev, "Request failed for GPIO %d: %d\n",
>> +				tegra_phy->reset_gpio, err);
>> +			return err;
>> +		}
>> +
>> +		tegra_phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
>> +		if (!tegra_phy->ulpi) {
>> +			dev_err(&pdev->dev, "Failed to create ULPI OTG\n");
>> +			err = -ENOMEM;
>> +			return err;
>> +		}
>> +
>> +		tegra_phy->ulpi->io_priv = tegra_phy->regs + ULPI_VIEWPORT;
>> +	} else {
>> +		tegra_phy->pad_clk = devm_clk_get(&pdev->dev, "utmi-pads");
>> +		err = PTR_ERR_OR_ZERO(tegra_phy->pad_clk);
>> +		if (err) {
>> +			dev_err(&pdev->dev,
>> +				"Failed to get UTMIP pad clock: %d\n", err);
>> +			return err;
>> +		}
>> +
>> +		tegra_phy->pad_rst = devm_reset_control_get_optional_shared(
>> +						&pdev->dev, "utmi-pads");
>> +		err = PTR_ERR_OR_ZERO(tegra_phy->pad_rst);
>> +		if (err) {
>> +			dev_err(&pdev->dev,
>> +				"Failed to get UTMI-pads reset: %d\n", err);
>> +			return err;
>> +		}
>> +	}
>> +
>> +	tegra_phy->u_phy.dev = &pdev->dev;
>> +	tegra_phy->u_phy.init = tegra_usb_phy_init;
>> +	tegra_phy->u_phy.shutdown = tegra_usb_phy_close;
>>  	tegra_phy->u_phy.set_suspend = tegra_usb_phy_suspend;
>>  
>>  	platform_set_drvdata(pdev, tegra_phy);
>>  
>>  	err = usb_add_phy_dev(&tegra_phy->u_phy);
>> -	if (err < 0) {
>> -		tegra_usb_phy_close(tegra_phy);
>> -		return err;
>> -	}
>> +	if (err < 0)
>> +		goto free_ulpi;
>>  
>>  	return 0;
>> +
>> +free_ulpi:
>> +	if (tegra_phy->ulpi) {
>> +		kfree(tegra_phy->ulpi->otg);
>> +		kfree(tegra_phy->ulpi);
>> +	}
>> +
>> +	return err;
>>  }
>>  
>>  static int tegra_usb_phy_remove(struct platform_device *pdev)
>> @@ -1157,7 +1192,11 @@ static int tegra_usb_phy_remove(struct platform_device *pdev)
>>  	struct tegra_usb_phy *tegra_phy = platform_get_drvdata(pdev);
>>  
>>  	usb_remove_phy(&tegra_phy->u_phy);
>> -	tegra_usb_phy_close(tegra_phy);
>> +
>> +	if (tegra_phy->ulpi) {
>> +		kfree(tegra_phy->ulpi->otg);
>> +		kfree(tegra_phy->ulpi);
>> +	}
> 
> It might be nicer to add a new otg_ulpi_free() (or whatever) function to
> do this. Manually cleaning up the resources allocated by a public API is
> a bit asymmetric and easy to get wrong.
> 
> But it's correct in this case and the new function can be added in a
> separate patch, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

Guess devm_otg_ulpi_create() could be even a better variant, I'll take a
look at implementing it. Thanks!
