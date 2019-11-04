Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5633ACA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D23A222D3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tx7ICpZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfKDJS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:18:57 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48538 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:18:56 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA49IbI6105735;
        Mon, 4 Nov 2019 03:18:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572859117;
        bh=xyN+0QGhuX6XIChTqWK1p/za3+ammgLwym9ib1UkJJ4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Tx7ICpZ3S+zJ0aOGPFGVZVvDuC0EmTa+ZtUmmSk4eXkPchWt5eOcBnx4f2YiHYNT0
         dhPSjLoNxkLjNF8/tyH7gNHdQhwMVl6oK576rzeAp6MZa7wnfM/n49H2jR9yBJE/yq
         /Zyegf4C2J6HlloYAwB3XYMFP0FEvApK/xw/DcTQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA49Ibv1032561;
        Mon, 4 Nov 2019 03:18:37 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 4 Nov
 2019 03:18:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 4 Nov 2019 03:18:22 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA49IY72065139;
        Mon, 4 Nov 2019 03:18:34 -0600
Subject: Re: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when
 connected to Super-Speed host
To:     Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191029151514.28495-1-rogerq@ti.com>
 <20191030121607.21739-1-rogerq@ti.com> <87pnide1k7.fsf@gmail.com>
 <44b07e90-a9de-ea99-25c6-dc72cf39bbe1@ti.com> <875zk5dw0m.fsf@gmail.com>
 <86a7fbc4-136f-78bb-4677-784199842c9f@ti.com>
 <BYAPR07MB4709B96934FAED77689ED89EDD7C0@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <03bb6f7e-5545-3047-d3f4-4fa9789d0bcb@ti.com>
Date:   Mon, 4 Nov 2019 11:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB4709B96934FAED77689ED89EDD7C0@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/2019 10:17, Pawel Laszczak wrote:
> Hi,
> 
>>>
>>> Hi,
>>>
>>> Roger Quadros <rogerq@ti.com> writes:
>>>
>>>> Hi,
>>>>
>>>> On 31/10/2019 10:55, Felipe Balbi wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>
>>>>>> Take into account gadget driver's speed limit when programming
>>>>>> controller speed.
>>>>>>
>>>>>> Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
>>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>>> Acked-by: Peter Chen <peter.chen@nxp.com>
>>>>>> ---
>>>>>>
>>>>>> Changelog:
>>>>>> v2
>>>>>> - Add Fixes line
>>>>>>
>>>>>>     drivers/usb/cdns3/gadget.c | 31 ++++++++++++++++++++++++++-----
>>>>>>     1 file changed, 26 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>>>>>> index 40dad4e8d0dc..1c724c20d468 100644
>>>>>> --- a/drivers/usb/cdns3/gadget.c
>>>>>> +++ b/drivers/usb/cdns3/gadget.c
>>>>>> @@ -2338,9 +2338,35 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
>>>>>>     {
>>>>>>     	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
>>>>>>     	unsigned long flags;
>>>>>> +	enum usb_device_speed max_speed = driver->max_speed;
>>>>>>
>>>>>>     	spin_lock_irqsave(&priv_dev->lock, flags);
>>>>>>     	priv_dev->gadget_driver = driver;
>>>>>> +
>>>>>> +	/* limit speed if necessary */
>>>>>> +	max_speed = min(driver->max_speed, gadget->max_speed);
>>>>>> +
>>>>>> +	switch (max_speed) {
>>>>>> +	case USB_SPEED_FULL:
>>>>>> +		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
>>>
>>> so this forces the controller to FS
>>
>> Right.
>>
>>>
>>>>>> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>>>
>>> and this disconnects in superspeed? What is this supposed to do?
>>>
>>
>> It says "Disconnect USB device in SuperSpeed".
>>
>> We were asked to set that bit to limit it to HS.
>>
>>>>>> +		break;
>>>>>> +	case USB_SPEED_HIGH:
>>>>>> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>>>>>> +		break;
>>>>>> +	case USB_SPEED_SUPER:
>>>>>> +		break;
>>>>>> +	default:
>>>>>> +		dev_err(priv_dev->dev,
>>>>>> +			"invalid maximum_speed parameter %d\n",
>>>>>> +			max_speed);
>>>>>> +		/* fall through */
>>>>>> +	case USB_SPEED_UNKNOWN:
>>>>>> +		/* default to superspeed */
>>>>>> +		max_speed = USB_SPEED_SUPER;
>>>>>> +		break;
>>>>>> +	}
>>>>>
>>>>> I had suggested some simplification for this case statement.
>>>>>
>>>>
>>>> oops, looks like Greg picked this already.
>>>>
>>>> During more tests today I just observed that this patch causes
>>>> the following regression.
>>>>
>>>> Connect EVM to Super-Speed host
>>>> Load g_audio. (this enumerates as HS which is fine)
>>>> unload g_audio
>>>> load g_zero (this enumerates at HS instead of SS).
>>>>
>>>> This is because the speed limit that we set doesn't get cleared.
>>>>
>>>> Now the bits are write only and there is a way to undo USB_CONF_SFORCE_FS
>>>> by writing USB_CONF_CFORCE_FS, however there is no corresponding bit
>>>> to clear USB_CONF_USB3DIS. Only way seems to be USB_CFG_SWRST which
>>>> is a bit harsh IMO.
>>>
>>> Isn't bit 0 enough?
>>>
>>> /* Reset USB device configuration. */
>>> #define USB_CONF_CFGRST		BIT(0)
>>
>> Probably not, as explanation of USB3DIS bit says,
>> "To connect disconnected device, CPU performs
>> software reset (CFG.SWRST)." which is bit 7. "Device software reset.
>>
>> But I'll let Pawel comment on this.
> 
> Yes it's the only way to return back to SS mode.
> The USB speed is detecting during connecting.
> CFG.SWRST make reconnect.

Can this be done as part of udc_start or udc_stop?

> 
> Maybe it would be better to add SS support in g_audio function.

Not every gadget needs SS, so this is not the right way IMO.

> 
>>>
>>> Also, now that I look at this more carefully, you should move that code
>>> to udc_set_speed().
>>>
>>
>> Agreed. I'll revise the implementation to move it to udc_set_speed()
>> once I know how to undo the USB3DIS.
>>


-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
