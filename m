Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0494AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1A9205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBGJEnz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfLLP5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:57:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42880 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbfLLP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:57:31 -0500
Received: by mail-qk1-f196.google.com with SMTP id z14so1978166qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKrtTwE5rLBEbmguHHhD5cVctR6tguPMm9hVQ57ihIA=;
        b=fBGJEnz1f9w+kl5VqxPmPljl5lCGULTtHp0qUdajbmHkyxAZbHqkD2qk19LE9iIbVz
         blmAbiPYPWIt/74ASndoQ7luUzNwPrLfLnsks1pLuZI9gSGsFWOD1DAv6GKEp9/bOi3u
         O1pfuSvYI5mWhm1QkYMfEDdgq6yy5cVqjp+rbYLX7nahnokdPNb6GA3byGj8vHKAtS6G
         4Jl3d1k26xAzLb9Vnzg3XISpi9/VqgE8rLY2HzKLufQKla+tQsCngDw74W6WK1ktjh2K
         KDm1Z2WhqeMgGxnDcKWTpNx3/1HI9695J5uvNySzi0ZyGRu2SAbSEUgwJai7ZX8f432K
         8BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKrtTwE5rLBEbmguHHhD5cVctR6tguPMm9hVQ57ihIA=;
        b=WzinZ46DJ2cNCHTv0Z0WE/5dXVi3OkjgfOHGfBZKqZnGntCWge1a3HGTbw9SeFdAYn
         TNYZaJe2wYio0SgM140dFzu951yXiYu9xreTR+tCEeskYIPWccC5N8FjKQYEy9xenr0T
         rgRQkJRv5XNYQLn9LiArH2L4UPogG+rQqX6Hh7i0b1iLkG+MxtDpXHJaxGCApjh56Kf5
         M1lJ3Wt2hcSoW0laKq/RAF+rAcrYPY8gxDWpERjqR0Bs2GSRQjcLuBTCoe4SC/g/oi9M
         RnHGYoCHlOs9Z/QNn3s/lFLC7BRu/AK6gF98YVVnM8eg/4asQ/AZbTgvgbmHicCBoaLs
         AgXQ==
X-Gm-Message-State: APjAAAUOkQZt7ReArLZvIRFibQAJDPV/Tb4zKpIXlTQTTs31jCrlRquX
        F06m7EzJB1H0E/PjOfEzv9Gj3m9sm+ANcopc/+O9Mw==
X-Google-Smtp-Source: APXvYqxvXmMKX9vTZsj2oERFWTTe+/2Ickf/DhM5VT0PtIPdxm8HrjGOVYGAayr35HigEjAsuQehpq1MN+RRe6vu0MI=
X-Received: by 2002:ae9:e50c:: with SMTP id w12mr8090287qkf.407.1576166249543;
 Thu, 12 Dec 2019 07:57:29 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b6b03205997b71cf@google.com> <20191212061206.GE4203@ZenIV.linux.org.uk>
 <CACT4Y+YJuV8EGSx8K_5Qd0f+fUz8MHb1awyJ78Jf8zrNmKokrA@mail.gmail.com> <20191212133844.GG4203@ZenIV.linux.org.uk>
In-Reply-To: <20191212133844.GG4203@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Dec 2019 16:57:14 +0100
Message-ID: <CACT4Y+ZQ6C07TcuAHwc-T+Lb2ZkigkqW32d=TF054RuPwUFimw@mail.gmail.com>
Subject: Re: BUG: corrupted list in __dentry_kill (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 2:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Dec 12, 2019 at 07:48:14AM +0100, Dmitry Vyukov wrote:
> > On Thu, Dec 12, 2019 at 7:12 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Wed, Dec 11, 2019 at 09:59:11PM -0800, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    938f49c8 Add linux-next specific files for 20191211
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=150eba1ee00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=96834c884ba7bb81
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=31043da7725b6ec210f1
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc83dae00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac8396e00000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com
> > >
> > > Already fixed in a3d1e7eb5abe3aa1095bc75d1a6760d3809bd672
> >
> > This commit was in the tested tree already as far as I can see.
>
> Broken version (653f0d05be0948e7610bb786e6570bb6c48a4e75) is there, its
> fixed replacement (a3d1e7eb5abe3aa1095bc75d1a6760d3809bd672) is not.

Right, sorry, I looked only at the title when checked if it's in the
tree or not.

> Look, I realize that your setup is oriented to "followup commit Y fixes
> a bug in earlier commit X", and sometimes it's the only possibility
> (when X has already been in mainline), but in general it's spelled
> "bisection hazard for no damn reason".  Fixes are folded in.
> Routinely.  What's more, in this case the fixed version had been done
> (and pushed out) before syzbot has seen the original, so putting
> any metadata into commit message hadn't been an option.
>
> If there is some format understandable for syzbot for such cases
> ("bug is caused by commit X; Y is a replacement that should not
> exhibit the same bug, so if you see that behaviour on a tree
> that doesn't contain X, report it.  X-containing trees ought
> to go extinct reasonably soon"), please tell what it is.
> Otherwise this situation will keep repeating - I am not going
> to stop folding fixes into developing patches.

I did not find anything that could serve as these X/Y here. Commit
hashes in linux-next are pointless and won't match against other
trees. Commit titles seem to be the best bet for kernel, but this is
exactly the case where they fall short.

But in this case I think we can safely mark this as:

#syz fix:
simple_recursive_removal(): kernel-side rm -rf for ramfs-style filesystems

This should work because syzbot does coarser-grained check than "if
you see that behaviour on a tree that doesn't contain X". Instead it
will wait until _all_ tested trees will have X and only then close the
bug and report it again if it sees it again. Since the commit is
already fixed in linux-next, when all trees including mainline and
bpf/bpf-next will get it, it should be the fixed version.


> Speaking of bisect hazards, I'd recommend to check how your bisect
> went - the bug is definitely local to this commit and I really
> wonder what had caused the bisect to go wrong in this particular
> case.

I did not get the relation of folding to bisection. Or you mean these
are just separate things?
In this particular case the reason seems to be the same as for most
kernel bisections -- too many unrelated bugs layering one onto
another.
If you are interested in more details about why kernel bisection go
wrong in general, I've published a bunch of info here (including
detailed stats on reason):
https://groups.google.com/g/syzkaller/c/sR8aAXaWEF4/m/tTWYRgvmAwAJ
https://github.com/google/syzkaller/issues/1051
https://docs.google.com/spreadsheets/d/1WdBAN54-csaZpD3LgmTcIMR7NDFuQoOZZqPZ-CUqQgA/edit#gid=0
