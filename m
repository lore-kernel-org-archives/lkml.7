Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC89C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC221670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfD3NtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:49:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfD3NtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FC84AC44;
        Tue, 30 Apr 2019 13:49:19 +0000 (UTC)
Message-ID: <1556632146.20085.36.camel@suse.com>
Subject: Re: KASAN: invalid-free in disconnect_rio
From:   Oliver Neukum <oneukum@suse.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Cesar Miquel <miquel@df.uba.ar>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rio500-users@lists.sourceforge.net,
        syzbot <syzbot+35f04d136fc975a70da4@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Tue, 30 Apr 2019 15:49:06 +0200
In-Reply-To: <CAAeHK+w-miwjw78hbUmACgVhr+hbCN31SF+fNeEtdMn7-9=O+A@mail.gmail.com>
References: <0000000000008d15ee058653b53e@google.com>
         <1556629116.20085.32.camel@suse.com>
         <CAAeHK+w-miwjw78hbUmACgVhr+hbCN31SF+fNeEtdMn7-9=O+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2019-04-30 at 15:02 +0200, Andrey Konovalov wrote:
> On Tue, Apr 30, 2019 at 2:58 PM Oliver Neukum <oneukum@suse.com> wrote:
> > 
> > On Fr, 2019-04-12 at 04:36 -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=174ce2e3200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=35f04d136fc975a70da4
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138150f3200000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1290c22d200000
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+35f04d136fc975a70da4@syzkaller.appspotmail.com
> > > 
> > > usb 6-1: USB disconnect, device number 2
> > > rio500 3-1:0.110: USB Rio disconnected.
> > > usb 4-1: USB disconnect, device number 2
> > > ==================================================================
> > > usb 1-1: USB disconnect, device number 2
> > > BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3003 [inline]
> > > BUG: KASAN: double-free or invalid-free in kfree+0xce/0x290 mm/slub.c:3958
> > > usb 2-1: USB disconnect, device number 2
> > > 
> > 
> > Try as I might, I don't understand this. I can see a memory leak,
> > but not a double free.
> 
> I took a look at this some time ago, and I was under the impression
> that this driver doesn't handle multiple devices being connected at
> the same time well.


You are right. A global variable is used. A fix is being worked on.

	Regards
		Oliver

