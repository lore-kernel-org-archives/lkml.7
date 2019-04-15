Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF25C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D064120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555360179;
	bh=Rh8v9GqgBV+0qOTCc87sR2oSBg3MJSxGGbsRHQN8SMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ze3HQtkTh80K0o1o5nmgWMkrNyViRaJw9daVVQsDsxswLL0P/Pqkz8F+FVN5/o3WQ
	 JXUPVuePPnrx0lLu28kwtm5poqAgjYDJ4r1c1fCoTlSB8nZ3UrTYYB7CMxfQjRYADr
	 MHFJpyfnz6yQNEBHbfNyMjn4XhdsiXhLdb3GteCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfDOU3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbfDOU3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:29:37 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD6021909
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555360177;
        bh=Rh8v9GqgBV+0qOTCc87sR2oSBg3MJSxGGbsRHQN8SMI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=diOtadquN6QdwACXgwremnrq5LX2pFAPgxDV0jFn5o8om5hYdhT+o65Q6HyHaK2Id
         +vTJ6qIdZ3Rf7iiw8c0mOHGtdYHwND4bodiZWlxAdTjQkvX+RyT6GKz+MSd/RA3kHh
         feFYcKX3YQyeL9akDvM42mq7pBZZvFnxjSPaSMqA=
Received: by mail-wm1-f53.google.com with SMTP id h18so22109174wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:29:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUxOW12VML8YNFVRDPGCNHOEv8L8JI+fLkhQB2RMd+9CnQJWSUR
        hoR8rky+HIr01bf6gcV4+R5kinf3Z/ZCPlmDQtAtDw==
X-Google-Smtp-Source: APXvYqz2aw1Qeqls94N7KjemrCW+ko8OW42gMIipB535SrCsaUGqWI433pjkicEXmJEtaddWVxouu0HiPJ8YR5Ndm1A=
X-Received: by 2002:a1c:4102:: with SMTP id o2mr23122688wma.91.1555360175032;
 Mon, 15 Apr 2019 13:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin>
In-Reply-To: <20190415195911.z7b7miwsj67ha54y@yavin>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Apr 2019 13:29:23 -0700
X-Gmail-Original-Message-ID: <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
Message-ID: <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Lutomirski <luto@kernel.org>,
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

On Mon, Apr 15, 2019 at 12:59 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2019-04-15, Enrico Weigelt, metux IT consult <lkml@metux.net> wrote:
> > > This patchset makes it possible to retrieve pid file descriptors at
> > > process creation time by introducing the new flag CLONE_PIDFD to the
> > > clone() system call as previously discussed.
> >
> > Sorry, for highjacking this thread, but I'm curious on what things to
> > consider when introducing new CLONE_* flags.
> >
> > The reason I'm asking is:
> >
> > I'm working on implementing plan9-like fs namespaces, where unprivileged
> > processes can change their own namespace at will. For that, certain
> > traditional unix'ish things have to be disabled, most notably suid.
> > As forbidding suid can be helpful in other scenarios, too, I thought
> > about making this its own feature. Doing that switch on clone() seems
> > a nice place for that, IMHO.
>
> Just spit-balling -- is no_new_privs not sufficient for this usecase?
> Not granting privileges such as setuid during execve(2) is the main
> point of that flag.
>

I would personally *love* it if distros started setting no_new_privs
for basically all processes.  And pidfd actually gets us part of the
way toward a straightforward way to make sudo and su still work in a
no_new_privs world: su could call into a daemon that would spawn the
privileged task, and su would get a (read-only!) pidfd back and then
wait for the fd and exit.  I suppose that, done naively, this might
cause some odd effects with respect to tty handling, but I bet it's
solveable.  I suppose it would be nifty if there were a way for a
process, by mutual agreement, to reparent itself to an unrelated
process.

Anyway, clone(2) is an enormous mess.  Surely the right solution here
is to have a whole new process creation API that takes a big,
extensible struct as an argument, and supports *at least* the full
abilities of posix_spawn() and ideally covers all the use cases for
fork() + do stuff + exec().  It would be nifty if this API also had a
way to say "add no_new_privs and therefore enable extra functionality
that doesn't work without no_new_privs".  This functionality would
include things like returning a future extra-privileged pidfd that
gives ptrace-like access.

As basic examples, the improved process creation API should take a
list of dup2() operations to perform, fds to remove the O_CLOEXEC flag
from, fds to close (or, maybe even better, a list of fds to *not*
close), a list of rlimit changes to make, a list of signal changes to
make, the ability to set sid, pgrp, uid, gid (as in
setresuid/setresgid), the ability to do capset() operations, etc.  The
posix_spawn() API, for all that it's rather complicated, covers a
bunch of the basics pretty well.

Sharing the parent's VM, signal set, fd table, etc, should all be
options, but they should default to *off*.

(Many other operating systems allow one to create a process and gain a
capability to do all kinds of things to that process.  It's a
generally good idea.)

--Andy
