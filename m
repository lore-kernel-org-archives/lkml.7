Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47CDC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F984214DE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568660378;
	bh=5STFR6MVl6TxG4mcGsXJ6uc++Bi8Qnv77eK8Naoj+VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CBf1uG7AsrKzvnS+SYOS4CzCbioatf7UEio/fyueXm9i3hbC36lIMZLSrKE3LUSuV
	 smNvaxGK4K90cgyFqsj2lr3wtAxi+S4c0bXr/7VZVAXY0eypftkc43edx5LEfFFnAM
	 ZsLaxcMKEbsBqmhi1dpCnTLF5XxKEOOmmMKxt+NY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbfIPS7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfIPS7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:59:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C28206A4;
        Mon, 16 Sep 2019 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568660375;
        bh=5STFR6MVl6TxG4mcGsXJ6uc++Bi8Qnv77eK8Naoj+VI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLpmN4z5rcKTxpxb0XeCqyOaa/6CPvNAGxcz5w1zxz3eppOjENpNegTsvtDRtaQfw
         n5UH2Etp5GiPqzKEIDFvwq68iv06vorGk78Cx4dN3f8UUOCnmYVHt6JT4iVZCUiaog
         mzktegyR0BCXMbcPjVAU6P7E63J6idqSo7PohSnY=
Date:   Mon, 16 Sep 2019 20:59:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzbot <syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>, chunfeng.yun@mediatek.com,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: rcu detected stall in dummy_timer
Message-ID: <20190916185933.GA1814003@kroah.com>
References: <CAAeHK+zrR3pB2R3yyyUdGM4Vrv77o47MHsgvbQ+LFHfiWBt1OQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1909161205280.1489-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1909161205280.1489-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 12:32:52PM -0400, Alan Stern wrote:
> On Mon, 16 Sep 2019, Andrey Konovalov wrote:
> 
> > On Fri, Sep 13, 2019 at 10:35 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, 13 Sep 2019, syzbot wrote:
> > >
> > > > syzbot has found a reproducer for the following crash on:
> > > >
> > > > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1146550d600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=b24d736f18a1541ad550
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11203fa5600000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162cd335600000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com
> > > >
> > > > yurex 3-1:0.101: yurex_interrupt - unknown status received: -71
> > > > yurex 5-1:0.101: yurex_interrupt - unknown status received: -71
> > > > yurex 6-1:0.101: yurex_interrupt - unknown status received: -71
> > > > rcu: INFO: rcu_sched self-detected stall on CPU
> > >
> > > Andrey:
> > >
> > > This problem may be a result of overloading dummy_timer.  The kernel
> > > config you are using has CONFIG_HZ=100, but dummy-hcd needs
> > > CONFIG_HZ=1000 (see the comment on line 1789).  That is, lower values
> > > of HZ will occasionally lead to trouble, and this may be an example.
> > >
> > > Can you change the config value for HZ and see if the bug still
> > > reproduces?
> > 
> > Hi Alan,
> > 
> > I've tried running the reproducer with CONFIG_HZ=1000 and still got
> > the same stall message. It's accompanied by countless "yurex
> > 6-1:0.101: yurex_interrupt - unknown status received: -71" messages,
> > so I believe this is an issue in the yurex driver.
> 
> Maybe.  Depends on exactly what the reproducer is doing, something 
> which is not at all easy to figure out from the scripts or programs.
> 
> I got the impression that the reproducer connects an emulated yurex
> device and then disconnects it -- but maybe that's not right at all.  
> Maybe the key point is that the reproducer sends a descriptor listing
> an endpoint address that doesn't actually exist; that would have a
> similar effect.  Can you tell?  (Trying to understand exactly what a
> syzkaller test program does is not for the faint of heart.)
> 
> As far as I can remember, the USB spec doesn't say what a device should
> do when the host sends a packet to a non-existent endpoint.  Which
> means that some devices will do nothing at all, leading to the -71
> (-EPROTO) errors you see in the log.  Indeed, there's only one place in
> dummy_hcd.c where -EPROTO occurs -- for the case where an URB is sent
> to an endpoint not supported by the gadget.
> 
> This leads to the question: How should the yurex driver (or any USB
> class driver, in fact) respond to a -EPROTO or similar error?  The 
> thing is, this sort of error typically arises in two circumstances:
> 
> 	The device was just unplugged, so of course it can't send
> 	any packets back to the host;
> 
> 	Noise on the bus caused a packet to be lost or corrupted.
> 
> In the first case, it doesn't much matter what the driver does because 
> the disconnection will be noticed and acted on within a few hundred 
> milliseconds (although I suppose a driver could generate a lot of 
> kernel-log spam during that time).
> 
> In the second case, retrying the lost/corrupted packet is the right 
> response.
> 
> But retrying is _not_ the right response in cases where the device is 
> never going to respond because the endpoint address is invalid.  This 
> can happen only in situations where the device provides incorrect 
> information (bad descriptors or something of that sort).  The only 
> suitable approach I can think of is to limit the number of retries.
> 
> Retry-limiting is not the sort of thing we want to add to each
> individual USB class driver.  Maybe it can be handled in the USB core;  
> I'll try to write some code for it.  Under normal circumstances the
> issue just doesn't arise, because normal devices aren't malicious.

I think this issue came up years ago when people realized they could
"abuse" this through usbfs, but maybe I am mistaken.

The "do we retry or not" is an old discussion, and one I think we just
said, "if it errors out, we will not retry as something is wrong with
the device".  Corrupted packets don't seem to be something that is even
noticable in the "real world".  When lots of noise happens on a system
that might cause this, usually the hub just disconnects the device and
resets it.

thanks,

greg k-h
