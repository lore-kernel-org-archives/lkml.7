Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E90C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13A8205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfHFTNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:13:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43896 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726058AbfHFTNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:13:42 -0400
Received: (qmail 6915 invoked by uid 2102); 6 Aug 2019 15:13:41 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Aug 2019 15:13:41 -0400
Date:   Tue, 6 Aug 2019 15:13:41 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <miquel@df.uba.ar>, <rio500-users@lists.sourceforge.net>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: possible deadlock in open_rio
In-Reply-To: <00000000000088af91058f0fe377@google.com>
Message-ID: <Pine.LNX.4.44L0.1908061509040.1571-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=136b6aec600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> dashboard link: https://syzkaller.appspot.com/bug?extid=7bbcbe9c9ff0cd49592a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.3.0-rc2+ #23 Not tainted
> ------------------------------------------------------

Andrey:

This should be completely reproducible, since it's a simple ABBA
locking violation.  Maybe just introducing a time delay (to avoid races
and give the open() call time to run) between the gadget creation and
gadget removal would be enough to do it.

Is there any way you can test this?

Alan Stern

