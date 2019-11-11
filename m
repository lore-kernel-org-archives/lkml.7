Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064C8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30FB21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgxTQ/SM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKKLSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:18:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34848 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:18:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so3083724wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LuIR7Y2Q8l8W+0L2qZWEBQmcPwgT0vQE3HF6dstyhYs=;
        b=ZgxTQ/SMx8RXWfAtO0tX/HSbwWdlMF4ZFU1BMTahqPHlAoJxF3Xg0PfINgYJmXfxlZ
         OshY2p8kNkC/xP0vWpYjZY2wfnkR+O3Dg46CJQgFLTwOzVANgUqK6wmkyyfcf1ZJsLZj
         FnBPR7NxsGBs3OErPednAFnHJ/HBxbSOZ3w6SuksnH/q+r0ywpB22djThh/T5tqraUbT
         q7XunKfZJOAOr3DFtZqgWGpatFxS3EIq3jReFRj9lo519Xdq/u4MHF/Wo2wSib/fueUb
         4M8nuNwqP1GGn66DoUNKFxyjt4/twnJaYJuEdlRmJak7ZLM7iJS052LpmZuzhMlJU9T0
         lF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LuIR7Y2Q8l8W+0L2qZWEBQmcPwgT0vQE3HF6dstyhYs=;
        b=jj7cyk+VByDPqtLhOKznsVhEECjeRRXdMHeq+l2dm5jEyWZQKlvZVPm70uQ+HpeCVw
         uKIOZztPq0UY3o/mAYXMca9DrYe0J7X7UrAsOZW/2eh52zWVv+i4Em/JS0hPdSaoyvlX
         cX0+6+ZQTOltOxRcSR9xAm+Tq6Q/sxXEC1RUKjNrqk7805dAn6vE5yLbHmsBYMkP9fjh
         NJIcsSHJZjVTTlmqBDtl/Xn2OROlgD22Phk1RYsc1LKWzD2A+JkWRbjVBcMSnBvJgbp1
         QKwFkU6JM0jyZcitd4YVNTQG4slftjma0eXIBUHqPZN0L0QqdLo1CnVOrCuL1C8sYzzN
         c3lQ==
X-Gm-Message-State: APjAAAVCxKIhNV5bHW632nesz9nxUxIjePxtgiy+B9OT9D8QCWNNhU7a
        TTcIoi3F8LcdrsNJuu04JqY6WA==
X-Google-Smtp-Source: APXvYqyWr0UkuHqzO+zZQypF+G5AGLM3U1R356CjHpgEyPXpa4/0gkSoA2aynuLIBXU/vxzN2zsZzQ==
X-Received: by 2002:adf:e701:: with SMTP id c1mr12490027wrm.166.1573471124238;
        Mon, 11 Nov 2019 03:18:44 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id x205sm23341057wmb.5.2019.11.11.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:18:43 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:18:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, broonie@kernel.org, linus.walleij@linaro.org,
        vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 02/11] mfd: wcd934x: add support to wcd9340/wcd9341
 codec
Message-ID: <20191111111836.GH3218@dell>
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
 <20191029112700.14548-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029112700.14548-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019, Srinivas Kandagatla wrote:

> Qualcomm WCD9340/WCD9341 Codec is a standalone Hi-Fi audio codec IC.
> 
> This codec has integrated SoundWire controller, pin controller and
> interrupt controller.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

No changelog?

>  drivers/mfd/Kconfig                   |  12 +
>  drivers/mfd/Makefile                  |   1 +
>  drivers/mfd/wcd934x.c                 | 306 +++++++++++++++
>  include/linux/mfd/wcd934x/registers.h | 529 ++++++++++++++++++++++++++
>  include/linux/mfd/wcd934x/wcd934x.h   |  31 ++
>  5 files changed, 879 insertions(+)
>  create mode 100644 drivers/mfd/wcd934x.c
>  create mode 100644 include/linux/mfd/wcd934x/registers.h
>  create mode 100644 include/linux/mfd/wcd934x/wcd934x.h

This driver reads much better now. Thanks for making the changes.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ae24d3ea68ea..9fe7e54b13bf 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1967,6 +1967,18 @@ config MFD_STMFX
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_WCD934X
> +	tristate "Support for WCD9340/WCD9341 Codec"
> +	depends on SLIMBUS
> +	select REGMAP
> +	select REGMAP_SLIMBUS
> +	select REGMAP_IRQ
> +	select MFD_CORE
> +	help
> +	  Support for the Qualcomm WCD9340/WCD9341 Codec.
> +	  This driver provides common support wcd934x audio codec and its
> +	  associated Pin Controller, Soundwire Controller and Audio codec.

