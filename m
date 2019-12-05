Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BD3C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB752245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sq8wL7AJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfLEMGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:06:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40425 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:06:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id z22so3279812qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 04:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=F6zHO/WCNUOJMFt0div43uU4YpgZXs8QE00GO2bNAOk=;
        b=sq8wL7AJ/+Mo4kdKlEjtVjVm2c/Kq/drIwY4aK59mtehKOQFqbYhnfUPP9a9T7XBP5
         llKuSWKB+Iq09BIfDEE11CvsUde33Jst5tMP8UjZglnByVypwtPnrJv1w2U0ZNjKQfqe
         he5q107St5f2RZEigfpMn9FVtBSs3ngX9ps9lxSUlm9UJIP26lR3KpAiuNHAW8nVBe4V
         xLsa2kAC9b9QL4MV/UKcoCnjOOkTKuTah7l5yb6oGU0YMIRRg+Bq6DnZxp28wHkcIEHs
         jwGCrvjtZU7fUDOXvNu25Tlw59oh9pgV/LwiUB73yMCksXnBt1P8O7shPafOjczJxJ4s
         Fefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=F6zHO/WCNUOJMFt0div43uU4YpgZXs8QE00GO2bNAOk=;
        b=bGz9TWsdHSwYGiQxMk30tqfgUZ8rnXcRFAGtIuXGjzOr4246tO4BAgyKwG+VdCoaA8
         RIXdqJggZAYg2aDZE8uI7e4Ej54Ydr5qc6ULFNKCatAYMR6IjiwuY4iXpnOaIHJUEmRc
         Q3AkQvn8MQ5Rpef5NbmWAYbfMzCBJOmbW5YS/loQ1Gg+B+cAmhWULUbs2J9MQgHpysfO
         gpM4ikXDYKyfU9ye34DnkexrKfDtbx6cWzVIos0mt9Tv6fo8vWUVyqOCdZCqxVg1I39G
         W85q5E3wBFTdsZ487KVVpVO4p80o9iTtRcikzuOIQ/tVJ9QTBOw/6aDaZKv3kx9LUI37
         RNKg==
X-Gm-Message-State: APjAAAXC8GDKwLfIg3zj+Owsw9Y1lvO2akFkxZXHUyhPBe+MJBWRePhP
        5R/e9sO8ri9P1wQjnMTud2E3D1xiE1cx1ZxSxhsr/g==
X-Google-Smtp-Source: APXvYqxK7xrHkUmgrCjpi9ygm1HQIqL3Jgeu8IJMBF2nFA4+2cZshObi4EtuL33VHl3sWGSpOux7oC+IFCOGraccxWU=
X-Received: by 2002:ac8:2489:: with SMTP id s9mr7142276qts.257.1575547594783;
 Thu, 05 Dec 2019 04:06:34 -0800 (PST)
MIME-Version: 1.0
References: <00000000000096009b056df92dc1@google.com> <beffba5d-e3d7-8b06-655b-bd04349177ea@kernel.org>
 <20191205100047.GA11438@Johanness-MacBook-Pro.local> <CACT4Y+Z-9g59XTwpfW+3fv1_jhbsskkvt8E8fx5F44BjofZ0ow@mail.gmail.com>
 <20191205113838.GC11438@Johanness-MacBook-Pro.local> <20191205115033.GJ2734@suse.cz>
In-Reply-To: <20191205115033.GJ2734@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Dec 2019 13:06:23 +0100
Message-ID: <CACT4Y+Z9QezPoc-8nASbK0Bi_ihF=knQ2ngeO8ibdRWbdkEH5g@mail.gmail.com>
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

On Thu, Dec 5, 2019 at 12:50 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Dec 05, 2019 at 12:38:38PM +0100, Johannes Thumshirn wrote:
> > On Thu, Dec 05, 2019 at 11:07:27AM +0100, Dmitry Vyukov wrote:
> > > The correct syntax would be (no dash + colon):
> > >
> > > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
> > > close_fs_devices
> >
> > Ah ok, thanks.
> >
> > Although syzbot already said it can't test because it has no reproducer.
> > Anyways good to know for future reports.
>
> According to
>
> https://syzkaller.appspot.com/bug?id=d50670eeb21302915bde3f25871dfb7ea43db1e4
>
> there is a way how to test it, many reports and the last one about a
> week old. Is there a way to instruct syzbot to run the same tests on a
> given branch?
>
> (The reproducer is basically setting up environment with limited amount
> of memory available for allocation and this hits the BUG_ON.)

syzkaller does this ("rerun the same tests") for every bug always. If
it succeeds (kernel crashes again), it results in a reproducer, that
can later be used for cause/fix bisection and patch testing. In this
case it does not reproduce, so rerunning the same tests will not lead
to anything useful (only if to false confirmation that a patch fixes
the crash).

There is a large number of reasons why a kernel crash may not
reproduce. It may be global accumulated state, non-hermetic tests,
poor syzkaller btrfs descriptions (most likely true) and others.

Need to take a closer look, on first sight it looks like something
that should be reproduced...
