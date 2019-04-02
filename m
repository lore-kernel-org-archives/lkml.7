Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FCAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1D9208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfDBKCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:02:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfDBKCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:02:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA60615AD;
        Tue,  2 Apr 2019 03:02:43 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A9393F59C;
        Tue,  2 Apr 2019 03:02:42 -0700 (PDT)
Subject: Re: [PATCH] usb: xhci: inherit dma_mask from bus if set correctly
To:     Pankaj Dubey <pankaj.dubey@samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        jingoohan1@gmail.com, krzk@kernel.org, mgautam@codeaurora.org,
        felipe.balbi@linux.intel.com, Sriram Dash <sriram.dash@samsung.com>
References: <CGME20190402094246epcas1p1f43795d840b4c3a1f7efddc0523b2c89@epcas1p1.samsung.com>
 <1554198011-24342-1-git-send-email-pankaj.dubey@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0d3e8992-06e1-57e4-edd5-ba230caaa189@arm.com>
Date:   Tue, 2 Apr 2019 11:02:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554198011-24342-1-git-send-email-pankaj.dubey@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 10:40, Pankaj Dubey wrote:
> From: Sriram Dash <sriram.dash@samsung.com>
> 
> The xhci forcefully converts the dma_mask to either 64 or 32 and the
> dma-mask set by the bus is somewhat ignored. If the platform  sets the
> correct dma_mask, then respect that.

It's expected for dma_mask to be larger than bus_dma_mask if the latter 
is set - conceptually, the device mask represents what the device is 
inherently capable of, while the bus mask represents external 
interconnect restrictions which individual drivers should not have to 
care about. The DMA API backend should take care of combining the two to 
find the intersection. Are you seeing an actual problem here, and if so 
on which platform? (If the bus mask is set at all then it wouldn't seem 
to be the DT PCI issue that I'm still trying to fix).

Robin.

> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> ---
>   drivers/usb/host/xhci.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 005e659..55cf89e 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5119,6 +5119,16 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>   		dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>   	}
>   
> +	/*
> +	 * A platform may require coherent masks other than 64/32 bit, and we
> +	 * should respect that. If the firmware has already requested for a
> +	 * dma-range, we inherit the dma_mask presuming the platform knows
> +	 * what it is doing.
> +	 */
> +
> +	if (dev->bus_dma_mask)
> +		dma_set_mask_and_coherent(dev, dev->bus_dma_mask);
> +
>   	xhci_dbg(xhci, "Calling HCD init\n");
>   	/* Initialize HCD and host controller data structures. */
>   	retval = xhci_init(hcd);
> 
