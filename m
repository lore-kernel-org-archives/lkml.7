Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D435C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE0120825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfDOP4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:56:06 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:39620 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726785AbfDOP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:56:06 -0400
Received: (qmail 5451 invoked by uid 2102); 15 Apr 2019 11:56:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Apr 2019 11:56:05 -0400
Date:   Mon, 15 Apr 2019 11:56:05 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Raul E Rangel <rrangel@chromium.org>
cc:     USB list <linux-usb@vger.kernel.org>, <groeck@chromium.org>,
        Oliver Neukum <oneukum@suse.com>, <djkurtz@chromium.org>,
        <zwisler@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Suwan Kim <suwan.kim027@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] usb/hcd: Send a uevent signaling that the host
 controller has died
In-Reply-To: <20190411185211.235940-1-rrangel@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1904151152390.1575-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019, Raul E Rangel wrote:

> This change will send a CHANGE event to udev with the DEAD environment
> variable set when the HC dies. I chose this instead of any of the other
> udev events because it's representing a state change in the host
> controller. The only other event that might have fit was OFFLINE, but
> that seems to be used for hot-removal and it implies the device could
> come ONLINE again.
> 
> By notifying user space the appropriate policies can be applied.
> i.e.,
>  * Collect error logs.
>  * Notify the user that USB is no longer functional.
>  * Perform a graceful reboot.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> I wasn't able to find any good examples of other drivers sending a dead
> notification.
> 
> Use an EVENT= format
> https://github.com/torvalds/linux/blob/master/drivers/acpi/dock.c#L302
> https://github.com/torvalds/linux/blob/master/drivers/net/wireless/ath/wil6210/interrupt.c#L497
> 
> Uses SDEV_MEDIA_CHANGE=
> https://github.com/torvalds/linux/blob/master/drivers/scsi/scsi_lib.c#L2318
> 
> Uses ERROR=1.
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/7f6d8aec5803aac44192f03dce5637b66cda7abf/drivers/input/touchscreen/atmel_mxt_ts.c#1581
> I'm not a fan because it doesn't signal what the error was.
> 
> We could change the DEAD=1 event to maybe ERROR=1?
> 
> Also where would be a good place to document this?
> 
> Also thanks for the review. This is my first kernel patch so forgive me
> if I get the workflow wrong.
> 
> Changes in v2:
> - Check that the root hub still exists before sending the uevent.
> - Ensure died_work has completed before deallocating.
> 
>  drivers/usb/core/hcd.c  | 32 ++++++++++++++++++++++++++++++++
>  include/linux/usb/hcd.h |  1 +
>  2 files changed, 33 insertions(+)

Technically this patch looks okay to me.  However, Greg KH may have
some comments regarding the new uevent this introduces.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern


> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 975d7c1288e3..7835f1a3647d 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2343,6 +2343,27 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
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
> +	mutex_lock(&usb_bus_idr_lock);
> +
> +	if (hcd->self.root_hub)
> +		/* Notify user space that the host controller has died */
> +		kobject_uevent_env(&hcd->self.root_hub->dev.kobj, KOBJ_CHANGE,
> +				   (char *[]){ "DEAD=1", NULL });
> +
> +	mutex_unlock(&usb_bus_idr_lock);
> +}
> +
>  /* Workqueue routine for root-hub remote wakeup */
>  static void hcd_resume_work(struct work_struct *work)
>  {
> @@ -2488,6 +2509,13 @@ void usb_hc_died (struct usb_hcd *hcd)
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
> @@ -2555,6 +2583,8 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
>  	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
>  #endif
>  
> +	INIT_WORK(&hcd->died_work, hcd_died_work);
> +
>  	hcd->driver = driver;
>  	hcd->speed = driver->flags & HCD_MASK;
>  	hcd->product_desc = (driver->product_desc) ? driver->product_desc :
> @@ -2908,6 +2938,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  #ifdef CONFIG_PM
>  	cancel_work_sync(&hcd->wakeup_work);
>  #endif
> +	cancel_work_sync(&hcd->died_work);
>  	mutex_lock(&usb_bus_idr_lock);
>  	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
>  	mutex_unlock(&usb_bus_idr_lock);
> @@ -2968,6 +2999,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>  #ifdef CONFIG_PM
>  	cancel_work_sync(&hcd->wakeup_work);
>  #endif
> +	cancel_work_sync(&hcd->died_work);
>  
>  	mutex_lock(&usb_bus_idr_lock);
>  	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
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

