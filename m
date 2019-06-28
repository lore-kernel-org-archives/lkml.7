Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FE5C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E2C208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTT4mMrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfF1N3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:29:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35612 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1N3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:29:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so2995719pfd.2;
        Fri, 28 Jun 2019 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1O8DrbpTmciwFV9+bKnWkKjm8kYVUsRM9LK8+PMCsEQ=;
        b=mTT4mMrlMn4nt1uoYeRFLnfXyesfH80IKsVF+J+x6Ab+MSLwe+k6FyhzEd1k2Zh64w
         BKovir0BKXq3/kzP8T/Krr5tujkf+gOIjpqPad2JqhHQwlTFMm9nyk+U8sS7IvFJUrb+
         xUS18x7vvjKjq18Pn7cV03gnaEfHixPB1WFjRnAdII8xlhHyqnMu6Zt5dMynfvx/Yqnr
         YzjRbYe4Ap91jVoAcwFT73kpmvbz3eEQ/3wIOYjstKnmjqwzmI2PYuIphEkdE2Gsz0ha
         bwbon+EbzDOAFA8RJ7zi4B8LIoYvym4EvthLZI0FkfTW/aic57XTsg9vAa0TrHtlq/Zl
         L7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1O8DrbpTmciwFV9+bKnWkKjm8kYVUsRM9LK8+PMCsEQ=;
        b=NuKpVC+4Sf25t+1YlHHVDfZDW1P0AuyQ9PjfWnZzjAIorki/x0mjwT9sijLVe/Cn89
         4C6ov7z+X1YdeDfN+xNd8c118loGpY4ZyBMT9+Gs4dblhpL8BV4HE/fKnOTUa3eZMtas
         uy/66Z56OMCAxWdszfOAPrnIZI3T+OQVQtsCz2sS2PNfv49OZJp7g6/igl77xe+1V75R
         R3Qg5SJMwby70OPPsquySklF+1LJsuYiekL4CMJHmYVAn9D5r7/yPZVq7v5ADP0modxu
         p6wWHN0us5PGYm+nSIKdhMTvXswqU23wCE+XWRWAEUGo4rIgXlaL05KbVjvbMpMkWT2T
         +jXw==
X-Gm-Message-State: APjAAAX1+6ZKMUlZAI3qA4HDPLPrL03RM/AqKp/UpT+pYvf1/oJJsrWb
        ap4IjBpmhd8HzBQf51W7D/E=
X-Google-Smtp-Source: APXvYqx3g+cSIJx81oO2RRodX9tHqRs3xn7vs37XmTWqnH1ATbRwp7PXlYj9JRV4u/2CI1VrWW28ag==
X-Received: by 2002:a63:2ec9:: with SMTP id u192mr430039pgu.16.1561728538929;
        Fri, 28 Jun 2019 06:28:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g92sm2066814pje.11.2019.06.28.06.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 06:28:57 -0700 (PDT)
Date:   Fri, 28 Jun 2019 06:28:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabian Schindlatz <fabian.schindlatz@fau.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?R=F6thenbacher?= 
        <thomas.roethenbacher@fau.de>, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH v2] hwmon: Correct struct allocation style
Message-ID: <20190628132856.GA22498@roeck-us.net>
References: <9160e7fe-7229-a097-48f7-d882cc760b53@roeck-us.net>
 <20190627152738.29645-1-fabian.schindlatz@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627152738.29645-1-fabian.schindlatz@fau.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 05:27:38PM +0200, Fabian Schindlatz wrote:
> Use sizeof(*var) instead of sizeof(struct var_type) as argument to
> kalloc() and friends to comply with the kernel coding style.
> 
> Co-developed-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
> Cc: linux-kernel@i4.cs.fau.de

Applied to hwmon-next. Note that it is in general much easier for me
if such patches are applied against mainline (or hwmon-next), not
against linux-next.

Guenter

> ---
>  drivers/hwmon/acpi_power_meter.c | 3 +--
>  drivers/hwmon/coretemp.c         | 4 ++--
>  drivers/hwmon/fschmd.c           | 2 +-
>  drivers/hwmon/sch56xx-common.c   | 2 +-
>  drivers/hwmon/via-cputemp.c      | 5 ++---
>  drivers/hwmon/w83793.c           | 2 +-
>  6 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 6ba1a08253f0..48c4570c61d7 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -862,8 +862,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
>  	if (!device)
>  		return -EINVAL;
>  
> -	resource = kzalloc(sizeof(struct acpi_power_meter_resource),
> -			   GFP_KERNEL);
> +	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
>  	if (!resource)
>  		return -ENOMEM;
>  
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index fe6618e49dc4..0361115d25dd 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -433,7 +433,7 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
>  {
>  	struct temp_data *tdata;
>  
> -	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
> +	tdata = kzalloc(sizeof(*tdata), GFP_KERNEL);
>  	if (!tdata)
>  		return NULL;
>  
> @@ -532,7 +532,7 @@ static int coretemp_probe(struct platform_device *pdev)
>  	struct platform_data *pdata;
>  
>  	/* Initialize the per-zone data structures */
> -	pdata = devm_kzalloc(dev, sizeof(struct platform_data), GFP_KERNEL);
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
>  
> diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
> index fa0c2f1fb443..d464dcbe5ac8 100644
> --- a/drivers/hwmon/fschmd.c
> +++ b/drivers/hwmon/fschmd.c
> @@ -1090,7 +1090,7 @@ static int fschmd_probe(struct i2c_client *client,
>  	int i, err;
>  	enum chips kind = id->driver_data;
>  
> -	data = kzalloc(sizeof(struct fschmd_data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
> index 6c84780e358e..0d6d20814183 100644
> --- a/drivers/hwmon/sch56xx-common.c
> +++ b/drivers/hwmon/sch56xx-common.c
> @@ -401,7 +401,7 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
>  		return NULL;
>  	}
>  
> -	data = kzalloc(sizeof(struct sch56xx_watchdog_data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return NULL;
>  
> diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
> index 8264e849e588..0feb1d0b5e13 100644
> --- a/drivers/hwmon/via-cputemp.c
> +++ b/drivers/hwmon/via-cputemp.c
> @@ -114,8 +114,7 @@ static int via_cputemp_probe(struct platform_device *pdev)
>  	int err;
>  	u32 eax, edx;
>  
> -	data = devm_kzalloc(&pdev->dev, sizeof(struct via_cputemp_data),
> -			    GFP_KERNEL);
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> @@ -223,7 +222,7 @@ static int via_cputemp_online(unsigned int cpu)
>  		goto exit;
>  	}
>  
> -	pdev_entry = kzalloc(sizeof(struct pdev_entry), GFP_KERNEL);
> +	pdev_entry = kzalloc(sizeof(*pdev_entry), GFP_KERNEL);
>  	if (!pdev_entry) {
>  		err = -ENOMEM;
>  		goto exit_device_put;
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index 46f5dfec8d0a..b37106c6f26d 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -1669,7 +1669,7 @@ static int w83793_probe(struct i2c_client *client,
>  	int files_pwm = ARRAY_SIZE(w83793_left_pwm) / 5;
>  	int files_temp = ARRAY_SIZE(w83793_temp) / 6;
>  
> -	data = kzalloc(sizeof(struct w83793_data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data) {
>  		err = -ENOMEM;
>  		goto exit;
