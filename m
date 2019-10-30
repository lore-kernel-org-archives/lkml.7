Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF04CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8F520874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mw37YHGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfJ3Iob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:44:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54400 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJ3Ioa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:44:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9U8iEeI098145;
        Wed, 30 Oct 2019 03:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572425054;
        bh=E27tcJBYIvqvaA31Zqpz1NjcSVFU5/7cIiIXtS8r2MU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Mw37YHGV8JrhVh7Qmt4bWBP3OSmJyp5Oj7izmTpcXhms4HZettDOBj4ae0OH08FvZ
         N+uMAvcdvv2SuBuNAJqkOIzCM8UOSGQQ+G3x7mFdOHTc3ViSbz8FCrufDTaLqahcFk
         zAVOLDu7Eoaw1/cASLhzy9zZpUvCvIvvthdZWPX4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9U8iEIC102783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Oct 2019 03:44:14 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 30
 Oct 2019 03:44:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 30 Oct 2019 03:44:00 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9U8iBda078433;
        Wed, 30 Oct 2019 03:44:11 -0500
Subject: Re: [PATCH] usb: cdns3: gadget: Fix g_audio use case when connected
 to Super-Speed host
To:     Peter Chen <peter.chen@nxp.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191029151514.28495-1-rogerq@ti.com>
 <20191030063636.GE26815@b29397-desktop>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <b780ffea-dca0-310e-1d66-4ceca380b4ee@ti.com>
Date:   Wed, 30 Oct 2019 10:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030063636.GE26815@b29397-desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2019 08:36, Peter Chen wrote:
> On 19-10-29 17:15:14, Roger Quadros wrote:
>> Take into account gadget driver's speed limit when programming
>> controller speed.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>> Hi Greg,
>>
>> Please apply this for -rc.
>> Without this, g_audio is broken on cdns3 USB controller is
>> connected to a Super-Speed host.
>>
>> cheers,
>> -roger
>>
>>   drivers/usb/cdns3/gadget.c | 31 ++++++++++++++++++++++++++-----
>>   1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index 40dad4e8d0dc..1c724c20d468 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -2338,9 +2338,35 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
>>   {
>>   	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
>>   	unsigned long flags;
>> +	enum usb_device_speed max_speed = driver->max_speed;
>>   
>>   	spin_lock_irqsave(&priv_dev->lock, flags);
>>   	priv_dev->gadget_driver = driver;
>> +
>> +	/* limit speed if necessary */
>> +	max_speed = min(driver->max_speed, gadget->max_speed);
>> +
>> +	switch (max_speed) {
>> +	case USB_SPEED_FULL:
>> +		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
>> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>> +		break;
>> +	case USB_SPEED_HIGH:
>> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>> +		break;
>> +	case USB_SPEED_SUPER:
>> +		break;
>> +	default:
>> +		dev_err(priv_dev->dev,
>> +			"invalid maximum_speed parameter %d\n",
>> +			max_speed);
>> +		/* fall through */
>> +	case USB_SPEED_UNKNOWN:
>> +		/* default to superspeed */
>> +		max_speed = USB_SPEED_SUPER;
>> +		break;
>> +	}
>> +
>>   	cdns3_gadget_config(priv_dev);
>>   	spin_unlock_irqrestore(&priv_dev->lock, flags);
>>   	return 0;
>> @@ -2570,12 +2596,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
>>   	/* Check the maximum_speed parameter */
>>   	switch (max_speed) {
>>   	case USB_SPEED_FULL:
>> -		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
>> -		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>> -		break;
>>   	case USB_SPEED_HIGH:
>> -		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
>> -		break;
>>   	case USB_SPEED_SUPER:
>>   		break;
>>   	default:
> 
> Just a small comment:
> 
> You could delete switch-case at cdns3_gadget_start, and just use
> if() statement, eg:
> 
> 	max_speed = usb_get_maximum_speed(cdns->dev);
> 	if (max_speed == USB_SPEED_UNKNOWN)
> 		max_speed = USB_SPEED_SUPER;

But then it will not take care of bailing out for USB_SPEED_WIRELESS,
USB_SPEED_SUPER_PLUS and any future speeds.

> 
> Otherwise:
> 
> Acked-by: Peter Chen <peter.chen@nxp.com>
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
