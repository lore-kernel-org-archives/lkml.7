Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1CBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB24420717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565105938;
	bh=WSyjZn+YLypg21sFQeIjJZqQbHjw3ecOVTDeasZ6QE4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=NdpKGK020cKt2cxGHKuGsx1K1X6kWVAoJYXMW0DkSLCddAWPkfi7+eN2LQWwgpzZb
	 LaieHM2dp1c4pxm7RPsup/VVMcaaWdp2XRGrkKCASkr8qRwwh9QYMWLFZPnKcfHgaw
	 iCPFYbndtMk89Yo0fgW5W/AzZ3Xnz49yWq/FOjlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfHFPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfHFPi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:38:57 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D2CE20717;
        Tue,  6 Aug 2019 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565105935;
        bh=WSyjZn+YLypg21sFQeIjJZqQbHjw3ecOVTDeasZ6QE4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Chbn1UpOQSIkiQmbmfnz3vY2T8w8jfDOCzP60WH3GSv0NCvXaMV8z0zV9S+9hCPLM
         YiUjcVLXt0gPO43bEiCiabBpUk/0K+RcdnKhupjr7PerFPsJBW8hAraqI7RCqNfjZ8
         8aaNHzq1Fjl0qmJhFlOgNBRzmHjjZoYSaHQTbIj8=
Subject: Re: [PATCH v4 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190806123154.23798-1-suwan.kim027@gmail.com>
 <20190806123154.23798-2-suwan.kim027@gmail.com>
 <c3485edd-f7e3-95a7-38db-acda371575a2@kernel.org>
 <20190806153241.GA3738@localhost.localdomain>
From:   shuah <shuah@kernel.org>
Message-ID: <b5c6c9e5-0855-c055-6bb5-47dbc497f606@kernel.org>
Date:   Tue, 6 Aug 2019 09:38:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806153241.GA3738@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 9:32 AM, Suwan Kim wrote:
> On Tue, Aug 06, 2019 at 09:11:30AM -0600, shuah wrote:
>> On 8/6/19 6:31 AM, Suwan Kim wrote:
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
>>> v3 - v4:
>>> - Replace WARN_ON() with pr_err() in the error path.
>>>
>>> v2 - v3
>>> - Move setting URB_DMA_MAP_SG flag to the patch 2.
>>> - Prevent isoc pipe from using SG buffer.
>>>
>>> v1 - v2
>>> - Add setting URB_DMA_MAP_SG flag in urb->transfer_flags to tell
>>> stub driver to use SG buffer.
>>> ---
>>>    drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>>> index 000ab7225717..429e4e989f38 100644
>>> --- a/drivers/usb/usbip/vhci_hcd.c
>>> +++ b/drivers/usb/usbip/vhci_hcd.c
>>> @@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
>>>    	return 0;
>>>    }
>>> +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>>> +				gfp_t mem_flags)
>>> +{
>>> +	if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
>>> +		pr_err("SG is not supported for isochronous transfer\n");
>>
>> Any reason to not use dev_err()?
> 
> Because some codes in vhci_hcd.c use pr_err().There is no other
> reason. However, dev_err() seems more appropriate than pr_err().
> I will replace pr_err() with dev_err(urb->dev->dev, "SG is ...")
> Is it ok?
> 

Please. This way we will have the device information. pr_err()
won't us that. In general I prefer dev_* if dev is available in
the code path, which is the case here.

thanks,
-- Shuah

