Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7087C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B6E21850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403951AbfEXNyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:54:04 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36642 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2403873AbfEXNyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:54:03 -0400
Received: (qmail 1597 invoked by uid 2102); 24 May 2019 09:54:02 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 May 2019 09:54:02 -0400
Date:   Fri, 24 May 2019 09:54:02 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <greg@kroah.com>
cc:     andreyknvl@google.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <wen.yang99@zte.com.cn>
Subject: Re: [PATCH] media: usb: siano: Fix general protection fault in smsusb
In-Reply-To: <20190524103540.250a69e7@coco.lan>
Message-ID: <Pine.LNX.4.44L0.1905240951470.1435-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019, Mauro Carvalho Chehab wrote:

> Em Tue, 7 May 2019 12:39:47 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> escreveu:
> 
> > The syzkaller USB fuzzer found a general-protection-fault bug in the
> > smsusb part of the Siano DVB driver.  The fault occurs during probe
> > because the driver assumes without checking that the device has both
> > IN and OUT endpoints and the IN endpoint is ep1.
> > 
> > By slightly rearranging the driver's initialization code, we can make
> > the appropriate checks early on and thus avoid the problem.  If the
> > expected endpoints aren't present, the new code safely returns -ENODEV
> > from the probe routine.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Reported-and-tested-by: syzbot+53f029db71c19a47325a@syzkaller.appspotmail.com
> > CC: <stable@vger.kernel.org>

> Patch looks correct, and I'm applying it. It exposes another potential
> problem though: what happens if sizeof(desc.wMaxPacketSize) < sizeof(struct sms_msg_hdr)?
> 
> I'm enclosing a followup patch that should solve this situation
> (and clean up a sparse warning).
> 
> Thanks,
> Mauro

Your points are well taken.

However, Greg KH has already taken the original patch and a fix for the 
sparse warning into his tree.  I guess the two of you should figure out 
how best to straighten this out.

Alan Stern

