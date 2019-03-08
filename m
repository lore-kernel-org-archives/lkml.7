Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F01C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1801020868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfCHRdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:33:18 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:46632 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726171AbfCHRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:33:15 -0500
Received: (qmail 5289 invoked by uid 2102); 8 Mar 2019 12:33:14 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2019 12:33:14 -0500
Date:   Fri, 8 Mar 2019 12:33:14 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Kento.A.Kobayashi@sony.com, <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
In-Reply-To: <1552063928.29776.2.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1903081231260.1412-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019, Oliver Neukum wrote:

> On Fr, 2019-03-08 at 09:13 +0000, Kento.A.Kobayashi@sony.com wrote:
> > The usb_reset_and_verify_device included in usb_reset_device fails
> > with -ENODEV after power off hub port, and the -ENODEV error will
> > be reported to uas_eh_bus_reset_handler and upper layer, so it
> > doesn't need to do rebind if -ENODEV happens.
> 
> Hi,
> 
> no I am sorry, that is an assumption you just cannot make.
> Anything can trigger a reset. That being SCSI is the common
> case certainly, but not the only case. And in those cases
> we cannot depend on upper layers doing the right thing, if
> we just ignore an error.
> 
> NACK
> 
> 	Sorry
> 		Oliver

Note that the reset routines in usb-storage do not make any exceptions
for -ENODEV.

Alan Stern

