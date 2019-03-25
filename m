Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40450C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0105120823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9c7pNAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfCYRxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:53:24 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43412 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYRxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:53:24 -0400
Received: by mail-ua1-f67.google.com with SMTP id g1so3291205uae.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9KR38/EdXIa+vs2m4+If1Kfw6K7q8TDzm15neHVoKA=;
        b=D9c7pNAslHyzN7W+VnTX6DTcK1Ea4dSWiD7bMwkvLuPb46bDEwbBo17Kd1KSVQi2fy
         pQZGNkzEzNEYU+gmfTBO1ZmRSdOmsHe2S8Q5NSoW0pjHbRmOOmWH0nehbfnIcc9GkhvA
         Q1suHHFrLS2v0bTnApQIge0BvM0CaopjMA0Uv1Bj1QhQIJpP/vYKLlzX1wta1XMAr2v6
         Dq1lXuFSvNje6GCFuC6BcO/C3/u4NKRk3QCSDDdONXx038BoPTSw58zY4YYVilMXFyma
         9MqS++IK9JDk2NiSZpEIHEmq8M9gxvBNH5RmwTs4TXriBra7ab7gdl1D/638kGwn1Ost
         5tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9KR38/EdXIa+vs2m4+If1Kfw6K7q8TDzm15neHVoKA=;
        b=LeriylV603YEDYvR26cnXnynImPpZOovm/ycF6NOotBX6x9ZEBiBDs7G8bVSJFsYob
         1dLgh6g5mJ1Nv9NGUyiMg+8U9rGlxg76BkYiQcEKYu04JMj+8/AmoodQnsGcbB4/gOXo
         HP80rnd+SKPVaXV5sh2OwzQpoiAgHOuHuTZX5AhcYVccsFJtCHRmoW9U87UXNzk4Xd6y
         vG+OdTWYBHxjfp1Jmr+6aJSRDjZo1XpEkfrJZpXKJNf+5a7EoyhBlawfQPxp/vfvr8pk
         ArMghIeYXmyqDJtpokWT/5EEJmSIsoZma5pVhBtM8t2YchoPxAg+25mN6ncgAKAFbwvV
         +z3w==
X-Gm-Message-State: APjAAAW9w4v4vakj0MrMWvolQBOon2iArTsgo+hVnazpUVdJ4jnInt4e
        sFdSL90CPn/RhUUACdptzdfWc8c4sFYTDEM32G7ynA==
X-Google-Smtp-Source: APXvYqw9/EP2Mrp25NqQkX+foNjqaaR6CzDpyfDhOk7qAuh3nVs5Wt4O1Iqon6nLT4AorZ7vujO7//ogH+YjLPW0+rY=
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr14865783uap.112.1553536402819;
 Mon, 25 Mar 2019 10:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
 <20190325173614.GB25975@google.com>
In-Reply-To: <20190325173614.GB25975@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 25 Mar 2019 10:53:11 -0700
Message-ID: <CAKOZuetbZOs1Yur4OrW6hh3wVYdoKNkSqTszbpTWnuRBTmT9zA@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian@brauner.io>,
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
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
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

