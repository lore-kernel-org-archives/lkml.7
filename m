Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31368C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B1E21734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FqYKtQqQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YLbWNhEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfD3PkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:40:10 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55205 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbfD3PkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:40:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0C4D779C;
        Tue, 30 Apr 2019 11:40:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Apr 2019 11:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=im7oD5qEY2zhcFnJGGzg2Qlw0IY
        OGi07CNykA7KpG74=; b=FqYKtQqQ/6eMcn2BKplv+JRDlcoyz5PdmBzSx8kHGGV
        TF/E0rvdRiXSvZ1LjFYqIaifS4nWequszxQ2L4qk/wIDPwEQb+AYRqlrM/2xmSDt
        ZvT2VxgA9SNG/jO6cv30eTgkfmmwL9Y+sLRd2tEIcQ+ObDqGJ06T4kBoKMm6NhsV
        /JbmhqNc05AyI555wr5Hg03CQGSL2qb8YaUjN8VhYtIV/VcKrpDncyB6u0/B/T39
        0M4T0HBXCf0ZNdSLxBO+aJEBuLdoqLB1g1jUcrdkarFyIV7TONwK9qy105Qzw4TI
        v1OS40C63GDmXkJD+CzgbZfnnc/pl6F89on2UBMrnLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=im7oD5
        qEY2zhcFnJGGzg2Qlw0IYOGi07CNykA7KpG74=; b=YLbWNhEbJPL9tS44Iiaqwm
        WN8qZEOw+YA2mOuVFiPzPwwLa/8OA4waAm9i0UT4ziFZatywspiJRMhHRSesxv5Z
        g4LSLSLwHlw+uTAQo/tHpmApdH3sUtpJuogCgySe8nl7fP1iQbM71287e5EUjYyd
        SNPKs24e78+mmAk0uENriafIg4kQvum5s+j2XSp1U7mJuFLb2Za2rraS9KjVJy5P
        j0fbtQtptk0wpjLdsjoqxnhCd4uXQP0J6KZD+1LjhTtcvTobA6C9lX/mgt5VuMPe
        Hipnd9yEbTHoeIN3cWlsVmjbC/ZyBa1tZm8lVTNusfCkd+t6pB/WssufnbmC0IKg
        ==
X-ME-Sender: <xms:WGzIXIcinPOrH_7j973CBKsOJQLB0icS3dE8hIVllvEqSbQZ7NU5-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieehgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvuffkfhggtggujggf
    sehttdertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrd
    gtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgohhordhglhdprghpphhs
    phhothdrtghomhenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:WGzIXMDLv2g20YuJ82OjmnuuA2kiPwrZLo9oN_bUp96vLyTJ7nZi0A>
    <xmx:WGzIXIpevVaZdu_ueJ5dqLAJjhnBrsV-XjW6bXbtcEexOa7dK5UkWw>
    <xmx:WGzIXBTGoriUMXlH2B_E1vVzaKBYsA-puOg0ioscmR_UNV49Sz_iNg>
    <xmx:WGzIXE0zUZ00VjdPzF5TISIwOjik-iSgmv3V5XigjPn8rPYNCCTWYQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 32D37E4176;
        Tue, 30 Apr 2019 11:40:06 -0400 (EDT)
Date:   Tue, 30 Apr 2019 17:40:00 +0200
From:   Greg KH <greg@kroah.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING: Support for this device (Terratec Grabster AV400) is
 experimental.
Message-ID: <20190430154000.GB23459@kroah.com>
References: <0000000000004101370587c052fb@google.com>
 <Pine.LNX.4.44L0.1904301058150.1465-100000@iolanthe.rowland.org>
 <CAAeHK+zYQ0QF_vo+iYns2d0O7RZ=Uq0kxi1mWc1W_0bBxMGR0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zYQ0QF_vo+iYns2d0O7RZ=Uq0kxi1mWc1W_0bBxMGR0A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:14:28PM +0200, Andrey Konovalov wrote:
> On Tue, Apr 30, 2019 at 5:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, 30 Apr 2019, syzbot wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=141ca62d200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=af8f8d2ac0d39b0ed3a0
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1405bedd200000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ce3bbb200000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com
> > >
> > > usb 1-1: New USB device found, idVendor=0ccd, idProduct=0039, bcdDevice=
> > > d.3c
> > > usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > > usb 1-1: config 0 descriptor??
> > > pvrusb2: Hardware description: Terratec Grabster AV400
> > > pvrusb2: **********
> > > pvrusb2: WARNING: Support for this device (Terratec Grabster AV400) is
> > > experimental.
> > > pvrusb2: Important functionality might not be entirely working.
> > > pvrusb2: Please consider contacting the driver author to help with further
> > > stabilization of the driver.
> > > pvrusb2: **********
> > >
> > >
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > This does seem like a bug in syzbot.  Why does it think this pr_info()
> > output indicates a crash?  Is it fooled by the capitalized "WARNING" at
> > the start of one of the lines?
> 
> Well, as of [1] WARN*() should only be used to indicate a kernel bug.
> Normally, WARN*() prints a line that start with a warning, which is
> followed by a stack trace. Unfortunately the stack trace is not always
> present (kernel memory is badly corrupted, console deadlocked, etc.),
> so syzbot detects the "WARNING:" line as a beginning of a WARN*()
> reported bug. In this case the driver does something like
> `pr_info("WARNING: ...", ...)`, which confuses syzbot. I'd say it's
> the kernel that needs to be changed here to use some other kind of
> prefix for printing warning messages.
> 
> [1] https://github.com/torvalds/linux/commit/96c6a32ccb55a366054fd82cc63523bb7f7493d3

Ok, we can change these to "Warning" then.  Want to send a patch?

thanks,

greg k-h
