Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767F6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419AC206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V6iFRYRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfHMHna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:43:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45910 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfHMHn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:43:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7D7hQux130497;
        Tue, 13 Aug 2019 02:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565682206;
        bh=jmgSYaqwXk9iNyRQAajzZfYkuGasJs2iYaU0WIsQS5c=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=V6iFRYRxSpilYbvZmXi2hXkDdYAnfmXMZEUqjecqu8wlzVAo3/LZgUYdyuLYd2NTH
         3jHCC6mxY7gZ7n25oGBU3R1HEiUkpboPd8eYpsVkySxiWy2Vp7ONsgLS3zHnD2Rfio
         eOT//UlU08G2aDuSx8np/mGXzLXae9CNA6N2ynqk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7D7hQsj006144
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Aug 2019 02:43:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 13
 Aug 2019 02:43:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 13 Aug 2019 02:43:26 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7D7hP5g027084;
        Tue, 13 Aug 2019 02:43:25 -0500
Subject: Re: [PATCH v2] bus: ti-sysc: sysc_check_one_child(): Change return
 type to void
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>, <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>
References: <20190813071714.27970-1-nishkadg.linux@gmail.com>
 <85a1d7eb-dd9a-2276-ed13-67291188538e@ti.com>
 <5285a1f4-644c-9e97-6e1c-9b3e66948dca@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <a9b27fbd-8db0-4ba7-fab0-0c118adff765@ti.com>
Date:   Tue, 13 Aug 2019 10:43:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5285a1f4-644c-9e97-6e1c-9b3e66948dca@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2019 10:37, Nishka Dasgupta wrote:
> On 13/08/19 12:58 PM, Roger Quadros wrote:
>>
>>
>> On 13/08/2019 10:17, Nishka Dasgupta wrote:
>>> Change return type of function sysc_check_one_child() from int to void
>>> as it always returns 0. Accordingly, at its callsite, delete the
>>> variable that previously stored the return value.
>>>
>>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Remove error variable entirely.
>>> - Change return type of sysc_check_one_child().
>>>
>>>   drivers/bus/ti-sysc.c | 9 +++------
>>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
>>> index e6deabd8305d..1c30fa58d70c 100644
>>> --- a/drivers/bus/ti-sysc.c
>>> +++ b/drivers/bus/ti-sysc.c
>>> @@ -615,8 +615,8 @@ static void sysc_check_quirk_stdout(struct sysc *ddata,
>>>    * node but children have "ti,hwmods". These belong to the interconnect
>>>    * target node and are managed by this driver.
>>>    */
>>> -static int sysc_check_one_child(struct sysc *ddata,
>>> -                struct device_node *np)
>>> +static void sysc_check_one_child(struct sysc *ddata,
>>> +                 struct device_node *np)
>>>   {
>>>       const char *name;
>>>   
>>
>> You didn't remove the "return 0" at end of this function.
>> Doesn't it complain during build?
>>
>>> @@ -633,12 +633,9 @@ static int sysc_check_one_child(struct sysc *ddata,
>>>   static int sysc_check_children(struct sysc *ddata)
>>>   {
>>
>> This could return void as well.
> 
> Okay. Sorry for the errors; I'll fix-up and resend.
> 
> However, while building it, I'm running into a compilation problem:
> on line 764 (function sysc_ioremap) there is apparently an "undeclared variable", "SZ_1K". Is it a problem with the architecture? What arch should I compile it with?

make ARCH=arm omap2plus_defconfig
make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-

> 
> Thanking you,
> Nishka
> 
>>
>>>       struct device_node *child;
>>> -    int error;
>>>         for_each_child_of_node(ddata->dev->of_node, child) {
>>> -        error = sysc_check_one_child(ddata, child);
>>> -        if (error)
>>> -            return error;
>>> +        sysc_check_one_child(ddata, child);
>>>       }
>>
>> You don't need the braces { }.
>>
>> Please run ./scripts/checkpatch.pl --strict on your patch and fix any
>> issues.
>>
>>>         return 0;
>>>
>>
>> return not required.
>>
>> You will also need to fix all instances using sysc_check_children()
>>

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
