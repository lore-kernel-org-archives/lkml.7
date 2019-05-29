Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843B1C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5378E20673
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL6q6NMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfE2MRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:17:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45608 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2MRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:17:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id x7so5695plr.12;
        Wed, 29 May 2019 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mZGYAq4lrxI2qWiiWxL3lpOyDLunU7v+t9aRbr1rHp8=;
        b=CL6q6NMeOqQUjc9NkgirjFhLDh1c+E1+vli8m+xou8kg05LTROFN+N5zGYAuNfRMAI
         vRyFzf7S0YPaw/C1kp3FpZTkAGxAF0bVrb+mx7jDyiKhG46VQOZgWeIU0nyEAtF63GuD
         qMO+MiUZJ2Uw5Zdbf1Ausp7sM0lFl6DXFsBdjb+uSMmzzV57eDa0nkWmh2UNvEcZVKdx
         XVQrYp3A8PRvs1NNe73Aj0HXIAqZ+eq3Epw90/TxXH+MmHNN7oj6t2ehGzMX19498ZwG
         ILWSG3HKh8wvJLHhv0TQUWdeewmTQqonvyCOu5JAEMJpiMad/yseLCVpg5h27pgFsjsD
         qzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mZGYAq4lrxI2qWiiWxL3lpOyDLunU7v+t9aRbr1rHp8=;
        b=ZLWB+CXDsIh49zdqkqtFsstpjZFnN9iFRFk50te1FDKCiNwjBXxdiDiNLpMkiuwB5Y
         L8U5xETyKmeauDeBlZuDUtwwxwB/caAZIwf7Ul6hOe+70+D7/utL3OkMez+wdzGvtLKa
         tH5fQ0lcSmGuIeFd3jE8CP0zNCkRXN4mpvMVZ1EIV7wUo/0o4PzObCdbYZ93+llgWUPE
         5pmOp5hZbE8FUAMUMfCxXFsBlHK6FAEIgBjBXze50vhbjFhjluXFzyIat1Z3qLXOKTlL
         0BgQkJD9Ybx11cnSAVZxnM9OBeL9DtHon5Xyy1LNYI6aM7nWamCoeHbJctnBDz4kOsvS
         HRwA==
X-Gm-Message-State: APjAAAWwRNw3Kty60NeZIoJiJKdE+CLh8xl38ShiKoyPyjYtBZWYFdbX
        LwzJWLJGJu6F36cP9SXSMVg=
X-Google-Smtp-Source: APXvYqwXGHMR1RML9OZAWF0Ad4pH8VBA02JKXLfeflQT+Pmx5ALVTxb81A4YOYiwrQIT1K5ST8ueOw==
X-Received: by 2002:a17:902:20e2:: with SMTP id v31mr140817199plg.138.1559132271167;
        Wed, 29 May 2019 05:17:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c17sm18960538pfo.114.2019.05.29.05.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 05:17:49 -0700 (PDT)
Subject: Re: [PATCH] adm1275: support PMBUS_VIRT_*_SAMPLES
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
References: <20190524124841.GA25728@localhost.localdomain>
 <20190528194652.GE24853@roeck-us.net>
 <20190529071027.GA6524@localhost.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d5a651f2-93ba-f966-1a5c-52b09ccb7d12@roeck-us.net>
