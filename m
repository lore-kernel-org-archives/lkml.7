Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE693C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723742084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfDIOoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:44:06 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46054 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726492AbfDIOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:44:05 -0400
Received: (qmail 2837 invoked by uid 2102); 9 Apr 2019 10:44:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Apr 2019 10:44:04 -0400
Date:   Tue, 9 Apr 2019 10:44:04 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Kento.A.Kobayashi@sony.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Oliver Neukum <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        <Jacky.Cao@sony.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
In-Reply-To: <yq1a7h0orn8.fsf@oracle.com>
Message-ID: <Pine.LNX.4.44L0.1904091014570.1599-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019, Martin K. Petersen wrote:

> 
> Alan,
> 
> > So it looks as though the SCSI subsystem doesn't like to have a reset 
> > handler call scsi_remove_host.
> 
> Are you talking about a PCI device removal handler or a SCSI error
> handler?

The context of this discussion is a USB mass-storage device where the
device's port on its upstream hub has been powered off.  The
powered-off port causes an executing command to time out.  As a result
the SCSI error handler runs and calls the USB reset routine, but the
reset fails because the kernel is unable to communicate with the device
through the powered-off port.  This causes the USB reset routine to
unbind the device from its USB driver, which in turn calls
scsi_remove_host -- while the error handler is still running.

> > Commands dispatched by the removal routines are forced to wait for the
> > reset recovery to finish, which won't happen until those commands have
> > been completed.
> >
> > Is this a bug in the SCSI core?  If not, we need to know what is the
> > right way to do things when a reset handler detects that the SCSI host
> > has been hot-unplugged.
> 
> PCI surprise removal should generally work. But it's somewhat unusual
> for a SCSI host to evaporate in the middle of error handling. After all,
> the main purpose of eh is to leverage the interfaces provided by the
> host to try to reconnect to a target that tripped and fell off the
> bus...

Still, it's not impossible for a SCSI host to evaporate in the middle
of error handling, given an appropriately mistimed hot-unplug event.  
How does the SCSI layer expect this to be handled?  Should the
low-level driver wait to call scsi_remove_host until after the error
handling is finished?

What about races?  In theory, scsi_remove_host could be called just as 
the error handler is starting up.

Alan Stern

