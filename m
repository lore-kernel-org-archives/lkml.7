Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB08C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C22D2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKVUM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:12:57 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:59902 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726568AbfKVUM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:12:56 -0500
Received: (qmail 7249 invoked by uid 2102); 22 Nov 2019 15:12:55 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Nov 2019 15:12:55 -0500
Date:   Fri, 22 Nov 2019 15:12:55 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     syzbot <syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <hverkuil@xs4all.nl>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mchehab@kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in si470x_int_in_callback (2)
In-Reply-To: <1574449256.2659.2.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1911221506490.1511-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019, Oliver Neukum wrote:

> Am Freitag, den 22.11.2019, 10:35 -0500 schrieb Alan Stern:
> > On Fri, 22 Nov 2019, syzbot wrote:
> > 
> > > Hello,
> > > 
> > > syzbot has tested the proposed patch but the reproducer still triggered  
> > > crash:
> > > INFO: rcu detected stall in dummy_timer
> > > 
> > > radio-si470x 1-1:0.0: non-zero urb status (-71)
> > > radio-si470x 4-1:0.0: non-zero urb status (-71)
> > > radio-si470x 3-1:0.0: non-zero urb status (-71)
> > 
> > Oliver:
> > 
> > The reason for this stall is because the driver goes into a tight
> > resubmit loop when the interrupt URB completes with an unrecognized
> > error status.  Instead, the driver should log an error message and
> > avoid resubmitting.  Error recovery can be done at a higher level.
> > 
> > In other words, change the
> > 
> > 			goto resubmit; /* Maybe we can recover. */
> > 
> > line in the completion handler into a return.

(I guess you also should clear the int_in_running flag, although the 
callback routine doesn't do that in the case of -ENOENT, -ECONNRESET, 
or -ESHUTDOWN.)

> 
> I thought so, too. That is why I poisoned the URB. Am I dense?

Poisoning the URB should work -- if you do it in the right place.  The
probe routine might not be good enough; an unrecognized error can occur
after the probe has succeeded.

Did you modify si470x_int_in_callback()?  That's where the tight loop
is.

Alan Stern


