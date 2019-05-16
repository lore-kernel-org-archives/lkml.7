Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767F1C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B9A2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfEPO4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:56:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40114 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727464AbfEPO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:56:04 -0400
Received: (qmail 2248 invoked by uid 2102); 16 May 2019 10:56:02 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 May 2019 10:56:02 -0400
Date:   Thu, 16 May 2019 10:56:02 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jim Lin <jilin@nvidia.com>
cc:     gregkh@linuxfoundation.org, <mathias.nyman@intel.com>,
        <kai.heng.feng@canonical.com>, <drinkcat@chromium.org>,
        <keescook@chromium.org>, <nsaenzjulienne@suse.de>,
        <jflat@chromium.org>, <malat@debian.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/2] usb: xhci : Add devaddr in struct usb_device
In-Reply-To: <1558017657-13835-2-git-send-email-jilin@nvidia.com>
Message-ID: <Pine.LNX.4.44L0.1905161054250.1280-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019, Jim Lin wrote:

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

Aside from the "xhci:" part of the Subject line (it's not really 
appropriate because this is a modification of the USB core more than of 
the xhci-hcd driver),

Acked-by: Alan Stern <stern@rowland.harvard.edu>


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
> v10 Initialize devaddr in xhci_setup_device()
>     Move devaddr to be below "u8 level"
> 
>  drivers/usb/core/hub.c  | 4 +++-
>  drivers/usb/host/xhci.c | 1 +
>  include/linux/usb.h     | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)
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
>  }
>  
>  static void hub_free_dev(struct usb_device *udev)
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 7fa58c99f126..68b393e5a453 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4096,6 +4096,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
>  	/* Zero the input context control for later use */
>  	ctrl_ctx->add_flags = 0;
>  	ctrl_ctx->drop_flags = 0;
> +	udev->devaddr = (u8)(le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK);
>  
>  	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
>  		       "Internal device address = %d",
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 4229eb74bd2c..af68e31118f8 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -580,6 +580,7 @@ struct usb3_lpm_parameters {
>   * @bus_mA: Current available from the bus
>   * @portnum: parent port number (origin 1)
>   * @level: number of USB hub ancestors
> + * @devaddr: device address, XHCI: assigned by HW, others: same as devnum
>   * @can_submit: URBs may be submitted
>   * @persist_enabled:  USB_PERSIST enabled for this device
>   * @have_langid: whether string_langid is valid
> @@ -663,6 +664,7 @@ struct usb_device {
>  	unsigned short bus_mA;
>  	u8 portnum;
>  	u8 level;
> +	u8 devaddr;
>  
>  	unsigned can_submit:1;
>  	unsigned persist_enabled:1;
> 

