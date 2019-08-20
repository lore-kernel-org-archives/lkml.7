Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428A1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AB5205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfHTOYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:24:02 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36036 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729137AbfHTOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:24:02 -0400
Received: (qmail 2525 invoked by uid 2102); 20 Aug 2019 10:24:01 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Aug 2019 10:24:01 -0400
Date:   Tue, 20 Aug 2019 10:24:01 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     syzbot <syzbot+cfe6d93e0abab9a0de05@syzkaller.appspotmail.com>,
        <keescook@chromium.org>, <gustavo@embeddedor.com>,
        <andreyknvl@google.com>, <syzkaller-bugs@googlegroups.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: KASAN: use-after-free Read in iowarrior_disconnect
In-Reply-To: <Pine.LNX.4.44L0.1908201005340.1573-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.44L0.1908201023090.1573-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I replied to the wrong email message -- sorry.  This was intended
to be about the problem with the yurex driver, not the iowarrior
driver.

Alan Stern


On Tue, 20 Aug 2019, Alan Stern wrote:

> On Mon, 19 Aug 2019, Oliver Neukum wrote:
> 
> > Am Montag, den 19.08.2019, 07:48 -0700 schrieb syzbot:
> > > Hello,
> > > 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    d0847550 usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=139be302600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=cfe6d93e0abab9a0de05
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fe6b02600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1548189c600000
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+cfe6d93e0abab9a0de05@syzkaller.appspotmail.com
> > > 
> > 
> > #syz test: https://github.com/google/kasan.git d0847550
> 
> There's no need for us to work at cross purposes on this.  We can go 
> with your approach.
> 
> However, the code is more complicated than your patch accounts for.  
> The wait can finish in several different ways:
> 
> (1)	The control URB succeeds and the interrupt URB gets an 
> 	acknowledgment.
> 
> (2)	The control URB completes with an error.
> 
> (3)	The wait times out.
> 
> (4)	A disconnect occurs.
> 
> Your patch doesn't handle cases (1) and (3).  (And it doesn't get rid 
> of the dev->waitq field, which is no longer used.)
> 
> In fact, (1) is a little ambiguous.  When the interrupt URB gets a 
> command acknowledgment, there's no way (as far as I can tell) to know 
> which command was acknowledged -- particularly if a prior command URB 
> had to be cancelled because it timed out.
> 
> And as it turns out, the driver neglects to kill the command URB in
> case (3).  Furthermore, the driver doesn't have mutual exclusion for 
> writes.  So there's nothing to prevent the command URB from being 
> submitted while it is still active (syzbot's new crash).
> 
> I have to wonder if anybody's actually using this driver.  It seems to
> be pretty broken.  Maybe we should just mark it as such and forget
> about fixing it.
> 
> Alan Stern

