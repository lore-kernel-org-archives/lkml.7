Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1905C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D1E20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFmzteWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfDPTw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:52:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33204 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPTw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:52:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so10860221plo.0;
        Tue, 16 Apr 2019 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q48l/tZXosNhmiaBqpv4IRMYrZo4BdVV+C/1sWO1DeU=;
        b=FFmzteWLQX71u6g0B3qU3nd3dshibGWDjuRiu/bQuVgNqJnLxTln6sX9msGxI5KZ53
         NcQWWo5srAU+KBdsSVZ7hPb11uxJLFPinAsKqp67PBaCNWFmI4mguan4QvqGXFvBRo3l
         4QM3yTkAnDtoi7MI0emg/6Z4ccP4YGiT9kcTSEaCJtQLQL5CjPkZ8KI5YuLaRWzmVOya
         CttqNns1z2nuyqeh1jqY+k1Ak10395fPKy0M64GOXW0BDSWAi++DRRv6GED7M79BFZPH
         DomdnmBA9ZbPeSVUS/siWlGGzfgOP5lCDieeqDt9Komgo2Wz89x2uFldm8wVAPHSMDiG
         BAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q48l/tZXosNhmiaBqpv4IRMYrZo4BdVV+C/1sWO1DeU=;
        b=PvxIm699VWRoUU23wbtT/Ve8dTlmunLcw0D2nkQbMfUlBbWOfA4amiwNiBJz6yYfY7
         8wT3vGkRkWRF07+Is4IXNX1hCLaaldSEQISxAb+iex48Yod5/n+HvHhvorBNRH40ceCK
         AYYZnEcvpVcJ5e3KvB9IUbrLoRlWg7+xYF9VfYY6Wpd2BFFtfQWE8bubpBq4dKjHMG8Y
         EqqjRv2BbKUZDkY7Xut/CLvX62FtndStH7TNp7JVpsxpSWGCOyMdbT5p+Pciw88IUmJ3
         pV8CqO0ByShb1qrHzXnmXDXZUOPYmVquMrLysrDH/n4opYEX3B+ZXCGkb83CuuHjjR8X
         RyjA==
X-Gm-Message-State: APjAAAUlivuc2unEXgfv08I+34fQ1C70RyJGZV38FjALM0mosJu+Yoy4
        s0T5iWUBgqjYRCsQX4JW/Ks=
X-Google-Smtp-Source: APXvYqym7VVmMWeGOVpjePDk6JJZk8F9cqYhzQnT8ktktWxO791hMV0f4X8Zo3v0sKpmhwJUwCpR1w==
X-Received: by 2002:a17:902:2ec5:: with SMTP id r63mr30842783plb.139.1555444376899;
        Tue, 16 Apr 2019 12:52:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p9sm22419768pfi.186.2019.04.16.12.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 12:52:56 -0700 (PDT)
Date:   Tue, 16 Apr 2019 12:52:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     xe-linux-external@cisco.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] hwmon: (pmbus) add support for output voltage
 registers
