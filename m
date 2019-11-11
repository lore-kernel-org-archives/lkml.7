Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D4FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0309722459
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fykSer/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfKKSo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:44:58 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:38005 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfKKSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:44:54 -0500
Received: by mail-il1-f170.google.com with SMTP id u17so8126385ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4BpCjYzPkx26Lry+SSYhIxQ+3eUNFix400wW4/08qQ=;
        b=fykSer/Nt12/oYUdAecve96EfZTE//MBbtTG4FkrK4dRROCaVT8fpeZFAYJzSbeMxO
         rOWo+yxd0tosbFqAsh5bPDuDKBMvvqDlvwBqgTgV7uku2N16SLVk41LoXrgI7jeMaiSq
         2i5CNda2++JlhpdIuyI4zcTC+fd9qJJq9B+7bm4UEdR/FPBmQWK5+xh8zuUkV8hEMVS8
         BCMrROkBrUOOAmiSig4g9/Pq71FzTcRcVdJ7KwstUr1O+GDT/VTqUmF4rJZDe/kNHfKL
         U5A8dQe5fxNixxg//Usggoq173wp6UQsVUO1zEwXSTD86cn6IVL+UJtjmDnLwycW60fj
         2JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4BpCjYzPkx26Lry+SSYhIxQ+3eUNFix400wW4/08qQ=;
        b=YL3+t7sBZOttLz2drbJO0/L38zWj7lXj5ts6vTkxm7RD1QRl1byXFVw9MJ3UQfDNlt
         O9N7yk2QhMGb21mF1MU8Tn/H0ydJHSiRuxNhiEt2qQnAUN4v/NEsbPe0HVI7NKxmMpLZ
         Z0lIA9Ua6t7dgO8tYzT8shzOYAo8mTMVyzHt2ECDdK1R4FTVH6B+3s6nSIhnHG6cn63r
         YfFCpOhf4JPbsrB+y97qSyMVpJofVW4yfoBN+bUULgpcmh0aeuj3ji0AWZWvr0DCKVH/
         jnmGimwvjBxCMuxWAL+aIg45q6nYf57opycfdAfGWnfEWO0OOFuE1B5Rsw3z7O8dRO+Y
         eBGA==
X-Gm-Message-State: APjAAAVut+plfOfqqCKr+9ZMwn3YZ4ERPC5PN4W6AaGei6TeadYJ3UEC
        6qxmPXfSBWlv27DwJRd+C8aQ1zJE5e27t43J4AsTAQ==
X-Google-Smtp-Source: APXvYqxZu5qGd+xUFwg7SMnSekBxnWYvigjk8QXdOJkg6GuKnqYxiS3POTOk/MiaTkcf1jIZUsnONLZwYJGSXtWsVMs=
X-Received: by 2002:a92:ba1b:: with SMTP id o27mr32680944ili.269.1573497892803;
 Mon, 11 Nov 2019 10:44:52 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com> <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
In-Reply-To: <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 11 Nov 2019 10:44:41 -0800
Message-ID: <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:31 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Nov 11, 2019 at 10:05 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Nov 11, 2019 at 9:52 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > Now I wonder what to do with the ~400 KCSAN reports sitting in
> > > pre-moderation queue.
> >
> > So regular KASAN reports are fairly easy to deal with: they report
> > actual bugs. They may be hard to hit, but generally there's no
> > question about something like a use-after-free or whatever.
> >
> > The problem with KCSAN is that it's not clear how many of the reports
> > have been actual real honest-to-goodness bugs that could cause
> > problems, and how many of them are "this isn't actually a bug, but an
> > annotation will shut up KCSAN".
> >
> > My gut feeling would be that it would be best to ignore the ones that
> > are "an annotation will shut up KCSAN", and look at the ones that are
> > real bugs.
> >
> > Is there a pattern to those real bugs? Is there perhaps a way to make
> > KCSAN notice _that_ pattern in particular, and suppress the ones that
> > are "we can shut these up with annotations that don't really change
> > the code"?
> >
> > I think it would be much better for the kernel - and much better for
> > KCSAN - if the problem reports KCSAN reports are real problems that
> > can actually be triggered as problems, and that it behaves much more
> > like KASAN in that respect.
> >
> > Yes, yes, then once the *real* problems have been handled, maybe we
> > can expand the search to be "stylistic issues" and "in theory, this
> > could cause problems with a compiler that did X" issues.
> >
> > But I think the "just annotate" thing makes people more likely to
> > dismiss KCSAN issues, and I don't think it's healthy.
> >
>
> Problem is that KASAN/KCSAN stops as soon as one issue is hit,
> regardless of it being a false positive or not.
>
> (Same happens with LOCKDEP seeing only one issue, then disabling itself)
>
> If we do not annotate the false positive, the real issues might be
> hidden for years.
>
> There is no pattern really, only a lot of noise (small ' bugs'  that
> have no real impact)

An interesting case is the race in ksys_write()

if (ppos) {
     pos = *ppos; // data-race
     ppos = &pos;
}
ret = vfs_write(f.file, buf, count, ppos);
if (ret >= 0 && ppos)
    f.file->f_pos = pos;  // data-race

BUG: KCSAN: data-race in ksys_write / ksys_write

write to 0xffff8880a9c29568 of 8 bytes by task 27477 on cpu 1:
 ksys_write+0x101/0x1b0 fs/read_write.c:613
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x4c/0x60 fs/read_write.c:620
 do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