Your capitalisation of devices is all over the place in both your help
section and in the commit message. Either capitalise them all or none
of them. Personally I would prefer all, rather than none. What ever
you choose, please be consistent.

Same for "wcd934x", this should read "WCD934x" in all comments and the
help.

[...]

> +static bool wcd934x_is_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case WCD934X_INTR_PIN1_STATUS0...WCD934X_INTR_PIN2_CLEAR3:
> +	case WCD934X_SWR_AHB_BRIDGE_RD_DATA_0:
> +	case WCD934X_SWR_AHB_BRIDGE_RD_DATA_1:
> +	case WCD934X_SWR_AHB_BRIDGE_RD_DATA_2:
> +	case WCD934X_SWR_AHB_BRIDGE_RD_DATA_3:
> +	case WCD934X_SWR_AHB_BRIDGE_ACCESS_STATUS:
> +	case WCD934X_ANA_MBHC_RESULT_3:
> +	case WCD934X_ANA_MBHC_RESULT_2:
> +	case WCD934X_ANA_MBHC_RESULT_1:
> +	case WCD934X_ANA_MBHC_MECH:
> +	case WCD934X_ANA_MBHC_ELECT:
> +	case WCD934X_ANA_MBHC_ZDET:
> +	case WCD934X_ANA_MICB2:
> +	case WCD934X_ANA_RCO:
> +	case WCD934X_ANA_BIAS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +

Nit: Please remove the superfluous empty line.

> +};

[...]

> +static int wcd934x_slim_probe(struct slim_device *sdev)
> +{
> +	struct device *dev = &sdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct wcd934x_ddata *ddata;
> +	int reset_gpio, ret;
> +
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return	-ENOMEM;
> +
> +	ddata->irq = of_irq_get(np, 0);
> +	if (ddata->irq < 0) {
> +		if (ddata->irq != -EPROBE_DEFER)
> +			dev_err(ddata->dev, "Failed to get IRQ: err = %d\n",
> +				ddata->irq);
> +		return ddata->irq;
> +	}
> +
> +	reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
> +	if (reset_gpio < 0) {
> +		dev_err(dev, "Failed to get reset gpio: err = %d\n",
> +			reset_gpio);
> +		return reset_gpio;
> +	}
> +
> +	ddata->extclk = devm_clk_get(dev, "extclk");
> +	if (IS_ERR(ddata->extclk)) {
> +		dev_err(dev, "Failed to get extclk");
> +		return PTR_ERR(ddata->extclk);
> +	}
> +
> +	ddata->supplies[0].supply = "vdd-buck";
> +	ddata->supplies[1].supply = "vdd-buck-sido";
> +	ddata->supplies[2].supply = "vdd-tx";
> +	ddata->supplies[3].supply = "vdd-rx";
> +	ddata->supplies[4].supply = "vdd-io";
> +
> +	ret = regulator_bulk_get(dev, WCD934X_MAX_SUPPLY, ddata->supplies);
> +	if (ret != 0) {

Nit: "if (ret)"

> +		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_bulk_enable(WCD934X_MAX_SUPPLY, ddata->supplies);
> +	if (ret != 0) {

Nit: "if (ret)"

> +		dev_err(dev, "Failed to enable supplies: err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * For WCD934X, it takes about 600us for the Vout_A and
> +	 * Vout_D to be ready after BUCK_SIDO is powered up.
> +	 * SYS_RST_N shouldn't be pulled high during this time
> +	 */
> +	usleep_range(600, 650);
> +	gpio_direction_output(reset_gpio, 0);
> +	msleep(20);
> +	gpio_set_value(reset_gpio, 1);
> +	msleep(20);
> +
> +	ddata->dev = dev;
> +	dev_set_drvdata(dev, ddata);
> +
> +	return 0;
> +}
> +
> +static void wcd934x_slim_remove(struct slim_device *sdev)
> +{
> +	struct wcd934x_ddata *ddata = dev_get_drvdata(&sdev->dev);
> +
> +	regulator_bulk_disable(WCD934X_MAX_SUPPLY, ddata->supplies);
> +	mfd_remove_devices(&sdev->dev);
> +	kfree(ddata);
> +}
> +
> +static const struct slim_device_id wcd934x_slim_id[] = {
> +	{ SLIM_MANF_ID_QCOM, SLIM_PROD_CODE_WCD9340, 0x1, 0x0 },

What do the last parameters mean? Might be better to define them.

> +	{}
> +};

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
