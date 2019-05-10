Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A08C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F952184C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557480671;
	bh=Xv9qGx06byI692xx7gyUH4Fmjwova5eTCKAm6zQru7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xM3p/cUQcLwj5+KXuTJex09f8YoF7QHqp03LnQhY9PW5UBT88avLUSb4haS3cWkZ7
	 rldbBvPlXzdrKySANr05ZScan7zC319rj7MYHfqYhA1hViAaT3nsoqnMIDtJ0//kDR
	 ONeogMZYJTLD7vAPac1xIvjlAowBJJVD7uP2xI6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfEJJbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfEJJbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:31:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010852053B;
        Fri, 10 May 2019 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557480668;
        bh=Xv9qGx06byI692xx7gyUH4Fmjwova5eTCKAm6zQru7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1vT9AhIcjR5HqN+iWmw6daLaLyvwZktiv0/C9Mj+u2sV0EC9tY1XLDAJvG/wVV7D
         QgKs8FJs7QUZbbmVdvsKWAP6hTEGShjkqBm1rrd2WGV7qjfjPVMVwhwgzJfiEhOaWJ
         P/ehENGk2b0JJRzHVzJSOIIIblIa2BpUR59F2kBU=
Date:   Fri, 10 May 2019 11:31:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        kai.heng.feng@canonical.com, drinkcat@chromium.org,
        keescook@chromium.org, nsaenzjulienne@suse.de, jflat@chromium.org,
        malat@debian.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] usb: hub : Add devaddr in struct usb_device
Message-ID: <20190510093105.GA9357@kroah.com>
References: <1557478937-30486-1-git-send-email-jilin@nvidia.com>
 <1557478937-30486-2-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557478937-30486-2-git-send-email-jilin@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 05:02:16PM +0800, Jim Lin wrote:
> The Clear_TT_Buffer request sent to the hub includes the address of
> the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
> uses udev->devnum to set the address wValue. This won't work for
> devices connected to xHC.
> 
> For other host controllers udev->devnum is the same as the address of
> the usb device, chosen and set by usb core. With xHC the controller
> hardware assigns the address, and won't be the same as devnum.
> 
> Here we add devaddr in "struct usb_device" for
> usb_hub_clear_tt_buffer() to use.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
>     , remove its claiming in xhci.h
> v3: Add description for clearing_tt (xhci.h)
> v4: Remove clearing_tt flag because hub_tt_work has hub->tt.lock
>     to protect for Clear_TT_Buffer to be run serially.
>     Remove xhci_clear_tt_buffer_complete as it's not necessary.
>     Same reason as the above.
>     Extend usb_hub_clear_tt_buffer parameter
> v5: Not extending usb_hub_clear_tt_buffer parameter
>     Add description.
> v6: Remove unused parameter slot_id from xhci_clear_hub_tt_buffer
> v7: Add devaddr field in "struct usb_device"
> v8: split as two patches, change type from int to u8 for devaddr.
> 
>  drivers/usb/core/hub.c | 4 +++-
>  include/linux/usb.h    | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 15a2934dc29d..078894023797 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -873,7 +873,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
>  	/* info that CLEAR_TT_BUFFER needs */
>  	clear->tt = tt->multi ? udev->ttport : 1;
>  	clear->devinfo = usb_pipeendpoint (pipe);
> -	clear->devinfo |= udev->devnum << 4;
> +	clear->devinfo |= (u16) (udev->devaddr << 4);
>  	clear->devinfo |= usb_pipecontrol(pipe)
>  			? (USB_ENDPOINT_XFER_CONTROL << 11)
>  			: (USB_ENDPOINT_XFER_BULK << 11);
> @@ -2125,6 +2125,8 @@ static void update_devnum(struct usb_device *udev, int devnum)
>  	/* The address for a WUSB device is managed by wusbcore. */
>  	if (!udev->wusb)
>  		udev->devnum = devnum;
> +	if (!udev->devaddr)
> +		udev->devaddr = (u8) devnum;

Checkpatch did not complain here?  Or above?  Please don't put a space
before the ) when casting.


>  }
>  
>  static void hub_free_dev(struct usb_device *udev)
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 4229eb74bd2c..db38c13a6b1d 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -565,6 +565,7 @@ struct usb3_lpm_parameters {
>   * @tx_lanes: number of tx lanes in use, USB 3.2 adds dual-lane support
>   * @tt: Transaction Translator info; used with low/full speed dev, highspeed hub
>   * @ttport: device port on that tt hub
> + * @devaddr: device address, XHCI: assigned by HW, others: same as devnum
>   * @toggle: one bit for each endpoint, with ([0] = IN, [1] = OUT) endpoints
>   * @parent: our hub, unless we're the root
>   * @bus: bus we're part of
> @@ -641,6 +642,7 @@ struct usb_device {
>  
>  	struct usb_tt	*tt;
>  	int		ttport;
> +	u8 devaddr;

That's some horrible variable alignment :(

Please use pahole to find a better place to put it.

thanks,

greg k-h
