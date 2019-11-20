Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA24C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E54B20674
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfKTQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:14:07 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34456 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729292AbfKTQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:14:06 -0500
Received: (qmail 2044 invoked by uid 2102); 20 Nov 2019 11:14:05 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2019 11:14:05 -0500
Date:   Wed, 20 Nov 2019 11:14:05 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Pete Zaitcev <zaitcev@redhat.com>,
        syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>
cc:     arnd@arndb.de, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in mon_bin_vma_fault
In-Reply-To: <0000000000002da08e0597c5efbd@google.com>
Message-ID: <Pine.LNX.4.44L0.1911201109500.1498-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019, syzbot wrote:

> syzbot has bisected this bug to:
> 
> commit 46eb14a6e1585d99c1b9f58d0e7389082a5f466b
> Author: Pete Zaitcev <zaitcev@redhat.com>
> Date:   Mon Jan 8 21:46:41 2018 +0000
> 
>      USB: fix usbmon BUG trigger

Here's part of the commit description:

    USB: fix usbmon BUG trigger
    
    Automated tests triggered this by opening usbmon and accessing the
    mmap while simultaneously resizing the buffers. This bug was with
    us since 2006, because typically applications only size the buffers
    once and thus avoid racing. Reported by Kirill A. Shutemov.

As it happens, I spent a little time investigating this bug report just
yesterday.  It seems to me that the easiest fix would be to disallow
resizing the buffer while it is mapped by any users.  (Besides,
allowing that seems like a bad idea in any case.)

Pete, does that seem reasonable to you?

Alan Stern

