Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65884C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449542171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLMR5KdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfIQSEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:04:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45950 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfIQSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:04:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id 4so2395490pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yK6Y+qZKl2iwWtG42hVK5zE4CNkVwf5HJTH9NnCzGPA=;
        b=rLMR5KdAbGzYVSITpBQ/vmU2krVc48UPg4fEldL0SCySEeKE3+xJ0e7kseGX2mwdY0
         7DtF71ZtK3yRUwuH/7dtRDWxUqCgmgqBfz08fF4s/3tbQTN76zcxAzQu9Tr0xy0cgED4
         Wu7BjxS537qF+rR9/rze0cCekS1+6pEXTyz1xnzLrKP+sS7N7s6YzVNH9Btpu+4DaAXi
         s/d413O+p0NP7vnB4BA9fSAuM5QIGcf+qfr4ewH++9ri0+E+tUtd5fR3zR/cux6919BX
         6rDaR9aeJ5K9coX6FJIhrM12E2RHGcEK6MBGL5C2LZ6gxxtZlE3GuHiyxhhWVHPzue0Z
         WFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yK6Y+qZKl2iwWtG42hVK5zE4CNkVwf5HJTH9NnCzGPA=;
        b=cTOqk7hor4FFs6LtchEt9X1kVq8kfghOwHk3coenhwXBc1YDnWKvuDKh01AJWej7ww
         CtgHiUFIsN/R+MayetRdnhtXooBHtbHh8myRFvI45MOdeK21nkBvEnRmb8A0T+4sfVON
         R+15KoULl+q2A/xU3w3acTL1NjxA4BodA9OBD+Im1j6Wo82r9mxNzxquQ620uBOYalIN
         OGTXmWOODgF+qRorViVN+avkxOdhGB3pVOVpoxqf36UxhPKVPU/H/WlUL+MvLkO555zw
         gbib2XcyLgB1zJAuI9sjjBQwvjq2zq88AH+Zb/ZigEIMNAKIFwxTF5yiAxUwUFA3ojHq
         X/vA==
X-Gm-Message-State: APjAAAV0PIElVC92UK9yngs2BJsC8pvw6gJs4wjG9JUG8rHBO9m55Rkp
        ndbvyDY+WezF81z+1T3/rLQUvRFv5hlqaet9whv+5A==
X-Google-Smtp-Source: APXvYqzol2HP8WtBLCt51czMcErewdzFgxppXEGOjwTdI5bce+bz+0ywaRqx+sMgIc9+oiUKRbiC8hQEP8MnLuVr4o8=
X-Received: by 2002:a63:3006:: with SMTP id w6mr103047pgw.440.1568743480853;
 Tue, 17 Sep 2019 11:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+yMaX7LUUXbGj3RDDChdCDp+U_4ePt5PjDWWsrJUk04uw@mail.gmail.com>
 <Pine.LNX.4.44L0.1909171125330.1590-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909171125330.1590-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 17 Sep 2019 20:04:29 +0200
Message-ID: <CAAeHK+z0cRqqf8HOyGhmm_NAUODJRBHp6q7X9c4tUDcNNLENQQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in usb_autopm_put_interface
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e1d1a6e595adbd2458f1@syzkaller.appspotmail.com>,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kai heng feng <kai.heng.feng@canonical.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 5:28 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 17 Sep 2019, Andrey Konovalov wrote:
>
> > On Tue, Sep 17, 2019 at 4:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Tue, 17 Sep 2019, Dmitry Vyukov wrote:
> > >
> > > > On Mon, Sep 16, 2019 at 10:31 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > >
> > > > > On Mon, 16 Sep 2019, syzbot wrote:
> > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    014077b5 DO-NOT-SUBMIT: usb-fuzzer: main usb gadget fuzzer..
> > > > > > git tree:       https://github.com/google/kmsan.git master
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16a7dde1600000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e1d1a6e595adbd2458f1
> > > > > > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > > > > > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176303e1600000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e8f23e600000
> > >
> > > > > This is probably the same problem that was fixed in the Logitech driver
> > > > > earlier.  The fix still appears to be in linux-next (commit
> > > > > 5f9242775bb6).
> > > > >
> > > > > Shouldn't syzbot wait until after the merge window before running tests
> > > > > like this?
> > > >
> > > >
> > > > Merge window is a weak notion and may be not enough either (all trees
> > > > do not necessary update at that point and syzbot does not necessary
> > > > rebuild all of them successfully). syzbot uses another criteria: if
> > > > you say a bug is fixed by commit X, it will wait until commit X
> > > > reaches all of tested trees and will report the same crash signature
> > > > again only after that. This procedure was specifically designed to not
> > > > produce duplicate reports about the same bug.
> > > > So either the bug wasn't really fixed, or this is another bug, or
> > > > syzbot was given a wrong commit.
> > >
> > > Hmmm.  Which are the "tested trees"?
> > >
> > > This bug (e1d1a6e595adbd2458f1) is marked as a duplicate of
> > > 3cbe5cd105d2ad56a1df.  The dashboard link says that bug was fixed by
> > > commit "HID: logitech: Fix general protection fault caused by Logitech
> > > driver" -- which is correct, as far as I know.
> > >
> > > That commit is present in linux-next, as mentioned above.  As of 10:44
> > > EDT today, it is not present in Linus's tree, according to
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/hid/hid-lg.c
> > >
> > > (in fact, no commits affecting drivers/hid/hid-lg.c in that tree are
> > > dated after 2019-07-10).
> > >
> > > Furthermore, according to
> > >
> > > https://github.com/google/kmsan/blob/master/drivers/hid/hid-lg.c?h=014077b5
> > >
> > > the source code actually used by syzbot for this test doesn't have that
> > > commit either.  (BTW, is there any way to get a git log out of github?
> > > It would be nice not to have to download the whole source file -- and
> > > I'm not certain that this URL really does point to the version of the
> > > file that syzbot used.)
> > >
> > > So what's really going on?
> >
> > Please see my response. This report is a different manifestation of
> > the same Logitech bug.
>
> Hmmm.  Does syzbot have any conception of which drivers are exercised
> by a particular test script?  If it doesn't, there's no way to avoid
> getting these duplicate reports.  Still, it is a little annoying for
> the developers.

Yeah, syzbot only looks at reports titles. I'll try to take care of
duplicate USB reports.
