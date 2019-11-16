Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FD5C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 22:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A4020730
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 22:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMyO+X9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKPWI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 17:08:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35775 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 17:08:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id q13so8385699pff.2;
        Sat, 16 Nov 2019 14:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c9Bsj+Ytkl4lsEgQewp6LWoKrSd3HfCpyrPvdNpCCys=;
        b=DMyO+X9pWtQk4w+mPLaTlLhTegMQYjU0koJsya9yyzLisHcJ04nQkqpnmbjNmwpDot
         pD/KzNgNcSvXMF3bj/jiGLJlCBBvSzOpYBfLhyXUgRHra1Cb4ktTmLBixkGsUty9LUzM
         ltgTUGKL64Agn3YaV2MinHNM14Pjka8cQkdlrZKlMIzMqJsq/ZVeWcH4d6dJEliQOLmW
         XKeoCCUZbOAU2xg+foi/EhipDrADZ+bJgrU0qFZHF02+5yAzcpcagpri0Yu6nVA7o7DE
         /Nr9f14SVqro+yNoPrizFy4/U6dbg8pUbcJ1oSlpOg64Sva3wwaoe2fOSjy8KCJQRC3y
         EIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c9Bsj+Ytkl4lsEgQewp6LWoKrSd3HfCpyrPvdNpCCys=;
        b=AhbRAhvNlDcoZ/fZjfJc6hXbI2Z/c/GyL7AclMVqf445fdS0DuI1Rg+KSsNPCKRx6g
         zpR1M/ealw3EjXrQ1mzT1WCfylMTfgndZQwsVcvyrobikWDwGB4RC/QujHXAtCehrc75
         g1Qbewb6LOUGCUNznMONUIy9az90E2y3bItMzyPFUZITQ1/ojVmRDXKLk+5RqfX3es5z
         mySzpTboUxLRil9PFpw5kcvyuo9ZEiFF6SvX96UkzZhHjfswT3eAZogxW/SM/M6e8cUU
         en+Fs1Bt4QVpNIA7LimmNwqR5NUph1CULyVNGgz5Vjj7TKw4ZNs3973uGwqODOQ9s4Vj
         0tqw==
X-Gm-Message-State: APjAAAU/yC9vna9QILVcCXbs6Fdh0kmBSdI9Gsl0j2rrcMpDefkqt3RY
        v7Ysf+UcD7nxCoG0QwTq48wdDGT9
X-Google-Smtp-Source: APXvYqyuXgeBjc6ZZsDxDK9ox0KsAkCCPxktcFi2RpHGMLNsQXmp90uVW6QnfI+7IX3/uS5K6kREKg==
X-Received: by 2002:a63:4653:: with SMTP id v19mr11492789pgk.307.1573942135078;
        Sat, 16 Nov 2019 14:08:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l5sm6517290pga.71.2019.11.16.14.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 14:08:54 -0800 (PST)
Subject: Re: [PATCH v3] dell-smm-hwmon: Add support for disabling automatic
 BIOS fan control
