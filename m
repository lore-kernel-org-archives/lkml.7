Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C6BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB81120665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565721299;
	bh=tHst/Kq9eYMCjaozC3wCdlJ+OCyQ524uuDHDBVOvfdQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=wdSHXjFWWTK87Wm9xCbIP+eIdiAOgrbL8CPtqUSZzgwMa4n59bdCoiK8ZlUAnYpGJ
	 KJGKfmpS2hsmeafGGKVfaJP9e5h/zQzCvfEYMoLh1Imo78pttTjZb/MIEdi5M8dLF5
	 z+QplUeeXDDBImb/iN9t2743Y1BGyq65yEnURomE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfHMSe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfHMSe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:34:58 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F29120665;
        Tue, 13 Aug 2019 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565721297;
        bh=tHst/Kq9eYMCjaozC3wCdlJ+OCyQ524uuDHDBVOvfdQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dJvR0hQCSDUCA4sNDK3nnDtfPfv7lzgE8feZLkhRWZXXPh2BTAS/F7b9S4eUmKgyC
         JZ++bCJO2Y6an4J/+O/bFPk7OciaEgwAsbVBP+zeL0n3zGbh4opAnlXofW6YbqgyP4
         uWktzSTv/YVEo9RKzbp3pI40e2DOtAR/thntScoU=
Subject: Re: [PATCH v5 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190808155435.10050-1-suwan.kim027@gmail.com>
 <20190808155435.10050-2-suwan.kim027@gmail.com>
 <d9359f3c-ca4c-6eab-5238-0013f8bb4dbb@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <a20e5721-d1ff-ab17-d4bb-ceae5829e647@kernel.org>
Date:   Tue, 13 Aug 2019 12:34:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d9359f3c-ca4c-6eab-5238-0013f8bb4dbb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 10:18 AM, shuah wrote:
> On 8/8/19 9:54 AM, Suwan Kim wrote:
>> vhci doesn’t do DMA for remote device. Actually, the real DMA
>> operation is done by network card driver. vhci just passes virtual
>> address of the buffer to the network stack, so vhci doesn’t use and
>> need dma address of the buffer of the URB.
>>
>> But HCD provides DMA mapping and unmapping function by default.
>> Moreover, it causes unnecessary DMA mapping and unmapping which
>> will be done again at the NIC driver and it wastes CPU cycles.
>> So, implement map_urb_for_dma and unmap_urb_for_dma function for
>> vhci in order to skip the DMA mapping and unmapping procedure.
>>
>> When it comes to supporting SG for vhci, it is useful to use native
>> SG list (urb->num_sgs) instead of mapped SG list because DMA mapping
>> fnuction can adjust the number of SG list (urb->num_mapped_sgs).
>> And vhci_map_urb_for_dma() prevents isoc pipe from using SG as
>> hcd_map_urb_for_dma() does.
>>
>> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
>> ---
>> v4 - v5
>> - Replace pr_err() with dev_err() in the error path.
>>
>> v3 - v4
>> - Replace WARN_ON() with pr_err() in the error path.
>>
>> v2 - v3
>> - Move setting URB_DMA_MAP_SG flag to the patch 2.
>> - Prevent isoc pipe from using SG buffer.
>>
>> v1 - v2
>> - Add setting URB_DMA_MAP_SG flag in urb->transfer_flags to tell
>> stub driver to use SG buffer.
>> ---
>>   drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>> index 000ab7225717..ea82b932a2f9 100644
>> --- a/drivers/usb/usbip/vhci_hcd.c
>> +++ b/drivers/usb/usbip/vhci_hcd.c
>> @@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd 
>> *hcd, struct usb_device *udev,
>>       return 0;
>>   }
>> +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>> +                gfp_t mem_flags)
>> +{
>> +    if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
>> +        dev_err(&urb->dev->dev, "SG is not supported for isochronous 
>> transfer\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void vhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
>> +{
>> +    dev_dbg(hcd->self.controller, "vhci does not unmap urb for dma\n");
>> +}
>> +
>>   static const struct hc_driver vhci_hc_driver = {
>>       .description    = driver_name,
>>       .product_desc    = driver_desc,
>> @@ -1304,6 +1320,9 @@ static const struct hc_driver vhci_hc_driver = {
>>       .get_frame_number = vhci_get_frame_number,
>> +    .map_urb_for_dma = vhci_map_urb_for_dma,
>> +    .unmap_urb_for_dma = vhci_unmap_urb_for_dma,
>> +
>>       .hub_status_data = vhci_hub_status,
>>       .hub_control    = vhci_hub_control,
>>       .bus_suspend    = vhci_bus_suspend,
>>
> 
> Looks good to me.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Greg!

Please pick this one up.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

