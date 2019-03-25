Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10322C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D132B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtCdN3sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfCYQs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:48:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42147 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:48:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so8667097otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVZj29afUwP/vWbrIvhNscs70tkl/GpK9WBPjaGIjuI=;
        b=BtCdN3smWTzgHODXrenjYO37kAuzHAbthtASL/I2X7GhUbT4ID/8JFeB10JzVVwlvK
         5WgKmn79NhvrYrwyLc9f2yepMcwladSoy9X9Hxzb2ad/z4r3XaW+J1Yt2tbslLWtajpy
         Cl3fGgWfVtf/yP3uU32NOfxNsk5fzoaFuq/GIN/zARCBLilXJg6biRwRVlcfrtgldAv4
         lm3nsnuR76ed9XgS6wbCtoGjN6o8anCOADIgaYBlitMEig62QHiQFrRDls4wVcSDjfLb
         ySMLMu9n62m0YR+1qSQ2Ue3mkcIzgPPD0YN7TETLSWjoGrfpQ792qOpr3NRmliob+PHM
         o8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVZj29afUwP/vWbrIvhNscs70tkl/GpK9WBPjaGIjuI=;
        b=dmVmbHQZutUhmcqRyREuV2+hHVWOhZXozsUmNRSM53pjQioAictg6k552Hp9GtXZ0B
         ileX7fj5tz8eccFXCZniOfKInNbFXSaO1V27Ajdi79v/n3WSwdB5Y5dREMowbKtDQfEP
         poOvkGynV5E+a5JEi99vRY1xdwmJLFkb7ssBSmXIaqTIMkAkDORkEfTA2njdheeF2g/B
         xj/03/alwf6c9/j3uVQ55Pl9wPhC0Ah+skgaBMWkvUU5cKIc0ngsPlVE56ivzokTRQ0a
         2Pzzskvje7qH1RcGtGa+0/SKkh7JEBCUMd5/Q7jZz3pMViXe97lAI6b7pXdx61shoP7B
         mFLg==
X-Gm-Message-State: APjAAAU/TnJ1LHPjl99D8ttwoatmUDqiHqFqneziqyE55KXf2y7C826A
        EK26zxbC3htjgPlnnHHfA8jG8iuHVmbNcsIT0r9ySQ==
X-Google-Smtp-Source: APXvYqwWGLwjTL030IrIgmiHTf2zRDwToqP3rAb0TlZ1MOiniQkJgzW8KmZJtRks6ZuDKZEfIa7ZHIBe7Zy41XcrOJE=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr18202853oth.308.1553532535739;
 Mon, 25 Mar 2019 09:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io>
In-Reply-To: <20190325162052.28987-1-christian@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 25 Mar 2019 09:48:43 -0700
Message-ID: <CAKOZueuJSAiKU7fZR2FNDKKCktdyE-sADtWprpsNMAqYQvD9Jw@mail.gmail.com>
Subject: Re: [PATCH 0/4] pid: add pidctl()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, khlebnikov@yandex-team.ru,
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
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        nagarathnam.muthusamy@oracle.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 9:21 AM Christian Brauner <christian@brauner.io> wrote:
> The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> I quote Konstantins original patchset first that has already been acked and
> picked up by Eric before and whose functionality is preserved in this
> syscall. Multiple people have asked when this patchset will be sent in
> for merging (cf. [1], [2]). It has recently been revived by Nagarathnam
> Muthusamy from Oracle [3].
>
> The intention of the original translate_pid() syscall was twofold:
> 1. Provide translation of pids between pid namespaces
> 2. Provide implicit pid namespace introspection
>
> Both functionalities are preserved. The latter task has been improved
> upon though. In the original version of the pachset passing pid as 1
> would allow to deterimine the relationship between the pid namespaces.
> This is inherhently racy. If pid 1 inside a pid namespace has died it
> would report false negatives. For example, if pid 1 inside of the target
> pid namespace already died, it would report that the target pid
> namespace cannot be reached from the source pid namespace because it
> couldn't find the pid inside of the target pid namespace and thus
> falsely report to the user that the two pid namespaces are not related.
> This problem is simple to avoid. In the new version we simply walk the
> list of ancestors and check whether the namespace are related to each
> other. By doing it this way we can reliably report what the relationship
> between two pid namespace file descriptors looks like.
>
> Additionally, this syscall has been extended to allow the retrieval of
> pidfds independent of procfs. These pidfds can e.g. be used with the new
> pidfd_send_signal() syscall we recently merged. The ability to retrieve
> pidfds independent of procfs had already been requested in the
> pidfd_send_signal patchset by e.g. Andrew [4] and later again by Alexey
> [5]. A use-case where a kernel is compiled without procfs but where
> pidfds are still useful has been outlined by Andy in [6]. Regular
> anon-inode based file descriptors are used that stash a reference to
> struct pid in file->private_data and drop that reference on close.
>
> With this translate_pid() has three closely related but still distinct
> functionalities. To clarify the semantics and to make it easier for
> userspace to use the syscall it has:
> - gained a command argument and three commands clearly reflecting the
>   distinct functionalities (PIDCMD_QUERY_PID, PIDCMD_QUERY_PIDNS,
>   PIDCMD_GET_PIDFD).
> - been renamed to pidctl()

Having made these changes, you've built a general-purpose command
command multiplexer, not one operation that happens to be flexible.
The general-purpose command multiplexer is a common antipattern:
multiplexers make it hard to talk about different kernel-provided
operations using the common vocabulary we use to distinguish
kernel-related operations, the system call number. socketcall, for
example, turned out to be cumbersome for users like SELinux policy
writers. People had to do work work later to split socketcall into
fine-grained system calls. Please split the pidctl system call so that
the design is clean from the start and we avoid work later. System
calls are cheap.

Also, I'm still confused about how metadata access is supposed to work
for these procfs-less pidfs. If I use PIDCMD_GET_PIDFD on a process,
You snipped out a portion of a previous email in which I asked about
your thoughts on this question. With the PIDCMD_GET_PIDFD command in
place, we have two different kinds of file descriptors for processes,
one derived from procfs and one that's independent. The former works
with openat(2). The latter does not. To be very specific; if I'm
writing a function that accepts a pidfd and I get a pidfd that comes
from PIDCMD_GET_PIDFD, how am I supposed to get the equivalent of
smaps or oom_score_adj or statm for the named process in a race-free
manner?