To:     Giovanni Mascellani <gio@debian.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191116173610.208358-1-gio@debian.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3a10f96a-06e1-39f4-74a6-908d25b1f496@roeck-us.net>
Date:   Sat, 16 Nov 2019 14:08:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191116173610.208358-1-gio@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/19 9:36 AM, Giovanni Mascellani wrote:
> This patch exports standard hwmon pwmX_enable sysfs attribute for
> enabling or disabling automatic fan control by BIOS. Standard value
> "1" is for disabling automatic BIOS fan control and value "2" for
> enabling.
> 
> By default BIOS auto mode is enabled by laptop firmware.
> 
> When BIOS auto mode is enabled, custom fan speed value (set via hwmon
> pwmX sysfs attribute) is overwritten by SMM in few seconds and
> therefore any custom settings are without effect. So this is reason
> why implementing option for disabling BIOS auto mode is needed.
> 
> So finally this patch allows kernel to set and control fan speed on
> laptops, but it can be dangerous (like setting speed of other fans).
> 
> The SMM commands to enable or disable automatic fan control are not
> documented and are not the same on all Dell laptops. Therefore a
> whitelist is used to send the correct codes only on laptopts for which
> they are known.
> 
> This patch was originally developed by Pali Rohár; later Giovanni
> Mascellani implemented the whitelist.
> 
> Signed-off-by: Giovanni Mascellani <gio@debian.org>
> Co-Developer-by: Pali Rohár <pali.rohar@gmail.com>
> ---
>   drivers/hwmon/dell-smm-hwmon.c | 119 ++++++++++++++++++++++++++++++---
>   1 file changed, 109 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 4212d022d253..87f88896cc79 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -68,6 +68,8 @@ static uint i8k_pwm_mult;
>   static uint i8k_fan_max = I8K_FAN_HIGH;
>   static bool disallow_fan_type_call;
>   static bool disallow_fan_support;
> +static unsigned int manual_fan;
> +static unsigned int auto_fan;
>   
>   #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
>   #define I8K_HWMON_HAVE_TEMP2	(1 << 1)
> @@ -300,6 +302,20 @@ static int i8k_get_fan_nominal_speed(int fan, int speed)
>   	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * i8k_fan_mult;
>   }
>   
> +/*
> + * Enable or disable automatic BIOS fan control support
> + */
> +static int i8k_enable_fan_auto_mode(bool enable)
> +{
> +	struct smm_regs regs = { };
> +
> +	if (disallow_fan_support)
> +		return -EINVAL;
> +
> +	regs.eax = enable ? auto_fan : manual_fan;
> +	return i8k_smm(&regs);
> +}
> +
>   /*
>    * Set the fan speed (off, low, high). Returns the new fan status.
>    */
> @@ -726,6 +742,35 @@ static ssize_t i8k_hwmon_pwm_store(struct device *dev,
>   	return err < 0 ? -EIO : count;
>   }
>   
> +static ssize_t i8k_hwmon_pwm_enable_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	int err;
> +	bool enable;
> +	unsigned long val;
> +
> +	if (!auto_fan)
> +		return -ENODEV;
> +
> +	err = kstrtoul(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	if (val == 1)
> +		enable = false;
> +	else if (val == 2)
> +		enable = true;
> +	else
> +		return -EINVAL;
> +
> +	mutex_lock(&i8k_mutex);
> +	err = i8k_enable_fan_auto_mode(enable);
> +	mutex_unlock(&i8k_mutex);
> +
> +	return err ? -EIO : count;

Why override the error code ? i8k_enable_fan_auto_mode()
can return -EINVAL.

I can see that the rest of the driver has the same bad habit,
but that is not a reason to continue it.

> +}
> +
>   static SENSOR_DEVICE_ATTR_RO(temp1_input, i8k_hwmon_temp, 0);
>   static SENSOR_DEVICE_ATTR_RO(temp1_label, i8k_hwmon_temp_label, 0);
>   static SENSOR_DEVICE_ATTR_RO(temp2_input, i8k_hwmon_temp, 1);
> @@ -749,12 +794,15 @@ static SENSOR_DEVICE_ATTR_RO(temp10_label, i8k_hwmon_temp_label, 9);
>   static SENSOR_DEVICE_ATTR_RO(fan1_input, i8k_hwmon_fan, 0);
>   static SENSOR_DEVICE_ATTR_RO(fan1_label, i8k_hwmon_fan_label, 0);
>   static SENSOR_DEVICE_ATTR_RW(pwm1, i8k_hwmon_pwm, 0);
> +static SENSOR_DEVICE_ATTR_WO(pwm1_enable, i8k_hwmon_pwm_enable, 0);
>   static SENSOR_DEVICE_ATTR_RO(fan2_input, i8k_hwmon_fan, 1);
>   static SENSOR_DEVICE_ATTR_RO(fan2_label, i8k_hwmon_fan_label, 1);
>   static SENSOR_DEVICE_ATTR_RW(pwm2, i8k_hwmon_pwm, 1);
> +static SENSOR_DEVICE_ATTR_WO(pwm2_enable, i8k_hwmon_pwm_enable, 0);
>   static SENSOR_DEVICE_ATTR_RO(fan3_input, i8k_hwmon_fan, 2);
>   static SENSOR_DEVICE_ATTR_RO(fan3_label, i8k_hwmon_fan_label, 2);
>   static SENSOR_DEVICE_ATTR_RW(pwm3, i8k_hwmon_pwm, 2);
> +static SENSOR_DEVICE_ATTR_WO(pwm3_enable, i8k_hwmon_pwm_enable, 0);

