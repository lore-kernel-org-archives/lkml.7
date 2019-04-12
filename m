Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF8FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1512171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDLTq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:46:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44364 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726870AbfDLTq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:46:26 -0400
Received: (qmail 2122 invoked by uid 2102); 12 Apr 2019 15:46:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Apr 2019 15:46:25 -0400
Date:   Fri, 12 Apr 2019 15:46:25 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     andreyknvl@google.com
cc:     gregkh@linuxfoundation.org, <gustavo@embeddedor.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: task hung in usb_kill_urb
In-Reply-To: <0000000000006f1596058653d991@google.com>
Message-ID: <Pine.LNX.4.44L0.1904121540001.1283-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey:

It's really hard to tell just what's going on here.

On Fri, 12 Apr 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c4c1af200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> dashboard link: https://syzkaller.appspot.com/bug?extid=d919b0f29d7b5a4994b9
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14410dbb200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f0acd3200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com
> 
> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> INFO: task kworker/0:2:532 blocked for more than 143 seconds.
>        Not tainted 5.1.0-rc4-319354-g9a33b36 #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/0:2     D26656   532      2 0x80000000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   schedule+0x8f/0x180 kernel/sched/core.c:3562
>   usb_kill_urb drivers/usb/core/urb.c:695 [inline]
>   usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
>   usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
>   usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
>   usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152

It looks like something is stuck waiting for usb_kill_urb() to finish.  
But what happened before that?

I can't tell from the reproducer source, because it uses a bunch of 
special stuff you added in your usb-fuzzer tree.

Alan Stern

