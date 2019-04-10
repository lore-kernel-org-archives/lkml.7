Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06082C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF68220830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDJUy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:54:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50798 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726181AbfDJUy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:54:27 -0400
Received: (qmail 10261 invoked by uid 2102); 10 Apr 2019 16:54:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Apr 2019 16:54:26 -0400
Date:   Wed, 10 Apr 2019 16:54:26 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Raul E Rangel <rrangel@chromium.org>
cc:     linux-usb@vger.kernel.org, <groeck@chromium.org>,
        <djkurtz@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] usb/hcd: Send a uevent signaling that the host controller
 has died
In-Reply-To: <20190410203520.248158-1-rrangel@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1904101647170.1629-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019, Raul E Rangel wrote:

> This change will send a CHANGE event to udev with the DEAD environment
> variable set when the HC dies. I chose this instead of any of the other
> udev events because it's representing a state change in the host
> controller. The only other event that might have fit was OFFLINE, but
> that seems to be used for hot-removal.
> 
> By notifying user space the appropriate policies can be applied.
> e.g.,
>  * Collect error logs.
>  * Notify the user that USB is no longer functional.
>  * Perform a graceful reboot.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

One or two problems...  See below.

> ---
> 
>  drivers/usb/core/hcd.c  | 25 +++++++++++++++++++++++++
>  include/linux/usb/hcd.h |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 975d7c1288e3..b38ad9ce068b 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2343,6 +2343,22 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
>  	return status;
>  }
>  
> +
> +/**
> + * hcd_died_work - Workqueue routine for root-hub has died.
> + * @hcd: primary host controller for this root hub.
> + *
> + * Do not call with the shared_hcd.
> + * */
> +static void hcd_died_work(struct work_struct *work)
> +{
> +	struct usb_hcd *hcd = container_of(work, struct usb_hcd, died_work);
> +
> +	/* Notify user space that the host controller has died */
> +	kobject_uevent_env(&hcd->self.root_hub->dev.kobj, KOBJ_CHANGE,
> +			   (char *[]){ "DEAD=1", NULL });

How do you know that the root hub hasn't already been deallocated?

> +}
> +
>  /* Workqueue routine for root-hub remote wakeup */
>  static void hcd_resume_work(struct work_struct *work)
>  {
> @@ -2488,6 +2504,13 @@ void usb_hc_died (struct usb_hcd *hcd)
>  			usb_kick_hub_wq(hcd->self.root_hub);
>  		}
>  	}
> +
> +	/* Handle the case where this function gets called with a shared HCD */
> +	if (usb_hcd_is_primary_hcd(hcd))
> +		schedule_work(&hcd->died_work);
> +	else
> +		schedule_work(&hcd->primary_hcd->died_work);
> +
>  	spin_unlock_irqrestore (&hcd_root_hub_lock, flags);
>  	/* Make sure that the other roothub is also deallocated. */
>  }
> @@ -2555,6 +2578,8 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
>  	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
>  #endif
>  
> +	INIT_WORK(&hcd->died_work, hcd_died_work);
> +
>  	hcd->driver = driver;
>  	hcd->speed = driver->flags & HCD_MASK;
>  	hcd->product_desc = (driver->product_desc) ? driver->product_desc :

You forgot to ensure that this work entry won't still be pending when
the hcd structure is deallocated.

Alan Stern

> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 695931b03684..ae51d5bd1dfc 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -98,6 +98,7 @@ struct usb_hcd {
>  #ifdef CONFIG_PM
>  	struct work_struct	wakeup_work;	/* for remote wakeup */
>  #endif
> +	struct work_struct	died_work;	/* for dying */
>  
>  	/*
>  	 * hardware info/state
> 

