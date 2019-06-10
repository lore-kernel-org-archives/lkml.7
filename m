Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8AEC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB35207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LrASFVP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbfFJL5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 07:57:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38018 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389309AbfFJL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:57:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5ABvJUP046949;
        Mon, 10 Jun 2019 06:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560167839;
        bh=7Y3wRsKJN+geLqJ0d8qLs+gltVPgxRyI0kjibKl0HS8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LrASFVP1qE3avX1bstjeL+3QWaVm7twyzTld8wRiuOO2BYOfRngqF4OfQaK93Qbib
         zzWBNuVB/f+6buIf1Ro6N46owPFqdW5VbRYPtza64NwwACID6G6D3HyAm5jl2lfnef
         pV4zCZVgJMLtiWB9xxdZ5npyu/MBq2XxmpWdE0Jo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5ABvJVT100411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jun 2019 06:57:19 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 10
 Jun 2019 06:57:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 10 Jun 2019 06:57:19 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5ABvFUw005623;
        Mon, 10 Jun 2019 06:57:15 -0500
Subject: Re: [PATCH v7 2/6] usb:common Separated decoding functions from dwc3
 driver.
To:     Pawel Laszczak <pawell@cadence.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-3-git-send-email-pawell@cadence.com>
 <20190608134008.GB11489@kroah.com>
 <BYAPR07MB4709C42303D60ABF917E22D0DD130@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <f86b1a4a-1400-bdf7-3d01-6010f20af72e@ti.com>
Date:   Mon, 10 Jun 2019 14:57:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB4709C42303D60ABF917E22D0DD130@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2019 09:29, Pawel Laszczak wrote:
> 
>> On Wed, Jun 05, 2019 at 11:03:46AM +0100, Pawel Laszczak wrote:
>>
>>> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
>>
>>> to driver/usb/common/debug.c file. These moved functions include:
>>
>>>     dwc3_decode_get_status
>>
>>>     dwc3_decode_set_clear_feature
>>
>>>     dwc3_decode_set_address
>>
>>>     dwc3_decode_get_set_descriptor
>>
>>>     dwc3_decode_get_configuration
>>
>>>     dwc3_decode_set_configuration
>>
>>>     dwc3_decode_get_intf
>>
>>>     dwc3_decode_set_intf
>>
>>>     dwc3_decode_synch_frame
>>
>>>     dwc3_decode_set_sel
>>
>>>     dwc3_decode_set_isoch_delay
>>
>>>     dwc3_decode_ctrl
>>
>>>
>>
>>> These functions are used also in inroduced cdns3 driver.
>>
>>>
>>
>>> All functions prefixes were changed from dwc3 to usb.
>>
>>> Also, function's parameters has been extended according to the name
>>
>>> of fields in standard SETUP packet.
>>
>>> Additionally, patch adds usb_decode_ctrl function to
>>
>>> include/linux/usb/ch9.h file.i
>>
>>>
>>
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>
>>> ---
>>
>>>  drivers/usb/common/Makefile |   2 +-
>>
>>>  drivers/usb/common/debug.c  | 273 ++++++++++++++++++++++++++++++++++++
>>
>>>  drivers/usb/dwc3/debug.h    | 252 ---------------------------------
>>
>>>  drivers/usb/dwc3/trace.h    |   2 +-
>>
>>>  include/linux/usb/ch9.h     |  25 ++++
>>
>>>  5 files changed, 300 insertions(+), 254 deletions(-)
>>
>>>  create mode 100644 drivers/usb/common/debug.c
>>
>>>
>>
>>> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
>>
>>> index 0a7c45e85481..02eb01666289 100644
>>
>>> --- a/drivers/usb/common/Makefile
>>
>>> +++ b/drivers/usb/common/Makefile
>>
>>> @@ -4,7 +4,7 @@
>>
>>>  #
>>
>>>
>>
>>>  obj-$(CONFIG_USB_COMMON)	  += usb-common.o
>>
>>> -usb-common-y			  += common.o
>>
>>> +usb-common-y			  += common.o debug.o
>>
>>>  usb-common-$(CONFIG_USB_LED_TRIG) += led.o
>>
>>>
>>
>>>  obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
>>
>>> diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
>>
>>> new file mode 100644
>>
>>> index 000000000000..f7218d794aa6
>>
>>> --- /dev/null
>>
>>> +++ b/drivers/usb/common/debug.c
>>
>>> @@ -0,0 +1,273 @@
>>
>>> +// SPDX-License-Identifier: GPL-2.0
>>
>>> +/**
>>
>>> + * Common USB debugging functions
>>
>>> + *
>>
>>> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://urldefense.proofpoint.com/v2/url?u=http-
>> 3A__www.ti.com&d=DwIBAg&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=e1OgxfvkL0qo9XO6fX1gscva-
>> w03uSYC1nIyxl89-rI&m=hCAftKt20FnC6KiCwNbVrg7WoY-WnCtUjVuast3iJSw&s=Q4qhFXl4s1P2u0s65WgkulIRgV4KZtGphj7Xjr4t6yA&e=
>>
>>> + *
>>
>>> + * Authors: Felipe Balbi <balbi@ti.com>,
>>
>>> + *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>>> + */
>>
>>> +
>>
>>> +#ifndef __LINUX_USB_COMMON_DEBUG
>>
>>> +#define __LINUX_USB_COMMON_DEBUG
>>
>>
>>
>> Why are you doing thsi in a .c file?
>>
> Good question, I don't know :). 
> Was removed 
> 
> Also I remember that you complained about placing it in 
> drivers/usb/common. 
> Currently this file is used only by two drivers dwc3 and cdns3.
> Both are USB controller drivers. Maybe it could be better to move it to:
> drivers/gadget/udc/debug.c
> drivers/gadget/debug.c 
> drivers/gadget/common/debug.c
> or
> drivers/gadget/debug/debug.c 
> 
> What do you think Roger? 

Since they are only used by gadget code, I would opt to have it in drivers/usb/gadget/

> 
> Felipe it's also question for you. 
>  
> 
> Thanks,
> Pawel
> 
>>
>>
>> thanks,
>>
>>
>>
>> greg k-h
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
