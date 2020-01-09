Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341BFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1244C2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbgAIQqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:46:09 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36172 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731399AbgAIQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:46:08 -0500
Received: (qmail 2234 invoked by uid 2102); 9 Jan 2020 11:46:07 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jan 2020 11:46:07 -0500
Date:   Thu, 9 Jan 2020 11:46:07 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>, <ingrassia@epigenesys.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (2)
In-Reply-To: <0000000000001b53f8059ba5431a@google.com>
Message-ID: <Pine.LNX.4.44L0.2001091142281.1307-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger  
> crash:
> 
> Reported-and-tested-by:  
> syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         ecdf2214 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b06a019075333661
> dashboard link: https://syzkaller.appspot.com/bug?extid=10e5f68920f13587ab12
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1583963ee00000
> 
> Note: testing is done by a robot and is best-effort only.

I'm at a loss for a way to track this down any farther.  The difference 
between this patch and the previous was very small and almost entirely 
confined to actions that take place _after_ the bug condition has been 
detected.

If this is indeed caused by a race, it would be nice to know that the
two racing threads are doing.  One of them we can see in the log output
(it's calling usb_control_msg) but the other is a mystery.

Alan Stern

