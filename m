Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FF2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32682173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfC1Qtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:49:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbfC1Qtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:49:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E2B9ABDE;
        Thu, 28 Mar 2019 16:49:44 +0000 (UTC)
Message-ID: <1553791752.6310.2.camel@suse.com>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
        Jacky.Cao@sony.com, Kento.A.Kobayashi@sony.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Thu, 28 Mar 2019 17:49:12 +0100
In-Reply-To: <Pine.LNX.4.44L0.1903281157070.1291-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1903281157070.1291-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2019-03-28 at 11:57 -0400, Alan Stern wrote:
> On Thu, 28 Mar 2019, Oliver Neukum wrote:
> 
> > On Do, 2019-03-28 at 07:53 +0000, Kento.A.Kobayashi@sony.com wrote:
> > > Hi,
> > > 
> > > > Sorry,
> > > > 
> > > > I thought this was clear. Your patch is making the assumption that the reset is triggered by the SCSI layer. You cannot make that assumption, as there is an ioctl for resetting a USB device.
> > > > In case we are getting an error during the reset (our endpoints vanish), the device driver must report that to the USB layer, so the driver will always be disconnected.
> > > > We cannot drop errors.
> > > > 
> > > >   Regards
> > > >           Oliver
> > > 
> > > This patch modified uas_post_reset to skip rebind operation to avoid exception while -ENODEV happens not drop error.
> > > If uas_post_reset happens -ENODEV, usb_reset_and_verify_device must happen error.
> > > So,when we use ioctl(USBDEVFS_RESET) to reset device, if usb_reset_and_verify_device happens error, the error will be reported through ioctl return value. 
> > 
> > OK, It is possible that I am stupid. We must rebind if uas_post_reset()
> > fails. The driver will crash without the endpoints. Can you please
> > explain again in greater detail, what you are trying to achieve?
> 
> Actually no, the driver doesn't have to do anything if the post-reset 
> method fails.  usbcore will take care of rebinding automatically.

Yes, but the rebinding is not optional. Hence, either the post_reset()
must fail to trigger it, or it will be triggered anyway.
So if the rebinding hangs the machine, I cannot see how alter
changing the return value of uas_post_reset() would help.

It looks to me like the state transitions of SCSI are too
restrictive.

	Regards
		Oliver

