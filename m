Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D3CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB79920643
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tQc3AiOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfDOTxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:53:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49672 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfDOTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:53:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3FJrbCW096485;
        Mon, 15 Apr 2019 14:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555358017;
        bh=JgSdssHRxOBzgBIWUrCOuItpmmKD4Yjpe8gVYq8JiLY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tQc3AiOpuBJ3KXNtm+XdMrOBBoN5bp6B7DIt4V00ekYr//8tFBk1Q0nmC0XNrzU5Z
         OsCJTSHhYopov5O9ZeFXj/Hwu4BPWMhre2pCrjGQ5mSqB3PXHvYv7XJVugl6z5egVh
         FXt6YNxuB5AV6p6wWq+oRjz3gRvnrrFDrixxWQfc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3FJrbZ4070713
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 14:53:37 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 14:53:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 14:53:37 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3FJraUn010984;
        Mon, 15 Apr 2019 14:53:36 -0500
Subject: Re: [PATCH 5/5] leds: lm3697: Introduce the lm3697 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-6-dmurphy@ti.com> <20190413200605.GA3013@amd>
 <f47fff9b-bca1-6412-c423-acf01baabc9f@ti.com> <20190415140306.GA13084@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ea9ac786-7303-5de3-9686-55589eed35ec@ti.com>
Date:   Mon, 15 Apr 2019 14:53:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415140306.GA13084@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/19 9:03 AM, Pavel Machek wrote:
> 
>>>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>>>> index 735009e73414..688bb9a6f275 100644
>>>> --- a/drivers/leds/Kconfig
>>>> +++ b/drivers/leds/Kconfig
>>>> @@ -776,9 +776,15 @@ config LEDS_NIC78BX
>>>>  	  To compile this driver as a module, choose M here: the module
>>>>  	  will be called leds-nic78bx.
>>>>  
>>>> +config LEDS_LM3697
>>>> +	tristate "LED driver for LM3697"
>>>> +	depends on LEDS_TI_LMU_COMMON
>>>> +	help
>>>> +	  Say Y to enable the LM3697 LED driver for TI LMU devices.
>>>> +	  This supports the LED device LM3697.
>>>> +
>>>>  config LEDS_TI_LMU_COMMON
>>>>  	tristate "LED driver for TI LMU"
>>>> -	depends on REGMAP
>>>>  	help
>>>>            Say Y to enable the LED driver for TI LMU devices.
>>>>            This supports common features between the TI LM3532, LM3631, LM3632,
> ...
>>> Plus we'd normally expect "COMMON" first and then specific driver. Not
>>> sure if Kconfig can handle it out-of-order...
>>
>> OK.  Should I rename the ti_lmu file to leds-common-ti-lmu?
> 
> Oh, no, that is not what I meant.
> 
> You have
> 
> config B
>        depends on A
> 
> config A
> 
> above. We really want
> 
> config A
> 
> config B
>        depends on A
> 

Got it I will rearrange that in v2.

>> This keeps the naming convention the same in the leds directory as well.
>>
>> FYI I will not add your acked-by on the LMU patch that introduced the code unless you approve.
>> Since you found issues with the kconfig
> 
> I did not review it in great detail, so no acked-by's, yet :-).

Thanks
Dan

> 									Pavel
> 
