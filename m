Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91D1C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C624C2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbfIPQcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:32:54 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51394 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726930AbfIPQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:32:53 -0400
Received: (qmail 4755 invoked by uid 2102); 16 Sep 2019 12:32:52 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2019 12:32:52 -0400
Date:   Mon, 16 Sep 2019 12:32:52 -0400 (EDT)
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
In-Reply-To: <CAAeHK+zrR3pB2R3yyyUdGM4Vrv77o47MHsgvbQ+LFHfiWBt1OQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1909161205280.1489-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Andrey Konovalov wrote:

> On Fri, Sep 13, 2019 at 10:35 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, 13 Sep 2019, syzbot wrote:
> >
> > > syzbot has found a reproducer for the following crash on:
> > >
> > > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1146550d600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b24d736f18a1541ad550
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11203fa5600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162cd335600000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com
> > >
> > > yurex 3-1:0.101: yurex_interrupt - unknown status received: -71
> > > yurex 5-1:0.101: yurex_interrupt - unknown status received: -71
> > > yurex 6-1:0.101: yurex_interrupt - unknown status received: -71
> > > rcu: INFO: rcu_sched self-detected stall on CPU
> >
> > Andrey:
> >
> > This problem may be a result of overloading dummy_timer.  The kernel
> > config you are using has CONFIG_HZ=100, but dummy-hcd needs
> > CONFIG_HZ=1000 (see the comment on line 1789).  That is, lower values
> > of HZ will occasionally lead to trouble, and this may be an example.
> >
> > Can you change the config value for HZ and see if the bug still
> > reproduces?
> 
> Hi Alan,
> 
> I've tried running the reproducer with CONFIG_HZ=1000 and still got
> the same stall message. It's accompanied by countless "yurex
> 6-1:0.101: yurex_interrupt - unknown status received: -71" messages,
> so I believe this is an issue in the yurex driver.

Maybe.  Depends on exactly what the reproducer is doing, something 
which is not at all easy to figure out from the scripts or programs.

I got the impression that the reproducer connects an emulated yurex
device and then disconnects it -- but maybe that's not right at all.  
Maybe the key point is that the reproducer sends a descriptor listing
an endpoint address that doesn't actually exist; that would have a
similar effect.  Can you tell?  (Trying to understand exactly what a
syzkaller test program does is not for the faint of heart.)

As far as I can remember, the USB spec doesn't say what a device should
do when the host sends a packet to a non-existent endpoint.  Which
means that some devices will do nothing at all, leading to the -71
(-EPROTO) errors you see in the log.  Indeed, there's only one place in
dummy_hcd.c where -EPROTO occurs -- for the case where an URB is sent
to an endpoint not supported by the gadget.

This leads to the question: How should the yurex driver (or any USB
class driver, in fact) respond to a -EPROTO or similar error?  The 
thing is, this sort of error typically arises in two circumstances:

	The device was just unplugged, so of course it can't send
	any packets back to the host;

	Noise on the bus caused a packet to be lost or corrupted.

In the first case, it doesn't much matter what the driver does because 
the disconnection will be noticed and acted on within a few hundred 
milliseconds (although I suppose a driver could generate a lot of 
kernel-log spam during that time).

In the second case, retrying the lost/corrupted packet is the right 
response.

But retrying is _not_ the right response in cases where the device is 
never going to respond because the endpoint address is invalid.  This 
can happen only in situations where the device provides incorrect 
information (bad descriptors or something of that sort).  The only 
suitable approach I can think of is to limit the number of retries.

Retry-limiting is not the sort of thing we want to add to each
individual USB class driver.  Maybe it can be handled in the USB core;  
I'll try to write some code for it.  Under normal circumstances the
issue just doesn't arise, because normal devices aren't malicious.

> Why does dumy_hcd require CONFIG_HZ=1000? The comment doesn't really
> explain the reason.

Oh, that's simple enough.  USB events tend to happen at millisecond
intervals.  The data on the USB bus is organized into frames (and
microframes for high speed and SuperSpeed); a frame lasts one
millisecond (and a microframe lasts 1/8 ms).  Many host controllers
report important events when a frame boundary occurs (that's how 
dummy-hcd works).

So for proper timing of the emulation, dummy-hcd requires timer 
interrupts with millisecond resolution.  I suppose the driver could be 
changed to use a high-res timer instead of a normal kernel timer, but 
for now that doesn't seem particularly important.

Alan Stern

