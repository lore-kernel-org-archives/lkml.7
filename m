Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF183C33C9C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772E218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkNGEg14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfKPPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:53:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43489 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfKPPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:53:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id a18so6821017plm.10;
        Sat, 16 Nov 2019 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3oG0EyAeJ44BrAqIWrqCfJH3ESwsz3poXTJWAbRRTXA=;
        b=XkNGEg14YOxkh3WUGePiOKP2/L0UTR9d+KidNRUcYHIhFq3jBefMKBB6+WGWDvRDYW
         WvXiHxsiTiJN7H1ei0TZd3oBmXAajlEc42uhVXXll5Sod7mpZAQ6zysqgXrp8ZeU3gcw
         QEmig/40Ln+UzXTTF/7rDhmBW2H7BR/8zTsEJYriIJ/YWaTyQxa+r5Y5Tk494zr0nHVe
         MsxboYQJhteeEAAiK/frPXvAjVzbU4pvHuxEFaj0HI/RHlOPoiNr+L+bzTYl8jh5Iz5l
         Esqiyvg/bXWb+tmFRMicI7PSvzJoECRkACa7bG4pb9xZoGxsoo+UCSCJS1z/pr3r1gKk
         W++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3oG0EyAeJ44BrAqIWrqCfJH3ESwsz3poXTJWAbRRTXA=;
        b=cKs6+W1YSdcp/91hiREYmKeF8LnNxFEIMNTireS6e6tSjpRGpXdYnBwv5NaBeKSJJ5
         sn+hbaXKk6HcIoDuQoFNzHynpZEmkbGtNIm1EtsRDxKy15apFLEkhdtO9j74OnWsv9Nt
         0AH37JRBFzR1nbuCYrWUnzHyJYHbjSudK1DDbphk2GNCfi7z12+QmmVysp7Wo+6O1Cgn
         NsEtFDox+aupHB36qFA63cb40waK284Ey0youFSoZGxrLUxr6wvHmCBAvflWRax3kswe
         4+Na69qZnyCpFBBHN4HTtwD4epNGMl8uzEb2er4i3bWEBfO5SHhIr8hPHrbXjLLeVG2v
         O+9w==
X-Gm-Message-State: APjAAAV4eUjR5aDJQP5eSASOiv0H05f6iqAnle0NtFZtZ9jCXGKFQTZg
        IKqj+RAF5/HYRWmMdJ8JYHU8VxGs
X-Google-Smtp-Source: APXvYqzUremlb5N5q5aZ2RvEmNV2Podx1pEPxenDkbtVlDEqeuI1ooIpnDFJDwBErN2dU3TNvItvlQ==
X-Received: by 2002:a17:90b:4006:: with SMTP id ie6mr27379874pjb.50.1573919593149;
        Sat, 16 Nov 2019 07:53:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j17sm14254316pfr.2.2019.11.16.07.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 07:53:12 -0800 (PST)
Subject: Re: [PATCH v2] dell-smm-hwmon: Add support for disabling automatic
 BIOS fan control
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Giovanni Mascellani <gio@debian.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191116140649.114592-1-gio@debian.org>
 <20191116145845.xmhki3ckza26eoln@pali>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7bc8ec9a-f559-96c8-36fd-6e11a1420626@roeck-us.net>
Date:   Sat, 16 Nov 2019 07:53:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191116145845.xmhki3ckza26eoln@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/19 6:58 AM, Pali Rohár wrote:
> On Saturday 16 November 2019 15:06:49 Giovanni Mascellani wrote:
>> This patch exports standard hwmon pwmX_enable sysfs attribute for
>> enabling or disabling automatic fan control by BIOS. Standard value
>> "1" is for disabling automatic BIOS fan control and value "2" for
>> enabling.
>>
>> By default BIOS auto mode is enabled by laptop firmware.
>>
>> When BIOS auto mode is enabled, custom fan speed value (set via hwmon
>> pwmX sysfs attribute) is overwritten by SMM in few seconds and
>> therefore any custom settings are without effect. So this is reason
>> why implementing option for disabling BIOS auto mode is needed.
>>
>> So finally this patch allows kernel to set and control fan speed on
>> laptops, but it can be dangerous (like setting speed of other fans).
>>
>> The SMM commands to enable or disable automatic fan control are not
>> documented and are not the same on all Dell laptops. Therefore a
>> whitelist is used to send the correct codes only on laptopts for which
>> they are known.
>>
>> This patch was originally developed by Pali Rohár; later Giovanni
>> Mascellani implemented the whitelist.
>>
>> Signed-off-by: Giovanni Mascellani <gio@debian.org>
>> Co-Developer-by: Pali Rohár <pali.rohar@gmail.com>
> 
> Hello! Patch looks good, see small suggestions below. The only important
> change for this patch is to hide those new pwmX_enable entries on
> unsupported machines.
> 
>> ---
>>   drivers/hwmon/dell-smm-hwmon.c | 111 ++++++++++++++++++++++++++++++---
>>   1 file changed, 101 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
>> index 4212d022d253..67b8c0adede8 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -68,6 +68,8 @@ static uint i8k_pwm_mult;
>>   static uint i8k_fan_max = I8K_FAN_HIGH;
>>   static bool disallow_fan_type_call;
>>   static bool disallow_fan_support;
>> +static unsigned int smm_manual_fan;
>> +static unsigned int smm_auto_fan;

