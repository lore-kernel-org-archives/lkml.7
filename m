Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C649EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A0F214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565017701;
	bh=pP2QV9RFikSg/QhS3JVeQ96q3EXCKWZuPOHE9VeEQNY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=KHzOXlP1qiolKH5rxolQHSStyt9aXggE2MiYmMnXXn5W0+9ckjlgFZ1kMI0fd9nLm
	 66VkX3lgoDyOi1+o28h8D/P8ptHjHPmXkhXPgDB827CBkY70FIPg2MG4HDdIU1nEfr
	 0OsnHJOxhBTrNRqTAMHVP9hO2JKhR0TgmAttCAm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfHEPIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbfHEPIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:08:20 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3148214C6;
        Mon,  5 Aug 2019 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017699;
        bh=pP2QV9RFikSg/QhS3JVeQ96q3EXCKWZuPOHE9VeEQNY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dkPlqTiVJR4OM905QzzFSSRjr3/Uxz+ktVrFmuv+aN0S6asPuCW4+3IWyFIX7FRGO
         hGVL/BqI2f1SNkrvob80iZePUX/TQy25TGkMewRLMx5QuCiScFbXFRS98WuE+uSPg6
         l7tGs5oslOQjt75LlNWg0yvFQZmlnEDTK3ic8rmY=
Subject: Re: [PATCH v3 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190802173651.22247-1-suwan.kim027@gmail.com>
 <20190802173651.22247-2-suwan.kim027@gmail.com>
 <c23b3ac1-68d9-bc1e-610b-955988e11055@kernel.org>
 <20190805052358.GA8904@localhost.localdomain>
From:   shuah <shuah@kernel.org>
Message-ID: <8ce7b60c-6075-54ac-a917-921cb41003e6@kernel.org>
Date:   Mon, 5 Aug 2019 09:08:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805052358.GA8904@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/19 11:23 PM, Suwan Kim wrote:
> On Fri, Aug 02, 2019 at 04:22:27PM -0600, shuah wrote:
>> On 8/2/19 11:36 AM, Suwan Kim wrote:
>>> vhci doesn’t do DMA for remote device. Actually, the real DMA
>>> operation is done by network card driver. vhci just passes virtual
>>> address of the buffer to the network stack, so vhci doesn’t use and
>>> need dma address of the buffer of the URB.
>>>
>>> But HCD provides DMA mapping and unmapping function by default.
>>> Moreover, it causes unnecessary DMA mapping and unmapping which
>>> will be done again at the NIC driver and it wastes CPU cycles.
>>> So, implement map_urb_for_dma and unmap_urb_for_dma function for
>>> vhci in order to skip the DMA mapping and unmapping procedure.
>>>
>>> When it comes to supporting SG for vhci, it is useful to use native
>>> SG list (urb->num_sgs) instead of mapped SG list because DMA mapping
>>> fnuction can adjust the number of SG list (urb->num_mapped_sgs).
>>> And vhci_map_urb_for_dma() prevents isoc pipe from using SG as
>>> hcd_map_urb_for_dma() does.
>>>
>>> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
>>> ---
>>>    drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>>> index 000ab7225717..c62f7fa8118c 100644
>>> --- a/drivers/usb/usbip/vhci_hcd.c
>>> +++ b/drivers/usb/usbip/vhci_hcd.c
>>> @@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
>>>    	return 0;
>>>    }
>>> +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>>> +		gfp_t mem_flags)
>>> +{
>>> +	if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
>>> +		WARN_ON(1);
>>
>> Don't add WARN_ON. I cleaned them all up recently and don't want new
>> ones added.
> 
> Ok. I will remove it and resend v4.
> 

Please add appropriate error message in place of WARN_ON

thanks,
-- Shuah

