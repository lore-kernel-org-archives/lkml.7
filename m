Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642942075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KnQQ+KW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfDJKYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:24:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35489 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbfDJKYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:24:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so1166918plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F+IcYepTaZNcb054fK7h53TiXoIuBY/DoVKRXtiA9Ys=;
        b=KnQQ+KW+P5DkuCiEAd3jtdt3l94zX2o8yT2oavNnRhnJdYhbUxMm2TLzllCuiSgEnZ
         F1yL0RiKcA32KszCzAnIqeTnadAsfy39pJLrgDQas9wlORr7b38F0y9GXfPTAFgGo/2M
         bwyVNDmuueluZzxNovOY4Afs7EFN4yhvqR+MoTaj5gsr9UImGLmzNYpiIw/4x/GXZvQt
         A0kCwdzF5mAvqmh7SroBIIfjO1fwt+I2mdqaiix5IJozeUVwc0TFRVHGEcX7pjKj26UZ
         IfJSsppzOx9+rCBeccetJZCcjQvGzVRZUC7xRhOEes+CmvSKxpaYnfO/Q2DRFrd6h8G/
         942Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F+IcYepTaZNcb054fK7h53TiXoIuBY/DoVKRXtiA9Ys=;
        b=Tf4yaItW0FA2sJu/Pw4Yi3YDVtWv9tkx33Q7MPixjnwQT0jbLAQmxoE6S4/++QAbRb
         F3LdrVVtJE1QBBvnO0slxaPCygpLzMTq1lDzt99q+HKBXikIeabf7jv2SfE4fXfCx2TS
         sIOIx2lijpdkkVR5VFXwi/hXjRecShUtlsGcAakc6Lz8iwkfWNawkEbDRamX6maeWY2q
         MpBzEEzpKHwMwGCU0R+l8VVNLnZah4z2HRBYrKvHnf7fraXka53nr0Pd4tD2wnxKQvpw
         YMp7+xaqz20Sc62Of+saBPlDh8uSwdpz46RAbwdSFDUZH2sn0WoCUdRxUzmC0evkDJHV
         tyuw==
X-Gm-Message-State: APjAAAXNsvUo/BFyoAKjsqsIlqVDHzc+SSC2OIngWtl3QZQ8F4Dtcaca
        E2c2HuHTbmozwvteW35EqWwvXw==
X-Google-Smtp-Source: APXvYqyR+ON7F4IxHT0DZh2LAR02HAGTdP1vDc3onHPdtFzUJXeWwd2VeV5PxyAp6QvzkLRUh+7i3w==
X-Received: by 2002:a17:902:b28b:: with SMTP id u11mr42137203plr.257.1554891872062;
        Wed, 10 Apr 2019 03:24:32 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id b72sm75679316pga.86.2019.04.10.03.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 03:24:30 -0700 (PDT)
Date:   Wed, 10 Apr 2019 15:54:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        dianders@chromium.org
Subject: Re: [PATCH RFC 6/9] OPP: Add and export helper to update voltage
Message-ID: <20190410102429.r6j6brm5kspmqxc3@vireshk-i7>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <20190328152822.532-7-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328152822.532-7-sibis@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-19, 20:58, Sibi Sankar wrote:
> Add and export 'dev_pm_opp_update_voltage' to find and update voltage
> of an opp for a given frequency. This will be useful to update the opps
> with voltages read back from firmware.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/opp/core.c     | 62 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 10 +++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index addaf7aae9ae..c066cd120a33 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2090,6 +2090,68 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
>  
> +static int _opp_update_voltage(struct device *dev, unsigned long freq,
> +			       unsigned long u_volt)
> +{
> +	struct opp_table *opp_table;
> +	struct dev_pm_opp *tmp_opp, *opp = ERR_PTR(-ENODEV);
> +	int r = 0;

s/r/ret/

> +
> +	/* Find the opp_table */
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table)) {
> +		r = PTR_ERR(opp_table);
> +		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);

Why dev_warn instead of dev_err which is normally used in this file ? And you
weren't searching for OPP but opp_table. Put out the correct error message
please.

> +		return r;
> +	}
> +
> +	mutex_lock(&opp_table->lock);
> +
> +	/* Do we have the frequency? */
> +	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
> +		if (tmp_opp->rate == freq) {
> +			opp = tmp_opp;
> +			break;
> +		}
> +	}
> +
> +	if (IS_ERR(opp)) {
> +		r = PTR_ERR(opp);
> +		goto unlock;
> +	}
> +
> +	/* update only if the opp is disabled */
> +	if (opp->available)
> +		goto unlock;
> +

What about reusing dev_pm_opp_find_freq_exact() instead of the above code in
this routine ?

> +	opp->supplies[0].u_volt = u_volt;
> +
> +unlock:
> +	mutex_unlock(&opp_table->lock);
> +	dev_pm_opp_put_opp_table(opp_table);
> +	return r;
> +}
> +
> +/**
> + * dev_pm_opp_update_voltage() - find and update voltage of an opp
> + *				 for a given frequency
> + * @dev:	device for which we do this operation
> + * @freq:	OPP frequency to update voltage
> + * @u_volt:	voltage requested for this opp
> + *
> + * This is useful only for devices with single power supply.
> + *
> + * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> + * copy operation, returns 0 if no modification was done OR modification was
> + * successful.
> + */
> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
> +			      unsigned long u_volt)
> +{
> +	return _opp_update_voltage(dev, freq, u_volt);

Remove the unnecessary wrapper and open code this routine here. While at it, you
should updated min/max/target and not just target voltage.

> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_update_voltage);
> +
>  /**
>   * dev_pm_opp_register_notifier() - Register OPP notifier for the device
>   * @dev:	Device for which notifier needs to be registered
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index d7cb0e65c4f0..58490f6839ce 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -130,6 +130,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
>  
>  int dev_pm_opp_disable(struct device *dev, unsigned long freq);
>  
> +int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
> +			      unsigned long u_volt);
> +
>  int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
>  
> @@ -265,6 +268,13 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
>  	return 0;
>  }
>  
> +static inline int dev_pm_opp_update_voltage(struct device *dev,
> +					    unsigned long freq,
> +					    unsigned long u_volt)
> +{
> +	return 0;
> +}
> +
>  static inline int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
>  {
>  	return -ENOTSUPP;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
viresh
