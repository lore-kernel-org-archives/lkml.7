Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6F3C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F008620866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiCTr0aF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfEADsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 23:48:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40899 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfEADsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 23:48:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so7682320plr.7;
        Tue, 30 Apr 2019 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J2KKEs5qyD3bh3G1zZGaua5TSLn8SD0b1DxMZllL6B0=;
        b=aiCTr0aF1jwCU6PVFSia8Pix5giZW2BrHRP2t+9nT7yY6qXkNjgT4dXFbarVh2yRwf
         2VzTuK+4w3GAA6gy+Yh7XXG9OWHRO50z0K37Qfy4tWwZqwuHERCyWJ9gg9bm/O9hQncH
         HpwZpGrbClf4rxxZ9IRMaU5Rq4bawD52k99IqRKE8OaBgHwh4vNjkeMgior0Rz66Eu2Q
         YlCsGwDKJ+GUIdeXLpCTaVdRWsVVbW57nOE/0YTLBbKvFdF7+uVpaynt7OPC/sodK0Qy
         kn+7JUNdY8bMctxcYyIn9L4wVHApmfiXH71ZdeWPThdjWVi8AZQtNU9Zk1BvYI7nI/Xw
         m1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J2KKEs5qyD3bh3G1zZGaua5TSLn8SD0b1DxMZllL6B0=;
        b=tIIya+zL2dAeyOybW1p6gQ49enKQJ0vbefe2vZzxVrXEBJgrqMixIb1MxqGe3n3pxR
         8Bu6QUTkAWax4Y2rMmJ3rele5fczYmZaT8AA4Vt1c94N7MWyE1RZJ/O92EusXK9NH9Dc
         ifIyQyx3jYlf3a2au0itIXhyQkWMzh33BH/g1FxlbDIEM10PCIZe7GyQeXSsx6eKXSZn
         PuXgTWR+EqeDF8MAiSnWYOcVSo7ikCl/F8/b+NVIdKCDJ0ZPvnk0CMiyGlvsxFZGWSJq
         hu1z8/gUTJB7WjvrKWF6gYQDXa2MlqH1xMI5xt1srqzL4tcHrmDOdUkdUSdYk50VzQcS
         R4hg==
X-Gm-Message-State: APjAAAXq/DDBEbWn0p1wPaglo2z90RTp/gNNtt3nkvawdRqL7EAUm1+T
        Xeo9nH9xhuy/eb0EGOWwcmA=
X-Google-Smtp-Source: APXvYqxBTptVBTtEmK4RFqNsvgCEuMsx2VcjLAtSPV+h4yj3hV+KeAT84WPh7J/rBmsy6SdJ6Ca0cw==
X-Received: by 2002:a17:902:ba8c:: with SMTP id k12mr56252983pls.213.1556682533865;
        Tue, 30 Apr 2019 20:48:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n11sm39757785pgq.8.2019.04.30.20.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 20:48:52 -0700 (PDT)
Subject: Re: [PATCH] hwmon: Convert to hwmon_device_register_with_info()
To:     Alakesh Haloi <alakesh.haloi@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
References: <20190430222955.GA97523@ip-172-31-29-54.us-west-2.compute.internal>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <479b3c4b-0191-5c1e-506e-4ba85a9d1267@roeck-us.net>
Date:   Tue, 30 Apr 2019 20:48:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430222955.GA97523@ip-172-31-29-54.us-west-2.compute.internal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/19 3:29 PM, Alakesh Haloi wrote:
> Booting linux on bare metal instance type causes this warning:
> 
> hwmon_device_register() is deprecated. Please convert the driver
> to use hwmon_device_register_with_info().
> 
> This patch fixes this call to deprecated function in acpi_power_meter.c
> 

Changing the function name to call isn't really a conversion to the new API.

Looking into the driver, I have to say it is broken almost beyond repair.
The hwmon device is registered with no attributes present, attributes,
including the mandatory name attribute, are added and removed more or
less randomly. Various attributes (such as oem and serial number) simply
don't belong into a hwmon driver.

If you really want to convert the driver, it should be a real conversion.
It should register with a hwmon_chip_info data structure, augmented with
whatever non-standard sysfs attributes are there.
The hwmon device should only be registered together with its attributes.
If it is changed, the hwmon device should be removed and re-registered.
Anything else doesn't really make sense.

Faking the use of the new API _really_ doesn't add any value, and doesn't
make any sense. If you don't want to convert the driver for real, it is
better to leave it alone.

> Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
> Cc: stable@vger.kernel.org

And, no, this is definitely not a patch to be applied to stable releases.

Guenter

> ---
>   drivers/hwmon/acpi_power_meter.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index e98591fa2528..d1b8029d0147 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -898,7 +898,9 @@ static int acpi_power_meter_add(struct acpi_device *device)
>   	if (res)
>   		goto exit_free;
>   
> -	resource->hwmon_dev = hwmon_device_register(&device->dev);
> +	resource->hwmon_dev = hwmon_device_register_with_info(&device->dev,
> +				ACPI_POWER_METER_NAME,
> +				&device->driver_data, NULL, NULL);
>   	if (IS_ERR(resource->hwmon_dev)) {
>   		res = PTR_ERR(resource->hwmon_dev);
>   		goto exit_remove;
> 

