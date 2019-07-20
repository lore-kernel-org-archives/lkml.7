Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BD6C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 14:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3A0217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 14:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSQEu+Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfGTOIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 10:08:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43326 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfGTOIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 10:08:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so15384007pfg.10;
        Sat, 20 Jul 2019 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8zVGLinC1CK/Mw22oN+G1sH1oRiJl8n5qv3o/8DfO58=;
        b=fSQEu+Z/SnCuYHeOmhOpyxLiZu6phE1y0IZT1r6MN3svS0K+UnUYZPHxKnZvhJby3K
         ZBSi4V4cKct0PYrA5Lp6PYNxmTEznF+TVzKn1TDxgzo+/EuU7glWwdHAazY4nuR5U+Lk
         3oZ1GSvqwiAjTUe4kxGo91s8LvABJqs2MzYYKF2EtwqmSGtS/dZJE74VAzDfs7vhk6rj
         hHq2fuqyKJQlRNl/9IxEKS39sSEF8Z8EMwvXCuqtMfvV1tExo/ZwQjvrf2hic8pZlfKl
         TVmQDeV4d+91B8CbzGS+j8s/+m2zzsnNxWtvconw7HKRO7jUQVv82tXNsWXFnMjNtC46
         futw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8zVGLinC1CK/Mw22oN+G1sH1oRiJl8n5qv3o/8DfO58=;
        b=U64MQFSHDy1jeZLD2TvfcP2xwYRIZ1zOTqc2uH6iMyJq5vlxgcgf2nkFFdaPW/oUpi
         OfodSG49QzGk1Eas2/+1rr7SQbCNh//DRqd1T6tnyJPXHODlUOvq8Iw0GT82gwPfPBpK
         J+kHvG1t5ssjglNW10zPYYjfg9Zmy1sYpDPtfXCwHzCPUjoxbqCJN/z5LmPm/YEt69y+
         hmuVjDPHrI7Tfd93TR+NQeur3fEQaqj1sADRb9PUIrbTKfyodARoaA2Rys61pvHQKclt
         5otbcV1rMvQWckDl4iomx7A+vMyBP03vPwRdfaw13wxeJSJRfyyEVqfTyxhBJN3Zv/z3
         USbw==
X-Gm-Message-State: APjAAAXwHYVgk29k4dupg+JgF1HIHYi+kx7RD5IbUSIEFWUfzdlTCQ+u
        4dsC1kgCLG0aOTLQUsqujdzxmJTH
X-Google-Smtp-Source: APXvYqy4dWITG9MWigqsy5rG5ZBHorDvIntzvjspN7I3aCbJcB2fAVox+Vdq5a2yhp3YrTAR4k6yGg==
X-Received: by 2002:a63:1950:: with SMTP id 16mr59922392pgz.312.1563631721697;
        Sat, 20 Jul 2019 07:08:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h12sm38580396pje.12.2019.07.20.07.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 07:08:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: (k8temp) update to use new hwmon registration
 API
To:     Robert Karszniewicz <avoidr@firemail.cc>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1563522498.git.avoidr@firemail.cc>
 <020f87268cd1a41fec68d1789e015552cfbb9da1.1563522498.git.avoidr@firemail.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c9b29f8b-9ae9-75c1-d976-f5424631256a@roeck-us.net>
Date:   Sat, 20 Jul 2019 07:08:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <020f87268cd1a41fec68d1789e015552cfbb9da1.1563522498.git.avoidr@firemail.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 7/20/19 6:16 AM, Robert Karszniewicz wrote:
> Also removes hwmon_dev from k8temp_data struct, as that is now passed
> to callbacks, anyway.
> 
> Also reduces binary size:
>     text    data     bss     dec     hex filename
>     4185    1384       0    5569    15c1 drivers/hwmon/k8temp.ko.bak
>     3877    1120       0    4997    1385 drivers/hwmon/k8temp.ko
> 

Excellent. Couple of comments below.

