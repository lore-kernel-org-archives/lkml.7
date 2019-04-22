Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93794C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A53206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7aswLyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfDVL7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:59:11 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51154 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVL7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:59:11 -0400
Received: by mail-it1-f193.google.com with SMTP id q14so9874954itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GR4/ak/mdmA9J1dGWXmuJoSLxL6gaRMiCRZUwYc+9Us=;
        b=Q7aswLyvFpbWuPIX0YACn7afa1imuvtlkaSEaFjU0GQ3lDZClLt5I48nnRE7GjCvKw
         V5McG8MY3ovP9pBRSPt0Vf0DLqFz/100zbDnchcsT2llp4Rm4BLCHa7SWys+eQ1Y7eux
         ziZqParx1H16dLAGsQwgz2+l3kVlcH31Ugetr8KixoETHzvMLpphB9CVixtuCiqq99b/
         ypV3hj7iUcy8Y1MH795VpAoTFJYtMs6SFwqkfPZGC1SUKMr1yr/PQedeRaIKxjPrQjAr
         Ul5mOz+9yvqpnb2nieah2yHSkmK/3PBZdmcrfhyfO39dFDnYnlwfH+ZRGFnpvZ1EYE3U
         CKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GR4/ak/mdmA9J1dGWXmuJoSLxL6gaRMiCRZUwYc+9Us=;
        b=k146zSc+IiDfRBNGVaVULvlCp3BXs4OgCJvW4Z+qGr+LvfIJk2EVpxy3z8/qvLmEjg
         6tg2xqOqnIJ5zfLw/KvqrAeYaGsF2wKb8tSq9zJ0fF0ttt19G6q8VQJ+ri7xdVO+LFpj
         LFX/zTG4Pp2z0Cr72SG+vKzee+HxE413f55D21jhHYc4tGTDcHgHqMnPG18y5CBHUvQV
         KguCWqWTK6BEgfGOtU+1UROfkCwEXqh/Bz0eqHDNLedRLbSNvehBQQxS41nV060Ac1UF
         0NCg+RS/dZjpajEuuLrm41XCX8KY22+5esxy59IqUTJTqbSsn9PDYRb/7wEkt6oMBHB3
         MyGg==
X-Gm-Message-State: APjAAAWSITyp2gyjMFvR4noI+4Nk2hJDEq4iWfy2omOmF1sqKAdqmYAL
        K+f5TWa7oFetUKTihOQiu7IbkrQXtbkBBl4jFeyJpg==
X-Google-Smtp-Source: APXvYqx/AyJJf1X231CA0SuYiaMDsEzEF4SgbGc6zVujjr48NsGHu6K+Odg7MQ7PZm1LcLQ2s8LSVIJi5xdVp1uwUz4=
X-Received: by 2002:a24:9584:: with SMTP id m126mr12180739itd.166.1555934350021;
 Mon, 22 Apr 2019 04:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000064bcf057a59e3b9@google.com> <0000000000004f7f7c0584fe33c0@google.com>
 <CAOQ4uxjOm+VFyTbm=2k1d0774qu2tK5gzEgKNnRPjd0GvMnihA@mail.gmail.com>
 <CACT4Y+bcm2PuX0=1miyXa4pSb2jU0nvp+9eyYwmavVncxB5JXQ@mail.gmail.com> <CAOQ4uxhyn8-FWRx4kSW4WZWHUTigJH0ATMQQLq6QSCCCYhZibg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhyn8-FWRx4kSW4WZWHUTigJH0ATMQQLq6QSCCCYhZibg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 22 Apr 2019 14:58:58 +0300
Message-ID: <CACT4Y+ZfCFhZgoNy4kAknQMvzYGPW8hxtSmDD5jCP=R=Y0HEFA@mail.gmail.com>
Subject: Re: WARNING in ovl_instantiate
To:     Amir Goldstein <amir73il@gmail.com>
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

On Mon, Apr 22, 2019 at 2:08 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Tue, Mar 26, 2019 at 2:10 PM syzbot
> > > <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com> wrote:
> > > >
> > > > syzbot has bisected this bug to:
> > > >
> > > > commit 01b39dcc95680b04c7af5de7f39f577e9c4865e3
> > > > Author: Amir Goldstein <amir73il@gmail.com>
> > > > Date:   Fri May 11 08:15:15 2018 +0000
> > > >
> > > >      ovl: use inode_insert5() to hash a newly created inode
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176da0cd200000
> > > > start commit:   de6629eb Merge tag 'pci-v5.0-fixes-1' of git://git.kernel...
> > > > git tree:       upstream
> > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=14eda0cd200000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10eda0cd200000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=9c69c282adc4edd2b540
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c7a94f400000
> > > >
> > > > Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com
> > > > Fixes: 01b39dcc9568 ("ovl: use inode_insert5() to hash a newly created
> > > > inode")
> > > >
> > >
> > > Dmitry,
> > >
> > > The root cause of this bug is that repro is mounting overlapping overlay
> > > layers (i.e. upperdir=./file0,lowerdir=.:file0).
> > > Miklos claimed that the fix should be to fail such mounts.
> > > Below is a patch to test:
> > >
> > > #syz test: https://github.com/amir73il/linux.git ovl-check-overlap
> > >
> > > However, I see that this specific overlapping layers mount has already
> > > mutated to several other repros out there, like the ones in this bug:
> > >
> > > https://syzkaller.appspot.com/bug?extid=a55ccfc8a853d3cff213
> > >
> > > I believe that disallowing overlapping layers will silence some
> > > bugs, whose root cause may be different.
> > >
> > > Besides doing the overlapping layers mount, this repro family also
> > > does extensive access to overlay underlying layers concurrently
> > > with overlay access and *that* is the root cause for most of these
> > > "possible deadlock" bugs (some false positives and some real).
> > >
> > > Assuming that ovl-check-overlap will get merged, you may need to
> > > hint syzkaller that overlapping layers is no longer a valid input or
> > > maybe it will figure it out on its own?...
> >
> > Hi Amir,
> >
> > It should figure it out on its own, it's coverage-guided fuzzer. And
> > unlearning things is easier then learning them :) But thanks for
> > thinking about this.
> > But maybe there is something else important in overlayfs that's not
> > covered. Here you can see the current coverage of overlayfs:
> > https://storage.googleapis.com/syzkaller/cover/ci-upstream-linux-next-kasan-gce-root.html#e2f448f0ca2e4397fd609ff8c42d4cd118411148
>
> That's nice, but the actual possible deadlocks that syzbot has currently
> unveiled are not strictly by covering overlayfs code but rather by covering
> VFS code that is *also* used by overlayfs.
>
> See this thread for example:
> https://lore.kernel.org/lkml/CAJfpegvt6eVhX8v5faMP76K0LEkqKFDQE8gyNOinxonRdjq3eA@mail.gmail.com/
>
> Documentation/filesystems/overlayfs.txt says:
> "Changes to the underlying filesystems while part of a mounted overlay
> filesystem are not allowed.  If the underlying filesystem is changed,
> the behavior of the overlay is undefined, though it will not result in
> a crash or deadlock."
>
> The part of "will not result in crash or deadlock" is only proven
> empirically, so long as syzbot is not reproducing a crash or deadlock...

I see.
Still we generally only teach it interfaces, and then let it loose
combining them and building sequences of syscalls and figuring out
what's interesting and what's not.
