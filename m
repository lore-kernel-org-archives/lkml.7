Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57900C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C7320880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355373;
	bh=A7Ui/SD/tqefETsYaRJrobK3ObaTe4rAJ6g3oyvZqXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VgbQlBLqqQZ1JKyPikaRU9Mq5N3HoYfn8hAuB4uTi3OKpimgWMRIuVHIGGU1e5zGC
	 uEkYZIZ0g8OHgZeHGtSijaR2iB58BdGInv9TgT0LGgR/yHNqNvsqXlqMYXFsSBapWL
	 d1WFEC+Hpy229pOBiMKUQDrbo7aep2PSh+NGDv4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfDOTJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbfDOTJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E530D20651;
        Mon, 15 Apr 2019 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355366;
        bh=A7Ui/SD/tqefETsYaRJrobK3ObaTe4rAJ6g3oyvZqXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTCr/Ml7g0KoEp39f+ctkw1lvhI24TEp0zVUGUY3TaO6U4VgELUToLvjdme6OlmY2
         BcLK6veJrICOeuyY1mJ9IS1bLRfBOgHINcD5bzuqsmkhjZClihE3bdUvoLSPt4i4rJ
         sYP8HOm6K6RfXKH1KFj5wN/2kJ4yUhm2wNsWEP/8=
Date:   Mon, 15 Apr 2019 21:00:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: task hung in usb_kill_urb
Message-ID: <20190415190054.GA10359@kroah.com>
References: <0000000000006f1596058653d991@google.com>
 <Pine.LNX.4.44L0.1904121540001.1283-100000@iolanthe.rowland.org>
 <CAAeHK+wrF8Oh7ur+BcuyARvm2sx6KNVGFxqKHoyajApN+tOA_g@mail.gmail.com>
 <52ac871b-ac61-432e-3a85-47b8e97233d2@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ac871b-ac61-432e-3a85-47b8e97233d2@embeddedor.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 01:39:57PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 4/15/19 12:48 PM, Andrey Konovalov wrote:
> > On Fri, Apr 12, 2019 at 9:46 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >>
> >> Andrey:
> >>
> >> It's really hard to tell just what's going on here.
> >>
> >> On Fri, 12 Apr 2019, syzbot wrote:
> >>
> >>> Hello,
> >>>
> >>> syzbot found the following crash on:
> >>>
> >>> HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> >>> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=14c4c1af200000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=d919b0f29d7b5a4994b9
> >>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14410dbb200000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f0acd3200000
> >>>
> >>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>> Reported-by: syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com
> >>>
> >>> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> >>> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> >>> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> >>> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> >>> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> >>> INFO: task kworker/0:2:532 blocked for more than 143 seconds.
> >>>        Not tainted 5.1.0-rc4-319354-g9a33b36 #3
> >>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>> kworker/0:2     D26656   532      2 0x80000000
> >>> Workqueue: usb_hub_wq hub_event
> >>> Call Trace:
> >>>   schedule+0x8f/0x180 kernel/sched/core.c:3562
> >>>   usb_kill_urb drivers/usb/core/urb.c:695 [inline]
> >>>   usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
> >>>   usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
> >>>   usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
> >>>   usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
> >>
> >> It looks like something is stuck waiting for usb_kill_urb() to finish.
> >> But what happened before that?
> > 
> > This crash is somewhat special. It happens quite often during USB
> > fuzzing, but at the same time it's a hang, which makes it a bit harder
> > debug. I initially thought that is somehow related to my custom USB
> > fuzzing kernel patches, but then I saw that someone else hit this
> > issue while doing USB fuzzing in a completely different way that
> > doesn't require kernel modifications. So it might be an actual issue
> > in the kernel.
> > 
> > The full console output is provided by the syzbot, but I guess it's
> > not very useful in this case. I've just made sure that this issue is
> > manually reproducible, so we can easily retest it with debug patches
> > (syzbot should be also able to do that via the syz test command). Or
> > is there a way to turn on some verbose mode to see some USB debug
> > messages?
> > 
> >>
> >> I can't tell from the reproducer source, because it uses a bunch of
> >> special stuff you added in your usb-fuzzer tree.
> >>
> >> Alan Stern
> >>
> > 
> > I understand, for now I guess the simpler way to debug this is to run
> > the reproducer. I'll write you and Greg a separate email regarding all
> > that special stuff that I added.
> > 
> 
> Hi Andrey,
> 
> Please, CC me on that email too.

Please cc: all of linux-usb@vger.kernel.org, no need to keep anything
private.

thanks,

greg k-h