The "smm_" prefix does not have any value here.

>>   
>>   #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
>>   #define I8K_HWMON_HAVE_TEMP2	(1 << 1)
>> @@ -300,6 +302,17 @@ static int i8k_get_fan_nominal_speed(int fan, int speed)
>>   	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * i8k_fan_mult;
>>   }
>>   
>> +/*
>> + * Enable or disable automatic BIOS fan control support
>> + */
>> +static int i8k_enable_fan_auto_mode(bool enable)
>> +{
>> +	struct smm_regs regs = { };
>> +
> 
> For safely reasons I would suggest to add:
> 
> 	if (disallow_fan_support)
> 		return -EINVAL;
> 
>> +	regs.eax = enable ? smm_auto_fan : smm_manual_fan;
>> +	return i8k_smm(&regs);
>> +}
>> +
>>   /*
>>    * Set the fan speed (off, low, high). Returns the new fan status.
>>    */
>> @@ -726,6 +739,35 @@ static ssize_t i8k_hwmon_pwm_store(struct device *dev,
>>   	return err < 0 ? -EIO : count;
>>   }
>>   
>> +static ssize_t i8k_hwmon_pwm_enable_store(struct device *dev,
>> +					  struct device_attribute *attr,
>> +					  const char *buf, size_t count)
>> +{
>> +	int err;
>> +	bool enable;
>> +	unsigned long val;
>> +
>> +	if (!smm_auto_fan)
>> +		return -ENODEV;
>> +
>> +	err = kstrtoul(buf, 10, &val);
>> +	if (err)
>> +		return err;
>> +
> 
> ====
> 
>> +	if (val == 0)
>> +		return -EINVAL;
>> +	if (val > 2)
>> +		return -EINVAL;
>> +
>> +	enable = (val != 1);
> 
> ====
> 
> Just small suggestion: I would write it more-opencoded to immediately
> see what values are valid and what are they meaning. It look me quite
> more time to check that above logic is correct (according to hwmon
> documentation).
> 
> 	if (val == 1)
> 		enable = false;
> 	else if (val == 2)
> 		enable = true;
> 	else
> 		return -EINVAL;
> 
> or via switch:
> 
> 	switch (val) {
> 	case 1:
> 		enable = false;
> 		break;
> 	case 2:
> 		enable = true;
> 		break;
> 	default:
> 		return -EINVAL;
> 	}
> 
>> +
>> +	mutex_lock(&i8k_mutex);
>> +	err = i8k_enable_fan_auto_mode(enable);
>> +	mutex_unlock(&i8k_mutex);
>> +
>> +	return err ? -EIO : count;
>> +}
>> +
>>   static SENSOR_DEVICE_ATTR_RO(temp1_input, i8k_hwmon_temp, 0);
>>   static SENSOR_DEVICE_ATTR_RO(temp1_label, i8k_hwmon_temp_label, 0);
>>   static SENSOR_DEVICE_ATTR_RO(temp2_input, i8k_hwmon_temp, 1);
>> @@ -749,12 +791,15 @@ static SENSOR_DEVICE_ATTR_RO(temp10_label, i8k_hwmon_temp_label, 9);
>>   static SENSOR_DEVICE_ATTR_RO(fan1_input, i8k_hwmon_fan, 0);
>>   static SENSOR_DEVICE_ATTR_RO(fan1_label, i8k_hwmon_fan_label, 0);
>>   static SENSOR_DEVICE_ATTR_RW(pwm1, i8k_hwmon_pwm, 0);
>> +static SENSOR_DEVICE_ATTR_WO(pwm1_enable, i8k_hwmon_pwm_enable, 0);
>>   static SENSOR_DEVICE_ATTR_RO(fan2_input, i8k_hwmon_fan, 1);
>>   static SENSOR_DEVICE_ATTR_RO(fan2_label, i8k_hwmon_fan_label, 1);
>>   static SENSOR_DEVICE_ATTR_RW(pwm2, i8k_hwmon_pwm, 1);
>> +static SENSOR_DEVICE_ATTR_WO(pwm2_enable, i8k_hwmon_pwm_enable, 0);
>>   static SENSOR_DEVICE_ATTR_RO(fan3_input, i8k_hwmon_fan, 2);
>>   static SENSOR_DEVICE_ATTR_RO(fan3_label, i8k_hwmon_fan_label, 2);
>>   static SENSOR_DEVICE_ATTR_RW(pwm3, i8k_hwmon_pwm, 2);
>> +static SENSOR_DEVICE_ATTR_WO(pwm3_enable, i8k_hwmon_pwm_enable, 0);
>>   
>>   static struct attribute *i8k_attrs[] = {
>>   	&sensor_dev_attr_temp1_input.dev_attr.attr,	/* 0 */
>> @@ -780,12 +825,15 @@ static struct attribute *i8k_attrs[] = {
>>   	&sensor_dev_attr_fan1_input.dev_attr.attr,	/* 20 */
>>   	&sensor_dev_attr_fan1_label.dev_attr.attr,	/* 21 */
>>   	&sensor_dev_attr_pwm1.dev_attr.attr,		/* 22 */
>> -	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 23 */
>> -	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 24 */
>> -	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 25 */
>> -	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 26 */
>> -	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 27 */
>> -	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 28 */
>> +	&sensor_dev_attr_pwm1_enable.dev_attr.attr,	/* 23 */
>> +	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 24 */
>> +	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 25 */
>> +	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 26 */
>> +	&sensor_dev_attr_pwm2_enable.dev_attr.attr,	/* 27 */
>> +	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 28 */
>> +	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 29 */
>> +	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 30 */
>> +	&sensor_dev_attr_pwm3_enable.dev_attr.attr,	/* 31 */
>>   	NULL
>>   };
>>   
>> @@ -828,13 +876,13 @@ static umode_t i8k_is_visible(struct kobject *kobj, struct attribute *attr,
>>   	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP10))
>>   		return 0;
>>   
>> -	if (index >= 20 && index <= 22 &&
>> +	if (index >= 20 && index <= 23 &&
>>   	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN1))
>>   		return 0;
>> -	if (index >= 23 && index <= 25 &&
>> +	if (index >= 24 && index <= 27 &&
>>   	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN2))
>>   		return 0;
>> -	if (index >= 26 && index <= 28 &&
>> +	if (index >= 28 && index <= 31 &&
>>   	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN3))
>>   		return 0;
> 
> 
> Indexes 23, 27 and 31 should not be visible when "smm_auto_fan" is not
> available. Please add check for this.
> 
>>   
>> @@ -1135,12 +1183,48 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
>>   	{ }
>>   };
>>   
>> +struct i8k_manual_fan_data {
>> +	unsigned int smm_manual_fan;
>> +	unsigned int smm_auto_fan;
>> +};
> 
> Just cosmetic suggestion: As this structure contains data for both
> manual and automatic mode I would not use "manual" in name. But e.g.
> something like "i8k_bios_fan_control_data"...
> 
Or i8k_fan_control_data. Also, "manual" and "auto" for the variable
names would be sufficient.

