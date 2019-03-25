Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99DBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ED920879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxN1DAwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfCYTmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:42:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45113 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:42:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id v20so11752484qtv.12;
        Mon, 25 Mar 2019 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIcail1q0Vj9y3ZxkGiNoq0bOit/ZXD2J+TAZmW+YZQ=;
        b=hxN1DAwLOQEb0uILnk/dx4xPBTyasoOOVsbh+Fi1vgANtH7/ieicXcRq0TyV0GnNN0
         A4QjyJq+agF9+EATBnVaHTWr7MPWHrs9hodEwaIRUYd5ot2O9KTwEIpoI7/rOMULsYyL
         i4IPoshHFxCKD0d3ny3LY0uPMVLWFbxBv/1W7mI7a6P2n0wHNnc1ebVeFI0JhZzJ34v7
         I3IDV2M5zga0Psmxo+8Crdvnc/EP99GL/z9AHBIiCNFi1Emaub3DN6ZmtRH9CiQLdyev
         v+EWwuB6loc7lgK/NYVmSzOZ2IVVAvrBl4r8moyKmxLK5iuOVpJAEJt/yIsnd4jaApQU
         PgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIcail1q0Vj9y3ZxkGiNoq0bOit/ZXD2J+TAZmW+YZQ=;
        b=nznegCMCOwgDDLoyQGoVR57j4mpWB6Uh73Oe/7qpEYR1J+RBT3RMHyjOFjoFxzqKhP
         k7Jp8qm/SLSOFgyh9loDBAHu/VPaMrMUKsIVrREwk9bE+eh7uTXFXdy1ORcaHSpfC64c
         TVVTakYYkuo5IyrzlhU3QOc8NExpue//aYdi9XlE4V/I71MtwrUkWCq9eSyIW2p2J9VG
         8Nr3M+HoXy/XmriERfuzTFED0TZKUFDwz4s4ts0D8MWQk9XFBJgRgEyu1qAvrajgG2t7
         JmCQjLt/Iyd3jyXYQXWfD6SkYJ3OZk57HN4Xw0OhA5+a3jjsCNHOHGDLeZBRO/+rmXl3
         7ncQ==
X-Gm-Message-State: APjAAAX6PWXXjKKLtELYHBHsMhZuzLO89gqxcOocrzldARDtBcWOY/me
        wRJpK6NThjA+P/ZBazVXJdiCinfrAPoXMp/qrCc=
X-Google-Smtp-Source: APXvYqzD5TEW1S2XHb/FstAfyVRup0LdNLj5OW6Hddp+xktokkmi5KablGJczMIZdf2QnAClQyr7IFzQGvBqCbdklD8=
X-Received: by 2002:ac8:2b53:: with SMTP id 19mr22717611qtv.374.1553542949602;
 Mon, 25 Mar 2019 12:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com> <CAKOZuetbZOs1Yur4OrW6hh3wVYdoKNkSqTszbpTWnuRBTmT9zA@mail.gmail.com>
 <CAGLj2rE1f4x36KFUjFLiFq8tF1RUmFuCSRTg_tCQ9W2G6LtizA@mail.gmail.com> <CAKOZuetCFgu0B53+mGmQ3+539MPT_tiu-PACx2ATvihHrrmUKg@mail.gmail.com>
In-Reply-To: <CAKOZuetCFgu0B53+mGmQ3+539MPT_tiu-PACx2ATvihHrrmUKg@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Mon, 25 Mar 2019 19:42:14 +0000
Message-ID: <CAGLj2rHETs+FjkOVP6PJ_EiePP7FKiDwxaWyjwg1gMZPYpU1fQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 6:57 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Mon, Mar 25, 2019 at 11:19 AM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> >
> > On Mon, Mar 25, 2019 at 5:53 PM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > [..snip..]
> > >
> > > I don't like the idea of having one kind of pollfd be pollable and
> > > another not. Such an interface would be confusing for users. If, as
> > > you suggest below, we instead make the procfs-less FD the only thing
> > > we call a "pidfd", then this proposal becomes less confusing and more
> > > viable.
> >
> > That's certainly on the table, we remove the ability to open
> > /proc/<PID> and use the dir fd with pidfd_send_signal. I'm in favor of
> > this.
> >
> > > > But.. one thing we could do for Daniel usecase is if a /proc/pid directory fd
> > > > can be translated into a "pidfd" using another syscall or even a node, like
> > > > /proc/pid/handle or something. I think this is what Christian suggested in
> > > > the previous threads.
> > >
> > > /proc/pid/handle, if I understand correctly, "translates" a
> > > procfs-based pidfd to a non-pidfd one. The needed interface would have
> > > to perform the opposite translation, providing a procfs directory for
> > > a given pidfd.
> > >
> > > > And also for the translation the other way, add a syscall or modify
> > > > translate_fd or something, to covert a anon_inode pidfd into a /proc/pid
> > > > directory fd. Then the user is welcomed to do openat(2) on _that_ directory fd.
> > > > Then we modify pidfd_send_signal to only send signals to pure pidfd fds, not
> > > > to /proc/pid directory fds.
> > >
> > > This approach would work, but there's one subtlety to take into
> > > account: which procfs? You'd want to take, as inputs, 1) the procfs
> > > root you want, and 2) the pidfd, this way you could return to the user
> > > a directory FD in the right procfs.
> > >
> >
> > I don't think metadata access is in the scope of such a pidfd itself.
>
> It should be possible to write a race-free pkill(1) using pidfds.
> Without metadata access tied to the pidfd somehow, that can't be done.
>
>
> > > > Should we work on patches for these? Please let us know if this idea makes
> > > > sense and thanks a lot for adding us to the review as well.
> > >
> > > I would strongly prefer that we not merge pidctl (or whatever it is)
> > > without a story for metadata access, be it your suggestion or
> > > something else.
> >
> > IMO, this is out of scope for a process handle. Hence, the need for
> > metadata access musn't stall it as is.
>
> On the contrary, rather than metadata being out of scope, metadata
> access is essential. Given a file handle (an FD), you can learn about
> the file backing that handle by using fstat(2). Given a socket handle
> (a socket FD), you can learn about the socket with getsockopt(2) and
> ioctl(2). It would be strange not to be able, similarly, to learn
> things about a process given a handle (a pidfd) to that process. I
> want process handles to be "boring" in that they let users query and
> manipulate processes mostly like they manipulate other resources.
>

