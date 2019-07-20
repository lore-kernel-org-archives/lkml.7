Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C1C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84612085A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 14:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZTqzSQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfGTOYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 10:24:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39762 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfGTOX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 10:23:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so17034170pls.6;
        Sat, 20 Jul 2019 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2WY7gIiE4mOMpygdUF32NBGOQWOHXGXeU7Fsa2C5D6w=;
        b=SZTqzSQAn6Iy1lRwE1x7yyH32lIyqYNZO+t7ZbjRiYEi2FdGf0vp3GBn3m8+2vTENQ
         DoEORWiJ43ck/Dp9QsqDHcoZGqrrs82F6oBiZXXVWKsaM6Jo36b6dVGAq6/NpU1NSAe3
         IUI1EcE8w2rjVhkwlEln0a5z+pkymBObNXMR9ktaj+KJAUvjSqAmUdHwzu6dEWGH7BvF
         QrtjBrfGwYVw8zKI4GxoPnn7eWBMw+wdhGVdXYxUXp+Lv6oBetWRFZNjPgrVHZQDBSMX
         8eSjQP73KlkPnFI+iafe18quWzxeMGagNNss6Te4NW4PCp9FZzEtkZBAacxpA/2Sfjc2
         W07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2WY7gIiE4mOMpygdUF32NBGOQWOHXGXeU7Fsa2C5D6w=;
        b=rmGFCCjuuk2Eo4yGyN5aDfbS2gFTeMchiLFPgS7a9S5p0Wrd7WKVWB3o6+x3e9I1Ph
         8k/miJH4/Gw6MN8slaQhD1O8S6I1I8gjImwbBvchU2D2Os4UskeUI4asfSaT9jwB9aIF
         bqiY70Qu6tejHMumBEytDrID1CLqJAw9uKxHYrlmY4iCffnYMTMykh2CWyxJFKxzfgB9
         djuW0o/7fjdT3QmthLLi63hhEa/p4ImnE4ySojEB9iLzFj/s57EUZb+0THW31Ali+2dn
         6srFo9/rhSgQrCvw/fdZPSiXGMxy3ASp0nPZqK2XqtDZw8r9aUT71Zp2qNwz4yiFd3y4
         Fq/w==
X-Gm-Message-State: APjAAAWyNBGevClLN11t4YvDKAJj+WasN7UdpMaD2GAp2oi/gqUz4hPX
        CIeI9SsBdxhbQc0NAPprWAwKCvWB
X-Google-Smtp-Source: APXvYqx7waD5QNp+5QIAsd+uWZsV1dUYM1XdIYYaofP0XGmm9yl9n4KZhYg7bfBpTaoU4cUxpscoVQ==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr53467623pla.33.1563632638711;
        Sat, 20 Jul 2019 07:23:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k5sm26440753pjl.32.2019.07.20.07.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 07:23:58 -0700 (PDT)
Date:   Sat, 20 Jul 2019 07:23:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (adt7475) Convert to use
 hwmon_device_register_with_groups()
Message-ID: <20190720142357.GA30793@roeck-us.net>
References: <20190719014130.1090-1-grant.mcewan@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719014130.1090-1-grant.mcewan@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 01:41:30PM +1200, Grant McEwan wrote:
> hwmon_device_register() is a deprecated function and produces a warning.
> 
> Converting the driver to use the hwmon_device_register_with_groups()
> instead.
> 
> Signed-off-by: Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
> ---
>  drivers/hwmon/adt7475.c | 104 +++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index c3c6031a7285..4e838555102f 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -188,6 +188,7 @@ MODULE_DEVICE_TABLE(of, adt7475_of_match);
>  
>  struct adt7475_data {
>  	struct device *hwmon_dev;
> +	struct i2c_client *client;
>  	struct mutex lock;
>  
>  	unsigned long measure_updated;
> @@ -212,6 +213,7 @@ struct adt7475_data {
>  
>  	u8 vid;
>  	u8 vrm;
> +	const struct attribute_group *groups[8];

There are a total of 8 groups, and the list of groups needs to be
terminated with a NULL pointer, so there have to be 9 entries in
this array.

>  };
>  
>  static struct i2c_driver adt7475_driver;
> @@ -346,8 +348,8 @@ static ssize_t voltage_store(struct device *dev,
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
> @@ -440,8 +442,8 @@ static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
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
> @@ -542,8 +544,7 @@ static ssize_t temp_st_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
>  	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
>  	long val;
>  
>  	switch (sattr->index) {
> @@ -570,8 +571,8 @@ static ssize_t temp_st_store(struct device *dev,
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
> @@ -647,8 +648,8 @@ static ssize_t point2_show(struct device *dev, struct device_attribute *attr,
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
> @@ -710,8 +711,8 @@ static ssize_t tach_store(struct device *dev, struct device_attribute *attr,
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
> @@ -769,8 +770,8 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
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
> @@ -818,8 +819,8 @@ static ssize_t stall_disable_show(struct device *dev,
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
> @@ -830,8 +831,8 @@ static ssize_t stall_disable_store(struct device *dev,
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
> @@ -914,8 +915,8 @@ static ssize_t pwmchan_store(struct device *dev,
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
> @@ -938,8 +939,8 @@ static ssize_t pwmctrl_store(struct device *dev,
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
> @@ -982,8 +983,8 @@ static ssize_t pwmfreq_store(struct device *dev,
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
> @@ -1022,8 +1023,8 @@ static ssize_t pwm_use_point2_pwm_at_crit_store(struct device *dev,
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
> @@ -1305,6 +1306,9 @@ static const struct attribute_group in4_attr_group = { .attrs = in4_attrs };
>  static const struct attribute_group in5_attr_group = { .attrs = in5_attrs };
>  static const struct attribute_group vid_attr_group = { .attrs = vid_attrs };
>  
> +/* Number of possible attribute groups to add into sysfs */
> +#define ATTR_GROUP_COUNT 8
> +

Not used anywhere.

>  static int adt7475_detect(struct i2c_client *client,
>  			  struct i2c_board_info *info)
>  {
> @@ -1489,7 +1493,7 @@ static int adt7475_probe(struct i2c_client *client,
>  	};
>  
>  	struct adt7475_data *data;
> -	int i, ret = 0, revision;
> +	int i, ret = 0, revision, group_num = 0;
>  	u8 config2, config3;
>  
>  	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> @@ -1497,6 +1501,7 @@ static int adt7475_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	mutex_init(&data->lock);
> +	data->client = client;
>  	i2c_set_clientdata(client, data);
>  
>  	if (client->dev.of_node)
> @@ -1590,49 +1595,37 @@ static int adt7475_probe(struct i2c_client *client,
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
> +	/* register device with all the acquired attributes */
> +	data->hwmon_dev = hwmon_device_register_with_groups(&client->dev,
> +							    client->name, data,
> +							    data->groups);
> +

You could call devm_hwmon_device_register_with_groups() here, drop the
remove function, and drop hwmon_dev from struct adt7475_data.

Also, adt7475_remove_files() is no longer necessary. With the new API,
attribute files are owned by the hwmon subsystem.

>  	if (IS_ERR(data->hwmon_dev)) {
>  		ret = PTR_ERR(data->hwmon_dev);
>  		goto eremove;
> @@ -1757,8 +1750,8 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
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
> @@ -1854,8 +1847,7 @@ static int adt7475_update_measure(struct device *dev)
>  
>  static struct adt7475_data *adt7475_update_device(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct adt7475_data *data = dev_get_drvdata(dev);
>  	int ret;
>  
>  	mutex_lock(&data->lock);