On Mon, Mar 25, 2019 at 10:36 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, Mar 25, 2019 at 09:48:43AM -0700, Daniel Colascione wrote:
> > On Mon, Mar 25, 2019 at 9:21 AM Christian Brauner <christian@brauner.io> wrote:
> > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > I quote Konstantins original patchset first that has already been acked and
> > > picked up by Eric before and whose functionality is preserved in this
> > > syscall. Multiple people have asked when this patchset will be sent in
> > > for merging (cf. [1], [2]). It has recently been revived by Nagarathnam
> > > Muthusamy from Oracle [3].
> > >
> > > The intention of the original translate_pid() syscall was twofold:
> > > 1. Provide translation of pids between pid namespaces
> > > 2. Provide implicit pid namespace introspection
> > >
> > > Both functionalities are preserved. The latter task has been improved
> > > upon though. In the original version of the pachset passing pid as 1
> > > would allow to deterimine the relationship between the pid namespaces.
> > > This is inherhently racy. If pid 1 inside a pid namespace has died it
> > > would report false negatives. For example, if pid 1 inside of the target
> > > pid namespace already died, it would report that the target pid
> > > namespace cannot be reached from the source pid namespace because it
> > > couldn't find the pid inside of the target pid namespace and thus
> > > falsely report to the user that the two pid namespaces are not related.
> > > This problem is simple to avoid. In the new version we simply walk the
> > > list of ancestors and check whether the namespace are related to each
> > > other. By doing it this way we can reliably report what the relationship
> > > between two pid namespace file descriptors looks like.
> > >
> > > Additionally, this syscall has been extended to allow the retrieval of
> > > pidfds independent of procfs. These pidfds can e.g. be used with the new
> > > pidfd_send_signal() syscall we recently merged. The ability to retrieve
> > > pidfds independent of procfs had already been requested in the
> > > pidfd_send_signal patchset by e.g. Andrew [4] and later again by Alexey
> > > [5]. A use-case where a kernel is compiled without procfs but where
> > > pidfds are still useful has been outlined by Andy in [6]. Regular
> > > anon-inode based file descriptors are used that stash a reference to
> > > struct pid in file->private_data and drop that reference on close.
> > >
> > > With this translate_pid() has three closely related but still distinct
> > > functionalities. To clarify the semantics and to make it easier for
> > > userspace to use the syscall it has:
> > > - gained a command argument and three commands clearly reflecting the
> > >   distinct functionalities (PIDCMD_QUERY_PID, PIDCMD_QUERY_PIDNS,
> > >   PIDCMD_GET_PIDFD).
> > > - been renamed to pidctl()
> >
> [snip]
> > Also, I'm still confused about how metadata access is supposed to work
> > for these procfs-less pidfs. If I use PIDCMD_GET_PIDFD on a process,
> > You snipped out a portion of a previous email in which I asked about
> > your thoughts on this question. With the PIDCMD_GET_PIDFD command in
> > place, we have two different kinds of file descriptors for processes,
> > one derived from procfs and one that's independent. The former works
> > with openat(2). The latter does not. To be very specific; if I'm
> > writing a function that accepts a pidfd and I get a pidfd that comes
> > from PIDCMD_GET_PIDFD, how am I supposed to get the equivalent of
> > smaps or oom_score_adj or statm for the named process in a race-free
> > manner?
>
> This is true, that such usecase will not be supportable.  But the advantage
> on the other hand, is that suchs "pidfd" can be made pollable or readable in
> the future. Potentially allowing us to return exit status without a new
> syscall (?). And we can add IOCTLs to the pidfd descriptor which we cannot do
> with proc.

I don't like the idea of having one kind of pollfd be pollable and
another not. Such an interface would be confusing for users. If, as
you suggest below, we instead make the procfs-less FD the only thing
we call a "pidfd", then this proposal becomes less confusing and more
viable.

> But.. one thing we could do for Daniel usecase is if a /proc/pid directory fd
> can be translated into a "pidfd" using another syscall or even a node, like
> /proc/pid/handle or something. I think this is what Christian suggested in
> the previous threads.

/proc/pid/handle, if I understand correctly, "translates" a
procfs-based pidfd to a non-pidfd one. The needed interface would have
to perform the opposite translation, providing a procfs directory for
a given pidfd.

> And also for the translation the other way, add a syscall or modify
> translate_fd or something, to covert a anon_inode pidfd into a /proc/pid
> directory fd. Then the user is welcomed to do openat(2) on _that_ directory fd.
> Then we modify pidfd_send_signal to only send signals to pure pidfd fds, not
> to /proc/pid directory fds.

This approach would work, but there's one subtlety to take into
account: which procfs? You'd want to take, as inputs, 1) the procfs
root you want, and 2) the pidfd, this way you could return to the user
a directory FD in the right procfs.

> Should we work on patches for these? Please let us know if this idea makes
> sense and thanks a lot for adding us to the review as well.

I would strongly prefer that we not merge pidctl (or whatever it is)
without a story for metadata access, be it your suggestion or
something else.