Message-ID: <20190416195255.GC8093@roeck-us.net>
References: <20190416183620.39950-1-ruslan@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416183620.39950-1-ruslan@babayev.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:36:16AM -0700, Ruslan Babayev wrote:
> Registers VOUT_COMMAND, VOUT_MARGIN_HIGH and VOUT_MARGIN_LOW are
> described in PMBUS Spec Part II Rev 1.2. Exposing them in the PMBUS
> core allows the drivers to turn them on with a corresponding
> PMBUS_HAVE_VOUT_... flags.
> 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
> ---
>  drivers/hwmon/pmbus/pmbus.h      |   7 ++
>  drivers/hwmon/pmbus/pmbus_core.c | 183 +++++++++++++++++++++++++++++++
>  2 files changed, 190 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 1d24397d36ec..723648b3da36 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -223,6 +223,9 @@ enum pmbus_regs {
>   * OPERATION
>   */
>  #define PB_OPERATION_CONTROL_ON		BIT(7)
> +#define PB_OPERATION_MARGIN_HIGH	BIT(5)
> +#define PB_OPERATION_MARGIN_LOW		BIT(4)
> +#define PB_OPERATION_ACT_ON_FAULT	BIT(3)
>  
>  /*
>   * CAPABILITY
> @@ -291,6 +294,7 @@ enum pmbus_fan_mode { percent = 0, rpm };
>  /*
>   * STATUS_VOUT, STATUS_INPUT
>   */
> +#define PB_VOLTAGE_MAX_WARNING		BIT(3)
>  #define PB_VOLTAGE_UV_FAULT		BIT(4)
>  #define PB_VOLTAGE_UV_WARNING		BIT(5)
>  #define PB_VOLTAGE_OV_WARNING		BIT(6)
> @@ -371,6 +375,9 @@ enum pmbus_sensor_classes {
>  #define PMBUS_HAVE_STATUS_VMON	BIT(19)
>  #define PMBUS_HAVE_PWM12	BIT(20)
>  #define PMBUS_HAVE_PWM34	BIT(21)
> +#define PMBUS_HAVE_VOUT_COMMAND		BIT(22)
> +#define PMBUS_HAVE_VOUT_MARGIN_HIGH	BIT(23)
> +#define PMBUS_HAVE_VOUT_MARGIN_LOW	BIT(24)
>  
>  #define PMBUS_PAGE_VIRTUAL	BIT(31)
>  
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 2e2b5851139c..f35b239961e3 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -89,6 +89,14 @@ struct pmbus_label {
>  #define to_pmbus_label(_attr) \
>  	container_of(_attr, struct pmbus_label, attribute)
>  
> +struct pmbus_operation {
> +	char name[PMBUS_NAME_SIZE];	/* sysfs label name */
> +	struct sensor_device_attribute attribute;
> +	u8 page;
> +};
> +#define to_pmbus_operation(_attr) \
> +	container_of(_attr, struct pmbus_operation, attribute)
> +
>  struct pmbus_data {
>  	struct device *dev;
>  	struct device *hwmon_dev;
> @@ -1004,6 +1012,65 @@ static ssize_t pmbus_show_label(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE, "%s\n", label->label);
>  }
>  
> +static ssize_t pmbus_show_operation(struct device *dev,
> +				    struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pmbus_operation *operation = to_pmbus_operation(attr);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	int ret;
> +
> +	ret = pmbus_read_byte_data(client, operation->page, PMBUS_OPERATION);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret & PB_OPERATION_CONTROL_ON) {
> +		if (ret & PB_OPERATION_MARGIN_HIGH)
> +			return snprintf(buf, PAGE_SIZE, "high\n");
> +		else if (ret & PB_OPERATION_MARGIN_LOW)
> +			return snprintf(buf, PAGE_SIZE, "low\n");
> +		else
> +			return snprintf(buf, PAGE_SIZE, "on\n");
> +	} else {
> +			return snprintf(buf, PAGE_SIZE, "off\n");
> +	}
> +}
> +
> +static ssize_t pmbus_set_operation(struct device *dev,
> +				   struct device_attribute *devattr,
> +				   const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pmbus_operation *operation = to_pmbus_operation(attr);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	int ret;
> +	u8 val;
> +
> +	/*
> +	 * sysfs_streq() doesn't need the \n's, but we add them so the strings
> +	 * will be shared with pmbus_show_operation() above.
> +	 */

Saving a few bytes of data in the driver is not worth such limitations. 
I would not want to have to deal with users sending "echo -n on" to the
driver and complain that it doesn't work.

> +	if (sysfs_streq(buf, "on\n"))
> +		val = PB_OPERATION_CONTROL_ON;
> +	else if (sysfs_streq(buf, "off\n"))
> +		val = 0;
> +	else if (sysfs_streq(buf, "high\n"))
> +		val = PB_OPERATION_CONTROL_ON | PB_OPERATION_ACT_ON_FAULT |
> +		      PB_OPERATION_MARGIN_HIGH;
> +	else if (sysfs_streq(buf, "low\n"))
> +		val = PB_OPERATION_CONTROL_ON | PB_OPERATION_ACT_ON_FAULT |
> +		      PB_OPERATION_MARGIN_LOW;
> +	else
> +		return -EINVAL;
> +
> +	ret = pmbus_write_byte_data(client, operation->page,
> +				    PMBUS_OPERATION, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
I am not convinced that it is a good idea to implement this as sysfs
attributes. It is notmally only used in manufacturing, and there the
registers can be acccessed directly.

Either case, we can not implement this in the pmbus driver as generic code.
Operation commands are notoriously implemented with slight differences across
different devices. It would also probably be more appropriate to implement
as regulator, since it affects setting voltages, not limits.

>  static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
>  {
>  	if (data->num_attributes >= data->max_attributes - 1) {
> @@ -1143,6 +1210,29 @@ static int pmbus_add_label(struct pmbus_data *data,
>  	return pmbus_add_attribute(data, &a->attr);
>  }
>  
> +static int pmbus_add_operation(struct pmbus_data *data, const char *name,
> +			       int seq, int page)
> +{
> +	struct pmbus_operation *operation;
> +	struct sensor_device_attribute *a;
> +
> +	operation = devm_kzalloc(data->dev, sizeof(*operation), GFP_KERNEL);
> +	if (!operation)
> +		return -ENOMEM;
> +
> +	a = &operation->attribute;
> +
> +	snprintf(operation->name, sizeof(operation->name), "%s%d_operation",
> +		 name, seq);
> +
> +	operation->page = page;
> +
> +	pmbus_attr_init(a, operation->name, S_IRUGO | S_IWUSR,
> +			pmbus_show_operation, pmbus_set_operation, seq);
> +
> +	return pmbus_add_attribute(data, &a->dev_attr.attr);
> +}
> +
>  /*
>   * Search for attributes. Allocate sensors, booleans, and labels as needed.
>   */
> @@ -1901,6 +1991,93 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
>  	return 0;
>  }
>  
> +static const struct pmbus_limit_attr vout_cmd_limit_attrs[] = {
> +	{
> +		.reg = PMBUS_VOUT_MAX,
> +		.attr = "max",
> +		.alarm = "max_alarm",
> +		.sbit = PB_VOLTAGE_MAX_WARNING,
> +	}
> +};
> +
> +static const struct pmbus_sensor_attr vout_attributes[] = {
> +	{
> +		.reg = PMBUS_VOUT_COMMAND,
> +		.class = PSC_VOLTAGE_OUT,
> +		.label = "command",

Bad name for a label.

> +		.paged = true,
> +		.func = PMBUS_HAVE_VOUT_COMMAND,
> +		.sfunc = PMBUS_HAVE_STATUS_VOUT,
> +		.sbase = PB_STATUS_VOUT_BASE,
> +		.gbit = PB_STATUS_VOUT_OV,
> +		.limit = vout_cmd_limit_attrs,
> +		.nlimit = ARRAY_SIZE(vout_cmd_limit_attrs),
> +	}, {
> +		.reg = PMBUS_VOUT_MARGIN_HIGH,
> +		.class = PSC_VOLTAGE_OUT,
> +		.label = "margin_high",
> +		.paged = true,
> +		.func = PMBUS_HAVE_VOUT_MARGIN_HIGH,
> +	}, {
> +		.reg = PMBUS_VOUT_MARGIN_LOW,
> +		.class = PSC_VOLTAGE_OUT,
> +		.label = "margin_low",
> +		.paged = true,
> +		.func = PMBUS_HAVE_VOUT_MARGIN_LOW,
> +	}
> +};
> +
> +static int pmbus_add_vout_attrs(struct i2c_client *client,
> +				struct pmbus_data *data,
> +				const char *name,
> +				const struct pmbus_sensor_attr *attr,
> +				int nattrs)
> +{
> +	const struct pmbus_driver_info *info = data->info;
> +	struct pmbus_sensor *base;
> +	int i, ret, index, page, pages;
> +
> +	index = 1;
> +	for (page = 0; page < info->pages; page++) {
> +		if (!pmbus_check_byte_register(client, page, PMBUS_OPERATION))
> +			continue;
> +		ret = pmbus_add_operation(data, name, index, page);
> +		if (ret)
> +			return ret;
> +		index++;
> +	}
> +
> +	for (i = 0; i < nattrs; i++) {
> +		index = 1;
> +		pages = attr->paged ? info->pages : 1;
> +		for (page = 0; page < pages; page++) {
> +			if (!(info->func[page] & attr->func))
> +				continue;
> +
> +			if (!pmbus_check_word_register(client, page, attr->reg))
> +				continue;
> +
> +			base = pmbus_add_sensor(data, name, attr->label, index,
> +						page, attr->reg, attr->class,
> +						true, false, true);
> +			if (!base)
> +				return -ENOMEM;
> +
> +			if (attr->sfunc) {
> +				ret = pmbus_add_limit_attrs(client, data, info,
> +							    name, index, page,
> +							    base, attr);
> +				if (ret < 0)
> +					return ret;
> +			}
> +
> +			index++;
> +		}
> +		attr++;
> +	}
> +	return 0;
> +}
> +
>  static int pmbus_find_attributes(struct i2c_client *client,
>  				 struct pmbus_data *data)
>  {
> @@ -1912,6 +2089,12 @@ static int pmbus_find_attributes(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> +	/* Output Voltage sensors */
> +	ret = pmbus_add_vout_attrs(client, data, "out", vout_attributes,
> +				   ARRAY_SIZE(vout_attributes));
> +	if (ret)
> +		return ret;
> +

The sensors you are adding are not output voltage sensors. They are not
sensors in the first place, and should probably not be reported as sensor
values. And setting voltages as limits is really not appropriate.

>  	/* Current sensors */
>  	ret = pmbus_add_sensor_attrs(client, data, "curr", current_attributes,
>  				     ARRAY_SIZE(current_attributes));
> -- 
> 2.17.1
> 
