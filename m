Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B97C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F7A207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYtJmv6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJPMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:12:08 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38640 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:12:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so16697270qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DqJ7eGZMr1qeqh+aIXxS2c2AcIbcPXeu9bzyHF9Ax44=;
        b=DYtJmv6nYnCFMrqz7yj7vRcbzCofqG0i3za6QMJp02W+m73MNzloxjFVx83RicwfP2
         o9DyiFkodPq3CTBMeNFscRZY04HWm3PB1S8jMePSSWj+CNym71N9Zmb9AGNTFTiwaW49
         n/fqbqtX39bewtOuJDctXSswjFyZFdh3iB/U3MNV+nOxv+vk/8bUQCZegmAZTLEpCIRQ
         p9mibYCYITZ+SEYPDadSeKr0+pmD96/+QeQBd2T2SopXXzv6o3UejRjp/HmZx/E5R0Xi
         eWQc0GWrlFI+dEUfZpm+BvV8jLBFy7f4fOvkKVHB/FYRYRJG+nrNz4RL2pFjT6GE9Sfa
         7ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DqJ7eGZMr1qeqh+aIXxS2c2AcIbcPXeu9bzyHF9Ax44=;
        b=au5NoQIydHtbCsjZF24KWC5keCWhbLptMc54D+cjhGMuc9PqRE6rTrf0BahZ6hEV6o
         CsphyMKUdb90Pri1dG8HiBHZB6Kja6ZTI266C8vQVNinl2m2irY3g40/ol0xyaRds+NZ
         1/mhZxk3ryLOkXOyncof+7ZpLFGEPVqfGNzFLko+BVzZNv8jVigFjZAopEPLvRvhKsmC
         LcT/PfQueYg4z2TIz8yJcgx4H54j/JkbGfJkJnXqGTcGR7I2F7SFOK/CJys346xB13pL
         3eP6jz1hQAm1fFwiWdzPLwgJ7wT/LnsXH0MTBWh2ATn0pmRrUG3yZnEXTgP0APtRqAZs
         DUsg==
X-Gm-Message-State: APjAAAWyBgJbbEIM1TvoDFZ6P2sZD/xYe7PqXqlE+GR80ub8Y+y04trK
        JDci4UxpVZhee6AwzJ3DJeiw9KaGph7fbSRFS6NpxA==
X-Google-Smtp-Source: APXvYqz42MGesULJvAZKpybp705MD/l+eR9isKEXXoyZQjybjJ6bkgrJCAv90qChWLOnSEzlJZPoVFtV3AsEPJ9BgD0=
X-Received: by 2002:ae9:e50c:: with SMTP id w12mr28795896qkf.407.1575990726561;
 Tue, 10 Dec 2019 07:12:06 -0800 (PST)
MIME-Version: 1.0
References: <00000000000096009b056df92dc1@google.com> <beffba5d-e3d7-8b06-655b-bd04349177ea@kernel.org>
 <20191205100047.GA11438@Johanness-MacBook-Pro.local> <CACT4Y+Z-9g59XTwpfW+3fv1_jhbsskkvt8E8fx5F44BjofZ0ow@mail.gmail.com>
 <20191205113838.GC11438@Johanness-MacBook-Pro.local> <20191205115033.GJ2734@suse.cz>
 <CACT4Y+Z9QezPoc-8nASbK0Bi_ihF=knQ2ngeO8ibdRWbdkEH5g@mail.gmail.com>
In-Reply-To: <CACT4Y+Z9QezPoc-8nASbK0Bi_ihF=knQ2ngeO8ibdRWbdkEH5g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Dec 2019 16:11:55 +0100
Message-ID: <CACT4Y+Zv3xJ5bDbHfUbPxC=Xwb06VB31A2rLo+f2fhBaB4g=sw@mail.gmail.com>
Subject: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
To:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 1:06 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > The correct syntax would be (no dash + colon):
> > > >
> > > > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
> > > > close_fs_devices
> > >
> > > Ah ok, thanks.
> > >
> > > Although syzbot already said it can't test because it has no reproducer.
> > > Anyways good to know for future reports.
> >
> > According to
> >
> > https://syzkaller.appspot.com/bug?id=d50670eeb21302915bde3f25871dfb7ea43db1e4
> >
> > there is a way how to test it, many reports and the last one about a
> > week old. Is there a way to instruct syzbot to run the same tests on a
> > given branch?
> >
> > (The reproducer is basically setting up environment with limited amount
> > of memory available for allocation and this hits the BUG_ON.)
>
> syzkaller does this ("rerun the same tests") for every bug always. If
> it succeeds (kernel crashes again), it results in a reproducer, that
> can later be used for cause/fix bisection and patch testing. In this
> case it does not reproduce, so rerunning the same tests will not lead
> to anything useful (only if to false confirmation that a patch fixes
> the crash).
>
> There is a large number of reasons why a kernel crash may not
> reproduce. It may be global accumulated state, non-hermetic tests,
> poor syzkaller btrfs descriptions (most likely true) and others.
>
> Need to take a closer look, on first sight it looks like something
> that should be reproduced...

Yes, there was a bug around image mount reproduction. Should be fixed
now by https://github.com/google/syzkaller/commit/cb704a294c54aed90281c016a6dc0c40ae295601
