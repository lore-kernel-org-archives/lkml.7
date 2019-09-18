Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF9CC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A586218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfIROQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:16:39 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53156 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730159AbfIROQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:16:38 -0400
Received: (qmail 2704 invoked by uid 2102); 18 Sep 2019 10:16:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Sep 2019 10:16:37 -0400
Date:   Wed, 18 Sep 2019 10:16:37 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>, <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: rcu detected stall in dummy_timer
In-Reply-To: <CAAeHK+yL9DX9oraq5dN8CSU6LzYN7PnRzppVbiG5b6QM5_ygEg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1909181004440.1507-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019, Andrey Konovalov wrote:

> > > Why does dumy_hcd require CONFIG_HZ=1000? The comment doesn't really
> > > explain the reason.
> >
> > Oh, that's simple enough.  USB events tend to happen at millisecond
> > intervals.  The data on the USB bus is organized into frames (and
> > microframes for high speed and SuperSpeed); a frame lasts one
> > millisecond (and a microframe lasts 1/8 ms).  Many host controllers
> > report important events when a frame boundary occurs (that's how
> > dummy-hcd works).
> >
> > So for proper timing of the emulation, dummy-hcd requires timer
> > interrupts with millisecond resolution.  I suppose the driver could be
> > changed to use a high-res timer instead of a normal kernel timer, but
> > for now that doesn't seem particularly important.
> 
> So what are the practical differences between using CONFIG_HZ=100 and
> 1000 for dummy-hcd? Is is going to be slower or faster?

The timing of the emulation will be more accurate with 1000.  Of
course, for your purposes that doesn't matter.  Also, the driver will 
probably end up using a higher fraction of the total CPU time.

>  Or can it get
> overloaded with data and cause stalls?

I really don't know the answer to that.  It seems probable that 100 is
okay and is less likely to lead to overload and stalls than 1000.

>   Or something else? We're somewhat hesitant to change CONFIG_HZ as 
> we don't know how it will affect other parts of the kernel (at some
> point the USB fuzzer will become a part of the main syzbot instance
> that doesn't only fuzz USB).

Leaving it at 100 should be okay for now.  Especially since we have 
decided to fix this particular problem in an independent way.

In general, I don't know how dummy-hcd will behave when a driver gets 
into a tight retry loop.  In theory, it might end up using so much CPU 
time that you get an rcu stall like the one we saw, but I don't 
understand exactly what happened in this case.  You'd think that with 
no more than six (or however many threads syzbot used) callbacks per 
jiffy, there would be plenty of time for normal threads to run.

Alan Stern

