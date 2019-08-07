Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C231C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C522199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfHGOjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:39:39 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42620 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388190AbfHGOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:39:37 -0400
Received: (qmail 18918 invoked by uid 2102); 7 Aug 2019 10:39:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Aug 2019 10:39:36 -0400
Date:   Wed, 7 Aug 2019 10:39:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Cesar Miquel <miquel@df.uba.ar>,
        <rio500-users@lists.sourceforge.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: possible deadlock in open_rio
In-Reply-To: <CAAeHK+yAY_ov4yH7n-R8ppnxc1ux33A-SEdxx18ywU1SyLGwug@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1908071033440.1514-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Andrey Konovalov wrote:

> On Wed, Aug 7, 2019 at 4:01 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, 7 Aug 2019, Andrey Konovalov wrote:
> >
> > > On Tue, Aug 6, 2019 at 9:13 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Thu, 1 Aug 2019, syzbot wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
> > > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=136b6aec600000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7bbcbe9c9ff0cd49592a
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com
> > > > >
> > > > > ======================================================
> > > > > WARNING: possible circular locking dependency detected
> > > > > 5.3.0-rc2+ #23 Not tainted
> > > > > ------------------------------------------------------
> > > >
> > > > Andrey:
> > > >
> > > > This should be completely reproducible, since it's a simple ABBA
> > > > locking violation.  Maybe just introducing a time delay (to avoid races
> > > > and give the open() call time to run) between the gadget creation and
> > > > gadget removal would be enough to do it.
> > >
> > > I've tried some simple approaches to reproducing this, but failed.
> > > Should this require two rio500 devices to trigger?
> >
> > No, one device should be enough.  Just plug it in and then try to open
> > the character device file.
> 
> OK, I've reproduced it, so I can test a patch manually. The reason
> syzbot couldn't do that, is because it doesn't open character devices.
> Right now the USB fuzzing instance only opens /dev/input*,
> /dev/hidraw* and /dev/usb/hiddev* (only the devices that are created
> by USB HID devices as I've been working on adding USB HID targeted
> fuzzing support lately).
> 
> I guess we should open /dev/chr/* as well. The problem is that there
> 300+ devices there even without connecting USB devices and opening
> them blindly probably won't work. Is there a way to know which
> character devices are created by USB devices? Maybe they are exposed
> over /sys/bus/usb or via some other way?

I don't have any devices that use this API, so I can't be certain.  
However, I believe the devices do get registered under /sys/class/usb/.  
(Note that this directory doesn't exist when there aren't any USB class 
files.)

In any case, the USB character device files all have their major
numbers set to 180 (USB_MAJOR defined in include/linux/usb.h), so you
can identify them that way.

Alan Stern