Date:   Wed, 29 May 2019 05:17:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529071027.GA6524@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 12:11 AM, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
> On Tue, May 28, 2019 at 12:46:52PM -0700, Guenter Roeck wrote:
>> On Fri, May 24, 2019 at 12:49:13PM +0000, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
>>> The device supports setting the number of samples for averaging the
>>> measurements. There are two separate settings - PWR_AVG for averaging
>>> PIN and VI_AVG for averaging VIN/VAUX/IOUT, both being part of
>>> PMON_CONFIG register. The values are stored as exponent of base 2 of the
>>> actual number of samples that will be taken.
>>>
>>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>>> ---
>>>   drivers/hwmon/pmbus/adm1275.c | 68 ++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 67 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
>>> index f569372c9204..4efe1a9df563 100644
>>> --- a/drivers/hwmon/pmbus/adm1275.c
>>> +++ b/drivers/hwmon/pmbus/adm1275.c
>>> @@ -23,6 +23,8 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/i2c.h>
>>>   #include <linux/bitops.h>
>>> +#include <linux/bitfield.h>
>>> +#include <linux/log2.h>
>>>   #include "pmbus.h"
>>>
>>>   enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1294 };
>>> @@ -78,6 +80,10 @@ enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1294 };
>>>   #define ADM1075_VAUX_OV_WARN		BIT(7)
>>>   #define ADM1075_VAUX_UV_WARN		BIT(6)
>>>
>>> +#define ADM1275_PWR_AVG_MASK		GENMASK(13, 11)
>>> +#define ADM1275_VI_AVG_MASK		GENMASK(10, 8)
>>> +#define ADM1275_SAMPLES_AVG_MAX	128
>>> +
>>>   struct adm1275_data {
>>>   	int id;
>>>   	bool have_oc_fault;
>>> @@ -90,6 +96,7 @@ struct adm1275_data {
>>>   	bool have_pin_max;
>>>   	bool have_temp_max;
>>>   	struct pmbus_driver_info info;
>>> +	struct mutex lock;
>>>   };
>>>
>>>   #define to_adm1275_data(x)  container_of(x, struct adm1275_data, info)
>>> @@ -164,6 +171,38 @@ static const struct coefficients adm1293_coefficients[] = {
>>>   	[18] = { 7658, 0, -3 },		/* power, 21V, irange200 */
>>>   };
>>>
>>> +static inline int adm1275_read_pmon_config(struct i2c_client *client, u64 mask)
>>
>> Why is the mask passed through as u64 ?
> 
> Good point. I used u64 as this is the type used by bitfield machinery
> under the hood but I agree it doesn't make sense and is even confusing
> to have this in the function prototype as we are using this to mask 16
> bit word anyways. I will fix that in v2. I am gonna have to cast the ret
> to u16 when passing to FIELD_GET() to make sure the __BF_FIELD_CHECK is
> not complaining (since it is signed right now), though.
> 

Not sure I understand what you are talking about. FIELD_GET() uses typeof().
FIELD_GET() is used by other callers even with u8 and without any typecasts.
Why would it be a problem here ?

>>
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	return FIELD_GET(mask, ret);
>>> +}
>>> +
>>> +static inline int adm1275_write_pmon_config(struct i2c_client *client, u64 mask,
>>> +					    u16 word)
>>> +{
>>> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
>>> +	struct adm1275_data *data = to_adm1275_data(info);
>>> +	int ret;
>>> +
>>> +	mutex_lock(&data->lock);
>>
>> Why is another lock on top of the lock provided by the pmbus core required ?
>>
> 
> Good point, I was considering if I should instead add mutex_lock on
> update_lock in the pmbus_set_samples() function inside of pmbus_core.c
> instead (as this function is missing it) but figured that not all
> devices will need that (lm25066 didn't) so it might be a waste in most
> cases. But this may be cleaner approach indeed.
> 
> Is this what you mean or there is some other lock I missed?
> 
pmbus_set_samples() should set the pmbus lock. That was missed when
the function was added.

>>> +	ret = i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
>>> +	if (ret < 0) {
>>> +		mutex_unlock(&data->lock);
>>> +		return ret;
>>> +	}
>>> +
>>> +	word = FIELD_PREP(mask, word) | (ret & ~mask);
>>> +	ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, word);
>>> +	mutex_unlock(&data->lock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>   static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
>>>   {
>>>   	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
>>> @@ -242,6 +281,19 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
>>>   		if (!data->have_temp_max)
>>>   			return -ENXIO;
>>>   		break;
>>> +	case PMBUS_VIRT_POWER_SAMPLES:
>>> +		ret = adm1275_read_pmon_config(client, ADM1275_PWR_AVG_MASK);
>>> +		if (ret < 0)
>>> +			break;
>>> +		ret = 1 << ret;
>>
>> 		ret = BIT(ret);
>>
> 
> I intentionally used the "raw" left shift to make it more obvious this
> is pow2 arithmetic operation and an direct inverse to the ilog2() used
> on write counterpart. This is also consistent with what I used in
> lm25066.c driver not long time ago.
> 
> I don't have strong preference but this is my reasoning. So do you still
> think it is better to use BIT() macro instead?
> 

I don't think that is a good rationale, but I'll let it go.

Guenter

>>> +		break;
>>> +	case PMBUS_VIRT_IN_SAMPLES:
>>> +	case PMBUS_VIRT_CURR_SAMPLES:
>>> +		ret = adm1275_read_pmon_config(client, ADM1275_VI_AVG_MASK);
>>> +		if (ret < 0)
>>> +			break;
>>> +		ret = 1 << ret;
>>
>> 		ret = BIT(ret);
>>
>>> +		break;
>>>   	default:
>>>   		ret = -ENODATA;
>>>   		break;
>>> @@ -286,6 +338,17 @@ static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
>>>   	case PMBUS_VIRT_RESET_TEMP_HISTORY:
>>>   		ret = pmbus_write_word_data(client, 0, ADM1278_PEAK_TEMP, 0);
>>>   		break;
>>> +	case PMBUS_VIRT_POWER_SAMPLES:
>>> +		word = clamp_val(word, 1, ADM1275_SAMPLES_AVG_MAX);
>>> +		ret = adm1275_write_pmon_config(client, ADM1275_PWR_AVG_MASK,
>>> +						ilog2(word));
>>> +		break;
>>> +	case PMBUS_VIRT_IN_SAMPLES:
>>> +	case PMBUS_VIRT_CURR_SAMPLES:
>>> +		word = clamp_val(word, 1, ADM1275_SAMPLES_AVG_MAX);
>>> +		ret = adm1275_write_pmon_config(client, ADM1275_VI_AVG_MASK,
>>> +						ilog2(word));
>>> +		break;
>>>   	default:
>>>   		ret = -ENODATA;
>>>   		break;
>>> @@ -422,6 +485,8 @@ static int adm1275_probe(struct i2c_client *client,
>>>   	if (!data)
>>>   		return -ENOMEM;
>>>
>>> +	mutex_init(&data->lock);
>>> +
>>>   	if (of_property_read_u32(client->dev.of_node,
>>>   				 "shunt-resistor-micro-ohms", &shunt))
>>>   		shunt = 1000; /* 1 mOhm if not set via DT */
>>> @@ -439,7 +504,8 @@ static int adm1275_probe(struct i2c_client *client,
>>>   	info->format[PSC_CURRENT_OUT] = direct;
>>>   	info->format[PSC_POWER] = direct;
>>>   	info->format[PSC_TEMPERATURE] = direct;
>>> -	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
>>> +	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
>>> +			PMBUS_HAVE_SAMPLES;
>>>
>>>   	info->read_word_data = adm1275_read_word_data;
>>>   	info->read_byte_data = adm1275_read_byte_data;
>>> --
>>> 2.20.1
>>>
> 

