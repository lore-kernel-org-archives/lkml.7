Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C34C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAD92077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556348308;
	bh=yfBMiPcLMy+O1uEvfH/c7VJUQlhkmumHM2EmB6C/bXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=US7utMJkvyy+wgla1HZBWsaVZIl49TtOJwGFwOXz0sdExM1zF/znoY65VFBmkMTGz
	 CETrMw1k/XUJzP+84k9kG0h3UL5mnYr/EC+DwIDbJaZUsv1/ja1J7i7yOEFCSMQUVV
	 vDbSb0I2tjhgEFXF3LEA/rQVxs+v0pdp4OhqMYIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfD0G61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfD0G61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:58:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF122077B;
        Sat, 27 Apr 2019 06:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556348306;
        bh=yfBMiPcLMy+O1uEvfH/c7VJUQlhkmumHM2EmB6C/bXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDLDF9e7hF/cpX2j78ECujCKlaXxrfIox15ycN2/Unb67ptThnoRWFzzGnwO2fnEh
         O3I8pEUYRMOK81Y0X+gxIIK52TDIg3y5HX9KPZL7EsVOup2quHCk6+0bWxH8qD1CxL
         qRV5zH5E4D4E+YASVyKgotfEgm0jOle1qC8QhOdU=
Date:   Sat, 27 Apr 2019 08:58:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: hub:Extend usb_hub_clear_tt_buffer parameter
Message-ID: <20190427065823.GC28250@kroah.com>
References: <1556290206-9393-1-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556290206-9393-1-git-send-email-jilin@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:50:06PM +0800, Jim Lin wrote:
> Extend usb_hub_clear_tt_buffer parameter to specify device number
> that will have the TT state of its hub cleared.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
>  drivers/usb/core/hub.c  | 5 +++--
>  include/linux/usb/hcd.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 15a2934dc29d..4dec054c9776 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -840,6 +840,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
>  /**
>   * usb_hub_clear_tt_buffer - clear control/bulk TT state in high speed hub
>   * @urb: an URB associated with the failed or incomplete split transaction
> + * @devnum : device number that will have the TT state of its hub cleared
>   *
>   * High speed HCDs use this to tell the hub driver that some split control or
>   * bulk transaction failed in a way that requires clearing internal state of
> @@ -851,7 +852,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
>   *
>   * Return: 0 if successful. A negative error code otherwise.
>   */
> -int usb_hub_clear_tt_buffer(struct urb *urb)
> +int usb_hub_clear_tt_buffer(struct urb *urb, int devnum)
>  {
>  	struct usb_device	*udev = urb->dev;
>  	int			pipe = urb->pipe;
> @@ -873,7 +874,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
>  	/* info that CLEAR_TT_BUFFER needs */
>  	clear->tt = tt->multi ? udev->ttport : 1;
>  	clear->devinfo = usb_pipeendpoint (pipe);
> -	clear->devinfo |= udev->devnum << 4;
> +	clear->devinfo |= devnum << 4;
>  	clear->devinfo |= usb_pipecontrol(pipe)
>  			? (USB_ENDPOINT_XFER_CONTROL << 11)
>  			: (USB_ENDPOINT_XFER_BULK << 11);
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 695931b03684..01720f1f7d62 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -559,7 +559,7 @@ struct usb_tt_clear {
>  	struct usb_host_endpoint	*ep;
>  };
>  
> -extern int usb_hub_clear_tt_buffer(struct urb *urb);
> +extern int usb_hub_clear_tt_buffer(struct urb *urb, int devnum);
>  extern void usb_ep0_reinit(struct usb_device *);
>  
>  /* (shifted) direction/type/recipient from the USB 2.0 spec, table 9.2 */
> -- 
> 2.1.4

You just broke the build with this patch.  No individual patch can ever
do that, they all have to be stand-alone.

Also, when you send a patch series, please make it such that they are
"linked" together.  git send-email does this automatically, I don't know
how you sent these, but it did not work that way :(

Also, always use scripts/get_maintainer.pl to determine who to send the
patches to.  You missed all of the maintainers and developers who need
to review your patches :(

sorry,

greg k-h
