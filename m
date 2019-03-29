Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768D0206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfC2ON6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:13:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49076 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728833AbfC2ON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:13:57 -0400
Received: (qmail 2706 invoked by uid 2102); 29 Mar 2019 10:13:56 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2019 10:13:56 -0400
Date:   Fri, 29 Mar 2019 10:13:56 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     gregkh@linuxfoundation.org, <usb-storage@lists.one-eyed-alien.net>,
        <Jacky.Cao@sony.com>, <Kento.A.Kobayashi@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
In-Reply-To: <1553791752.6310.2.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1903291007150.1497-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019, Oliver Neukum wrote:

> On Do, 2019-03-28 at 11:57 -0400, Alan Stern wrote:
> > On Thu, 28 Mar 2019, Oliver Neukum wrote:
> > 
> > > On Do, 2019-03-28 at 07:53 +0000, Kento.A.Kobayashi@sony.com wrote:
> > > > Hi,
> > > > 
> > > > > Sorry,
> > > > > 
> > > > > I thought this was clear. Your patch is making the assumption that the reset is triggered by the SCSI layer. You cannot make that assumption, as there is an ioctl for resetting a USB device.
> > > > > In case we are getting an error during the reset (our endpoints vanish), the device driver must report that to the USB layer, so the driver will always be disconnected.
> > > > > We cannot drop errors.
> > > > > 
> > > > >   Regards
> > > > >           Oliver
> > > > 
> > > > This patch modified uas_post_reset to skip rebind operation to avoid exception while -ENODEV happens not drop error.
> > > > If uas_post_reset happens -ENODEV, usb_reset_and_verify_device must happen error.
> > > > So,when we use ioctl(USBDEVFS_RESET) to reset device, if usb_reset_and_verify_device happens error, the error will be reported through ioctl return value. 
> > > 
> > > OK, It is possible that I am stupid. We must rebind if uas_post_reset()
> > > fails. The driver will crash without the endpoints. Can you please
> > > explain again in greater detail, what you are trying to achieve?
> > 
> > Actually no, the driver doesn't have to do anything if the post-reset 
> > method fails.  usbcore will take care of rebinding automatically.
> 
> Yes, but the rebinding is not optional. Hence, either the post_reset()
> must fail to trigger it, or it will be triggered anyway.
> So if the rebinding hangs the machine, I cannot see how alter
> changing the return value of uas_post_reset() would help.
> 
> It looks to me like the state transitions of SCSI are too
> restrictive.

Maybe I don't understand the problem correctly.  It sounds like the
problem occurs because uas tries to rebind (Where, how, and why does it
do this?  I don't see anything special in uas_post_reset) using the
same scsi_host structure as before instead of creating a new one.  
Trying to reuse a defunct host is definitely not allowed.

But if uas didn't try to do anything special, it would be unbound from
the device, causing the scsi_host to be destroyed.  Then when usbcore
automatically attempted a rebind, uas would create a new scsi_host and
the rebind would have a chance to succeed, without hanging anything.

If this description is wrong, please explain more fully.

Alan Stern

