Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD797C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6D82245B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfIZVoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:44:32 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51435 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727974AbfIZVoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 17:44:32 -0400
Received: (qmail 17553 invoked by uid 500); 26 Sep 2019 17:44:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Sep 2019 17:44:31 -0400
Date:   Thu, 26 Sep 2019 17:44:31 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        syzbot <syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in pvr2_i2c_core_done
In-Reply-To: <CAAeHK+zSYnRgUb_S9MwEp0rp5nk0YzpoVcYZOn_WooCW68EOmw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1909261741540.16697-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019, Andrey Konovalov wrote:

> On Wed, Sep 25, 2019 at 4:10 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, 25 Sep 2019, syzbot wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    d9e63adc usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16b5fcd5600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f4fa60e981ee8e6a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e74a998ca8f1df9cc332
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec07b1600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ff0871600000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com
> > >
> > > pvrusb2: Device being rendered inoperable
> > > cx25840 0-0044: Unable to detect h/w, assuming cx23887
> > > cx25840 0-0044: cx23887 A/V decoder found @ 0x88 (pvrusb2_a)
> > > pvrusb2: Attached sub-driver cx25840
> > > pvrusb2: ***WARNING*** pvrusb2 device hardware appears to be jammed and I
> > > can't clear it.
> > > pvrusb2: You might need to power cycle the pvrusb2 device in order to
> > > recover.
> > > ------------[ cut here ]------------
> > > sysfs group 'power' not found for kobject 'i2c-0'
> > > WARNING: CPU: 0 PID: 102 at fs/sysfs/group.c:278 sysfs_remove_group
> > > fs/sysfs/group.c:278 [inline]
> > > WARNING: CPU: 0 PID: 102 at fs/sysfs/group.c:278
> > > sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
> >
> > I have seen a lot of error messages like this one (i.e., "group 'power'
> > not found for kobject"), in runs that involved fuzzing a completely
> > different USB driver.  Initial testing failed to find a cause.
> >
> > This leads me to wonder whether the problem might lie somewhere else
> > entirely.  A bug in some core kernel code?  Memory corruption?
> 
> AFAICS so far this has only been triggered from the usbvision driver
> [1] and from the pvrusb2 driver (this report).
> 
> I wanted to loop in sysfs maintainers, but it seems that Greg and
> Rafael are already cc'ed on this.
> 
> [1] https://syzkaller.appspot.com/bug?extid=7fa38a608b1075dfd634

It turns out the reason for this error is simple: The driver 
unregisters its subdevices in the release handler instead of in the 
disconnect handler.  There probably is documentation about this 
somewhere, but I don't know exactly where -- maybe Greg remembers.

In the case of pvrusb2, the issues involve unregistering both the v4l2 
device and the i2c device.

Alan Stern

