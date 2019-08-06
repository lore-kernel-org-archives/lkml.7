Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE510C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0F92089E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565104307;
	bh=6UDrRhYrOs/0fVNeFUa7B2/tVmvKcooNzy/lwG+cCG0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=JpFGT4OMtwBSpaYICtQfx2d3v+G+J4JNZXp3xU52I37ki4VWQMwn3DzwcRUMWB0zJ
	 iCRi7N3Ty7DWZ5BNaRRiFwlpG+ptMYCV6b3zYPHfpN+KHltl2pwiq03mCCtKOu8Key
	 xkpAikUKdU5Xx86PSrzGmITs7ZQvybn6IfJwPldY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbfHFPLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFPLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:11:45 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCA9F2089E;
        Tue,  6 Aug 2019 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565104305;
        bh=6UDrRhYrOs/0fVNeFUa7B2/tVmvKcooNzy/lwG+cCG0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=k6IBJzQx9Arxu9foQUy+C1P4gaB9mQ07b842qiWcYyMDUu8gNQN6rq7QT9uRCAvCb
         8wEWWuGOGCTnGaGo3VBmag8BLg/EVF0Td+PCzKJ6fstT7C43cnYrGl8W0nztAj+aw4
         cCjlwkwKoMmSn8gmQFpAvOh3Y348vzvNBshV5wno=
Subject: Re: [PATCH v4 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190806123154.23798-1-suwan.kim027@gmail.com>
 <20190806123154.23798-2-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <c3485edd-f7e3-95a7-38db-acda371575a2@kernel.org>
Date:   Tue, 6 Aug 2019 09:11:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806123154.23798-2-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 6:31 AM, Suwan Kim wrote:
> vhci doesn’t do DMA for remote device. Actually, the real DMA
> operation is done by network card driver. vhci just passes virtual
> address of the buffer to the network stack, so vhci doesn’t use and
> need dma address of the buffer of the URB.
> 
> But HCD provides DMA mapping and unmapping function by default.
> Moreover, it causes unnecessary DMA mapping and unmapping which
> will be done again at the NIC driver and it wastes CPU cycles.
> So, implement map_urb_for_dma and unmap_urb_for_dma function for
> vhci in order to skip the DMA mapping and unmapping procedure.
> 
> When it comes to supporting SG for vhci, it is useful to use native
> SG list (urb->num_sgs) instead of mapped SG list because DMA mapping
> fnuction can adjust the number of SG list (urb->num_mapped_sgs).
> And vhci_map_urb_for_dma() prevents isoc pipe from using SG as
> hcd_map_urb_for_dma() does.
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
> v3 - v4:
> - Replace WARN_ON() with pr_err() in the error path.
> 
> v2 - v3
> - Move setting URB_DMA_MAP_SG flag to the patch 2.
> - Prevent isoc pipe from using SG buffer.
> 
> v1 - v2
> - Add setting URB_DMA_MAP_SG flag in urb->transfer_flags to tell
> stub driver to use SG buffer.
> ---
>   drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 000ab7225717..429e4e989f38 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
>   	return 0;
>   }
>   
> +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> +				gfp_t mem_flags)
> +{
> +	if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
> +		pr_err("SG is not supported for isochronous transfer\n");

Any reason to not use dev_err()?

Looks good otherwise.

thanks,
-- Shuah
