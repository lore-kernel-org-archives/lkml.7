Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED3C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB902064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh7H/qQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfDVLIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:08:16 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34610 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfDVLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:08:16 -0400
Received: by mail-yw1-f65.google.com with SMTP id u14so2343463ywe.1;
        Mon, 22 Apr 2019 04:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wzn2kZUNMTXZ00Yns3rv3rVNZZF5U8eI12+m33bJrvU=;
        b=Dh7H/qQYZmdfCPB6rw1Cthl+jm2VX/+BYsZivsjZ3aJJmBhWlZNs9FwKKM/rXh86tU
         yAYGYtiirJ5K/xrGY8S+CWijbce5yJ44yZW4/jFbPPaKIYFqjvd4Kt2HrIK7bpBG88mv
         zWgcRnNxahHXAbF2YB7jsDC2iQ6DeTr9RBRxnE0mvyKAQmtZ6+SdMk5lIF2sK5v68Wzi
         N0jjod1qdFWkUOXbYpNAP/R0jwqhKkIgWtLcklUtcCBNNy0ZGdCM3TBRWNMyn71UyKbo
         Pd+mfyZIh8f0IJhxNdoew826ewjd1i0hRVw93vvVj6vd30VeX+RCupJpkm+xdHUatn+o
         xXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wzn2kZUNMTXZ00Yns3rv3rVNZZF5U8eI12+m33bJrvU=;
        b=CY8on2pKwKjgTvTD0ziu2U/fFrLHqx4SwYXM92bKFpsUcl084l7GrL1cciUxYR1Ers
         +9f+4nQeH9uWHIuGYPDBDiBNM5oCeV8WntSaA8WsaLS+WqtPGwB61JqTW0d7P9Zn4AgS
         qMHhrZraQUR764iJlhXzN3rkaM3CFg8LuupLd2/M43RGzRyjVeKpuUjD/WaD2aph2frE
         z3cLEiEUnY6mR282oDr07KygjKgDb228BBZuvH5bjlkIMehre0v6V8Gd1Plm1htqYr0/
         +unXoRwkc5g+pbPmNCmOLBABo0PV9RxdJbGzJ/YkPDVwhdj9mVf954//TkE1Ri6ao6P5
         99lQ==
X-Gm-Message-State: APjAAAXV+fHkS0K9pfO1FuQ+ws4HPV52Ji+MMFb266+0fAZ9pLkFlmyD
        udk5MMInkLjeJ54ffupAGAuuFX+y1DiBAiJEE28=
X-Google-Smtp-Source: APXvYqyA9Or6ouddse5nJxkVJAiS6Br96xlnrV4fm88b1pvwr8Dr8gTdkvpWmWwlUI7F0T9rKFXeTUXi5B9Usv7DauI=
X-Received: by 2002:a0d:ff82:: with SMTP id p124mr15936292ywf.409.1555931294871;
 Mon, 22 Apr 2019 04:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000064bcf057a59e3b9@google.com> <0000000000004f7f7c0584fe33c0@google.com>
 <CAOQ4uxjOm+VFyTbm=2k1d0774qu2tK5gzEgKNnRPjd0GvMnihA@mail.gmail.com> <CACT4Y+bcm2PuX0=1miyXa4pSb2jU0nvp+9eyYwmavVncxB5JXQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bcm2PuX0=1miyXa4pSb2jU0nvp+9eyYwmavVncxB5JXQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Apr 2019 14:08:03 +0300
Message-ID: <CAOQ4uxhyn8-FWRx4kSW4WZWHUTigJH0ATMQQLq6QSCCCYhZibg@mail.gmail.com>
Subject: Re: WARNING in ovl_instantiate
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 1:12 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Apr 19, 2019 at 11:21 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Mar 26, 2019 at 2:10 PM syzbot
> > <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this bug to:
> > >
> > > commit 01b39dcc95680b04c7af5de7f39f577e9c4865e3
> > > Author: Amir Goldstein <amir73il@gmail.com>
> > > Date:   Fri May 11 08:15:15 2018 +0000
> > >
> > >      ovl: use inode_insert5() to hash a newly created inode
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176da0cd200000
> > > start commit:   de6629eb Merge tag 'pci-v5.0-fixes-1' of git://git.kernel...
> > > git tree:       upstream
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=14eda0cd200000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10eda0cd200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=9c69c282adc4edd2b540
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c7a94f400000
> > >
> > > Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com
> > > Fixes: 01b39dcc9568 ("ovl: use inode_insert5() to hash a newly created
> > > inode")
> > >
> >
> > Dmitry,
> >
> > The root cause of this bug is that repro is mounting overlapping overlay
> > layers (i.e. upperdir=./file0,lowerdir=.:file0).
> > Miklos claimed that the fix should be to fail such mounts.
> > Below is a patch to test:
> >
> > #syz test: https://github.com/amir73il/linux.git ovl-check-overlap
> >
> > However, I see that this specific overlapping layers mount has already
> > mutated to several other repros out there, like the ones in this bug:
> >
> > https://syzkaller.appspot.com/bug?extid=a55ccfc8a853d3cff213
> >
> > I believe that disallowing overlapping layers will silence some
> > bugs, whose root cause may be different.
> >
> > Besides doing the overlapping layers mount, this repro family also
> > does extensive access to overlay underlying layers concurrently
> > with overlay access and *that* is the root cause for most of these
> > "possible deadlock" bugs (some false positives and some real).
> >
> > Assuming that ovl-check-overlap will get merged, you may need to
> > hint syzkaller that overlapping layers is no longer a valid input or
> > maybe it will figure it out on its own?...
>
> Hi Amir,
>
> It should figure it out on its own, it's coverage-guided fuzzer. And
> unlearning things is easier then learning them :) But thanks for
> thinking about this.
> But maybe there is something else important in overlayfs that's not
> covered. Here you can see the current coverage of overlayfs:
> https://storage.googleapis.com/syzkaller/cover/ci-upstream-linux-next-kasan-gce-root.html#e2f448f0ca2e4397fd609ff8c42d4cd118411148

That's nice, but the actual possible deadlocks that syzbot has currently
unveiled are not strictly by covering overlayfs code but rather by covering
VFS code that is *also* used by overlayfs.

See this thread for example:
https://lore.kernel.org/lkml/CAJfpegvt6eVhX8v5faMP76K0LEkqKFDQE8gyNOinxonRdjq3eA@mail.gmail.com/

Documentation/filesystems/overlayfs.txt says:
"Changes to the underlying filesystems while part of a mounted overlay
filesystem are not allowed.  If the underlying filesystem is changed,
the behavior of the overlay is undefined, though it will not result in
a crash or deadlock."

The part of "will not result in crash or deadlock" is only proven
empirically, so long as syzbot is not reproducing a crash or deadlock...

Thanks,
Amir.
