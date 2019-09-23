Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14164C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5CC20865
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X+lcm42p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407533AbfIWKBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:01:19 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52164 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407398AbfIWKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:01:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8NA1Ac2117639;
        Mon, 23 Sep 2019 05:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569232870;
        bh=bop2ehz1wB641+wwnJfyqzQLSIrzQRGO11Uw2gHnBI4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=X+lcm42pU50o1fzParKUDJvSJ9k1fSdveaBWLHASrP9ERQ4F22osiGViTrj4l8L61
         CZF7FjW6+GDQsx1edf8V/gVTBelIY+XjT1xyc/OnkZ3XzYfpWwMb21YtYsgqKyYDG/
         VCqUC0LZEy4Q5HIDP9ZjyaZMhIuhWecPZg9EVM8k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8NA1ABM018292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Sep 2019 05:01:10 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 23
 Sep 2019 05:01:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 23 Sep 2019 05:01:04 -0500
Received: from [10.250.99.146] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8NA18ml122460;
        Mon, 23 Sep 2019 05:01:08 -0500
Subject: Re: [PATCH v4 2/2] leds: tlc591xx: use
 devm_led_classdev_register_ext()
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <dmurphy@ti.com>
CC:     <tomi.valkeinen@ti.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190920115806.14475-1-jjhiblot@ti.com>
 <20190920115806.14475-3-jjhiblot@ti.com>
 <b4387d66-febd-ff20-7b5e-e66e5de8a988@gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
Message-ID: <1b0dd104-3deb-ea42-ab59-522f21d8dffe@ti.com>
Date:   Mon, 23 Sep 2019 12:01:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4387d66-febd-ff20-7b5e-e66e5de8a988@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/09/2019 22:29, Jacek Anaszewski wrote:
> Hi Jean,
>
> Thank you for the update.
>
> On 9/20/19 1:58 PM, Jean-Jacques Hiblot wrote:
>> Use devm_led_classdev_register_ext() to pass the fwnode to the LED core.
>> The fwnode can then be used by the firmware core to create meaningful
>> names.
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
>> ---
>>   drivers/leds/leds-tlc591xx.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/leds/leds-tlc591xx.c b/drivers/leds/leds-tlc591xx.c
>> index bbdaa3148317..8eadb673dc2e 100644
>> --- a/drivers/leds/leds-tlc591xx.c
>> +++ b/drivers/leds/leds-tlc591xx.c
>> @@ -186,6 +186,9 @@ tlc591xx_probe(struct i2c_client *client,
>>   
>>   	for_each_child_of_node(np, child) {
>>   		struct tlc591xx_led *led;
>> +		struct led_init_data init_data = {};
>> +
>> +		init_data.fwnode = of_fwnode_handle(child);
>>   
>>   		err = of_property_read_u32(child, "reg", &reg);
>>   		if (err) {
>> @@ -200,8 +203,6 @@ tlc591xx_probe(struct i2c_client *client,
>>   		led = &priv->leds[reg];
>>   
>>   		led->active = true;
>> -		led->ldev.name =
>> -			of_get_property(child, "label", NULL) ? : child->name;
>>   		led->ldev.default_trigger =
>>   			of_get_property(child, "linux,default-trigger", NULL);
>>   
>> @@ -209,7 +210,8 @@ tlc591xx_probe(struct i2c_client *client,
>>   		led->led_no = reg;
>>   		led->ldev.brightness_set_blocking = tlc591xx_brightness_set;
>>   		led->ldev.max_brightness = LED_FULL;
> I was asking for removing tabove assignment, but we can always do that
> in the incremental patch.

right. I forgot to remove this one.

Looking into it, it looks like the TLC actually has 257 levels (OFF, 
PWM: 0% to 99.6%, and full ON)

I'll send a patch for this after testing.

JJ


>
> Patch set applied to the for-5.5 branch. Thanks.
>
>> -		err = devm_led_classdev_register(dev, &led->ldev);
>> +		err = devm_led_classdev_register_ext(dev, &led->ldev,
>> +						     &init_data);
>>   		if (err < 0) {
>>   			dev_err(dev, "couldn't register LED %s\n",
>>   				led->ldev.name);
>>
