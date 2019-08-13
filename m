Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25343C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41C820673
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mOvkGQqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfHMG0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:26:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57896 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfHMG0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:26:02 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7D6Pwk0052886;
        Tue, 13 Aug 2019 01:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565677558;
        bh=ZS6jom8hyruNhhn92H7Pd6e1fN82ogmMfLmiZ4OzHJ4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=mOvkGQqzHHjfYJMaaL5o0LlRwmSjyivPLSbPmtA5F/Tn3/1A2tvMhTzhz/E+zPZY2
         GoyE6P4fy8xo1X8rQcsfcoPeTjlrg2WvOPnOl5Pnx3gWveJwqLmRNkSDPAGiKSFrqa
         lO+G8BoQ21xk3yGbGo0GByCjHcOtLfX54U8mi/9k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7D6Pw7j047582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Aug 2019 01:25:58 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 13
 Aug 2019 01:25:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 13 Aug 2019 01:25:58 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7D6PuMJ122172;
        Tue, 13 Aug 2019 01:25:57 -0500
Subject: Re: [PATCH] bus: ti-sysc: Remove if-block in sysc_check_children()
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>, <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
References: <20190808074042.15403-1-nishkadg.linux@gmail.com>
 <2038cdcd-1506-84c6-520d-6dda50d4f317@ti.com>
 <a1f56fcc-2207-fa32-83bc-cd219c2b893c@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <b1f8756e-4b15-7f1a-8562-5b80063733de@ti.com>
Date:   Tue, 13 Aug 2019 09:25:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a1f56fcc-2207-fa32-83bc-cd219c2b893c@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2019 07:35, Nishka Dasgupta wrote:
> On 08/08/19 7:25 PM, Roger Quadros wrote:
>> Nishka,
>>
>> On 08/08/2019 10:40, Nishka Dasgupta wrote:
>>> In function sysc_check_children, there is an if-statement checking
>>> whether the value returned by function sysc_check_one_child is non-zero.
>>> However, sysc_check_one_child always returns 0, and hence this check is
>>> not needed. Hence remove this if-block.
>>>
>>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>>> ---
>>>   drivers/bus/ti-sysc.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
>>> index e6deabd8305d..bc8082ae7cb5 100644
>>> --- a/drivers/bus/ti-sysc.c
>>> +++ b/drivers/bus/ti-sysc.c
>>> @@ -637,8 +637,6 @@ static int sysc_check_children(struct sysc *ddata)
>>>         for_each_child_of_node(ddata->dev->of_node, child) {
>>>           error = sysc_check_one_child(ddata, child);
>>> -        if (error)
>>> -            return error;
>>
>> We cannot assume that sysc_check_one_child() will never return error in the future.
>> If it can never return an error then why does it have an int return type?
> 
> I'm not sure why it has an int return type, unfortunately. This is the function in its entirety:
> 
> static int sysc_check_one_child(struct sysc *ddata,
>                 struct device_node *np)
> {
>     const char *name;
> 
>     name = of_get_property(np, "ti,hwmods", NULL);
>     if (name)
>         dev_warn(ddata->dev, "really a child ti,hwmods property?");
> 
>     sysc_check_quirk_stdout(ddata, np);
>     sysc_parse_dts_quirks(ddata, np, true);
> 
>     return 0;
> }
> 
> I'm not sure how to understand this function. Do dev_warn() or sysc_check_quirk_stdout() or sysc_parse_dts_quirks() cause a non-zero return from sysc_check_one_child()? Should I drop my patch?

None of those functions return anything.
Maybe you can fix sysc_check_one_child() to return void?
I think you can retain your patch but get rid of error variable.

> 
> Thanking you,
> Nishka
>>
>>>       }
>>>         return 0;
>>>
>>

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