Yes, but everything in /proc is not equivalent to an attribute, or an
option, and depending on its configuration, you may not want to allow
processes to even be able to see /proc for any PIDs other than those
running as their own user (hidepid). This means, even if this new
system call is added, to respect hidepid, it must, depending on if
/proc is mounted (and what hidepid is set to, and what gid= is set
to), return EPERM, because then there is a discrepancy between how the
two entrypoints to acquire a process handle do access control. This is
ugly, but ideally should work the way it is described above.
Otherwise, things would be able to bypass the restrictions made
therein, because we also want a system call.

PIDs however are addressable with kill(2) even with hidepid enabled.
For good reason, the capabilities you can exercise using a PID is
limited in that case. The same logic applies to a process reference
like pidfd.

I agree there should be some way (if you can take care of the hidepid
gotcha) to return a dir fd of /proc entry, but I don't think it should
be the pidfd itself. You can get it to work using the fdinfo thing for
now.

> > If you really need this, the pid this pidfd is mapped to can be
> > exposed through fdinfo (which is perfectly fine for your case as you
> > use /proc anyway). This means you can reliably determine if you're
> > opening it for the same pid (and it hasn't been recycled) because this
> > pidfd will be pollable for state change (in the future). Exposing it
> > through fdinfo isn't a problem, pid ns is bound to the process during
> > its lifetime, it's a process creation time property, so the value
> > isn't going to change anyway. So you can do all metadata access you
> > want subsequently.
>
> Thanks for the proposal. I'm a bit confused. Are you suggesting that
> we report the numeric FD in fdinfo? Are you saying it should work
> basically like this?
>

Yes, numeric PID that you would see from your namespace for the said
process the pidfd is for. It could be -1 if this process is not in any
of the namespaces (current or children) (which would happen, say if
you pass it to some other pidns residing process, during fd
installation on ithe target process we set that up properly).

> int get_oom_score_adj(int pidfd) {
>   unique_fd fdinfo_fd = open(fmt("/proc/self/fdinfo/%d", pidfd));
>   string fdinfo = read_all(fdinfo_fd);
>   numeric_pid = parse_fdinfo_for_line("pid");
>   unique_fd procdir_fd = open(fmt("/proc/%d", numeric_pid), O_DIRECTORY);
>   if(!is_pidfd_alive(pidfd)) { return -1; /* process died */ } /*
> LIVENESS CHECK */
>   // We know the process named by pidfd was called NUMERIC_PID
>   // in our namespace (because fdinfo told us) and we know that the
> named process
>   // was alive after we successfully opened its /proc/pid directory, therefore,
>   // PROCDIR_FD and PIDFD must refer to the same underlying process.
>   unique_fd oom_adj_score_fd = openat(procdir_fd, "oom_score_adj");
>   return parse_int(read_all(oom_adj_score_fd));
> }
>
> While this interface functions correctly, I have two concerns: 1) the
> number of system calls necessary is very large -- by my count,
> starting with the pifd, we need six, not counting the follow-on
> close(2) calls (which would bring the total to nine[1]),

But hey, that's a bit rich if you're planning to collect metadata from
/proc ;-).

> and 2) it's
> "fail unsafe": IMHO, most users in practice will skip the line marked
> "LIVENESS CHECK", and as a result, their code will appear to work but
> contain subtle race conditions. An explicit interface to translate
> from a (PIDFD, PROCFS_ROOT) tuple to a /proc/pid directory file
> descriptor would be both more efficient and fail-safe.
>
> [1] as a separate matter, it'd be nice to have a batch version of close(2).

Since /proc is full of gunk, how about adding more to it and making
the magic symlink of /proc/self/fd for the pidfd to lead to the dirfd
of the /proc entry of the process it maps to, when one uses
O_DIRECTORY while opening it? Otherwise, it behaves as it does today.
It would be equivalent to opening the proc entry with usual access
restrictions (and hidepid made to work) but without the races, and
because for processes outside your and children pid ns, it shouldn't
work anyway, and since they wouldn't have their entry on this procfs
instance, it would all just fit in nicely?
