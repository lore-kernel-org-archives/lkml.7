Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F466C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DF1206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfIMUf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:35:59 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54314 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730723AbfIMUf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:35:58 -0400
Received: (qmail 6179 invoked by uid 2102); 13 Sep 2019 16:35:57 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Sep 2019 16:35:57 -0400
Date:   Fri, 13 Sep 2019 16:35:57 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <balbi@kernel.org>,
        <chunfeng.yun@mediatek.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: rcu detected stall in dummy_timer
In-Reply-To: <0000000000004fb020059274a5ff@google.com>
Message-ID: <Pine.LNX.4.44L0.1909131629230.1466-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1146550d600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> dashboard link: https://syzkaller.appspot.com/bug?extid=b24d736f18a1541ad550
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11203fa5600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162cd335600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com
> 
> yurex 3-1:0.101: yurex_interrupt - unknown status received: -71
> yurex 5-1:0.101: yurex_interrupt - unknown status received: -71
> yurex 6-1:0.101: yurex_interrupt - unknown status received: -71
> rcu: INFO: rcu_sched self-detected stall on CPU

Andrey:

This problem may be a result of overloading dummy_timer.  The kernel 
config you are using has CONFIG_HZ=100, but dummy-hcd needs 
CONFIG_HZ=1000 (see the comment on line 1789).  That is, lower values 
of HZ will occasionally lead to trouble, and this may be an example.

Can you change the config value for HZ and see if the bug still 
reproduces?

Alan Stern

