Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38015C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D86C233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sBLkeISC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389154AbfHVNhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:37:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59272 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfHVNhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:37:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7MDbgsP118773;
        Thu, 22 Aug 2019 08:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566481062;
        bh=KClX8zGAqMXvkwVK0aEixQaZyFMmTporptwJb8u6V+k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sBLkeISChmSwkWhg08PvCyN4PNBBbzKWkyNMvSxHRNBmU7Ha0th9o25KubOjKNLli
         JL+mmWNgjNkoqXwaO/A11G4Fd8BarnqcyvJDExMRNClzAtmd4CRwxG+GidsxwZz5vL
         sehwone1NfXleBLD1bicxkXE/2BsoTM7ka99d5Xw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7MDbgpQ039456
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Aug 2019 08:37:42 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 22
 Aug 2019 08:37:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 22 Aug 2019 08:37:41 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7MDbdn5046197;
        Thu, 22 Aug 2019 08:37:40 -0500
Subject: Re: [PATCH] usb: gadget: udc: core: Fix error case while binding
 pending gadget drivers
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1908211027430.1816-100000@iolanthe.rowland.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <9eba7e43-5692-b9c7-b30c-39a60e3239a6@ti.com>
Date:   Thu, 22 Aug 2019 16:37:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1908211027430.1816-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/08/2019 17:30, Alan Stern wrote:
> On Wed, 21 Aug 2019, Roger Quadros wrote:
> 
>> If binding a pending gadget driver fails we should not
>> remove it from the pending driver list, otherwise it
>> will cause a segmentation fault later when the gadget driver is
>> unloaded.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/gadget/udc/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>> index 7cf34beb50df..c272c8014772 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -1142,7 +1142,7 @@ static int check_pending_gadget_drivers(struct usb_udc *udc)
>>  		if (!driver->udc_name || strcmp(driver->udc_name,
>>  						dev_name(&udc->dev)) == 0) {
>>  			ret = udc_bind_to_driver(udc, driver);
>> -			if (ret != -EPROBE_DEFER)
>> +			if (!ret)
>>  				list_del(&driver->pending);
>>  			break;
>>  		}
> 
> This is kind of a policy question.  If binding a pending gadget driver 
> fails, should the driver remain pending?
> 
> Depending on the answer to this question, you might want to change the 
> list_del to list_del_init.  That should fix the segmentation fault 
> just as well.

OK. I'll send a revised patch to retain existing policy.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
