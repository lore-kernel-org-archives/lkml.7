Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E5BC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D9A2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXymgly1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfGVSfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:35:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38209 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfGVSfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:35:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so17790572pfn.5;
        Mon, 22 Jul 2019 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZvKX1n+pRbwdwmkbAvRdkhqHzETPBbuvkZpv6xUMk4Y=;
        b=KXymgly1tLbiJJTn3kj4fLT5hodvOy620VRtbaqkAKBxAekrqOWQdXPrDo5n5Ey9xC
         G/lCDUEVJIQI/7dzG8ht4/ozuO8JfNsK6m5Y8RsJawzLXk3YJqt9DvdgWtcgjfiTuyfz
         PrKX4LWI9HpIb+4gswVFyKqv6o/jNDkuWkJmMf6SDytgpWpvifx7vYTXVVe6Q490g7uS
         1JsF+jQmK4XgAiXzmknvQGrJGd2ohHAxVycm+OBHAD40Bimdn5VoYhoaf7v8RFyCn26N
         hxJmNRVaU5g/givrJrKzbhU8CV8iCkL22ilzN6TGcll8PXeXCuZ4e0IByd+hbBsIP+9V
         mbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZvKX1n+pRbwdwmkbAvRdkhqHzETPBbuvkZpv6xUMk4Y=;
        b=q/+ly/8mwNXOYGc724iRDX897+SPdAQyvQfWQ7Somj7ctS1adfdJ+ZTsCyVL0kskrp
         WmcGZxU7VyXoksfvtesjETGoEvqCicShA9A8Z5ak85/H3kS2oZwN9ClWperklhWhBzJU
         oDn6IGScirsgWSgCdG9qY1s0u7andiAXD7CU4RhJZmzLhSTYzKVaxHHdYTXFkfwfZQxp
         tu5hS1SpM5tyKcgraFJ2dRwpmJFXR7UwK8hJt2lCSDIQUSTmIgYjPkFST2vr2XKXdRze
         clHmpCsnZ7ZN1CUx2yFJCSBvz1uCMnDKQx96hBmGjTfyujDkiIqOFe5wvev2QYudsE4e
         jiPw==
X-Gm-Message-State: APjAAAX5/nSCVQmKrtAfsKye+WtZlKPNnx/Yiznk0IKqRn/DaSLbPgtE
        BHIDAXa4dUFnLFCiTFf/zyj5t445
X-Google-Smtp-Source: APXvYqy73MAipaG+76GHf1r68WlljKaZpWHyYZf+GA62pnDJrokp7+meFXXzsBOfg43sCAxpq1tIbA==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr75301019pjb.37.1563820524227;
        Mon, 22 Jul 2019 11:35:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 23sm43942566pfn.176.2019.07.22.11.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 11:35:23 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:35:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hwmon: (adt7475) Convert to use
 hwmon_device_register_with_groups()
Message-ID: <20190722183522.GA17207@roeck-us.net>
References: <20190721225530.28799-1-grant.mcewan@alliedtelesis.co.nz>
 <20190721225530.28799-2-grant.mcewan@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721225530.28799-2-grant.mcewan@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:55:30AM +1200, Grant McEwan wrote:
