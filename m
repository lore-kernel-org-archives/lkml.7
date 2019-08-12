Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAC1C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D95B208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwx3t+e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfHLHQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:16:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHLHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:16:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so6926346wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Mod2oK0m77k6FtdEdfK0my77Z4ReG7ID/JEsVZ/Tdqk=;
        b=uwx3t+e6UlvTSQlvSbhKGcDewJmKG7rIJGNeUnqZa0NWaVTltcT0PNwbLcC2iL0wvL
         zx/zQNUi6ECu4WNQWi5IDPRej4+SzDQmygiNVYl6F1vDK/kvxNBq0wiHTaYUprh4Ao47
         XW57FLp9mofYxJaRu2EtYcHfQuf8QsA+pi3s98DPtM3rASp3h0KSNZqCyl2jQ820aQL9
         wXFBnPvx82bctqCp50fNueoe7veerljZ8ThwgAvcR59L4Q0uVMhT7+cxvuzDShR1yy1j
         jBhtHei/32z3dgZwzIJcX9dju9jYABjHa2R0gklCeRscjaedyyVc0/QZiyeDOnvF6aEe
         EyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Mod2oK0m77k6FtdEdfK0my77Z4ReG7ID/JEsVZ/Tdqk=;
        b=Tte7kTujMHRgxNiVUXD/IkYcSp7h+yxeqFjlqOVLECMsbtGK6nd1kXlHZR5jNcUjIL
         8UZwkm2pdI961a+d6VtyNLHDZgVoh7m7YB10hH+V6zbiEjzM4RYqcncb6tS0FqEBCBlP
         y9ePv9KyVHGNBxigfgAeMk3CZSLG0q8+OaHAfoRHgxCJnpAdq5b+OoaJc9miRs7eyJNp
         ohTALvUqiNQSgZOaE2r8o8cIwRcj/f4O8ReBnITcAadU5DmTRG4bJhYGdgXRvK/Tajlv
         q/KaT4kZVLktTz8bZh4HasGzTHHSQtjJdnNfL7kL9fwH4zmJmceAl4krSqpn2KXWPLsv
         se7g==
X-Gm-Message-State: APjAAAWAiIH7ILc5U13htpm6XqPAzjJtL3a2vduiMaEKKu3Bm6zoRYWE
        beFBCfU8CQAh61b3UxEDgcQQRA==
X-Google-Smtp-Source: APXvYqykskmaj8Vj9lYoV+Ik8HeRrMB2B+w+LtjsbGcGM0acn7XZVCZWrK5Vsm8RshkOp7ZkEqxHVw==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr18408325wrs.338.1565594202848;
        Mon, 12 Aug 2019 00:16:42 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id p7sm75602362wrs.6.2019.08.12.00.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:16:41 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:16:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 08/11] mfd: cros_ec: Add convenience struct to define
 dedicated CrOS EC MCUs
Message-ID: <20190812071639.GC4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-9-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-9-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> With the increasing use of dedicated CrOS EC MCUs, it takes a fair amount
> of boiler plate code to add those devices, add a struct that can be used
> to specify a dedicated CrOS EC MCU so we can just add a new item to it to
> define a new dedicated MCU.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mfd/cros_ec_dev.c | 87 +++++++++++++++++++++------------------
>  1 file changed, 48 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index c6bf52d795f2..e0e18c0eb9f5 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -22,6 +22,41 @@ static struct class cros_class = {
>  	.name           = "chromeos",
>  };
>  
> +/**
> + * cros_feature_to_name - CrOS feature id to name/short description.
> + * @id: The feature identifier.
> + * @name: Device name associated with the feature id.
> + * @desc: Short name that will be displayed.
> + */
> +struct cros_feature_to_name {
> +	unsigned int id;
> +	const char *name;
> +	const char *desc;
> +};
> +
> +static const struct cros_feature_to_name cros_mcu_devices[] = {
> +	{
> +		.id	= EC_FEATURE_FINGERPRINT,
> +		.name	= CROS_EC_DEV_FP_NAME,
> +		.desc	= "Fingerprint",
> +	},
> +	{
> +		.id	= EC_FEATURE_ISH,
> +		.name	= CROS_EC_DEV_ISH_NAME,
> +		.desc	= "Integrated Sensor Hub",
> +	},
> +	{
> +		.id	= EC_FEATURE_SCP,
> +		.name	= CROS_EC_DEV_SCP_NAME,
> +		.desc	= "System Control Processor",
> +	},
> +	{
> +		.id	= EC_FEATURE_TOUCHPAD,
> +		.name	= CROS_EC_DEV_TP_NAME,
> +		.desc	= "Touchpad",
> +	},
> +};
> +
>  static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  {
>  	struct cros_ec_command *msg;
> @@ -278,6 +313,7 @@ static int ec_device_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
>  	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
> +	int i;
>  
>  	if (!ec)
>  		return retval;
> @@ -290,47 +326,20 @@ static int ec_device_probe(struct platform_device *pdev)
>  	ec->features[1] = -1U; /* Not cached yet */
>  	device_initialize(&ec->class_dev);
>  
> -	/* Check whether this is actually a Fingerprint MCU rather than an EC */
> -	if (cros_ec_check_features(ec, EC_FEATURE_FINGERPRINT)) {
> -		dev_info(dev, "CrOS Fingerprint MCU detected.\n");
> -		/*
> -		 * Help userspace differentiating ECs from FP MCU,
> -		 * regardless of the probing order.
> -		 */
> -		ec_platform->ec_name = CROS_EC_DEV_FP_NAME;
> -	}
> -
> -	/*
> -	 * Check whether this is actually an Integrated Sensor Hub (ISH)
> -	 * rather than an EC.
> -	 */
> -	if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
> -		dev_info(dev, "CrOS ISH MCU detected.\n");
> -		/*
> -		 * Help userspace differentiating ECs from ISH MCU,
> -		 * regardless of the probing order.
> -		 */
> -		ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
> -	}
> -
> -	/* Check whether this is actually a Touchpad MCU rather than an EC */
> -	if (cros_ec_check_features(ec, EC_FEATURE_TOUCHPAD)) {
> -		dev_info(dev, "CrOS Touchpad MCU detected.\n");
> +	for (i = 0; i < ARRAY_SIZE(cros_mcu_devices); i++) {
>  		/*
> -		 * Help userspace differentiating ECs from TP MCU,
> -		 * regardless of the probing order.
> +		 * Check whether this is actually a dedicated MCU rather
> +		 * than an standard EC.
>  		 */
> -		ec_platform->ec_name = CROS_EC_DEV_TP_NAME;
> -	}
> -
> -	/* Check whether this is actually a SCP rather than an EC. */
> -	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
> -		dev_info(dev, "CrOS SCP MCU detected.\n");
> -		/*
> -		 * Help userspace differentiating ECs from SCP,
> -		 * regardless of the probing order.
> -		 */
> -		ec_platform->ec_name = CROS_EC_DEV_SCP_NAME;
> +		if (cros_ec_check_features(ec, cros_mcu_devices[i].id)) {
> +			dev_info(dev, "CrOS %s MCU detected\n",
> +				 cros_mcu_devices[i].desc);
> +			/*
> +			 * Help userspace differentiating ECs from other MCU,
> +			 * regardless of the probing order.
> +			 */
> +			ec_platform->ec_name = cros_mcu_devices[i].name;

I assume by "dedicated MCU", you mean it can only support one of these
at a time?  If so, please make that clear by adding a break statement
once the MCU type has been determined.

> +		}
>  	}
>  
>  	/*

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