> Signed-off-by: Robert Karszniewicz <avoidr@firemail.cc>
> ---
>   drivers/hwmon/k8temp.c | 204 +++++++++++++++++++----------------------
>   1 file changed, 92 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index 4994c90c8929..2e8fa1e07398 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -13,7 +13,6 @@
>   #include <linux/jiffies.h>
>   #include <linux/pci.h>
>   #include <linux/hwmon.h>
> -#include <linux/hwmon-sysfs.h>
>   #include <linux/err.h>
>   #include <linux/mutex.h>
>   #include <asm/processor.h>
> @@ -24,7 +23,6 @@
>   #define SEL_CORE	0x04
>   
>   struct k8temp_data {
> -	struct device *hwmon_dev;
>   	struct mutex update_lock;
>   	const char *name;

No longer needed (see below)

>   	char valid;		/* zero until following fields are valid */
> @@ -40,7 +38,7 @@ struct k8temp_data {
>   static struct k8temp_data *k8temp_update_device(struct device *dev)
>   {
>   	struct k8temp_data *data = dev_get_drvdata(dev);
> -	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev->parent);
>   	u8 tmp;
>   
>   	mutex_lock(&data->update_lock);
> @@ -82,50 +80,10 @@ static struct k8temp_data *k8temp_update_device(struct device *dev)
>   	return data;
>   }
>   
> -/*
> - * Sysfs stuff
> - */
> -
> -static ssize_t name_show(struct device *dev, struct device_attribute
> -			 *devattr, char *buf)
> -{
> -	struct k8temp_data *data = dev_get_drvdata(dev);
> -
> -	return sprintf(buf, "%s\n", data->name);
> -}
> -
> -
> -static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
> -			 char *buf)
> -{
> -	struct sensor_device_attribute_2 *attr =
> -	    to_sensor_dev_attr_2(devattr);
> -	int core = attr->nr;
> -	int place = attr->index;
> -	int temp;
> -	struct k8temp_data *data = k8temp_update_device(dev);
> -
> -	if (data->swap_core_select && (data->sensorsp & SEL_CORE))
> -		core = core ? 0 : 1;
> -
> -	temp = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
> -
> -	return sprintf(buf, "%d\n", temp);
> -}
> -
> -/* core, place */
> -
> -static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0, 0);
> -static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 0, 1);
> -static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 1, 0);
> -static SENSOR_DEVICE_ATTR_2_RO(temp4_input, temp, 1, 1);
> -static DEVICE_ATTR_RO(name);
> -
>   static const struct pci_device_id k8temp_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
>   	{ 0 },
>   };
> -
>   MODULE_DEVICE_TABLE(pci, k8temp_ids);
>   
>   static int is_rev_g_desktop(u8 model)
> @@ -159,14 +117,97 @@ static int is_rev_g_desktop(u8 model)
>   	return 1;
>   }
>   
> +static umode_t
> +k8temp_is_visible(const void *drvdata, enum hwmon_sensor_types type,
> +		  u32 attr, int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;

Not really needed since only temperature sensors are registered in the first place.

> +
> +	if (attr != hwmon_temp_input)
> +		return 0;
> +

The idea here is to only create sensors if they actually exist, so I would expect
something like the following here.

	struct k8temp_data *data = drvdata;

	if (attr != hwmon_temp_input)
		return 0;

	if ((channel & 1) && !(data->sensorsp & SEL_PLACE))
		return 0;

	if ((channel & 2) && !(data->sensorsp & SEL_CORE))
		return 0;

> +	return 0444;
> +}
> +
> +static int
> +k8temp_read(struct device *dev, enum hwmon_sensor_types type,
> +	    u32 attr, int channel, long *val)
> +{
> +	struct k8temp_data *data = k8temp_update_device(dev);

It might make sense to remove all the caching. Reading the sensors
isn't that expensive, after all. More on that see below.

> +	int core, place;
> +
> +	if (type != hwmon_temp)
> +		return -EINVAL;
> +
> +	if (attr != hwmon_temp_input)
> +		return -EINVAL;
> +

The above checks are not needed here, since other sensors and types
have not been instantiated.

> +	switch (channel) {
> +	case 0:
> +		core = 0;
> +		place = 0;
> +		break;
> +	case 1:
> +		core = 0;
> +		place = 1;
> +		break;
> +	case 2:
> +		core = 1;
> +		place = 0;
> +		break;
> +	case 3:
> +		core = 1;
> +		place = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

How about
	core = (channel >> 1) & 1;
	place = channel & 1;
instead ?

> +
> +	if (data->swap_core_select)
> +		core = core ? 0 : 1;

		core = 1 - core;

would accomplish the same without conditional.

As for caching, let's see. Something like the following should do.

	struct pci_dev *pdev = to_pci_dev(dev);
	u32 temp;
	u8 tmp;
	...

	mutex_lock(&data->update_lock);
	pci_read_config_byte(pdev, REG_TEMP, &tmp);
	tmp &= ~(SEL_PLACE | SEL_CORE);
	if (channel)
		tmp |= SEL_PLACE;
	if (core)
		tmp |= SEL_CORE;
	pci_write_config_byte(pdev, REG_TEMP, tmp);
	pci_read_config_dword(pdev, REG_TEMP, &temp);
	mutex_unlock(&data->update_lock);

	*val = TEMP_FROM_REG(temp) + data->temp_offset;

... and then you could drop a lot of code.

> +
> +	*val = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops k8temp_ops = {
> +	.is_visible = k8temp_is_visible,
> +	.read = k8temp_read,
> +};
> +
> +static const u32 k8temp_config[] = {
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	HWMON_T_INPUT,
> +	0
> +};
> +	
> +static const struct hwmon_channel_info k8temp_temp_info = {
> +	.type = hwmon_temp,
> +	.config = k8temp_config,
> +};
> +
> +static const struct hwmon_channel_info *k8temp_info[] = {
> +	&k8temp_temp_info,
> +	NULL
> +};

static const struct hwmon_channel_info *k8temp_info[] = {
	HWMON_CHANNEL_INFO(temp,
		HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT),
	NULL
};

> +
> +static const struct hwmon_chip_info k8temp_chip_info = {
> +	.ops = &k8temp_ops,
> +	.info = k8temp_info,
> +};
> +
>   static int k8temp_probe(struct pci_dev *pdev,
>   				  const struct pci_device_id *id)
>   {
> -	int err;
>   	u8 scfg;
>   	u32 temp;
>   	u8 model, stepping;
>   	struct k8temp_data *data;
> +	struct device *hwmon_dev;
>   
>   	data = devm_kzalloc(&pdev->dev, sizeof(struct k8temp_data), GFP_KERNEL);
>   	if (!data)
> @@ -233,84 +274,23 @@ static int k8temp_probe(struct pci_dev *pdev,
>   
>   	data->name = "k8temp";
>   	mutex_init(&data->update_lock);
> -	pci_set_drvdata(pdev, data);
> -
> -	/* Register sysfs hooks */
> -	err = device_create_file(&pdev->dev,
> -			   &sensor_dev_attr_temp1_input.dev_attr);
> -	if (err)
> -		goto exit_remove;
> -
> -	/* sensor can be changed and reports something */
> -	if (data->sensorsp & SEL_PLACE) {
> -		err = device_create_file(&pdev->dev,
> -				   &sensor_dev_attr_temp2_input.dev_attr);
> -		if (err)
> -			goto exit_remove;
> -	}
> -
> -	/* core can be changed and reports something */
> -	if (data->sensorsp & SEL_CORE) {
> -		err = device_create_file(&pdev->dev,
> -				   &sensor_dev_attr_temp3_input.dev_attr);
> -		if (err)
> -			goto exit_remove;
> -		if (data->sensorsp & SEL_PLACE) {
> -			err = device_create_file(&pdev->dev,
> -					   &sensor_dev_attr_temp4_input.
> -					   dev_attr);
> -			if (err)
> -				goto exit_remove;
> -		}
> -	}
>   
> -	err = device_create_file(&pdev->dev, &dev_attr_name);
> -	if (err)
> -		goto exit_remove;
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +							 data->name,

data->name isn't needed. Just pass "k8temp" directly.

> +							 data,
> +							 &k8temp_chip_info,
> +							 NULL);
>   
> -	data->hwmon_dev = hwmon_device_register(&pdev->dev);
> -
> -	if (IS_ERR(data->hwmon_dev)) {
> -		err = PTR_ERR(data->hwmon_dev);
> -		goto exit_remove;
> -	}
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
>   
>   	return 0;

	return PTR_ERR_OR_ZERO(hwmon_dev);

> -
> -exit_remove:
> -	device_remove_file(&pdev->dev,
> -			   &sensor_dev_attr_temp1_input.dev_attr);
> -	device_remove_file(&pdev->dev,
> -			   &sensor_dev_attr_temp2_input.dev_attr);
> -	device_remove_file(&pdev->dev,
> -			   &sensor_dev_attr_temp3_input.dev_attr);
> -	device_remove_file(&pdev->dev,
> -			   &sensor_dev_attr_temp4_input.dev_attr);
> -	device_remove_file(&pdev->dev, &dev_attr_name);
> -	return err;
> -}
> -
> -static void k8temp_remove(struct pci_dev *pdev)
> -{
> -	struct k8temp_data *data = pci_get_drvdata(pdev);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	device_remove_file(&pdev->dev,
> -			   &sensor_dev_attr_temp1_input.dev_attr);
> -	device_remove_file(&pdev->dev,
> -			   &sensor_dev_attr_temp2_input.dev_attr);
> -	device_remove_file(&pdev->dev,
> -			   &sensor_dev_attr_temp3_input.dev_attr);
> -	device_remove_file(&pdev->dev,
> -			   &sensor_dev_attr_temp4_input.dev_attr);
> -	device_remove_file(&pdev->dev, &dev_attr_name);
>   }
>   
>   static struct pci_driver k8temp_driver = {
>   	.name = "k8temp",
>   	.id_table = k8temp_ids,
>   	.probe = k8temp_probe,
> -	.remove = k8temp_remove,
>   };
>   
>   module_pci_driver(k8temp_driver);
> 

