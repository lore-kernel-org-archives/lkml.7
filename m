Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511A2C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280D5218BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563827218;
	bh=rj/oDMHTdc2sn0j+S9jVqwOaKC+ElFvaZ+ApNh/+vt8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rXhsDOZHbSqPkyXMO75ccoEHeWOl8+AEX3w/Kha4UA0S5XYkkafx0Vy+tTHs98uJ5
	 XLjDzqsRySSpPaAHW6VMS4wDMqZfW3GP/gskhla0+XLmQN1MBvwCiTXRrwjUq8xW50
	 VHy34GEYkf/xHoF5sC25CZKOlayQjEJHGcJDrOag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfGVU04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbfGVU04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:26:56 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B32B218BE;
        Mon, 22 Jul 2019 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563827215;
        bh=rj/oDMHTdc2sn0j+S9jVqwOaKC+ElFvaZ+ApNh/+vt8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ywe94oQoJL0n6e8RNUPMtWMtTUnPYbUj8S1C5LmC740IA4NF1E885Xg2N6ogKXpKd
         HXKNoryVBZCx++kJL2C2gBNiCtHYJam+LnGGvUcEy6cDu15xboZauPL9bnSNSl3ENB
         bo3honQryvKcu7IIACy2b9VtkUVpfg80+B/0L3jQ=
Subject: Re: [PATCH v2 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <20190705164355.14025-2-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <d10b23b3-601d-c2c6-df2e-77b2ed9adc66@kernel.org>
Date:   Mon, 22 Jul 2019 14:26:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190705164355.14025-2-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suwan,

On 7/5/19 10:43 AM, Suwan Kim wrote:
> vhci doesn’t do DMA for remote device. Actually, the real DMA
> operation is done by network card driver. vhci just passes virtual
> address of the buffer to the network stack, so vhci doesn’t use and
> need dma address of the buffer of the URB.
> 
> When it comes to supporting SG for vhci, it is useful to use native
> SG list (urb->num_sgs) instead of mapped SG list because DMA mapping
> fnuction can adjust the number of SG list (urb->num_mapped_sgs).
> 
> But HCD provides DMA mapping and unmapping function by default.
> Moreover, it causes unnecessary DMA mapping and unmapping which
> will be done again at the NIC driver and it wastes CPU cycles.
> So, implement map_urb_for_dma and unmap_urb_for_dma function for
> vhci in order to skip the DMA mapping and unmapping procedure.
> 
> To support SG, vhci_map_urb_for_dma() sets URB_DMA_MAP_SG flag in
> urb->transfer_flags if URB has SG list and this flag will tell the
> stub driver to use SG list.
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>   drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 000ab7225717..14fc6d9f4e6a 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
>   	return 0;
>   }
>   
> +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> +			gfp_t mem_flags)
> +{
> +	dev_dbg(hcd->self.controller, "vhci does not map urb for dma\n");
> +
> +	if (urb->num_sgs)
> +		urb->transfer_flags |= URB_DMA_MAP_SG;
> +

Shouldn't this be part of patch 2. The debug message saying "no map"
and setting flag doesn't make sense.

> +       return 0;

This should be a tab and no spaces btw. chekpatch isn't happy.

> +}
> +
> +static void vhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
> +{
> +       dev_dbg(hcd->self.controller, "vhci does not unmap urb for dma\n");

This should be a tab and no spaces btw. chekpatch isn't happy.


WARNING: please, no spaces at the start of a line
#144: FILE: drivers/usb/usbip/vhci_hcd.c:1299:
+       return 0;$

WARNING: please, no spaces at the start of a line
#149: FILE: drivers/usb/usbip/vhci_hcd.c:1304:
+       dev_dbg(hcd->self.controller, "vhci does not unmap urb for dma\n");$

total: 0 errors, 2 warnings, 31 lines checked


> +}
> +
>   static const struct hc_driver vhci_hc_driver = {
>   	.description	= driver_name,
>   	.product_desc	= driver_desc,
> @@ -1304,6 +1320,9 @@ static const struct hc_driver vhci_hc_driver = {
>   
>   	.get_frame_number = vhci_get_frame_number,
>   
> +	.map_urb_for_dma = vhci_map_urb_for_dma,
> +	.unmap_urb_for_dma = vhci_unmap_urb_for_dma,
> +
>   	.hub_status_data = vhci_hub_status,
>   	.hub_control    = vhci_hub_control,
>   	.bus_suspend	= vhci_bus_suspend,
> 

thanks,
-- Shuah
