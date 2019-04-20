Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62DC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8413720854
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOHAV4Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDTPGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 11:06:33 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41773 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfDTPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 11:06:32 -0400
Received: by mail-ua1-f68.google.com with SMTP id l22so2471441uao.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFnRGAsoLvk8Uoq9FyDh/WzWy/bRQWDRkdgej3+Z1Nk=;
        b=kOHAV4HxLuAVkp4grvw/Go3PZ3q9mbg95MRViMH3J4FLgJ+ocEboBCnZFJNkBs0QPZ
         Uo63adCiSIulipqVbY8xNg5Gni54BCBJMSzAZtVPXZbcOlV59bWmky/wQSpHOFSe2tlI
         J3pPJ2oAe0HMRANjroNQ3+chUP+t+Y4khSlqHRjeNWJHpL4bAzvToXn6HTWeWDDYR7zT
         AmvvwpXww2S+iX+gbyygkRla8jNGerYPpOoHHy1mLSyF269e+dbpf4co0owkQy6Fvnzn
         Lruf3SzvsD93dxyP0pnKbCzboKTFB1PYiKy/GkY7tAbC+d22IVljU5q5loXjkkOAe2LS
         p8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFnRGAsoLvk8Uoq9FyDh/WzWy/bRQWDRkdgej3+Z1Nk=;
        b=aldg1KJxMZXSXjzTxvyYbRM4CKHBg+4ldapDhkhGFxkDbjVQGIvos7KkqYfYSVwRko
         13A8y2S+mhLuG4PE6dKxG1Gn23tkVCW7Mc1sDfINkLFprKvR8hj2Qoj/aBZ8KMuX5fTm
         hSO1dKvNZLtluV/Dxqqxv/U2KZhh088rhjJQ58uyI/pLlTYBuQYbDjJzPiodUtBxzc0g
         xiI8zJlWIhxliG8jMQtVbU64muUT2s4/hqbSFV9IbsFw2qpRExY9c6N52FbcYdSfzHaD
         PSRQgR5MvMtzu07uXq0XJjj156BSHW+KNpjoF2p5T4fuVicH4o1xOpVGbd4BFiFdmpL/
         S/7g==
X-Gm-Message-State: APjAAAUnfccKU4d4bu92P2zMF56riwpoDWu0wni76TC3j+aypqUfTc3w
        +/QtaOiiWKPzTD0zzE7G0rvLwvFpfDyICIFnCpwvnQ==
X-Google-Smtp-Source: APXvYqysExRkufLaj0ErmxZGJwMAyqQ/c3HI7QoCxXozHidE4CKrzsuxvSErHstRhTxy9he4P/LstU0b6Wg6m76dwUw=
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr4745378uap.112.1555772791172;
 Sat, 20 Apr 2019 08:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78>
In-Reply-To: <20190420071406.GA22257@ip-172-31-15-78>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 20 Apr 2019 08:06:19 -0700
Message-ID: <CAKOZuetGV8vz9dgi+v78tV5MuHQ2QRG7eJbfdiAFvtbzFZfBWw@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Kevin Easton <kevin@guarana.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 12:14 AM Kevin Easton <kevin@guarana.org> wrote:
> On Mon, Apr 15, 2019 at 01:29:23PM -0700, Andy Lutomirski wrote:
> > On Mon, Apr 15, 2019 at 12:59 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > >
> > > On 2019-04-15, Enrico Weigelt, metux IT consult <lkml@metux.net> wrote:
> > > > > This patchset makes it possible to retrieve pid file descriptors at
> > > > > process creation time by introducing the new flag CLONE_PIDFD to the
> > > > > clone() system call as previously discussed.
> > > >
> > > > Sorry, for highjacking this thread, but I'm curious on what things to
> > > > consider when introducing new CLONE_* flags.
> > > >
> > > > The reason I'm asking is:
> > > >
> > > > I'm working on implementing plan9-like fs namespaces, where unprivileged
> > > > processes can change their own namespace at will. For that, certain
> > > > traditional unix'ish things have to be disabled, most notably suid.
> > > > As forbidding suid can be helpful in other scenarios, too, I thought
> > > > about making this its own feature. Doing that switch on clone() seems
> > > > a nice place for that, IMHO.
> > >
> > > Just spit-balling -- is no_new_privs not sufficient for this usecase?
> > > Not granting privileges such as setuid during execve(2) is the main
> > > point of that flag.
> > >
> >
> > I would personally *love* it if distros started setting no_new_privs
> > for basically all processes.  And pidfd actually gets us part of the
> > way toward a straightforward way to make sudo and su still work in a
> > no_new_privs world: su could call into a daemon that would spawn the
> > privileged task, and su would get a (read-only!) pidfd back and then
> > wait for the fd and exit.  I suppose that, done naively, this might
> > cause some odd effects with respect to tty handling, but I bet it's
> > solveable.  I suppose it would be nifty if there were a way for a
> > process, by mutual agreement, to reparent itself to an unrelated
> > process.
> >
> > Anyway, clone(2) is an enormous mess.  Surely the right solution here
> > is to have a whole new process creation API that takes a big,
> > extensible struct as an argument, and supports *at least* the full
> > abilities of posix_spawn() and ideally covers all the use cases for
> > fork() + do stuff + exec().  It would be nifty if this API also had a
> > way to say "add no_new_privs and therefore enable extra functionality
> > that doesn't work without no_new_privs".  This functionality would
> > include things like returning a future extra-privileged pidfd that
> > gives ptrace-like access.
> >
> > As basic examples, the improved process creation API should take a
> > list of dup2() operations to perform, fds to remove the O_CLOEXEC flag
> > from, fds to close (or, maybe even better, a list of fds to *not*
> > close), a list of rlimit changes to make, a list of signal changes to
> > make, the ability to set sid, pgrp, uid, gid (as in
> > setresuid/setresgid), the ability to do capset() operations, etc.  The
> > posix_spawn() API, for all that it's rather complicated, covers a
> > bunch of the basics pretty well.
>
> The idea of a system call that takes an infinitely-extendable laundry
> list of operations to perform in kernel space seems quite inelegant, if
> only for the error-reporting reason.
>
> Instead, I suggest that what you'd want is a way to create a new
> embryonic process that has no address space and isn't yet schedulable.
> You then just need other-process-directed variants of all the normal
> setup functions - so pr_openat(pidfd, dirfd, pathname, flags, mode),
> pr_sigaction(pidfd, signum, act, oldact), pr_dup2(pidfd, oldfd, newfd)
> etc.

Providing process-directed versions of these functions would be useful
for a variety of management tasks anyway,

> Then when it's all set up you pr_execve() to kick it off.

Yes. That's the right general approach.
