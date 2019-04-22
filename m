Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD17C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703CE20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfDVRxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:53:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38298 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727480AbfDVRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:53:18 -0400
Received: (qmail 6556 invoked by uid 2102); 22 Apr 2019 13:53:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2019 13:53:17 -0400
Date:   Mon, 22 Apr 2019 13:53:17 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, <rafael@kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in __dev_printk
In-Reply-To: <00000000000029431d0586d10813@google.com>
Message-ID: <Pine.LNX.4.44L0.1904221344550.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    d34f9519 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=10adfe6b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
> dashboard link: https://syzkaller.appspot.com/bug?extid=2eb9121678bdb36e6d57
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145cb7e3200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f8bd2d200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com
> 
> yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> usb 1-1: USB disconnect, device number 112
> yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI

Andrey:

This original bug report included a "USB disconnect" line, as shown
above.  The newer results, for runs with my patches added, do not.  At
least, if such a line was present, it didn't show up in the console
output files -- the most recent one contains nothing but repeats of
that "yurex_interrupt - unknown status received: -71" line, although
for devices on multiple buses.

Is there any way to get more information about what's happening, such 
as a complete kernel log?  And perhaps to run the test with just a 
single dummy-hcd bus instead of 6?

At this point, I suspect the original general protection fault in
the yurex driver has been fixed, but something else in dummy-hcd may be
causing the rcu-detected stalls.

Alan Stern

