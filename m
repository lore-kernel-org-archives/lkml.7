Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC45C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696662168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hahLTPEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbfJPJzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:55:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33020 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfJPJzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:55:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9G9sfBB080644;
        Wed, 16 Oct 2019 04:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571219681;
        bh=ilvmorCMdYLV72y3iRRl828Fp9lD2xDungHZT0n9FRU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hahLTPEGxEbDd5g7fTyGMLIpHg87uMKwqP4+TlO2o7Og00hHuXZSfrhRQ8fLCJFnE
         uQ/gjBdIqAvGGdUsHS9OZZQWqhWv+P6c9FQ4cliyE8hOUyqQx8aPt+0pL+fUFV/Fjl
         0E19L8NAJbj1G5dnD4nzw6qUkHWcs5tBFnp9Rt5M=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9G9sfxC105364
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 04:54:41 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 04:54:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 04:54:40 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9G9scFD113224;
        Wed, 16 Oct 2019 04:54:39 -0500
Subject: Re: [PATCH 1/2] usb: cdns3: fix cdns3_core_init_role()
To:     Pawel Laszczak <pawell@cadence.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191007121601.25996-1-rogerq@ti.com>
 <20191007121601.25996-2-rogerq@ti.com>
 <BYAPR07MB470974496C7C59FDE615E5F3DD920@BYAPR07MB4709.namprd07.prod.outlook.com>
 <715c8f74-2790-6546-66ae-c0aea53946ed@ti.com>
 <BYAPR07MB470923F80C4B49D26291B268DD920@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <3d2e7110-448f-d847-7668-bb20d7e03d22@ti.com>
Date:   Wed, 16 Oct 2019 12:54:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB470923F80C4B49D26291B268DD920@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/10/2019 12:38, Pawel Laszczak wrote:
>>
>>
>> Hi Pawel,
>>
>> On 16/10/2019 07:32, Pawel Laszczak wrote:
>>> Hi Roger
>>>
>>>>
>>>> At startup we should trigger the HW state machine
>>>> only if it is OTG mode. Otherwise we should just
>>>> start the respective role.
>>>>
>>>> Initialize idle role by default. If we don't do this then
>>>> cdns3_idle_role_stop() is not called when switching to
>>>> host/device role and so lane switch mechanism
>>>> doesn't work. This results to super-speed device not working
>>>> in one orientation if it was plugged before driver probe.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>>> ---
>>>> drivers/usb/cdns3/core.c | 20 +++++++++++++++++++-
>>>> 1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>> index 06f1e105be4e..1109dc5a4c39 100644
>>>> --- a/drivers/usb/cdns3/core.c
>>>> +++ b/drivers/usb/cdns3/core.c
>>>> @@ -160,10 +160,28 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>>>> 	if (ret)
>>>> 		goto err;
>>>>
>>>> -	if (cdns->dr_mode != USB_DR_MODE_OTG) {
>>>> +	/* Initialize idle role to start with */
>>>> +	ret = cdns3_role_start(cdns, USB_ROLE_NONE);
>>>> +	if (ret)
>>>> +		goto err;
>>>> +
>>>> +	switch (cdns->dr_mode) {
>>>> +	case USB_DR_MODE_UNKNOWN:
>>>
>>> One note in this place. USB_DR_MODE_UNKNOWN is not possible in this place.
>>> If cdns->dr_mode will be USB_DR_MODE_UNKNOWN then driver returns -EINVAL
>>
>> At which place? I could not find.
> 
> In this patch we can't see this line:
> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/usb/cdns3/core.c#L159
> There is called  cdns3_drd_update_mode(cdns);
> 
> int cdns3_drd_update_mode(struct cdns3 *cdns)
> {
> 	int ret = 0;
> 
> 	switch (cdns->dr_mode) {
> 	case USB_DR_MODE_PERIPHERAL:
> 		ret = cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
> 		break;
> 	case USB_DR_MODE_HOST:
> 		ret = cdns3_set_mode(cdns, USB_DR_MODE_HOST);
> 		break;
> 	case USB_DR_MODE_OTG:
> 		ret = cdns3_init_otg_mode(cdns);
> 		break;
> 	default:
> 		dev_err(cdns->dev, "Unsupported mode of operation %d\n",
> 			cdns->dr_mode);
> 		return -EINVAL;
> 	}
> 
> 	return ret;
> }
> 
> After calling cdns3_drd_update_mode  we have 2 first lines from this patch
> 	if (ret)
> 		goto err;

I see now. I will update this patch to error out if dr_mode is USB_DR_MODE_UNKNOWN.
Thanks.

cheers,
-roger

> 
> Pawel
>>
>>> some line before after returning form cdns3_drd_update_mode and in consequence
>>> it jump to err label.
>>>
>>> Maybe for better readability it this condition should be treated here also as error.
>>>
>>>> +	case USB_DR_MODE_OTG:
>>>> 		ret = cdns3_hw_role_switch(cdns);
>>>> 		if (ret)
>>>> 			goto err;
>>>> +		break;
>>>> +	case USB_DR_MODE_PERIPHERAL:
>>>> +		ret = cdns3_role_start(cdns, USB_ROLE_DEVICE);
>>>> +		if (ret)
>>>> +			goto err;
>>>> +		break;
>>>> +	case USB_DR_MODE_HOST:
>>>> +		ret = cdns3_role_start(cdns, USB_ROLE_HOST);
>>>> +		if (ret)
>>>> +			goto err;
>>>> +		break;
>>>> 	}
>>>>
>>>> 	return ret;
>>>
>>> Reviewed-by: Pawel Laszczak <pawell@cadence.com>
>>> Tested-by: Pawel Laszczak <pawell@cadence.com>
>>>
>>> --
>>> Regards,
>>> Pawel
>>>
>>
>> --
>> cheers,
>> -roger
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
