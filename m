Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EA8C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C79620844
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHIUwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:52:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55628 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726053AbfHIUwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:52:07 -0400
Received: (qmail 6004 invoked by uid 2102); 9 Aug 2019 16:52:06 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2019 16:52:06 -0400
Date:   Fri, 9 Aug 2019 16:52:06 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in usb_kill_urb
In-Reply-To: <0000000000007e2e84058fb46c49@google.com>
Message-ID: <Pine.LNX.4.44L0.1908091646230.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger  
> crash:
> 
> Reported-and-tested-by:  
> syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=173f2d2c600000
> 
> Note: testing is done by a robot and is best-effort only.

This shows that this bug is a duplicate of extid=30cf45ebfe0b0c4847a1.  
This fact is also visible in the console logs; both have lines saying 
something like:

[  549.416341][   T22] sysfs: cannot create duplicate filename '/class/usbmisc/ldusb0'

and

[  549.958755][   T22] ldusb 1-1:0.28: Not able to get a minor for this device.

preceding the invalid access.

Alan Stern

