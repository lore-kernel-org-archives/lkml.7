Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C85CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86A92175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfEJOTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:19:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47712 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727825AbfEJOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:19:15 -0400
Received: (qmail 2193 invoked by uid 2102); 10 May 2019 10:19:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 May 2019 10:19:14 -0400
Date:   Fri, 10 May 2019 10:19:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jim Lin <jilin@nvidia.com>
cc:     gregkh@linuxfoundation.org, <mathias.nyman@intel.com>,
        <kai.heng.feng@canonical.com>, <drinkcat@chromium.org>,
        <keescook@chromium.org>, <nsaenzjulienne@suse.de>,
        <jflat@chromium.org>, <malat@debian.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] usb: hub : Add devaddr in struct usb_device
In-Reply-To: <1557491070-24715-2-git-send-email-jilin@nvidia.com>
Message-ID: <Pine.LNX.4.44L0.1905101010100.1516-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019, Jim Lin wrote:

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
> v9: Use pahole to find place to put devaddr in struct usb_device.
>     Remove space between type cast and variable.
>     hub.c changed from v8
>     clear->devinfo |= (u16) (udev->devaddr << 4);
>     to 
>     clear->devinfo |= ((u16)udev->devaddr) << 4;
>     to solve a problem if devaddr is larger than 16.
> 
> 
>  drivers/usb/core/hub.c | 4 +++-
>  include/linux/usb.h    | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 15a2934dc29d..0d4b289be103 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -873,7 +873,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
>  	/* info that CLEAR_TT_BUFFER needs */
>  	clear->tt = tt->multi ? udev->ttport : 1;
>  	clear->devinfo = usb_pipeendpoint (pipe);
> -	clear->devinfo |= udev->devnum << 4;
> +	clear->devinfo |= ((u16)udev->devaddr) << 4;
>  	clear->devinfo |= usb_pipecontrol(pipe)
>  			? (USB_ENDPOINT_XFER_CONTROL << 11)
>  			: (USB_ENDPOINT_XFER_BULK << 11);
> @@ -2125,6 +2125,8 @@ static void update_devnum(struct usb_device *udev, int devnum)
>  	/* The address for a WUSB device is managed by wusbcore. */
>  	if (!udev->wusb)
>  		udev->devnum = devnum;
> +	if (!udev->devaddr)
> +		udev->devaddr = (u8)devnum;

Whether or not to put a space after the ')' in a typecast is a matter 
of personal choice; CodingStyle doesn't say anything about it.  Quite 
often the space is present.  IIRC, that is how K&R does it.  But it 
doesn't really matter.

>  }
>  
>  static void hub_free_dev(struct usb_device *udev)
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 4229eb74bd2c..5641965e44a1 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -566,6 +566,7 @@ struct usb3_lpm_parameters {
>   * @tt: Transaction Translator info; used with low/full speed dev, highspeed hub
>   * @ttport: device port on that tt hub
>   * @toggle: one bit for each endpoint, with ([0] = IN, [1] = OUT) endpoints
> + * @devaddr: device address, XHCI: assigned by HW, others: same as devnum
>   * @parent: our hub, unless we're the root
>   * @bus: bus we're part of
>   * @ep0: endpoint 0 data (default control pipe)
> @@ -643,6 +644,7 @@ struct usb_device {
>  	int		ttport;
>  
>  	unsigned int toggle[2];
> +	u8 devaddr;

This is another lousy place to put the new value.  A much better
position would be immediately after "u8 level".

>  	struct usb_device *parent;
>  	struct usb_bus *bus;

You should move into this patch the code added to xhci.c to assign
udev->devaddr.  Without it, this patch is incomplete: devaddr will not
contain the correct value for devices on a USB-3 bus.  And it doesn't
belong in the 2/2 patch -- that patch is all about making xhci-hcd call
usb_clear_tt_buffer().

Alan Stern

