Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68F5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F722075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpnZ9ObM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDCXJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:09:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33473 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCXJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 19:09:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so231490pgh.0;
        Wed, 03 Apr 2019 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z4uzUTt9h1kPP021FkWrkSbjKM/0yI5RmClKPhqKTLA=;
        b=SpnZ9ObML2VHx+WFokziNyP9Rr9V1EqECpfMqkQkdZVcyUNuVHYDsZpJ7qljhgLFfp
         5LiWYGqQDOnmm9Pn3wPh5XbBoeXMm0klUxpIMQhRaZeN5avFpalxUDoczWOfS5I68Eyl
         fSCKwIJW6V7HMViuB9VBpjZIWUtoWui9xInOCT7t43kv9kmT9Ja2Abo4K+BuUvViBDog
         VgkqYOibgKxNFjv5kRTCBbgRGzpeykXnfS9HpG5A+Av7sZsLVSoWsIAECv3Tk4ja3ert
         zZaM1N8qeT7Xl1x26qPHDqSvBp6xe25oF/b5BYVAUyuaC9DuAeGg/evLxv2axvudYb3O
         acLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z4uzUTt9h1kPP021FkWrkSbjKM/0yI5RmClKPhqKTLA=;
        b=EXy8rav1BGUW255NA1LkoGjNtLt3ol1GeM/EUjQaAYN8WUHDEtAP+7MYXnHdLpl3kl
         EuLgafouHT2m+XmVYJQSx+D3LImc+xC56emmX5bLEB5/YuTNvpw2b83GSFBmPfOFSFkU
         sRp0vEHHJShuPqBaTipYlpRraXyR6LoJe/GWV3rJ5mnbQF/59si+S92OjgRx541APR12
         cjeWfvvcxBhCqzFC3PqVsfM35dUk41D1/BgQKdZFdnZ9aylcVavqckwSx3GlFKUA+o1a
         NqhSIkzNQwQon+3yT9VeEaZP90XLku7UT8S3pDAXEwsKVlfpBHs0ZNNLLRaHYXTwuyAY
         VCmQ==
X-Gm-Message-State: APjAAAW2ntLIU6OTtGt/Gyf5rk3YTwQbu0AoWEOCTCntPXVxMyTBST99
        DCxFnEpaBpQX/SqFG+1M3nc=
X-Google-Smtp-Source: APXvYqyMlPPIJc9MGCcJ/Mi9lpdcEd3N6ciuzyvwWlPyt9nmkpHggLSnyv3z43Gn0RBYrzuOSn5qAA==
X-Received: by 2002:aa7:9151:: with SMTP id 17mr2239425pfi.192.1554332964525;
        Wed, 03 Apr 2019 16:09:24 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t64sm42603434pfa.86.2019.04.03.16.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 16:09:23 -0700 (PDT)
Date:   Wed, 3 Apr 2019 16:09:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v7 2/4] Input: goodix - Add regulators suppot
Message-ID: <20190403230922.GG53104@dtor-ws>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
 <20190321082104.2874-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321082104.2874-3-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Thu, Mar 21, 2019 at 01:51:02PM +0530, Jagan Teki wrote:
> Goodix CTP controllers require AVDD28, VDDIO regulators for power-on
> sequence.
> 
> The delay between these regualtor operations as per Power-on Timing
> from datasheet[1] is 0 (T1 >= 0 usec).
> 
> So, enable and disable these regulators in proper order using normal
> regulator functions without any delay in between.
> 
> [1] GT5663 Datasheet_English_20151106_Rev.01
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/input/touchscreen/goodix.c | 58 ++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index f57d82220a88..de5b80a08f41 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -27,6 +27,7 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> @@ -47,6 +48,8 @@ struct goodix_ts_data {
>  	struct touchscreen_properties prop;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> +	struct regulator *avdd28;
> +	struct regulator *vddio;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
>  	u16 id;
> @@ -532,6 +535,24 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
>  		return -EINVAL;
>  	dev = &ts->client->dev;
>  
> +	ts->avdd28 = devm_regulator_get(dev, "AVDD28");
> +	if (IS_ERR(ts->avdd28)) {
> +		error = PTR_ERR(ts->avdd28);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev,
> +				"Failed to get AVDD28 regulator: %d\n", error);
> +		return error;
> +	}
> +
> +	ts->vddio = devm_regulator_get(dev, "VDDIO");
> +	if (IS_ERR(ts->vddio)) {
> +		error = PTR_ERR(ts->vddio);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev,
> +				"Failed to get VDDIO regulator: %d\n", error);
> +		return error;
> +	}
> +
>  	/* Get the interrupt GPIO pin number */
>  	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
>  	if (IS_ERR(gpiod)) {
> @@ -764,6 +785,17 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
>  	complete_all(&ts->firmware_loading_complete);
>  }
>  
> +static void goodix_disable_regulator(void *arg)
> +{
> +	struct goodix_ts_data *ts = arg;
> +
> +	if (!IS_ERR(ts->vddio))
> +		regulator_disable(ts->vddio);

We error out of goodix_get_gpio_config() and abort probe() if
devm_regulator_get() fails, so there is no need to check for errors
here.

> +
> +	if (!IS_ERR(ts->avdd28))
> +		regulator_disable(ts->avdd28);
> +}
> +
>  static int goodix_ts_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
> @@ -789,6 +821,32 @@ static int goodix_ts_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> +	error = devm_add_action_or_reset(&client->dev,
> +					 goodix_disable_regulator, ts);
> +	if (error)
> +		return error;

We need to do this after enabling regulators, otherwise there is a risk
of unbalanced disable.

I adjusted and applied, thank you.

-- 
Dmitry
