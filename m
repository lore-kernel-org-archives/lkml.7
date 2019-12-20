Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E46DC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE242465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfLTPsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:48:39 -0500
Received: from netrider.rowland.org ([192.131.102.5]:44493 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727270AbfLTPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:48:39 -0500
Received: (qmail 4678 invoked by uid 500); 20 Dec 2019 10:48:38 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Dec 2019 10:48:38 -0500
Date:   Fri, 20 Dec 2019 10:48:38 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     AceLan Kao <acelan.kao@canonical.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Harry Pan <harry.pan@intel.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: hub: move resume delay at the head of all USB access
 functions
In-Reply-To: <20191220025917.11886-1-acelan.kao@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1912201040000.2513-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019, AceLan Kao wrote:

> usb_control_msg() function should be called after the resume delay, or

Which usb_control_msg() call are you referring to?  Is it the call
under hub_port_status()?

> you'll encounter the below errors sometime.
> After the issue happens, have to re-plug the USB cable to recover.
> 
> [ 837.483573] hub 2-3:1.0: hub_ext_port_status failed (err = -71)
> [ 837.490889] hub 2-3:1.0: hub_ext_port_status failed (err = -71)
> [ 837.506780] usb 2-3-port4: cannot disable (err = -71)

You need to do a better job of figuring out why these errors occur.  It 
is not connected to the resume delay; there must be a different reason.
Hint: This is the sort of error you would expect to see if the kernel 
tried to resume a device while its parent hub was still suspended.

> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/usb/core/hub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index f229ad6952c0..2fb2816b0d38 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3522,6 +3522,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  		}
>  	}
>  
> +	msleep(USB_RESUME_TIMEOUT);

This makes no sense at all.  At this point we haven't even started to
do the resume signalling, so there's no reason to wait for it to 
finish.

>  	usb_lock_port(port_dev);
>  
>  	/* Skip the initial Clear-Suspend step for a remote wakeup */
> @@ -3544,7 +3545,6 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  		/* drive resume for USB_RESUME_TIMEOUT msec */
>  		dev_dbg(&udev->dev, "usb %sresume\n",
>  				(PMSG_IS_AUTO(msg) ? "auto-" : ""));
> -		msleep(USB_RESUME_TIMEOUT);

This is wrong also.  At this point the resume signal _is_ being sent, 
and the USB spec requires that we wait a minimum amount of time for the 
device to fully resume.

Alan Stern

