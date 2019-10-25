Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D963CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7EF21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hfOx8YhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501916AbfJYJ73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:59:29 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54864 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408510AbfJYJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:59:28 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9P9xKrK066500;
        Fri, 25 Oct 2019 04:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571997560;
        bh=V6hOD5dytEB/3BCbaVXsPiwjMD39duocB15Lwiy7XLU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hfOx8YhLPWRW7wJRbqNBJ5mw+F8j9L+oe9BMdToXpsp09kwVmjN6EZOJvwO2uj7SS
         cMWaPs07XcDgR7OdghbpebCYu67pTRGMVN64KCF64D2pmOxpLOfLrMvqmb9pPf22a+
         JYFM/F5Jg1NPIn9+zkdhTQcIvDJt7VxWtEecH1N4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9P9xKuQ077394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Oct 2019 04:59:20 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 04:59:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 04:59:09 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P9xHaw053809;
        Fri, 25 Oct 2019 04:59:18 -0500
Subject: Re: [PATCH] usb: cdns3: gadget: Don't manage pullups
To:     Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191023090232.27237-1-rogerq@ti.com>
 <BYAPR07MB4709A6212601A75DCB1A25ACDD6B0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20191025031343.GA13392@b29397-desktop>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <83a1da01-19d6-65a9-aecd-2027fd62a272@ti.com>
Date:   Fri, 25 Oct 2019 12:59:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025031343.GA13392@b29397-desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On 25/10/2019 06:13, Peter Chen wrote:
> On 19-10-23 09:17:45, Pawel Laszczak wrote:
>> Hi,
>>
>> Reviewed-by: Pawel Laszczak <pawell@cadence.com>
> 
> Hi Roger & Pawel,
> 
> Assume gadget function has already enabled, if you switch host mode
> to device mode, with your changes, where the device mode will be enabled
> again?

When it switches from device mode to host the UDC is removed. When we switch
back from host to device mode the UDC is added, so,

usb_add_gadget_udc_release()-> check_pending_gadget_drivers()->
udc_bind_to_driver()->usb_udc_connect_control()->usb_gadget_connect()->
gadget->ops->pullup()

cheers,
-roger
> 
> Peter
>>
>> Regards,
>> Pawel,
>>
>>> The USB gadget core is supposed to manage pullups
>>> of the controller. Don't manage pullups from within
>>> the controller driver. Otherwise, function drivers
>>> are not able to keep the controller disconnected from
>>> the bus till they are ready. (e.g. g_webcam)
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>> Hi Greg/Felipe,
>>>
>>> This can be used for -rc as it is a bug fix.
>>>
>>> cheers,
>>> -roger
>>>
>>> drivers/usb/cdns3/gadget.c | 4 ----
>>> 1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>>> index 2ca280f4c054..714382d96055 100644
>>> --- a/drivers/usb/cdns3/gadget.c
>>> +++ b/drivers/usb/cdns3/gadget.c
>>> @@ -2324,8 +2324,6 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
>>> 	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
>>>
>>> 	cdns3_configure_dmult(priv_dev, NULL);
>>> -
>>> -	cdns3_gadget_pullup(&priv_dev->gadget, 1);
>>> }
>>>
>>> /**
>>> @@ -2708,8 +2706,6 @@ static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
>>> 	/* disable interrupt for device */
>>> 	writel(0, &priv_dev->regs->usb_ien);
>>>
>>> -	cdns3_gadget_pullup(&priv_dev->gadget, 0);
>>> -
>>> 	return 0;
>>> }
>>>
>>> --
>>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
