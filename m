Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B4AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C592133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOHsK+kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfDAQWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:22:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43455 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfDAQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:22:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id u15so9107749otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZ09BE7bZZUYfb3KOySGgcA6QPAtPnUG4ieDO4DHbmg=;
        b=WOHsK+kvahNR5HL4esyJ9CDkg+MZ6Oip8mpOX3usiain5wgd6GPvCJ1YNs40USOzF9
         J1Q5jiUBMXf+9RrQBXhH6cLFVKcV3BPs1ugoxsN1PRV2pVgwZzteqHHDjz+lCKnIgLxH
         gWRmk3bkgwzrnpGZkcAHgbkDiAIyU7I9Xyz1kMP0M9/Mke1Tbh0NiBH5YRKRdqpdRXUU
         hTLrqGyJkL2og+M4CF0OA2oJm8RrKA1/4BFzJeFyPRdIyGaDTQpCLSWhPWiUHptFdgR/
         uYPq190+KWZ13Py2WMXNJ6+D19XFphKRZ/zUELn8VwL9+Rx7KPiV2/v5QzBlKl1LPUj7
         8sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZ09BE7bZZUYfb3KOySGgcA6QPAtPnUG4ieDO4DHbmg=;
        b=PZWcNNA/GcWmObcTsg0dZoGChuM9+gyGtDO8ERvQ8uWiunJhLItTQLU4RC1MgFBAWY
         /SZkJFI/jADGdbRwlrZe4cmDqHetHC0axXq5Fw5FV/guu6dLgkJEZrwztb62WspmLAUD
         Jx9yQPcq3SHH/xyn3pkxttd+OiigJSgu9B+cIoldKprUV0y/uzegredibFSbsa3dUhJi
         FdqfSB6liWPb6wKh5xXWlJ7rE8GFjnEFAo18HpPTt1Ich3kQmwUVqjusJ1hz/wto4MIi
         KcvZyPP/wJjT/afkPgGlQTEWvUWVOUlHuNx5pux6F9KiHAx1le+utxURlBZxv28kJM4M
         HSHA==
X-Gm-Message-State: APjAAAX8kyjBU+LAp2Dh6g4MCa0PtwTstoENU7Tg7MOa1w0Ql+/iR+vu
        jnQLUr/02A/wX5SRyY2M0QHx0P/Td11pfHfeGMYX5Q==
X-Google-Smtp-Source: APXvYqyirSCtgHmK+P8KrMFNyXGfvNPhR+UXgnDSIpz/P0HqO9EuO50Is5/ZfG70IY+Ka+TT+ojdVe3nuuRd3+W6lpU=
X-Received: by 2002:a05:6830:144e:: with SMTP id w14mr47561203otp.170.1554135721334;
 Mon, 01 Apr 2019 09:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com> <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com>
In-Reply-To: <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 1 Apr 2019 09:21:49 -0700
Message-ID: <CAKOZuetovU9NawSjUfGTAwXVfnmKC9GFtmS8FxAE5Hjmzq0HHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 9:07 AM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
>
> On Mon, Apr 1, 2019 at 4:55 PM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Mon, Apr 1, 2019 at 8:36 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Mon, Apr 1, 2019 at 4:41 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > >
> > > > Eric pitched a procfs2 which would *just* be the PIDs some time ago (in
> > > > an attempt to make it possible one day to mount /proc inside a container
> > > > without adding a bunch of masked paths), though it was just an idea and
> > > > I don't know if he ever had a patch for it.
> >
> > Couldn't this mode just be a relatively simple procfs mount option
> > instead of a whole new filesystem? It'd be a bit like hidepid, right?
> > The internal bind mount option and the no-dotdot-traversal options
> > also look good to me.
> >
> > > I wonder if we really want a fill procfs2, or maybe we could just make
> > > the pidfd readable (yes, it's a directory file descriptor, but we
> > > could allow reading).
> >
> > What would read(2) read?
> >
> > > What are the *actual* use cases for opening /proc files through it? If
> > > it's really just for a small subset that android wants to do this
> > > (getting basic process state like "running" etc), rather than anything
> > > else, then we could skip the whole /proc linking entirely and go the
> > > other way instead (ie open_pidfd() would get that limited IO model,
> > > and we could make the /proc directory node get the same limited IO
> > > model).
> >
> > We do a lot of process state inspection and manipulation, including
> > reading and writing the oom killer adjustment score, reading smaps,
> > and the occasional cgroup manipulation. More generally, I'd also like
> > to be able to write a race-free pkill(1). Doing this work via pidfd
> > would be convenient. More generally, we can't enumerate the specific
> > use cases, because what we want to do with processes isn't bounded in
> > advance, and we regularly find new things in /proc/pid that we want to
> > read and write. I'd rather not prematurely limit the applicability of
> > the pidfd interface, especially when there's a simple option (the
> > procfs directory file descriptor approach) that doesn't require
> > in-advance enumeration of supported process inspection and
> > manipulation actions or a separate per-option pidfd equivalent. I very
> > much want a general-purpose API that reuses the metadata interfaces
> > the kernel already exposes. It's not clear to me how this rich
> > interface could be matched by read(2) on a pidfd.
>
> With the POLLHUP model on a simple pidfd, you'd know when the process
> you were referring to is dead (and one can map POLLPRI to dead and
> POLLHUP to zombie, etc).

I agree that there needs to be *some* kind of pollable file descriptor
that fires on process death. Should it be the pifd itself? I've been
thinking that a pollable directory would be too weird, but if that's
not actually a problem, I'm fine with it.

Mapping different state transitions to different poll bits is an
interesting idea, but I'm also worried about making poll the "source
of truth" with respect to process state as reported by a pidfd.
Consider a socket: for a socket, read(2)/recv(2) is the "source of
truth" and poll is just a hint that says "now is a good time to
attempt a read". Some other systems even allow for spurious wakeups
from poll. It's also worth keeping in mind that some pre-existing
event loops let you provide "is readable" and "is writable" callbacks,
but don't support the more exotic poll notification bits. That's why
I've tried to keep my proposals limited to poll signaling readability.

But I'm not really that picky. I just want something that works.

> This is just an extension of the child process model, since you'd know
> when it's dead, there's no race involved with opening the wrong
> /proc/<PID> entry. The entire thing is already non-racy for direct
> children, the same model can be extended to non-direct ones.
>
> This simplifies a lot of things, now I am essentially just passing a
> file descriptor pinning the struct pid associated with the original
> task, and not process state around to others (I may even want the
> other process to not read that stuff out even if it was allowed to, as
> it wouldn't have been able to otherwise, due to being a in a different
> mount namespace). KISS.
>
> The upshot is this same descriptor can be returned from clone, which
> would allow you to directly register it in your event loop (like
> signalfd, timerfd, file fd, sockets, etc) and POLLIN generated for you
> to read back its exit status (it is arguable if non-parents should be
> returned a readable instance from pidfd_open, but parents sure
> should). You can disable SIGCHLD for the child, and read back exit
> status much later. The entire point of waiting and reaping was that
> it'd be lost, but now you have a descriptor where it is kept for you
> to consume.

There's a subtlety: suppose I'm a library and I want to create a
private subprocess. I use the new clone facility, whatever it is, and
get a pidfd back. I need to be able to read the child's exit status
even if the child exits before clone returns in the parent. Doesn't
this requirement imply that the pidfd, kernel-side, contain something
a bit more than a struct pid?
