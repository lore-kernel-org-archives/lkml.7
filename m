Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B79A20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q02PEyFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfDOV0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:26:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37656 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfDOV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:26:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id z16so20999347qtn.4;
        Mon, 15 Apr 2019 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tdht+H+WKoJ4uNO6O9o2u/2SgVclovMiCpBDwUs7Y4=;
        b=q02PEyFW4AFFyETMl21EeN6I2Q7zphC6sPTBQ9aHFM21uf5R9Y/uepMRojRy4JfC8O
         hLR2curwS58I5iDWuRLGysRswLA23HYPHUhrzGXHk7EMRWqjpk6ywbKGXRXctSbGZEr8
         +uG34e3G7eUBWPwxtPkEWuIPOaPY9lozsEOSt9ScqAwEKdtRNx+A3p4QzdT8D4xYOXj9
         CwtvwqSJLG+u2ukM+bzcL1pqoA668M9dsBjec7eNa4CjnX8UVhJFCv7tSC2pdEADaCvR
         JT6Spd3N6LdZ89noRduMhk0263P6faQh798raU3+6LfGOQJLFyFZ0i27NIGf4Z9IE6g8
         FrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tdht+H+WKoJ4uNO6O9o2u/2SgVclovMiCpBDwUs7Y4=;
        b=Wng3Bg7KYFmRtcx9Re5WF+tbBiKOpzPZ8SbAbqaUtda1gLmAqK33IW0YNxHZ4oW5UP
         j3wCp7DBf6RA2fdWoFyB6VP/D2FDH2JDHBP/YSj/QkBkyt3kh2TX868MOUbQYOqiCtIU
         C145kXASSpoy78B2LFX6jpKYk3DVpVdT84S1ohQ3hbWKcAeqx2FFrsD1RGKeO56mVjop
         +pcYZcXka94PHmkkMOfePHFZtubBdgaZXOA2J5DaEqKhLCZHygf7gSYfeoLsKtWJkB7H
         +UTOMcM6MIhlMqkh+KPUFh5aXZb7NLss7iVwOhF7/vbxQgA9fD0ZQItDrLPRTZSVI83/
         Jl9Q==
X-Gm-Message-State: APjAAAWzaCAiDG4t/27NKbJq5baPgjLEx4jA+zzcS/F5hU8jJ+9j3o8/
        FFMp3f8eK4wmgDOSGC5iwI+UU8Vh1HjcvPoTnp4=
X-Google-Smtp-Source: APXvYqx4phRGHeePoo6fdogy+7/A9K/rfiCxBLG89M2PdgUL1nnVf1pWwgszRBDerPEymuE1l1v1FTVWJNBkkCRByk4=
X-Received: by 2002:a0c:b7a5:: with SMTP id l37mr62074019qve.94.1555363603948;
 Mon, 15 Apr 2019 14:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
In-Reply-To: <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 15 Apr 2019 22:27:04 +0100
Message-ID: <CAGLj2rEOfW=3wis3YWomWK1AVDdCX6DMqbvSHXba3-x=kpkcNA@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 9:34 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Apr 15, 2019 at 12:59 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2019-04-15, Enrico Weigelt, metux IT consult <lkml@metux.net> wrote:
> > > > This patchset makes it possible to retrieve pid file descriptors at
> > > > process creation time by introducing the new flag CLONE_PIDFD to the
> > > > clone() system call as previously discussed.
> > >
> > > Sorry, for highjacking this thread, but I'm curious on what things to
> > > consider when introducing new CLONE_* flags.
> > >
> > > The reason I'm asking is:
> > >
> > > I'm working on implementing plan9-like fs namespaces, where unprivileged
> > > processes can change their own namespace at will. For that, certain
> > > traditional unix'ish things have to be disabled, most notably suid.
> > > As forbidding suid can be helpful in other scenarios, too, I thought
> > > about making this its own feature. Doing that switch on clone() seems
> > > a nice place for that, IMHO.
> >
> > Just spit-balling -- is no_new_privs not sufficient for this usecase?
> > Not granting privileges such as setuid during execve(2) is the main
> > point of that flag.
> >
>
> I would personally *love* it if distros started setting no_new_privs
> for basically all processes.  And pidfd actually gets us part of the
> way toward a straightforward way to make sudo and su still work in a
> no_new_privs world: su could call into a daemon that would spawn the
> privileged task, and su would get a (read-only!) pidfd back and then
> wait for the fd and exit.  I suppose that, done naively, this might
> cause some odd effects with respect to tty handling, but I bet it's
> solveable.  I suppose it would be nifty if there were a way for a

Hmm, isn't what you're describing roughly what systemd-run -t does? It
will serialize the argument list, ask PID 1 to create a transient unit
(go through the polkit stuff), and then set the stdout/stderr and
stdin of the service to your tty, make it the controlling terminal of
the process and
reset it. So I guess it should work with sudo/su just fine too.

There is also s6-sudod (and a s6-sudoc client to it) that works in a
similar fashion, though it's a lot less fancy.

> process, by mutual agreement, to reparent itself to an unrelated
> process.
>
> Anyway, clone(2) is an enormous mess.  Surely the right solution here
> is to have a whole new process creation API that takes a big,
> extensible struct as an argument, and supports *at least* the full
> abilities of posix_spawn() and ideally covers all the use cases for
> fork() + do stuff + exec().  It would be nifty if this API also had a
> way to say "add no_new_privs and therefore enable extra functionality
> that doesn't work without no_new_privs".  This functionality would
> include things like returning a future extra-privileged pidfd that
> gives ptrace-like access.

My idea was that this intent could be supplied at clone time, you
could attach ptrace access modes to a pidfd (we could make those a bit
granular, perhaps) and any API that takes PIDs and checks against the
caller's ptrace access mode could instead derive so from the pidfd.
Since killing is a bit convoluted due to setuid binaries, that should
work if one is CAP_KILL capable in the owning userns of the task, and
if not that, has permissions to kill and the target has NNP set. This
would allow you to bind kill privileges in a way that is compatible
with both worlds, the upshot being NNP allows for the functionality to
be available to a lot more of userspace. Ofcourse, this would require
a new clone version, possibly with taking a clone2 struct which sets a
few parameters for the process and the flags for the pidfd.

Another point is that you have a pidfd_open (or something else) that
can create multiple pidfds from a pidfd obtained at clone time and
create pidfds with varying level of rights. It can also work by taking
a TID to open a pidfd for an external task (and then for all the
rights you wish to acquire on it, check against your ambient
authority).

(Actually, in general, having FMODE_* style bits spanning all methods
a file descriptor can take (through system calls), with the type of
object as key (class containing a set), and be able to enable/disable
them and seal them would be a useful addition, this all happening at
the struct file level instead of inode level sealing in memfds).

>
> As basic examples, the improved process creation API should take a
> list of dup2() operations to perform, fds to remove the O_CLOEXEC flag
> from, fds to close (or, maybe even better, a list of fds to *not*
> close), a list of rlimit changes to make, a list of signal changes to
> make, the ability to set sid, pgrp, uid, gid (as in
> setresuid/setresgid), the ability to do capset() operations, etc.  The
> posix_spawn() API, for all that it's rather complicated, covers a
> bunch of the basics pretty well.
>
> Sharing the parent's VM, signal set, fd table, etc, should all be
> options, but they should default to *off*.

Historical note: Plan 9's rfork has RFC* flags for resources like
namespace/env/fd table, which means supplying those means you start
with an clean/empty view of that resource.


>
> (Many other operating systems allow one to create a process and gain a
> capability to do all kinds of things to that process.  It's a
> generally good idea.)
>
> --Andy
