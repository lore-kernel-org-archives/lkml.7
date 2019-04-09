Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFA1C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F092084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfDIQpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:45:55 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46462 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726570AbfDIQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:45:54 -0400
Received: (qmail 4779 invoked by uid 2102); 9 Apr 2019 12:45:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Apr 2019 12:45:53 -0400
Date:   Tue, 9 Apr 2019 12:45:53 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Bart Van Assche <bvanassche@acm.org>
cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <Kento.A.Kobayashi@sony.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Oliver Neukum <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        <Jacky.Cao@sony.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
In-Reply-To: <1554823007.161891.6.camel@acm.org>
Message-ID: <Pine.LNX.4.44L0.1904091232370.1599-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019, Bart Van Assche wrote:

> On Tue, 2019-04-09 at 10:44 -0400, Alan Stern wrote:
> +AD4 On Mon, 8 Apr 2019, Martin K. Petersen wrote:
> +AD4 
> +AD4 +AD4 
> +AD4 +AD4 Alan,
> +AD4 +AD4 
> +AD4 +AD4 +AD4 So it looks as though the SCSI subsystem doesn't like to have a reset 
> +AD4 +AD4 +AD4 handler call scsi+AF8-remove+AF8-host.
> +AD4 +AD4 
> +AD4 +AD4 Are you talking about a PCI device removal handler or a SCSI error
> +AD4 +AD4 handler?
> +AD4 
> +AD4 The context of this discussion is a USB mass-storage device where the
> +AD4 device's port on its upstream hub has been powered off.  The
> +AD4 powered-off port causes an executing command to time out.  As a result
> +AD4 the SCSI error handler runs and calls the USB reset routine, but the
> +AD4 reset fails because the kernel is unable to communicate with the device
> +AD4 through the powered-off port.  This causes the USB reset routine to
> +AD4 unbind the device from its USB driver, which in turn calls
> +AD4 scsi+AF8-remove+AF8-host -- while the error handler is still running.
> 
> From which context does that unbind happen? From inside a SCSI EH callback
> or from the context of a workqueue? I think the former is not allowed but
> that the latter is allowed. The SRP initiator driver (ib+AF8-srp.c) follows the
> latter approach. See also srp+AF8-queue+AF8-remove+AF8-work().

The unbind happens from inside the SCSI EH callback.  If that really is
not allowed, we'll need to change it.  Or we can just change it
regardless, since the effort required is pretty small.

Kento, please try the patch below.  Does it help with your problem?

Alan Stern



Index: usb-4.x/drivers/usb/core/hub.c
===================================================================
--- usb-4.x.orig/drivers/usb/core/hub.c
+++ usb-4.x/drivers/usb/core/hub.c
@@ -5902,7 +5902,9 @@ int usb_reset_device(struct usb_device *
 					cintf->needs_binding = 1;
 			}
 		}
-		usb_unbind_and_rebind_marked_interfaces(udev);
+		/* If the reset failed, hub_wq will unbind drivers later */
+		if (ret == 0)
+			usb_unbind_and_rebind_marked_interfaces(udev);
 	}
 
 	usb_autosuspend_device(udev);


