Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C97C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1735D21783
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569561061;
	bh=ls1GkAP3q7Y1jxVP/fVgN6Pw3D11AGVy4cV2gOlLBQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XmKkp5IgqQamC+BtGsXghxiNDwoUt7vKuzhzCaO9wRAaqgpjc22WNYTcsszDpvyW2
	 O9ikBzkE/ZXFsr/u4g6JHUEbet54L/LxPqccyMTYkNe5oV1mXjBNVV7VaoqmCZBTNa
	 uaW1NicCqZouio2qgUDZHx6Y/YqJAQNyNEf9ebpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfI0FLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfI0FK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:10:59 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 848E22054F;
        Fri, 27 Sep 2019 05:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569561058;
        bh=ls1GkAP3q7Y1jxVP/fVgN6Pw3D11AGVy4cV2gOlLBQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKy4AbNzhC5BVtzJ4z9lhF7ZcnaQJytp/ZFP4CwT7wy3imcfsYP0ANB1H5XBntsgT
         5Vh6j6eBzUQ5I3deD1XcTpgOhIHVaQ3XA+f4go0NAyQnjgoS8+PeXiNc+HrMtxDP9S
         uq8xHaOIbwWfcID7oI/P+mi/EWu5nE2FWot4Xav4=
Date:   Fri, 27 Sep 2019 07:10:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        syzbot <syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in pvr2_i2c_core_done
Message-ID: <20190927051042.GA1767219@kroah.com>
References: <CAAeHK+zSYnRgUb_S9MwEp0rp5nk0YzpoVcYZOn_WooCW68EOmw@mail.gmail.com>
 <Pine.LNX.4.44L0.1909261741540.16697-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1909261741540.16697-100000@netrider.rowland.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:44:31PM -0400, Alan Stern wrote:
> On Wed, 25 Sep 2019, Andrey Konovalov wrote:
> 
> > On Wed, Sep 25, 2019 at 4:10 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Wed, 25 Sep 2019, syzbot wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    d9e63adc usb-fuzzer: main usb gadget fuzzer driver
> > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16b5fcd5600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f4fa60e981ee8e6a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e74a998ca8f1df9cc332
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec07b1600000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ff0871600000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+e74a998ca8f1df9cc332@syzkaller.appspotmail.com
> > > >
> > > > pvrusb2: Device being rendered inoperable
> > > > cx25840 0-0044: Unable to detect h/w, assuming cx23887
> > > > cx25840 0-0044: cx23887 A/V decoder found @ 0x88 (pvrusb2_a)
> > > > pvrusb2: Attached sub-driver cx25840
> > > > pvrusb2: ***WARNING*** pvrusb2 device hardware appears to be jammed and I
> > > > can't clear it.
> > > > pvrusb2: You might need to power cycle the pvrusb2 device in order to
> > > > recover.
> > > > ------------[ cut here ]------------
> > > > sysfs group 'power' not found for kobject 'i2c-0'
> > > > WARNING: CPU: 0 PID: 102 at fs/sysfs/group.c:278 sysfs_remove_group
> > > > fs/sysfs/group.c:278 [inline]
> > > > WARNING: CPU: 0 PID: 102 at fs/sysfs/group.c:278
> > > > sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
> > >
> > > I have seen a lot of error messages like this one (i.e., "group 'power'
> > > not found for kobject"), in runs that involved fuzzing a completely
> > > different USB driver.  Initial testing failed to find a cause.
> > >
> > > This leads me to wonder whether the problem might lie somewhere else
> > > entirely.  A bug in some core kernel code?  Memory corruption?
> > 
> > AFAICS so far this has only been triggered from the usbvision driver
> > [1] and from the pvrusb2 driver (this report).
> > 
> > I wanted to loop in sysfs maintainers, but it seems that Greg and
> > Rafael are already cc'ed on this.
> > 
> > [1] https://syzkaller.appspot.com/bug?extid=7fa38a608b1075dfd634
> 
> It turns out the reason for this error is simple: The driver 
> unregisters its subdevices in the release handler instead of in the 
> disconnect handler.  There probably is documentation about this 
> somewhere, but I don't know exactly where -- maybe Greg remembers.

Nope, I don't remember.  It should happen in the disconnect handler, odd
of it to be in release, but maybe that's the "easiest" way for v4l to
handle this?

thanks,

greg k-h
