Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336EDC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC35821670
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9MY/1wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfD2Tad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:30:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37767 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbfD2Tac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:30:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id r20so8598534otg.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3S30fnNfP/vnduIvjLl5mMhkQCl728BK6kiG5qPqks=;
        b=t9MY/1wL1LAXzzclFlIXOnXYaiesW58NNavo7EGjvCUw/bSAjxOmT/YO/v4rGjAfWj
         C52vLw1ppf6uZcW699erNcsGlLXioez54/Z7OwIMZnc/7xp8q6XXNtfvfegAqiKfYsn+
         5HN+BmcZF+FIv4u5zB78Tw3FpToPVAamz/FIuw3ikspEvGwOfcLxXlj+U36c9uZ7p4R+
         /TaripeOkZziiz59xAwjN2/jw6l00OdO6hFdyscn61d4dFBx6isecrNGqJB0tJhmFnv0
         9mJPzI72v3h41wSiOQlQ98hFymhDDqn4yBXAquwVltQZ1NyBTS7jk6x4kxIxF++brnH3
         BDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3S30fnNfP/vnduIvjLl5mMhkQCl728BK6kiG5qPqks=;
        b=al+dhE+cdx7/9q0zGvDVMRQqO4ESxd4pmsJfU+TglgBqGTHN4MFa0RiEOtZnX6DFeN
         w0Su6LGnpDD3PPHFbZFXca6dAAzbt4NBDECnNGRey5PfInPTmAkCWcok95mzKS070ua2
         IAnGVhXvPbr/myE3DTvDiZF1d4d1P28ytEfAZSlvJ2SL/s6+xv068hTkZoD8MWfc90l8
         8deehwLLzpZJvlZnftGNWpyK/lReVEDMPLiLhzR1tmBNVGVX92cc6+Kh/zF7Qy3yyck3
         rJW8qQDHxPGEuQOckNh/SnXTNa1QhmW7nb/Fc5LDNwJOYPQ7BKKwI4ud7/3piMpzLOv+
         Zjfg==
X-Gm-Message-State: APjAAAVbfDSoEG4HjBJOCXuiWTr7Dy8F5kJap5SYDcr9mUJY2/f17x03
        9F99OfhUvMlPyRqnKE1ofhGbd7nOFe7gtGRDRoETTA==
X-Google-Smtp-Source: APXvYqxF/sp28d2utwcizkjTEmpMnBMGt9jZ0wS01XZFbyK7jZMtumY9RSFyV0o6YyJOFBEWieyCbAKaRByLXLF8RSs=
X-Received: by 2002:a9d:6152:: with SMTP id c18mr2183265otk.230.1556566231212;
 Mon, 29 Apr 2019 12:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78>
In-Reply-To: <20190420071406.GA22257@ip-172-31-15-78>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 29 Apr 2019 15:30:04 -0400
Message-ID: <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Sat, Apr 20, 2019 at 3:14 AM Kevin Easton <kevin@guarana.org> wrote:
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
>
> Then when it's all set up you pr_execve() to kick it off.

Is this really necessary? I agree that fork()+exec() is suboptimal,
but if you just want to avoid the cost of duplicating the address
space, you can AFAICS already do that in userspace with
clone(CLONE_VM|CLONE_CHILD_SETTID|CLONE_CHILD_CLEARTID|SIGCHLD). Then
the parent can block on a futex until the child leaves the mm_struct
through execve() (or by exiting, in the case of an error), and the
child can temporarily have its stack at the bottom of the caller's
stack. You could build an API like this around it in userspace:

int clone_temporary(int (*fn)(void *arg), void *arg, pid_t *child_pid,
<clone flags and arguments, maybe in a struct>)

and then you'd use it like this to fork off a child process:

int spawn_shell_subprocess_(void *arg) {
  char *cmdline = arg;
  execl("/bin/sh", "sh", "-c", cmdline);
  return -1;
}
pid_t spawn_shell_subprocess(char *cmdline) {
  pid_t child_pid;
  int res = clone_temporary(spawn_shell_subprocess_, cmdline,
&child_pid, [...]);
  if (res == 0) return child_pid;
  return res;
}

clone_temporary() could be implemented roughly as follows by the libc
(or other userspace code):

sigset_t sigset, sigset_old;
sigfillset(&sigset);
sigprocmask(SIG_SETMASK, &sigset, &sigset_old);
int child_pid;
int result = 0;
/* starting here, use inline assembly to ensure that no stack
allocations occur */
long child = syscall(__NR_clone,
CLONE_VM|CLONE_CHILD_SETTID|CLONE_CHILD_CLEARTID|SIGCHLD, $RSP -
ABI_STACK_REDZONE_SIZE, NULL, &child_pid, 0);
if (child == -1) { result = -1; goto reset_sigmask; }
if (child == 0) {
  result = fn(arg);
  syscall(__NR_exit, 0);
}
futex(&child_pid, FUTEX_WAIT, child, NULL);
/* end of no-stack-allocations zone */
reset_sigmask:
sigprocmask(SIG_SETMASK, &sigset_old, NULL);
return result;
