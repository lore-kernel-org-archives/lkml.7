Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3320C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F627EBE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gcbf9zYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfFCMoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:44:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41751 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFCMoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:44:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so11914609wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Zwr3vv+eMdjlpjmEc4HE3us4LgHzeUpOklcIYvSawzo=;
        b=gcbf9zYk66xEbf+X9bevRXNLMvjzZWg16Bxg9CF4bRMx2fR6SZ+UaOpLE1PR8S7Yij
         khKENx/ypIT/a74aWCgZBHnQ3zEcmu1Wd+8qQ8G1hts6S6FmUjVtYumpyiYDXfghg7MC
         4rlcmGNCfQ268rMwrSlp+JXv8sEGVL6DxHWOm1VpPwdJpETTHGQWhM47T1RMucppOv3Y
         +n8DZhvK8wACTMjNytAYCy6ErSPYmRIyICqpP0O4+I0SHpzzplAstmEB2tLugoTY32JW
         jBIw6LejVrFucNfVrmCQzkL3JZt+mSGlepyavumsGEvB65PaR103lCQt04MPOS3/DcB1
         q3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Zwr3vv+eMdjlpjmEc4HE3us4LgHzeUpOklcIYvSawzo=;
        b=t8lbldhVfnJw7nXBtv61/qy2DhAorqxWxds496x8Fx8JHSQjib7soLsY2DIHD5jPDX
         hrIDhpunlLScpKiaFM/onOMbjT9M98BwxyMWXcqWElGsQfOOreCGUZne3khN4cMjTnvA
         faInmqNx8rIGx2T9m2eLrJ57WttWcdrJ4YZeir7jC9yTNvem1jA8czSR9y9yPsN/AO1D
         VPzA0KqmYGt1ISJt+bhweclQLU3Zl48iUW2AR/H2prTjFnlFtujYuL63PTdMqW60Hs25
         GLB1OsBewqhUFs0QbEAYnSKLVBt4g4JQZXT4aXQ8YAZQb46LUqZU7cOkFuz/zAApt029
         Z5gQ==
X-Gm-Message-State: APjAAAUHBdxcaPUseerCXT0VBUWWjj+fO8AgGALfgCvic47QR5WsDwTv
        nKSuzyJ+JGFQ07/7yPpc+lW+ICjAZVA=
X-Google-Smtp-Source: APXvYqxbCV5ImKYCqFFDSptIpwwZwtXyEHcy1XwWTcXGUisZlyPfdZ1fxHI3RaPKKo6VtXU0grwM1g==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr797668wrl.140.1559565892246;
        Mon, 03 Jun 2019 05:44:52 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id g8sm1156892wmf.17.2019.06.03.05.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 05:44:51 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:44:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: rk808: Prepare rk805 for poweroff
Message-ID: <20190603124450.GO4797@dell>
References: <20190521062449.29410-1-stefan@olimex.com>
 <20190521062449.29410-3-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521062449.29410-3-stefan@olimex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Stefan Mavrodiev wrote:

> RK805 has SLEEP signal, which can put the device into SLEEP or OFF
> mode. The default is SLEEP mode.
> 
> However, when the kernel performs power-off (actually the ATF) the
> device will not go fully off and this will result in higher power
> consumption and inability to wake the device with RTC alarm.
> 
> The solution is to enable pm_power_off_prepare function, which will
> configure SLEEP pin for OFF function.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
> Changes for v2:
>  - Move pm_pwroff_prep_fn to header
>  - Check pm_power_off_prepare before make it NULL
> 
>  drivers/mfd/rk808.c       | 29 +++++++++++++++++++++++++++++
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index c0b179792bbf..fb6cdf900899 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -387,6 +387,24 @@ static void rk805_device_shutdown(void)
>  		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>  }
>  
> +static void rk805_device_shutdown_prepare(void)
> +{
> +	int ret;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +
> +	if (!rk808) {
> +		dev_warn(&rk808_i2c_client->dev,
> +			 "have no rk805, so do nothing here\n");

No need for this message I think.

If it's not available, just return.

> +		return;
> +	}
> +
> +	ret = regmap_update_bits(rk808->regmap,
> +				 RK805_GPIO_IO_POL_REG,
> +				 SLP_SD_MSK, SHUTDOWN_FUN);
> +	if (ret)
> +		dev_err(&rk808_i2c_client->dev, "power off error!\n");
> +}

"Failed to shutdown device"

>  static void rk808_device_shutdown(void)
>  {
>  	int ret;
> @@ -475,6 +493,7 @@ static int rk808_probe(struct i2c_client *client,
>  		cells = rk805s;
>  		nr_cells = ARRAY_SIZE(rk805s);
>  		rk808->pm_pwroff_fn = rk805_device_shutdown;
> +		rk808->pm_pwroff_prep_fn = rk805_device_shutdown_prepare;
>  		break;
>  	case RK808_ID:
>  		rk808->regmap_cfg = &rk808_regmap_config;
> @@ -550,6 +569,12 @@ static int rk808_probe(struct i2c_client *client,
>  		pm_power_off = rk808->pm_pwroff_fn;
>  	}
>  
> +	if (pm_off && !pm_power_off_prepare) {
> +		if (!rk808_i2c_client)
> +			rk808_i2c_client = client;
> +		pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
> +	}
> +
>  	return 0;
>  
>  err_irq:
> @@ -566,6 +591,10 @@ static int rk808_remove(struct i2c_client *client)
>  	if (rk808->pm_pwroff_fn && pm_power_off == rk808->pm_pwroff_fn)
>  		pm_power_off = NULL;
>  
> +	if (rk808->pm_pwroff_prep_fn &&
> +	    pm_power_off_prepare == rk808->pm_pwroff_prep_fn)
> +		pm_power_off_prepare = NULL;

I think this block would benefit from a comment.

>  	return 0;
>  }
>  
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index 8b5d68a7bb9c..ec928173e507 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -454,5 +454,6 @@ struct rk808 {
>  	const struct regmap_config	*regmap_cfg;
>  	const struct regmap_irq_chip	*regmap_irq_chip;
>  	void				(*pm_pwroff_fn)(void);
> +	void				(*pm_pwroff_prep_fn)(void);
>  };
>  #endif /* __LINUX_REGULATOR_RK808_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
