Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA0C20409
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t+rAc2yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKNJsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:48:17 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36876 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKNJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:48:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAE9m5a5027418;
        Thu, 14 Nov 2019 03:48:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573724885;
        bh=1q4MpOUzBLd6f2gFBx2Y+31uqZ0iVHkf8HwMdleJdbM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t+rAc2ykt4MRCS1C16dg7sajamEvL5cKc2qB840wHukRFr/2PfmwG0mmJ5jpJvfr0
         lbz7LUDxLnHvYBQT5jYXf6b/eRgyFjYsmlBkEeUYYh2nb0E+91xP5PSH7sq3H17BDR
         4hU+5AT+nfsB4MjifWYyE0F1Vg7EQA9nznFGeIx8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAE9m51i050470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Nov 2019 03:48:05 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 14
 Nov 2019 03:48:05 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 14 Nov 2019 03:48:05 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAE9m2EF044096;
        Thu, 14 Nov 2019 03:48:02 -0600
Subject: Re: [RFC PATCH] usb: gadget: f_tcm: Added DMA32 flag while allocation
 of command buffer
To:     Peter Chen <peter.chen@nxp.com>, Jayshri Pawar <jpawar@cadence.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
References: <1573640672-10344-1-git-send-email-jpawar@cadence.com>
 <20191114025301.GD30608@b29397-desktop>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5b567d57-6206-24cf-5886-20e8b5a92a45@ti.com>
Date:   Thu, 14 Nov 2019 11:48:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114025301.GD30608@b29397-desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jayshri,

On 14/11/2019 04:50, Peter Chen wrote:
> On 19-11-13 10:24:32, Jayshri Pawar wrote:
>> There is a problem when function driver allocate memory for buffer
>> used by DMA from outside dma_mask space.
>> It appears during testing f_tcm driver with cdns3 controller.
>> In the result cdns3 driver was not able to map virtual buffer to DMA.
>> This fix should be improved depending on dma_mask associated with device.
>> Adding GFP_DMA32 flag while allocationg command data buffer only for 32
>> bit controllers.
> 
> Hi Jayshri,
> 
> This issue should be fixed by setting DMA_MASK correctly for controller,
> you can't limit user's memory region. At usb_ep_queue, the UDC driver
> will call DMA MAP API, for Cadence, it is usb_gadget_map_request_by_dev.
> For the system without SMMU (IO-MMU), it will use swiotlb to make sure
> the data buffer used for DMA transfer is within DMA mask for controller,
> There is a reserved low memory region for debounce buffer in swiotlb
> use case.
> 

/**
  * struct usb_request - describes one i/o request
  * @buf: Buffer used for data.  Always provide this; some controllers
  *	only use PIO, or don't use DMA for some endpoints.
  * @dma: DMA address corresponding to 'buf'.  If you don't set this
  *	field, and the usb controller needs one, it is responsible
  *	for mapping and unmapping the buffer.
<snip>
  */

So if dma is not set in the usb_request then controller driver is
responsible to do a dma_map of the buffer pointed by 'buf' before
it attemps to do DMA. This should take care of DMA mask and swiotlb.

This patch is not correct.

cheers,
-roger

> Peter
> 
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
>> ---
>>   drivers/usb/gadget/function/f_tcm.c | 20 ++++++++++++++------
>>   include/linux/usb/gadget.h          |  2 ++
>>   2 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
>> index 36504931b2d1..a78d5fad3d84 100644
>> --- a/drivers/usb/gadget/function/f_tcm.c
>> +++ b/drivers/usb/gadget/function/f_tcm.c
>> @@ -213,7 +213,8 @@ static int bot_send_read_response(struct usbg_cmd *cmd)
>>   	}
>>   
>>   	if (!gadget->sg_supported) {
>> -		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC);
>> +		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC |
>> +					gadget->dma_flag);
>>   		if (!cmd->data_buf)
>>   			return -ENOMEM;
>>   
>> @@ -257,7 +258,8 @@ static int bot_send_write_request(struct usbg_cmd *cmd)
>>   	}
>>   
>>   	if (!gadget->sg_supported) {
>> -		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_KERNEL);
>> +		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_KERNEL |
>> +					gadget->dma_flag);
>>   		if (!cmd->data_buf)
>>   			return -ENOMEM;
>>   
>> @@ -305,6 +307,7 @@ static void bot_cmd_complete(struct usb_ep *ep, struct usb_request *req)
>>   static int bot_prepare_reqs(struct f_uas *fu)
>>   {
>>   	int ret;
>> +	struct usb_gadget *gadget = fuas_to_gadget(fu);
>>   
>>   	fu->bot_req_in = usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
>>   	if (!fu->bot_req_in)
>> @@ -327,7 +330,8 @@ static int bot_prepare_reqs(struct f_uas *fu)
>>   	fu->bot_status.req->complete = bot_status_complete;
>>   	fu->bot_status.csw.Signature = cpu_to_le32(US_BULK_CS_SIGN);
>>   
>> -	fu->cmd.buf = kmalloc(fu->ep_out->maxpacket, GFP_KERNEL);
>> +	fu->cmd.buf = kmalloc(fu->ep_out->maxpacket, GFP_KERNEL |
>> +				gadget->dma_flag);
>>   	if (!fu->cmd.buf)
>>   		goto err_buf;
>>   
>> @@ -515,7 +519,8 @@ static int uasp_prepare_r_request(struct usbg_cmd *cmd)
>>   	struct uas_stream *stream = cmd->stream;
>>   
>>   	if (!gadget->sg_supported) {
>> -		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC);
>> +		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC |
>> +					gadget->dma_flag);
>>   		if (!cmd->data_buf)
>>   			return -ENOMEM;
>>   
>> @@ -763,11 +768,13 @@ static int uasp_alloc_stream_res(struct f_uas *fu, struct uas_stream *stream)
>>   
>>   static int uasp_alloc_cmd(struct f_uas *fu)
>>   {
>> +	struct usb_gadget *gadget = fuas_to_gadget(fu);
>>   	fu->cmd.req = usb_ep_alloc_request(fu->ep_cmd, GFP_KERNEL);
>>   	if (!fu->cmd.req)
>>   		goto err;
>>   
>> -	fu->cmd.buf = kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL);
>> +	fu->cmd.buf = kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL |
>> +				gadget->dma_flag);
>>   	if (!fu->cmd.buf)
>>   		goto err_buf;
>>   
>> @@ -980,7 +987,8 @@ static int usbg_prepare_w_request(struct usbg_cmd *cmd, struct usb_request *req)
>>   	struct usb_gadget *gadget = fuas_to_gadget(fu);
>>   
>>   	if (!gadget->sg_supported) {
>> -		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC);
>> +		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC |
>> +					gadget->dma_flag);
>>   		if (!cmd->data_buf)
>>   			return -ENOMEM;
>>   
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index 124462d65eac..d6c9cd222600 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -373,6 +373,7 @@ struct usb_gadget_ops {
>>    * @connected: True if gadget is connected.
>>    * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
>>    *	indicates that it supports LPM as per the LPM ECN & errata.
>> + * @dma_flag: dma zone to be used for buffer allocation.
>>    *
>>    * Gadgets have a mostly-portable "gadget driver" implementing device
>>    * functions, handling all usb configurations and interfaces.  Gadget
>> @@ -427,6 +428,7 @@ struct usb_gadget {
>>   	unsigned			deactivated:1;
>>   	unsigned			connected:1;
>>   	unsigned			lpm_capable:1;
>> +	unsigned int			dma_flag;
>>   };
>>   #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
>>   
>> -- 
>> 2.20.1
>>
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