> hwmon_device_register() is a deprecated function and produces a warning.
> 
> Converting the driver to use the hwmon_device_register_with_groups()
> instead.
> 
> Signed-off-by: Grant McEwan <grant.mcewan@alliedtelesis.co.nz>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/adt7475.c | 146 ++++++++++++++--------------------------
>  1 file changed, 50 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index c3c6031a7285..6c64d50c9aae 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -187,7 +187,7 @@ static const struct of_device_id __maybe_unused adt7475_of_match[] = {
>  MODULE_DEVICE_TABLE(of, adt7475_of_match);
>  
>  struct adt7475_data {
> -	struct device *hwmon_dev;
> +	struct i2c_client *client;
>  	struct mutex lock;
>  
>  	unsigned long measure_updated;
> @@ -212,6 +212,7 @@ struct adt7475_data {
>  
>  	u8 vid;
>  	u8 vrm;
> +	const struct attribute_group *groups[9];
>  };
>  
>  static struct i2c_driver adt7475_driver;
> @@ -346,8 +347,8 @@ static ssize_t voltage_store(struct device *dev,
>  {
>  
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	unsigned char reg;
>  	long val;
>  
> @@ -440,8 +441,8 @@ static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t count)
>  {
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	unsigned char reg = 0;
>  	u8 out;
>  	int temp;
> @@ -542,8 +543,7 @@ static ssize_t temp_st_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
>  	long val;
>  
>  	switch (sattr->index) {
> @@ -570,8 +570,8 @@ static ssize_t temp_st_store(struct device *dev,
>  			     size_t count)
>  {
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	unsigned char reg;
>  	int shift, idx;
>  	ulong val;
> @@ -647,8 +647,8 @@ static ssize_t point2_show(struct device *dev, struct device_attribute *attr,
>  static ssize_t point2_store(struct device *dev, struct device_attribute *attr,
>  			    const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
>  	int temp;
>  	long val;
> @@ -710,8 +710,8 @@ static ssize_t tach_store(struct device *dev, struct device_attribute *attr,
>  {
>  
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	unsigned long val;
>  
>  	if (kstrtoul(buf, 10, &val))
> @@ -769,8 +769,8 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
>  {
>  
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	unsigned char reg = 0;
>  	long val;
>  
> @@ -818,8 +818,8 @@ static ssize_t stall_disable_show(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +
>  	u8 mask = BIT(5 + sattr->index);
>  
>  	return sprintf(buf, "%d\n", !!(data->enh_acoustics[0] & mask));
> @@ -830,8 +830,8 @@ static ssize_t stall_disable_store(struct device *dev,
>  				   const char *buf, size_t count)
>  {
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	long val;
>  	u8 mask = BIT(5 + sattr->index);
>  
> @@ -914,8 +914,8 @@ static ssize_t pwmchan_store(struct device *dev,
>  			     size_t count)
>  {
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	int r;
>  	long val;
>  
> @@ -938,8 +938,8 @@ static ssize_t pwmctrl_store(struct device *dev,
>  			     size_t count)
>  {
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	int r;
>  	long val;
>  
> @@ -982,8 +982,8 @@ static ssize_t pwmfreq_store(struct device *dev,
>  			     size_t count)
>  {
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	int out;
>  	long val;
>  
> @@ -1022,8 +1022,8 @@ static ssize_t pwm_use_point2_pwm_at_crit_store(struct device *dev,
>  					struct device_attribute *devattr,
>  					const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	long val;
>  
>  	if (kstrtol(buf, 10, &val))
> @@ -1342,26 +1342,6 @@ static int adt7475_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static void adt7475_remove_files(struct i2c_client *client,
> -				 struct adt7475_data *data)
> -{
> -	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
> -	if (data->has_fan4)
> -		sysfs_remove_group(&client->dev.kobj, &fan4_attr_group);
> -	if (data->has_pwm2)
> -		sysfs_remove_group(&client->dev.kobj, &pwm2_attr_group);
> -	if (data->has_voltage & (1 << 0))
> -		sysfs_remove_group(&client->dev.kobj, &in0_attr_group);
> -	if (data->has_voltage & (1 << 3))
> -		sysfs_remove_group(&client->dev.kobj, &in3_attr_group);
> -	if (data->has_voltage & (1 << 4))
> -		sysfs_remove_group(&client->dev.kobj, &in4_attr_group);
> -	if (data->has_voltage & (1 << 5))
> -		sysfs_remove_group(&client->dev.kobj, &in5_attr_group);
> -	if (data->has_vid)
> -		sysfs_remove_group(&client->dev.kobj, &vid_attr_group);
> -}
> -
>  static int adt7475_update_limits(struct i2c_client *client)
>  {
>  	struct adt7475_data *data = i2c_get_clientdata(client);
> @@ -1489,7 +1469,8 @@ static int adt7475_probe(struct i2c_client *client,
>  	};
>  
>  	struct adt7475_data *data;
> -	int i, ret = 0, revision;
> +	struct device *hwmon_dev;
> +	int i, ret = 0, revision, group_num = 0;
>  	u8 config2, config3;
>  
>  	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> @@ -1497,6 +1478,7 @@ static int adt7475_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	mutex_init(&data->lock);
> +	data->client = client;
>  	i2c_set_clientdata(client, data);
>  
>  	if (client->dev.of_node)
> @@ -1590,52 +1572,40 @@ static int adt7475_probe(struct i2c_client *client,
>  		break;
>  	}
>  
> -	ret = sysfs_create_group(&client->dev.kobj, &adt7475_attr_group);
> -	if (ret)
> -		return ret;
> +	data->groups[group_num++] = &adt7475_attr_group;
>  
>  	/* Features that can be disabled individually */
>  	if (data->has_fan4) {
> -		ret = sysfs_create_group(&client->dev.kobj, &fan4_attr_group);
> -		if (ret)
> -			goto eremove;
> +		data->groups[group_num++] = &fan4_attr_group;
>  	}
>  	if (data->has_pwm2) {
> -		ret = sysfs_create_group(&client->dev.kobj, &pwm2_attr_group);
> -		if (ret)
> -			goto eremove;
> +		data->groups[group_num++] = &pwm2_attr_group;
>  	}
>  	if (data->has_voltage & (1 << 0)) {
> -		ret = sysfs_create_group(&client->dev.kobj, &in0_attr_group);
> -		if (ret)
> -			goto eremove;
> +		data->groups[group_num++] = &in0_attr_group;
>  	}
>  	if (data->has_voltage & (1 << 3)) {
> -		ret = sysfs_create_group(&client->dev.kobj, &in3_attr_group);
> -		if (ret)
> -			goto eremove;
> +		data->groups[group_num++] = &in3_attr_group;
>  	}
>  	if (data->has_voltage & (1 << 4)) {
> -		ret = sysfs_create_group(&client->dev.kobj, &in4_attr_group);
> -		if (ret)
> -			goto eremove;
> +		data->groups[group_num++] = &in4_attr_group;
>  	}
>  	if (data->has_voltage & (1 << 5)) {
> -		ret = sysfs_create_group(&client->dev.kobj, &in5_attr_group);
> -		if (ret)
> -			goto eremove;
> +		data->groups[group_num++] = &in5_attr_group;
>  	}
>  	if (data->has_vid) {
>  		data->vrm = vid_which_vrm();
> -		ret = sysfs_create_group(&client->dev.kobj, &vid_attr_group);
> -		if (ret)
> -			goto eremove;
> +		data->groups[group_num] = &vid_attr_group;
>  	}
>  
> -	data->hwmon_dev = hwmon_device_register(&client->dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		ret = PTR_ERR(data->hwmon_dev);
> -		goto eremove;
> +	/* register device with all the acquired attributes */
> +	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
> +							   client->name, data,
> +							   data->groups);
> +
> +	if (IS_ERR(hwmon_dev)) {
> +		ret = PTR_ERR(hwmon_dev);
> +		return ret;
>  	}
>  
>  	dev_info(&client->dev, "%s device, revision %d\n",
> @@ -1657,21 +1627,7 @@ static int adt7475_probe(struct i2c_client *client,
>  	/* Limits and settings, should never change update more than once */
>  	ret = adt7475_update_limits(client);
>  	if (ret)
> -		goto eremove;
> -
> -	return 0;
> -
> -eremove:
> -	adt7475_remove_files(client, data);
> -	return ret;
> -}
> -
> -static int adt7475_remove(struct i2c_client *client)
> -{
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	adt7475_remove_files(client, data);
> +		return ret;
>  
>  	return 0;
>  }
> @@ -1683,7 +1639,6 @@ static struct i2c_driver adt7475_driver = {
>  		.of_match_table = of_match_ptr(adt7475_of_match),
>  	},
>  	.probe		= adt7475_probe,
> -	.remove		= adt7475_remove,
>  	.id_table	= adt7475_id,
>  	.detect		= adt7475_detect,
>  	.address_list	= normal_i2c,
> @@ -1757,8 +1712,8 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
>  
>  static int adt7475_update_measure(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	u16 ext;
>  	int i;
>  	int ret;
> @@ -1854,8 +1809,7 @@ static int adt7475_update_measure(struct device *dev)
>  
>  static struct adt7475_data *adt7475_update_device(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
>  	int ret;
>  
>  	mutex_lock(&data->lock);
