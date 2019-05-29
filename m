Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F331C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4CB2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf0yQunK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfE2NRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:17:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40014 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfE2NRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:17:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so1359103pgm.7;
        Wed, 29 May 2019 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jGU+IWw3fhQwMj+4gNT4folr25bhqCVF0fJDKSZCqFc=;
        b=Vf0yQunKPBWZTEehjbJfB7ddgKiCM+Hfj7i7TOJzgSWzASo/bUdLQ71KTG1tQeDwcQ
         lt7nV+Knx0ZvBU3Uj8/AFrHkJXrSqU3jLKJWDT3YY0IlPCQysZrQlSSpRv9U0/Op77j6
         IGSMEORaQbBqBkHTuTUUdgGVCqZpehP6UVe2dPYlQU+8SEPHLp3ojA7r16xTmBbEjSxR
         WlmrLFuagXmPOKdGWpVvSlOUV3PvmpiDO5uIErHosDx+BofixIxC4ZIw9GyrVluucLsr
         L4knh9/gEYpv0UtNPgHpvCGOfnsvRWPiq76+GoZU+emsbimZjp51Ck+/hviaBFXT20uL
         35Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jGU+IWw3fhQwMj+4gNT4folr25bhqCVF0fJDKSZCqFc=;
        b=HuulY5+7kkanZoZZITvGKYdcTNkfxyhuFZ8QnUBFxCYjzhgeVkDy71prgS27Ws9lBF
         SlgnDLMEa11s5NmJJibJL25+Ij/TBOBBb5TqA7myFu63L6SAlhlIVWZrDdhQLvd3CbhU
         gGxr1sUhoB2PQ9vDywqyuwR9kaXaslgwQdgCBL98SfxsdBqsOJJ4C+1ou0ixqiB1KUJ6
         o/ORfDSnCckvhaHB6pkcHmfw1hN+UskPxBnt9Xi/r5w3XfsjbNl+06K2YVhl6bHAlEN7
         34S+UekdvLcH71ZlY/Pjpq6Ax3wgq/IFfLclS9qeaoxJWRdAG7LXu4d8CNPsRhcymit6
         71qg==
X-Gm-Message-State: APjAAAU8lK1i7Y+0DT8zCkg2fwY/rlrRqP4voQBqaPbg17dSjE5AAXd1
        RuUvRUI1SrsI1mMinSe93lkTvq2X
X-Google-Smtp-Source: APXvYqxTD2WDUewDUNuYhNuAePeh4l9PBZk61vRa6gmIWnjX/hw/+WuFh5Q45h7Nc7dLH3buMOfDQA==
X-Received: by 2002:a63:c50c:: with SMTP id f12mr136656652pgd.71.1559135829739;
        Wed, 29 May 2019 06:17:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i12sm19511533pfd.33.2019.05.29.06.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:17:08 -0700 (PDT)
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
 <d5a651f2-93ba-f966-1a5c-52b09ccb7d12@roeck-us.net>
 <20190529125314.GA30959@localhost.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <56787ecf-c6d3-27f2-75f0-9e4dfa194fba@roeck-us.net>
