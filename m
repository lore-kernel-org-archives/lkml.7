Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7B6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52CC2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfDXOyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:54:14 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55191 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731630AbfDXOyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:54:11 -0400
Received: from [167.98.27.226] (helo=[10.35.4.32])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hJJHk-0004BK-Ok; Wed, 24 Apr 2019 15:54:08 +0100
Subject: Re: Fwd: [PATCH 1/2] hwmon: (lm75) Add support for TMP75B
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com
References: <2904a750-c6e9-719b-7523-0f45e0bc82cc@codethink.co.uk>
 <2effcb0e-03c6-0f7e-b154-62cbc9ad415a@codethink.co.uk>
 <655fa0d3-1b76-96c7-4c04-9f258a3305bc@roeck-us.net>
From:   Iker Perez del Palomar <iker.perez@codethink.co.uk>
Message-ID: <bd601100-f2f9-60c4-6bcc-6edf3010cfc1@codethink.co.uk>
Date:   Wed, 24 Apr 2019 15:54:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <655fa0d3-1b76-96c7-4c04-9f258a3305bc@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Thank you for the review, I will submit a fixed patch soon. I have one
question before doing it though, after running scrips/chechpatch.sh I
obtain the next message:

WARNING: DT compatible string "ti,tmp75b" appears un-documented -- check
./Documentation/devicetree/bindings/
#83: FILE: drivers/hwmon/lm75.c:549:
+		.compatible = "ti,tmp75b",

total: 0 errors, 1 warnings, 60 lines checked

So I added the next in
"Documentation/devicetree/bindings/trivial-devices.yaml":

	- ti,amc6821
	# I2C Touch-Screen Controller
  	- ti,tsc2003
+ 	# Digital Temperature Sensor with Two-Wire Interface and Alert
+ 	- ti,tmp75b
  	# Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial
Interface
  	- ti,tmp102
  	# Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial
Interface


Is that the proper procedure??

Thank you for your help.



Regards,


Iker

On 23/04/2019 14:52, Guenter Roeck wrote:
> On 4/23/19 3:11 AM, Iker Perez del Palomar wrote:
>> The TMP75B has a different control register, supports 12-bit
>> resolution and the default conversion rate is 37 Hz.
>>
>> Signed-off-by: Iker Perez del Palomar Sustatxa
>> <iker.perez@codethink.co.uk>
> 
> This patch is corrupted. It replaces tabs with spaces, and there are
> line wraps.
> 
>> ---
>>   Documentation/hwmon/lm75 |  5 +++--
>>   drivers/hwmon/lm75.c     | 13 +++++++++++++
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
>> index 010583608f12..baf052935761 100644
>> --- a/Documentation/hwmon/lm75
>> +++ b/Documentation/hwmon/lm75
>> @@ -47,8 +47,8 @@ Supported chips:
>>       Addresses scanned: none
>>       Datasheet: Publicly available at the ST website
>>              https://www.st.com/resource/en/datasheet/stlm75.pdf
>> -  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75C,
>> TMP175, TMP275
>> -    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175',
>> 'tmp75', 'tmp75c', 'tmp275'
>> +  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75B,
>> TMP75C, TMP175, TMP275
>> +    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175',
>> 'tmp75', 'tmp75b', 'tmp75c', 'tmp275'
>>       Addresses scanned: none
>>       Datasheet: Publicly available at the Texas Instruments website
>>                  http://www.ti.com/product/tmp100
>> @@ -56,6 +56,7 @@ Supported chips:
>>                  http://www.ti.com/product/tmp105
>>                  http://www.ti.com/product/tmp112
>>                  http://www.ti.com/product/tmp75
>> +               http://www.ti.com/product/tmp75b
>>                  http://www.ti.com/product/tmp75c
>>                  http://www.ti.com/product/tmp175
>>                  http://www.ti.com/product/tmp275
>> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
>> index 62acb9f16ec5..1b5c32cbdc62 100644
>> --- a/drivers/hwmon/lm75.c
>> +++ b/drivers/hwmon/lm75.c
>> @@ -32,6 +32,7 @@
>>   #include "lm75.h"
>>
>>
>> +
> 
> I don't mind if you'd remove one of the two empty lines above, but add
> yet another one ?
> Please don't.
> 
>>   /*
>>    * This driver handles the LM75 and compatible digital temperature
>> sensors.
>>    */
>> @@ -59,6 +60,7 @@ enum lm75_type {        /* keep sorted in
>> alphabetical order */
>>       tmp175,
>>       tmp275,
>>       tmp75,
>> +    tmp75b,
>>       tmp75c,
>>   };
>>
>> @@ -378,6 +380,12 @@ lm75_probe(struct i2c_client *client, const
>> struct i2c_device_id *id)
>>           data->resolution = 12;
>>           data->sample_time = MSEC_PER_SEC / 2;
>>           break;
>> +    case tmp75b:
>> +        clr_mask |= 1 << 15;        /* not one-shot mode */
>> +        data->resolution = 12;
>> +        data->sample_time = MSEC_PER_SEC / 32;
>> +        break;
>> +
>>       case tmp75c:
>>           clr_mask |= 1 << 5;        /* not one-shot mode */
>>           data->resolution = 12;
>> @@ -438,6 +446,7 @@ static const struct i2c_device_id lm75_ids[] = {
>>       { "tmp175", tmp175, },
>>       { "tmp275", tmp275, },
>>       { "tmp75", tmp75, },
>> +    { "tmp75b", tmp75b,},
>>       { "tmp75c", tmp75c, },
>>       { /* LIST END */ }
>>   };
>> @@ -537,6 +546,10 @@ static const struct of_device_id lm75_of_match[] = {
>>           .data = (void *)tmp75
>>       },
>>       {
>> +        .compatible = "ti,tmp75b",
>> +        .data = (void *)tmp75b
>> +    },
>> +    {
>>           .compatible = "ti,tmp75c",
>>           .data = (void *)tmp75c
>>       },
>>
> 
> 

-- 
Iker Perez del Palomar, Software Engineer
Codethink Ltd                             35 Dale St, Manchester M1 2HF
http://www.codethink.co.uk/          Manchester, M1 2JW, United Kingdom
We respect your privacy.   See https://www.codethink.co.uk/privacy.html
