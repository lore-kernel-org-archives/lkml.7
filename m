Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A129C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480C62086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIgp9ikq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfF0MGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:06:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41035 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0MGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:06:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so1130715pff.8;
        Thu, 27 Jun 2019 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c733q1AyuYONJCLx0WN/my/+D2iXi2MVTrWKRRAtIfM=;
        b=JIgp9ikqNM8iJYMul3T5uLceI/kwNzYv4INSrUpapJWNiNzKDtX4QLbuT/kE6Dw0JE
         cVicRIZFjK1T86QJWBZbf1hyO9jlkLifkhyOZ8pwzitHgdJG3P2g5HhVsbXdmJapQmM3
         h1NGyLt1GjRCzEjUb+Dtpl43Y7n95aWnhHJByIAsxCVXuTCgdik33BSXEBXileg5GmTq
         l3L42PQ+Q0cpQ+DyNrYQ14TQhNdw354siUYJSqSjXjz9Ts14ucIASZt5ZZeLMiYhD6RW
         px6dM5pGlD+tkAfSaWgSShLmRhyni8hMRqsiQEPPi6lhNCGOLSeiGxnNuVZ3ZkiO7u07
         d6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c733q1AyuYONJCLx0WN/my/+D2iXi2MVTrWKRRAtIfM=;
        b=pvlbrvZYFMNS7p1hdC5cFgDLfYkEZsLcmNsAem53X1IzibAnlvyLa/+gMU1IBaOWMT
         TdHgkztP8bKT5T7XHwtiShjp1AE/Bde+Ah2cu/TIJIAJxhTN0IY0xzkkQ5B3R5rWMj3X
         seFRX34XCxIoBpeF8WYRlzO12oz9mC8uHZxxbthxZf0xqQUTPoFvH0tuzkZZTUHldCRQ
         iCMb8lMnaVoZyi0meTyMz2rxbr1pVWWDmat+azm0Rq0ZwLdbvUcvGBSxq1StKLuWbCte
         u6VLYcXlcDRWJRSREWbtuPbjQBZxw3K7NDNg+XBvJcCpMdVDdc8Votd5WOGTbOsp47hh
         DXQA==
X-Gm-Message-State: APjAAAVIUwnvyKVukGS04Mjlkg8qN0J93W8aFmDZUX+rYw/yTyPOr9Fs
        SsiI48WI7/QPfunpS4Ym7SYF9sOl
X-Google-Smtp-Source: APXvYqy001mBGj/KQQHsMgEd9ZAWIxFkM0fImWA2T/eiMms9w61gQu+wVFxa1vbR/sDltgagUaha1Q==
X-Received: by 2002:a63:6155:: with SMTP id v82mr3444201pgb.304.1561637210039;
        Thu, 27 Jun 2019 05:06:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e26sm2570036pfn.94.2019.06.27.05.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 05:06:48 -0700 (PDT)
Subject: Re: [PATCH] hwmon: Correct struct allocation style
To:     Fabian Schindlatz <fabian.schindlatz@fau.de>,
        Jean Delvare <jdelvare@suse.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Thomas_R=c3=b6thenbacher?= <thomas.roethenbacher@fau.de>,
        linux-kernel@i4.cs.fau.de
References: <20190627115645.5077-1-fabian.schindlatz@fau.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9160e7fe-7229-a097-48f7-d882cc760b53@roeck-us.net>
Date:   Thu, 27 Jun 2019 05:06:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627115645.5077-1-fabian.schindlatz@fau.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 4:56 AM, Fabian Schindlatz wrote:
> Use sizeof(*var) instead of sizeof(struct var_type) as argument to
> kalloc() and friends to comply with the kernel coding style.
> 
> Co-developed-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
> Cc: linux-kernel@i4.cs.fau.de
> ---
>   drivers/hwmon/acpi_power_meter.c | 2 +-
>   drivers/hwmon/coretemp.c         | 4 ++--
>   drivers/hwmon/fschmd.c           | 2 +-
>   drivers/hwmon/sch56xx-common.c   | 2 +-
>   drivers/hwmon/via-cputemp.c      | 4 ++--
>   drivers/hwmon/w83793.c           | 2 +-
>   6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 6ba1a08253f0..f20223e3579c 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -862,7 +862,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
>   	if (!device)
>   		return -EINVAL;
>   
> -	resource = kzalloc(sizeof(struct acpi_power_meter_resource),
> +	resource = kzalloc(sizeof(*resource),
>   			   GFP_KERNEL);

Continuation line is no longer necessary.

>   	if (!resource)
>   		return -ENOMEM;
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index fe6618e49dc4..0361115d25dd 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -433,7 +433,7 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
>   {
>   	struct temp_data *tdata;
>   
> -	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
> +	tdata = kzalloc(sizeof(*tdata), GFP_KERNEL);
>   	if (!tdata)
>   		return NULL;
>   
> @@ -532,7 +532,7 @@ static int coretemp_probe(struct platform_device *pdev)
>   	struct platform_data *pdata;
>   
>   	/* Initialize the per-zone data structures */
> -	pdata = devm_kzalloc(dev, sizeof(struct platform_data), GFP_KERNEL);
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>   	if (!pdata)
>   		return -ENOMEM;
>   
> diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
> index fa0c2f1fb443..d464dcbe5ac8 100644
> --- a/drivers/hwmon/fschmd.c
> +++ b/drivers/hwmon/fschmd.c
> @@ -1090,7 +1090,7 @@ static int fschmd_probe(struct i2c_client *client,
>   	int i, err;
>   	enum chips kind = id->driver_data;
>   
> -	data = kzalloc(sizeof(struct fschmd_data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>   
> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
> index 6c84780e358e..0d6d20814183 100644
> --- a/drivers/hwmon/sch56xx-common.c
> +++ b/drivers/hwmon/sch56xx-common.c
> @@ -401,7 +401,7 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
>   		return NULL;
>   	}
>   
> -	data = kzalloc(sizeof(struct sch56xx_watchdog_data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return NULL;
>   
> diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
> index 8264e849e588..338b600716a5 100644
> --- a/drivers/hwmon/via-cputemp.c
> +++ b/drivers/hwmon/via-cputemp.c
> @@ -114,7 +114,7 @@ static int via_cputemp_probe(struct platform_device *pdev)
>   	int err;
>   	u32 eax, edx;
>   
> -	data = devm_kzalloc(&pdev->dev, sizeof(struct via_cputemp_data),
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data),
>   			    GFP_KERNEL);

Continuation line is no longer necessary.

>   	if (!data)
>   		return -ENOMEM;
> @@ -223,7 +223,7 @@ static int via_cputemp_online(unsigned int cpu)
>   		goto exit;
>   	}
>   
> -	pdev_entry = kzalloc(sizeof(struct pdev_entry), GFP_KERNEL);
> +	pdev_entry = kzalloc(sizeof(*pdev_entry), GFP_KERNEL);
>   	if (!pdev_entry) {
>   		err = -ENOMEM;
>   		goto exit_device_put;
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index 46f5dfec8d0a..b37106c6f26d 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -1669,7 +1669,7 @@ static int w83793_probe(struct i2c_client *client,
>   	int files_pwm = ARRAY_SIZE(w83793_left_pwm) / 5;
>   	int files_temp = ARRAY_SIZE(w83793_temp) / 6;
>   
> -	data = kzalloc(sizeof(struct w83793_data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data) {
>   		err = -ENOMEM;
>   		goto exit;
> 

