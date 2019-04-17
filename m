Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77959C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0EF2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbfDQRxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:53:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41305 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbfDQRxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:53:06 -0400
Received: by mail-io1-f66.google.com with SMTP id v10so21325748iom.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbtnPlxJZO76Uoisj8kOzOCBVlHzykfVfXh/H8Jfi80=;
        b=hl0IXEeUhyCvdxzwZsTA/CD64LoaEFDOMd9xzXCT90U+5cFuUqFGss3DdShQL3+wFz
         F7CAxlU4u2McusT9p11npOf4OQzkczcWcLlfjxzq2lQL6NTMqWKNwOOtvQXNlR0BKyFi
         ILYnMQ0jY0Ge04SXWlGxZQ03Z8vAVsmJbQlzmP13C8NaIWb41ddPf9tx3vEoc76vrj6G
         llcc3u+e5+jHL7BXFm8rPqsJROD0OoiBick3jYL08KIx9gje5NYc9+nfp4APPlH3yotI
         49uj6qoC8/Fd5k/uaEMogh7b3W9ODIK4QB+5Rv/oACagfJZm6zCVXm/wUFYvGv11qRNZ
         wZoA==
X-Gm-Message-State: APjAAAXMKMYgv/2CMoYRfzm9v14jykBO7OTvytVQ1LZ5yrFVbxojWqtY
        iCGeMJS4v6IxYQzhplPaLWLWDQ==
X-Google-Smtp-Source: APXvYqwsMgM4hUvyypV1LfcRz36DAWroNn894iMVzSfnpSnQQOscNbCBOztBHkqMJS3u6eeUfU7xlg==
X-Received: by 2002:a5e:981a:: with SMTP id s26mr56204649ioj.90.1555523585535;
        Wed, 17 Apr 2019 10:53:05 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id k201sm1566495itb.10.2019.04.17.10.53.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 10:53:04 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:53:00 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, groeck@chromium.org, oneukum@suse.com,
        djkurtz@chromium.org, zwisler@chromium.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Torokhov <dtor@chromium.org>,
        Suwan Kim <suwan.kim027@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH v2] usb/hcd: Send a uevent signaling that the host
 controller has died
Message-ID: <20190417175300.GA74282@google.com>
References: <20190411185211.235940-1-rrangel@chromium.org>
 <20190416095429.GC896@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416095429.GC896@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:54:29AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 11, 2019 at 12:52:11PM -0600, Raul E Rangel wrote:
> > This change will send a CHANGE event to udev with the DEAD environment
> > variable set when the HC dies. I chose this instead of any of the other
> > udev events because it's representing a state change in the host
> > controller. The only other event that might have fit was OFFLINE, but
> > that seems to be used for hot-removal and it implies the device could
> > come ONLINE again.
> 
> Is "DEAD" used by any other uevents?
No, I wasn't able to find any other events that notify when the host
controller has died.
> 
> > By notifying user space the appropriate policies can be applied.
> > i.e.,
> >  * Collect error logs.
> >  * Notify the user that USB is no longer functional.
> >  * Perform a graceful reboot.
> 
> What userspace code uses this new uevent to do any of this?
On ChromeOS we have an error reporter that listens for hardware errors:
https://chromium-review.googlesource.com/c/chromiumos/platform2/+/1560170
Though not implemented yet, I also  want to notify the user that USB is no
longer functional and they should restart.

> 
> I think "OFFLINE" is a bit better here, it does not always imply that it
> can come online again.

How about OFFLINE with ERROR=DEAD? I would like to report the problem,
but I'm OK if you want to just stick with OFFLINE.

