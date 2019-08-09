Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E430C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475D020B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfHITcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:32:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55460 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725980AbfHITcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:32:52 -0400
Received: (qmail 5254 invoked by uid 2102); 9 Aug 2019 15:32:51 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2019 15:32:51 -0400
Date:   Fri, 9 Aug 2019 15:32:51 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+a64a382964bf6c71a9c0@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <oneukum@suse.de>, <syzkaller-bugs@googlegroups.com>
Subject: Re: possible deadlock in usb_deregister_dev
In-Reply-To: <00000000000026d72f058fb33242@google.com>
Message-ID: <Pine.LNX.4.44L0.1908091531590.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=15bf780e600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> dashboard link: https://syzkaller.appspot.com/bug?extid=a64a382964bf6c71a9c0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16787574600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136cc4d2600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a64a382964bf6c71a9c0@syzkaller.appspotmail.com
> 
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> iowarrior 1-1:0.236: IOWarrior product=0x1501, serial= interface=236 now  
> attached to iowarrior0
> usb 1-1: USB disconnect, device number 2
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.3.0-rc2+ #25 Not tainted
> ------------------------------------------------------
> kworker/0:1/12 is trying to acquire lock:
> 00000000cd63e8f1 (minor_rwsem){++++}, at: usb_deregister_dev  
> drivers/usb/core/file.c:238 [inline]
> 00000000cd63e8f1 (minor_rwsem){++++}, at: usb_deregister_dev+0x61/0x270  
> drivers/usb/core/file.c:230
> 
> but task is already holding lock:
> 000000001d1989ef (iowarrior_open_disc_lock){+.+.}, at:  
> iowarrior_disconnect+0x45/0x2c0 drivers/usb/misc/iowarrior.c:867
> 
> which lock already depends on the new lock.

https://syzkaller.appspot.com/bug?extid=ca52394faa436d8131df is 
undoubtedly a duplicate of this.

Alan Stern