Having three attributes do all the same is not very valuable.
I would suggest to stick with pwm1_enable and document that it applies
to all pwm channels.

>   
>   static struct attribute *i8k_attrs[] = {
>   	&sensor_dev_attr_temp1_input.dev_attr.attr,	/* 0 */
> @@ -780,12 +828,15 @@ static struct attribute *i8k_attrs[] = {
>   	&sensor_dev_attr_fan1_input.dev_attr.attr,	/* 20 */
>   	&sensor_dev_attr_fan1_label.dev_attr.attr,	/* 21 */
>   	&sensor_dev_attr_pwm1.dev_attr.attr,		/* 22 */
> -	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 23 */
> -	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 24 */
> -	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 25 */
> -	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 26 */
> -	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 27 */
> -	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 28 */
> +	&sensor_dev_attr_pwm1_enable.dev_attr.attr,	/* 23 */
> +	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 24 */
> +	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 25 */
> +	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 26 */
> +	&sensor_dev_attr_pwm2_enable.dev_attr.attr,	/* 27 */
> +	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 28 */
> +	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 29 */
> +	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 30 */
> +	&sensor_dev_attr_pwm3_enable.dev_attr.attr,	/* 31 */
>   	NULL
>   };
>   
> @@ -828,16 +879,20 @@ static umode_t i8k_is_visible(struct kobject *kobj, struct attribute *attr,
>   	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP10))
>   		return 0;
>   
> -	if (index >= 20 && index <= 22 &&
> +	if (index >= 20 && index <= 23 &&
>   	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN1))
>   		return 0;
> -	if (index >= 23 && index <= 25 &&
> +	if (index >= 24 && index <= 27 &&
>   	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN2))
>   		return 0;
> -	if (index >= 26 && index <= 28 &&
> +	if (index >= 28 && index <= 31 &&
>   	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN3))
>   		return 0;
>   
> +	if ((index == 23 || index == 27 || index == 31) &&
> +	    !auto_fan)
> +		return 0;
> +
>   	return attr->mode;
>   }
>   
> @@ -1135,12 +1190,48 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
>   	{ }
>   };
>   
> +struct i8k_fan_control_data {
> +	unsigned int manual_fan;
> +	unsigned int auto_fan;
> +};
> +
> +enum i8k_fan_controls {
> +	I8K_FAN_34A3_35A3,
> +};
> +
> +static const struct i8k_fan_control_data i8k_fan_control_data[] = {
> +	[I8K_FAN_34A3_35A3] = {
> +		.manual_fan = 0x34a3,
> +		.auto_fan = 0x35a3,
> +	},
> +};
> +
> +static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
> +	{
> +		.ident = "Dell Precision 5530",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> +	{
> +		.ident = "Dell Latitude E6440",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E6440"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> +	{ }
> +};
> +
>   /*
>    * Probe for the presence of a supported laptop.
>    */
>   static int __init i8k_probe(void)
>   {
> -	const struct dmi_system_id *id;
> +	const struct dmi_system_id *id, *fan_control;
>   	int fan, ret;
>   
>   	/*
> @@ -1200,6 +1291,14 @@ static int __init i8k_probe(void)
>   	i8k_fan_max = fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
>   	i8k_pwm_mult = DIV_ROUND_UP(255, i8k_fan_max);
>   
> +	fan_control = dmi_first_match(i8k_whitelist_fan_control);
> +	if (fan_control && fan_control->driver_data) {
> +		const struct i8k_fan_control_data *fan_control_data = fan_control->driver_data;
> +		manual_fan = fan_control_data->manual_fan;
> +		auto_fan = fan_control_data->auto_fan;
> +		pr_info("enabling experimental BIOS fan control support\n");

That isn't entirely accurate. What this enables is the ability
to select automatic or manual fan control.

> +	}
> +
>   	if (!fan_mult) {
>   		/*
>   		 * Autodetect fan multiplier based on nominal rpm
> 