> 
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > I wasn't able to find any good examples of other drivers sending a dead
> > notification.
> > 
> > Use an EVENT= format
> > https://github.com/torvalds/linux/blob/master/drivers/acpi/dock.c#L302
> > https://github.com/torvalds/linux/blob/master/drivers/net/wireless/ath/wil6210/interrupt.c#L497
> > 
> > Uses SDEV_MEDIA_CHANGE=
> > https://github.com/torvalds/linux/blob/master/drivers/scsi/scsi_lib.c#L2318
> > 
> > Uses ERROR=1.
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/7f6d8aec5803aac44192f03dce5637b66cda7abf/drivers/input/touchscreen/atmel_mxt_ts.c#1581
> > I'm not a fan because it doesn't signal what the error was.
> > 
> > We could change the DEAD=1 event to maybe ERROR=1?
> 
> "ERROR=1" is worse than "DEAD=1" :(
> 
> > Also where would be a good place to document this?
> 
> Documentation/ABI/ is a good start.
I'll add something to Documentation/ABI/testing/xhci-uevent
> 
> > Also thanks for the review. This is my first kernel patch so forgive me
> > if I get the workflow wrong.
> > 
> > Changes in v2:
> > - Check that the root hub still exists before sending the uevent.
> > - Ensure died_work has completed before deallocating.
> > 
> >  drivers/usb/core/hcd.c  | 32 ++++++++++++++++++++++++++++++++
> >  include/linux/usb/hcd.h |  1 +
> >  2 files changed, 33 insertions(+)
> > 
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index 975d7c1288e3..7835f1a3647d 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -2343,6 +2343,27 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
> >  	return status;
> >  }
> >  
> > +
> > +/**
> > + * hcd_died_work - Workqueue routine for root-hub has died.
> > + * @hcd: primary host controller for this root hub.
> > + *
> > + * Do not call with the shared_hcd.
> > + * */
> 
> No need for kerneldoc fortting for a static function.
> 
> And your documentation isn't even correct, @hcd is not an argument to
> this function :(
Oops! Apparently I never updated the documentation when I refactored
this to use a worker.
> 
> > +static void hcd_died_work(struct work_struct *work)
> > +{
> > +	struct usb_hcd *hcd = container_of(work, struct usb_hcd, died_work);
> > +
> > +	mutex_lock(&usb_bus_idr_lock);
> 
> Why do you need to lock something that is "dead"?  And why is the idr
> lock the correct one here?
We need to ensure that root_hub is not null. Though I'm not sure the
lock is entirely necessary in this case. usb_remove_hcd stops the work
item before it sets the rhdev to null. The reason I picked
usb_bus_idr_lock was because it's the same lock that usb_remove_hcd uses
when setting rhdev = NULL.

Alan, what do you think? Should I remove the lock?
> 
> > +
> > +	if (hcd->self.root_hub)
> > +		/* Notify user space that the host controller has died */
> > +		kobject_uevent_env(&hcd->self.root_hub->dev.kobj, KOBJ_CHANGE,
> > +				   (char *[]){ "DEAD=1", NULL });
> 
> declaring the envp in the function is cute, but please don't do that,
> make it obvious what is happening here with a real variable.
> 
I can do that.
> > +
> > +	mutex_unlock(&usb_bus_idr_lock);
> > +}
> > +
> >  /* Workqueue routine for root-hub remote wakeup */
> >  static void hcd_resume_work(struct work_struct *work)
> >  {
> > @@ -2488,6 +2509,13 @@ void usb_hc_died (struct usb_hcd *hcd)
> >  			usb_kick_hub_wq(hcd->self.root_hub);
> >  		}
> >  	}
> > +
> > +	/* Handle the case where this function gets called with a shared HCD */
> > +	if (usb_hcd_is_primary_hcd(hcd))
> > +		schedule_work(&hcd->died_work);
> > +	else
> > +		schedule_work(&hcd->primary_hcd->died_work);
> > +
> >  	spin_unlock_irqrestore (&hcd_root_hub_lock, flags);
> >  	/* Make sure that the other roothub is also deallocated. */
> >  }
> > @@ -2555,6 +2583,8 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
> >  	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
> >  #endif
> >  
> > +	INIT_WORK(&hcd->died_work, hcd_died_work);
> > +
> >  	hcd->driver = driver;
> >  	hcd->speed = driver->flags & HCD_MASK;
> >  	hcd->product_desc = (driver->product_desc) ? driver->product_desc :
> > @@ -2908,6 +2938,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> >  #ifdef CONFIG_PM
> >  	cancel_work_sync(&hcd->wakeup_work);
> >  #endif
> > +	cancel_work_sync(&hcd->died_work);
> >  	mutex_lock(&usb_bus_idr_lock);
> >  	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
> >  	mutex_unlock(&usb_bus_idr_lock);
> > @@ -2968,6 +2999,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
> >  #ifdef CONFIG_PM
> >  	cancel_work_sync(&hcd->wakeup_work);
> >  #endif
> > +	cancel_work_sync(&hcd->died_work);
> >  
> >  	mutex_lock(&usb_bus_idr_lock);
> >  	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
> > diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> > index 695931b03684..ae51d5bd1dfc 100644
> > --- a/include/linux/usb/hcd.h
> > +++ b/include/linux/usb/hcd.h
> > @@ -98,6 +98,7 @@ struct usb_hcd {
> >  #ifdef CONFIG_PM
> >  	struct work_struct	wakeup_work;	/* for remote wakeup */
> >  #endif
> > +	struct work_struct	died_work;	/* for dying */
> 
> "For when the device dies"?
Will do
> 
> And have you ever hit this in the real world?  If so, what can you do
> about it?

So I've encountered this in two real world situations:
1) There is a firmware bug in the AMD Device 7812 xHC where if a device
is disconnected during a SET_ADDRESS command, the controller will lock
up. The xHCI spec says that when SET_ADDRESS times out, the Command
Abort bit should be asserted to cancel the command.
Since the firmware doesn't respond to the CA bit in this situation,
the command abort times out and the controller is deemed dead. The only
way to get out of this situation is to reboot :( I have tried HCRST, but
that is ignored as well.

2) My workstation using a Lewisburg USB 3.0 xHCI Controller.
We have some USB devices we use for debugging and testing our DUTs.
Ever since upgrading our workstations from 4.18 to 4.19 we get the
following error:
xhci_hcd 0000:00:14.0: Mismatch between completed Set TR Deq Ptr command & xHCI internal state.
xhci_hcd 0000:00:14.0: ep deq seg = 000000000552b658, deq ptr = 000000004895b2f8
DMAR: DRHD: handling fault status reg 2
DMAR: [DMA Read] Request device [00:14.0] fault addr 0 [fault reason 06] PTE Read access is not set
xhci_hcd 0000:00:14.0: xHCI host not responding to stop endpoint command.
xhci_hcd 0000:00:14.0: xHCI host controller not responding, assume dead
xhci_hcd 0000:00:14.0: xHCI host not responding to stop endpoint command.
xhci_hcd 0000:00:14.0: HC died; cleaning up

In this situation we also need to reboot. I haven't spent anytime trying
to track down the problem.

> 
> thanks,

Thanks for the through review and comments. I'll get a new patch
uploaded soon.
> 
> greg k-h