Date:   Wed, 29 May 2019 06:17:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529125314.GA30959@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 5:53 AM, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
> On Wed, May 29, 2019 at 05:17:47AM -0700, Guenter Roeck wrote:
>> On 5/29/19 12:11 AM, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
>>> On Tue, May 28, 2019 at 12:46:52PM -0700, Guenter Roeck wrote:
>>>> On Fri, May 24, 2019 at 12:49:13PM +0000, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
>>>>> The device supports setting the number of samples for averaging the
>>>>> measurements. There are two separate settings - PWR_AVG for averaging
>>>>> PIN and VI_AVG for averaging VIN/VAUX/IOUT, both being part of
>>>>> PMON_CONFIG register. The values are stored as exponent of base 2 of the
>>>>> actual number of samples that will be taken.
>>>>>
>>>>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>>>>> ---
>>>>>   drivers/hwmon/pmbus/adm1275.c | 68 ++++++++++++++++++++++++++++++++++-
>>>>>   1 file changed, 67 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
>>>>> index f569372c9204..4efe1a9df563 100644
>>>>> --- a/drivers/hwmon/pmbus/adm1275.c
>>>>> +++ b/drivers/hwmon/pmbus/adm1275.c
>>>>> @@ -23,6 +23,8 @@
>>>>>   #include <linux/slab.h>
>>>>>   #include <linux/i2c.h>
>>>>>   #include <linux/bitops.h>
>>>>> +#include <linux/bitfield.h>
>>>>> +#include <linux/log2.h>
>>>>>   #include "pmbus.h"
>>>>>
>>>>>   enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1294 };
>>>>> @@ -78,6 +80,10 @@ enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1294 };
>>>>>   #define ADM1075_VAUX_OV_WARN		BIT(7)
>>>>>   #define ADM1075_VAUX_UV_WARN		BIT(6)
>>>>>
>>>>> +#define ADM1275_PWR_AVG_MASK		GENMASK(13, 11)
>>>>> +#define ADM1275_VI_AVG_MASK		GENMASK(10, 8)
>>>>> +#define ADM1275_SAMPLES_AVG_MAX	128
>>>>> +
>>>>>   struct adm1275_data {
>>>>>   	int id;
>>>>>   	bool have_oc_fault;
>>>>> @@ -90,6 +96,7 @@ struct adm1275_data {
>>>>>   	bool have_pin_max;
>>>>>   	bool have_temp_max;
>>>>>   	struct pmbus_driver_info info;
>>>>> +	struct mutex lock;
>>>>>   };
>>>>>
>>>>>   #define to_adm1275_data(x)  container_of(x, struct adm1275_data, info)
>>>>> @@ -164,6 +171,38 @@ static const struct coefficients adm1293_coefficients[] = {
>>>>>   	[18] = { 7658, 0, -3 },		/* power, 21V, irange200 */
>>>>>   };
>>>>>
>>>>> +static inline int adm1275_read_pmon_config(struct i2c_client *client, u64 mask)
>>>>
>>>> Why is the mask passed through as u64 ?
>>>
>>> Good point. I used u64 as this is the type used by bitfield machinery
>>> under the hood but I agree it doesn't make sense and is even confusing
>>> to have this in the function prototype as we are using this to mask 16
>>> bit word anyways. I will fix that in v2. I am gonna have to cast the ret
>>> to u16 when passing to FIELD_GET() to make sure the __BF_FIELD_CHECK is
>>> not complaining (since it is signed right now), though.
>>>
>>
>> Not sure I understand what you are talking about. FIELD_GET() uses typeof().
>> FIELD_GET() is used by other callers even with u8 and without any typecasts.
>> Why would it be a problem here ?
> 
> So I basically agree with you but just wanted to note why there will be
> additional cast needed in my code. The:
>     return FIELD_GET(mask, ret);
> will be changed to:
>     return FIELD_GET(mask, (u16)ret);
> 
> And the reason for that is that the __BF_FIELD_CHECK does this check at
> compile time (and breaks if this is true)
>     (_mask) > (typeof(_reg))~0ull
> 
> In my case typeof(_reg) is int, so (typeof(_reg))~0ull = -1 which is
> signed. _mask is unsigned. Depending on the type promotion, this might
> or might not be true depending on the size of _mask. When _mask was u64,
> it always worked. For _mask being u16, it will fail. For u32, this will
> fail depending on if we are compiling for 32 or 64 bit architecture.
> 
> All this might be obvious to you but it wasn't to me, thus this note.
> 

The problem here is that ret is an int, and integers are not well suited
for mask operations. The typecast thus makes sense and is ok.

>>>>
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +
>>>>> +	return FIELD_GET(mask, ret);
>>>>> +}
>>>>> +
>>>>> +static inline int adm1275_write_pmon_config(struct i2c_client *client, u64 mask,
>>>>> +					    u16 word)
>>>>> +{
>>>>> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
>>>>> +	struct adm1275_data *data = to_adm1275_data(info);
>>>>> +	int ret;
>>>>> +
>>>>> +	mutex_lock(&data->lock);
>>>>
>>>> Why is another lock on top of the lock provided by the pmbus core required ?
>>>>
>>>
>>> Good point, I was considering if I should instead add mutex_lock on
>>> update_lock in the pmbus_set_samples() function inside of pmbus_core.c
>>> instead (as this function is missing it) but figured that not all
>>> devices will need that (lm25066 didn't) so it might be a waste in most
>>> cases. But this may be cleaner approach indeed.
>>>
>>> Is this what you mean or there is some other lock I missed?
>>>
>> pmbus_set_samples() should set the pmbus lock. That was missed when
>> the function was added.
> 
> And by pmbus lock you mean the update_lock from the pmbus_data
> structure? I didn't see any other lock but wanted to double check my
> understanding.
> 

Yes, that is the lock intended to protect write operations.

Guenter

>>>>> +	ret = i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
>>>>> +	if (ret < 0) {
>>>>> +		mutex_unlock(&data->lock);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	word = FIELD_PREP(mask, word) | (ret & ~mask);
>>>>> +	ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, word);
>>>>> +	mutex_unlock(&data->lock);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>>   static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
>>>>>   {
>>>>>   	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
>>>>> @@ -242,6 +281,19 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
>>>>>   		if (!data->have_temp_max)
>>>>>   			return -ENXIO;
>>>>>   		break;
>>>>> +	case PMBUS_VIRT_POWER_SAMPLES:
>>>>> +		ret = adm1275_read_pmon_config(client, ADM1275_PWR_AVG_MASK);
>>>>> +		if (ret < 0)
>>>>> +			break;
>>>>> +		ret = 1 << ret;
>>>>
>>>> 		ret = BIT(ret);
>>>>
>>>
>>> I intentionally used the "raw" left shift to make it more obvious this
>>> is pow2 arithmetic operation and an direct inverse to the ilog2() used
>>> on write counterpart. This is also consistent with what I used in
>>> lm25066.c driver not long time ago.
>>>
>>> I don't have strong preference but this is my reasoning. So do you still
>>> think it is better to use BIT() macro instead?
>>>
>>
>> I don't think that is a good rationale, but I'll let it go.
>>
> 
> If you don't think so, I'll change it in v2. As I said, I don't have a
> strong opinion on that.
> 
> Krzysztof
> 

