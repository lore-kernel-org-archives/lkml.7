Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91021C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5494E20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578493714;
	bh=VP0m4Z4aLOD37bc50GkxAFfmTbYNBzLxyFi0JDRvWww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kJZaUV2p/aW0Yc1/Tn8kz8R3sVZJFqv/6RIR/PxeKGPSfjn7+Tr0Fd7jYtFSYj3ty
	 OM37Tm2jUunpqKexm2gAMBX//6I1ZqXMCZJEF4FocGMNowscK6xSQ2/QyWoSatgpv0
	 fqOVnGWXRhOqmdwpnNrl+2/zflUcPZdpYws7MD9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgAHO2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgAHO2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:28:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3598020692;
        Wed,  8 Jan 2020 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578493711;
        bh=VP0m4Z4aLOD37bc50GkxAFfmTbYNBzLxyFi0JDRvWww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyhNnsd8Q0GP/tcLlxkNWJ79/Zsem2GkAX6/KNWYVBQyS3NgeKHsA/gjFNkvLmOgg
         N/Wdny/T4SUpR1/w3ZdKl4BKSffxhRL9ZgKrgBJKwzVHxOpPaJElJiBByj4lcYYiXP
         nK4cjNeCC0tbf0hi2DVFBWZEjpL0pA960IHLFRl0=
Date:   Wed, 8 Jan 2020 15:28:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     felipe.balbi@linux.intel.com, rogerq@ti.com, jbergsagel@ti.com,
        nsekhar@ti.com, nm@ti.com, linux-kernel@vger.kernel.org,
        jpawar@cadence.com, kurahul@cadence.com, sparmar@cadence.com,
        Peter Chan <peter.chan@nxp.com>
Subject: Re: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Message-ID: <20200108142829.GB2383861@kroah.com>
References: <20200108113719.21551-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108113719.21551-1-pawell@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 12:37:18PM +0100, Pawel Laszczak wrote:
> The ARM core hang when access USB register after tens of thousands
> connect/disconnect operation.
> 
> The issue was observed on platform with android system and is not easy
> to reproduce. During test controller works at HS device mode with host
> connected.
> 
> The test is based on continuous disabling/enabling USB device function
> what cause continuous setting DEVDS/DEVEN bit in USB_CONF register.
> 
> For testing was used composite device consisting from ADP and RNDIS
> function.
> 
> Presumably the problem was caused by DMA transfer made after setting
> DEVDS bit. To resolve this issue fix stops all DMA transfer before
> setting DEVDS bit.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Peter Chan <peter.chan@nxp.com>
> Reported-by: Peter Chan <peter.chan@nxp.com>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")

As this is in the 5.4 kernel release, you should have a "Cc: stable..."
line in here, right?

> ---
>  drivers/usb/cdns3/gadget.c | 84 ++++++++++++++++++++++++++------------
>  drivers/usb/cdns3/gadget.h |  1 +
>  2 files changed, 58 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 4c1e75509303..277ed8484032 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -1516,6 +1516,49 @@ static int cdns3_ep_onchip_buffer_reserve(struct cdns3_device *priv_dev,
>  	return 0;
>  }
>  
> +static int cdns3_disable_reset_ep(struct cdns3_device *priv_dev,
> +				  struct cdns3_endpoint *priv_ep)
> +{
> +	unsigned long flags;
> +	u32 val;
> +	int ret;
> +
> +	spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +	if (priv_ep->flags & EP_HW_RESETED) {

Is "reseted" a word?  :)

> +		spin_unlock_irqrestore(&priv_dev->lock, flags);
> +		return 0;
> +	}
> +
> +	cdns3_select_ep(priv_dev, priv_ep->endpoint.desc->bEndpointAddress);
> +
> +	val = readl(&priv_dev->regs->ep_cfg);
> +	val &= ~EP_CFG_ENABLE;
> +	writel(val, &priv_dev->regs->ep_cfg);
> +
> +	/**

No need for kernel-doc comment style please.

> +	 * Driver needs some time before resetting endpoint.
> +	 * It need waits for clearing DBUSY bit or for timeout expired.
> +	 * 10us is enough time for controller to stop transfer.
> +	 */
> +	readl_poll_timeout_atomic(&priv_dev->regs->ep_sts, val,
> +				  !(val & EP_STS_DBUSY), 1, 10);

You don't care if you time out?

> +	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> +
> +	ret = readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
> +					!(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
> +					1, 1000);
> +
> +	if (unlikely(ret))

Unless you can measure the difference of using/not using a
unlikely/likely mark, NEVER use it.  The compiler and cpu can almost
always do better than you can, we have the tests to prove it.

> +		dev_err(priv_dev->dev, "Timeout: %s resetting failed.\n",
> +			priv_ep->name);
> +
> +	priv_ep->flags |= EP_HW_RESETED;

So an error happens, but you still claim the device is reset?  What can
a user do about this error?

Yes, I know you copied this from other code in this driver, but it
doesn't look right to me.

> +	spin_unlock_irqrestore(&priv_dev->lock, flags);

Why print while a spinlock is held?  That's mean, you could have printed
here, right?

> +
> +	return ret;
> +}
> +
>  void cdns3_configure_dmult(struct cdns3_device *priv_dev,
>  			   struct cdns3_endpoint *priv_ep)
>  {
> @@ -1893,8 +1936,6 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
>  	struct usb_request *request;
>  	unsigned long flags;
>  	int ret = 0;
> -	u32 ep_cfg;
> -	int val;
>  
>  	if (!ep) {
>  		pr_err("usbss: invalid parameters\n");
> @@ -1908,32 +1949,11 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
>  			  "%s is already disabled\n", priv_ep->name))
>  		return 0;
>  
> -	spin_lock_irqsave(&priv_dev->lock, flags);
> -
>  	trace_cdns3_gadget_ep_disable(priv_ep);
>  
> -	cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
> -
> -	ep_cfg = readl(&priv_dev->regs->ep_cfg);
> -	ep_cfg &= ~EP_CFG_ENABLE;
> -	writel(ep_cfg, &priv_dev->regs->ep_cfg);
> -
> -	/**
> -	 * Driver needs some time before resetting endpoint.
> -	 * It need waits for clearing DBUSY bit or for timeout expired.
> -	 * 10us is enough time for controller to stop transfer.
> -	 */
> -	readl_poll_timeout_atomic(&priv_dev->regs->ep_sts, val,
> -				  !(val & EP_STS_DBUSY), 1, 10);
> -	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> -
> -	readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
> -				  !(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
> -				  1, 1000);
> -	if (unlikely(ret))
> -		dev_err(priv_dev->dev, "Timeout: %s resetting failed.\n",
> -			priv_ep->name);
> +	cdns3_disable_reset_ep(priv_dev, priv_ep);
>  
> +	spin_lock_irqsave(&priv_dev->lock, flags);
>  	while (!list_empty(&priv_ep->pending_req_list)) {
>  		request = cdns3_next_request(&priv_ep->pending_req_list);
>  
> @@ -1962,6 +1982,7 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
>  
>  	ep->desc = NULL;
>  	priv_ep->flags &= ~EP_ENABLED;
> +	priv_ep->flags |= EP_CLAIMED | EP_HW_RESETED;

Why do you now set EP_CLAIMED here when you never set that before?  Is
this a different type of change?

thanks,

greg k-h