>> +
>> +enum i8k_manual_fans {
>> +	I8K_FAN_34A3_35A3,
>> +};
>> +
>> +static const struct i8k_manual_fan_data i8k_manual_fan_data[] = {
>> +	[I8K_FAN_34A3_35A3] = {
>> +		.smm_manual_fan = 0x34a3,
>> +		.smm_auto_fan = 0x35a3,
>> +	},
>> +};
>> +
>> +static struct dmi_system_id i8k_whitelist_manual_fan[] __initdata = {
>> +	{
>> +		.ident = "Dell Precision 5530",
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
>> +		},
>> +		.driver_data = (void *)&i8k_manual_fan_data[I8K_FAN_34A3_35A3],
>> +	},
>> +	{
>> +		.ident = "Dell Latitude E6440",
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E6440"),
>> +		},
>> +		.driver_data = (void *)&i8k_manual_fan_data[I8K_FAN_34A3_35A3],
>> +	},
>> +	{ }
>> +};
>> +

Drop the "manual" from the variable names. maybe use "fan_control" instead of
"manual_fan".

>>   /*
>>    * Probe for the presence of a supported laptop.
>>    */
>>   static int __init i8k_probe(void)
>>   {
>> -	const struct dmi_system_id *id;
>> +	const struct dmi_system_id *id, *manual_fan;
>>   	int fan, ret;
>>   
>>   	/*
>> @@ -1200,6 +1284,13 @@ static int __init i8k_probe(void)
>>   	i8k_fan_max = fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
>>   	i8k_pwm_mult = DIV_ROUND_UP(255, i8k_fan_max);
>>   
>> +	manual_fan = dmi_first_match(i8k_whitelist_manual_fan);
>> +	if (manual_fan && manual_fan->driver_data) {
>> +		const struct i8k_manual_fan_data *manual_fan_data = manual_fan->driver_data;
>> +		smm_manual_fan = manual_fan_data->smm_manual_fan;
>> +		smm_auto_fan = manual_fan_data->smm_auto_fan;
> 
> As this feature is experimental, I would suggest to add some pr_info
> message that experimental BIOS fan control support is exported via hwmon
> interface. It may happen that it would not work for some people and for
> debugging purposes it would be easier to spot problem if dmesg provides
> such message.
> 
>> +	}
>> +
>>   	if (!fan_mult) {
>>   		/*
>>   		 * Autodetect fan multiplier based on nominal rpm
> 

