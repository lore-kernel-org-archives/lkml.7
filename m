Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C4EECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D79206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sn7d0Yqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfJHJnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:43:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59914 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbfJHJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:43:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x989hM0o022835;
        Tue, 8 Oct 2019 04:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570527802;
        bh=QG9uBEOGOzGIz8o38Mi9I32wNHAc3Flv5KIkUGiBtpQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Sn7d0YqiY0gcXEDqp0XRQOCjSA6rVwj3xq7DimKiY5zCL22euL0aX14q0j7VvUoCH
         msH55QL91/8SYsZUIxCfA+BOCO+69mVVwDE1qORtc5BErW7S/NZWh0uhljDI75QO4W
         UPqYwznlE1lIkExSll/gSYFI/s4/VsO0V8+VlMM8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x989hLBf027561
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Oct 2019 04:43:22 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 8 Oct
 2019 04:43:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 8 Oct 2019 04:43:19 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x989hIw9032587;
        Tue, 8 Oct 2019 04:43:19 -0500
Subject: Re: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
To:     Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com>
 <20191008065619.GE5670@b29397-desktop>
 <BN7PR07MB47056F9852550657E9651DD7DD9A0@BN7PR07MB4705.namprd07.prod.outlook.com>
 <VI1PR04MB53276319AB49C454A7A0318B8B9A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <0b3cd2c4-c9dc-f88a-965d-357b9f34cec3@ti.com>
Date:   Tue, 8 Oct 2019 12:43:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB53276319AB49C454A7A0318B8B9A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On 08/10/2019 11:44, Peter Chen wrote:
>   
>>>> Endpoint can defer transition to Halted state if endpoint has pending
>>>> requests.
>>>
>>> The implementation of halt handling is a little complicated, you may
>>> consider return -EAGAIN for functional stall through usb_ep_set_halt
>> >from function driver if the requests are pending, it doesn't need to
>>> defer such kinds of functional stall.
>>
>> Yes, I remember your suggestion regarding using EAGAIN, but f_mass_storage
>> Driver simple check the status and try to stall endpoint again after 100 ms.
>>
>> What if Command Verifier ask for endpoint status before this time, or if the transfer
>> will not be finished on time ? Then the CV test may fail.
>>
>> So solution from this patch should be more certain.
>>
> 
> Your description is reasonable, since I have not met this issue, I would like
> to know more about it:
> It occurs at CV9 or MSC test? For CV9 test, it may not try to stall non-ep0.
> Which test case was failed?

Since g_zero was used it would be CV9.

cheers,
-roger

> 
> Peter
> 
>>>
>>> Peter
>>>> Patch add additional condition that allows to return correct endpoint
>>>> status during Get Endpoint Status request even if the halting
>>>> endpoint is in progress.
>>>>
>>>> Reported-by: Rahul Kumar <kurahul@cadence.com>
>>>> Signed-off-by: Rahul Kumar <kurahul@cadence.com>
>>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>>> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>>>> ---
>>>>   drivers/usb/cdns3/ep0.c | 10 ++++++++--
>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c index
>>>> 44f652e8b5a2..10ae03430f34 100644
>>>> --- a/drivers/usb/cdns3/ep0.c
>>>> +++ b/drivers/usb/cdns3/ep0.c
>>>> @@ -234,9 +234,11 @@ static int cdns3_req_ep0_set_address(struct
>>>> cdns3_device *priv_dev,  static int cdns3_req_ep0_get_status(struct
>> cdns3_device *priv_dev,
>>>>   				    struct usb_ctrlrequest *ctrl)  {
>>>> +	struct cdns3_endpoint *priv_ep;
>>>>   	__le16 *response_pkt;
>>>>   	u16 usb_status = 0;
>>>>   	u32 recip;
>>>> +	u8 index;
>>>>
>>>>   	recip = ctrl->bRequestType & USB_RECIP_MASK;
>>>>
>>>> @@ -262,9 +264,13 @@ static int cdns3_req_ep0_get_status(struct
>> cdns3_device *priv_dev,
>>>>   	case USB_RECIP_INTERFACE:
>>>>   		return cdns3_ep0_delegate_req(priv_dev, ctrl);
>>>>   	case USB_RECIP_ENDPOINT:
>>>> -		/* check if endpoint is stalled */
>>>> +		index = cdns3_ep_addr_to_index(ctrl->wIndex);
>>>> +		priv_ep = priv_dev->eps[index];
>>>> +
>>>> +		/* check if endpoint is stalled or stall is pending */
>>>>   		cdns3_select_ep(priv_dev, ctrl->wIndex);
>>>> -		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
>>>> +		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)) ||
>>>> +		    (priv_ep->flags & EP_STALL_PENDING))
>>>>   			usb_status =  BIT(USB_ENDPOINT_HALT);
>>>>   		break;
>>>>   	default:
>>>> --
>>>> 2.17.1
>>>>
>>>
>>> --
>>>
>>> Thanks,
>>> Peter Chen
>>
>> Regards,
>> Pawel

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
