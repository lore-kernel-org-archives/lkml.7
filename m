Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1A3C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3D42073F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfIDPXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:23:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47066 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731173AbfIDPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:23:25 -0400
Received: (qmail 4826 invoked by uid 2102); 4 Sep 2019 11:23:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2019 11:23:24 -0400
Date:   Wed, 4 Sep 2019 11:23:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+35f4d916c623118d576e@syzkaller.appspotmail.com>,
        <Thinh.Nguyen@synopsys.com>, <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <jflat@chromium.org>, Kai Heng Feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, <malat@debian.org>,
        <mathias.nyman@linux.intel.com>, <nsaenzjulienne@suse.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: slab-out-of-bounds Read in usb_reset_and_verify_device
In-Reply-To: <CAAeHK+xegKOayZw+kvw7ndA4v6Fy77rNM_VQnufZWXEHSjoqhg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1909041120330.1722-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019, Andrey Konovalov wrote:

> On Wed, Sep 4, 2019 at 4:41 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, 3 Sep 2019, syzbot wrote:
> >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer still triggered
> > > crash:
> > > KASAN: slab-out-of-bounds Read in usb_reset_and_verify_device
> > >
> > > usb 6-1: Using ep0 maxpacket: 16
> > > usb 6-1: BOS total length 54, descriptor 168
> > > usb 6-1: Old BOS ffff8881cd814f60  Len 0xa8
> > > usb 6-1: New BOS ffff8881cd257ae0  Len 0xa8
> > > ==================================================================
> > > BUG: KASAN: slab-out-of-bounds in memcmp+0xa6/0xb0 lib/string.c:904
> > > Read of size 1 at addr ffff8881cd257c36 by task kworker/1:0/17
> >
> > Very sneaky!  A BOS descriptor whose wTotalLength field varies
> > depending on how many bytes you read.
> >
> > This should fix it.  It's the same approach we use for the Config
> > descriptor.
> 
> Nice, core USB bug :)
> 
> Can this potentially lead to something worse than a out-of-bounds memcmp?

I tend to doubt it.  It would require some code that does its own
parsing of the BOS descriptors.  If there is any code like that in the
kernel, I'm not aware of it.

Still, you never know...

Alan Stern

