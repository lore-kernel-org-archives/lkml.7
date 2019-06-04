Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD10C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391F623CCA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D25pQvBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfFDIZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:25:08 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57214 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFDIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:25:07 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x548OkBN019202;
        Tue, 4 Jun 2019 03:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559636686;
        bh=DiwIg104ZzyKgBvZwBFwYzUsFbehKHIF90gx3ALGLTY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=D25pQvBBkM9DAi1+FdnReiOtmHHDb1cndQDh3j7vN6ScYV53SJ8sYwV7ZC+ISsjAY
         2P/DArzWKbfcSFyn8Rs/kUf1rieTBXuWfADP/pdniznyZbhiIrWdoXg1zeU3HJFLCH
         qc5IbCMuyPbreNERH8xh29vGohiW/VAxIFhAowo4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x548Okmi063873
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 03:24:46 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 03:24:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 03:24:45 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x548Od3P118317;
        Tue, 4 Jun 2019 03:24:40 -0500
Subject: Re: [PATCH v6 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>
References: <1554882504-9010-1-git-send-email-pawell@cadence.com>
 <1554882504-9010-6-git-send-email-pawell@cadence.com>
 <b768bde9-d6c8-f655-aecb-d08bcb9286a6@ti.com>
 <BYAPR07MB47099815FA4691B6106F80FEDD150@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <f912a979-1e0c-8013-7f82-09102cb39a19@ti.com>
Date:   Tue, 4 Jun 2019 13:54:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB47099815FA4691B6106F80FEDD150@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/19 1:47 PM, Pawel Laszczak wrote:
>>
>> On 10/04/19 1:18 PM, Pawel Laszczak wrote:
>>> +static void cdns3_wa1_tray_restore_cycle_bit(struct cdns3_device *priv_dev,
>>> +					     struct cdns3_endpoint *priv_ep)
>>> +{
>>> +	int dma_index;
>>> +	u32 doorbell;
>>> +
>>> +	doorbell = !!(readl(&priv_dev->regs->ep_cmd) & EP_CMD_DRDY);
>>
>>> +	dma_index = (readl(&priv_dev->regs->ep_traddr) -
>>> +		    priv_ep->trb_pool_dma) / TRB_SIZE;
>>
>> This gets upgraded to 64-bit by 64-bit division whenever dma_addr_t is
>> 64-bit. That should be avoided. Following diff should fix it.
>> But please review the logic itself. You are subtracting a 64 bit entity
>>from a 32-bit entity. What is guaranteeing that priv_ep->trb_pool_dma is
>> 32-bit?
>>
>> There is one more instance of same issue in cdns3_request_handled().
>>
>> Thanks,
>> Sekhar
>>
>> [1]
>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>> index bfd5dbf40c7e..e73b618501fb 100644
>> --- a/drivers/usb/cdns3/gadget.c
>> +++ b/drivers/usb/cdns3/gadget.c
>> @@ -749,8 +749,8 @@ static void cdns3_wa1_tray_restore_cycle_bit(struct cdns3_device *priv_dev,
>> 	u32 doorbell;
>>
>> 	doorbell = !!(readl(&priv_dev->regs->ep_cmd) & EP_CMD_DRDY);
>> -	dma_index = (readl(&priv_dev->regs->ep_traddr) -
>> -		    priv_ep->trb_pool_dma) / TRB_SIZE;
>> +	dma_index = readl(&priv_dev->regs->ep_traddr) - priv_ep->trb_pool_dma;
>> +	dma_index /= TRB_SIZE;
> 
> Hi Sekhar,
> 
> In the next latest version I added setting dma and coherent mask to 32-bits as suggested by Roger. 
> Controller can do only 32-bit access.

I think this should work for now except if in some future version of
controller the limitation of 32-bit access is fixed. I guess that might
mean different logic for DMA handling anyway.

> DMA address space should be allocated from first 32 bits of address space. Most significant 32-bit 
> of priv_ep->trb_pool_dma should be zeroed, so I do not assume any issue in this place.
> 
> Have you seen any issue with this on your platform ?

build fails with

ERROR: "__aeabi_uldivmod" [drivers/usb/cdns3/cdns3.ko] undefined!

on 32-bit platforms with ARM LPAE enabled. So please roll in the fix I
suggested.

Thanks,
Sekhar
