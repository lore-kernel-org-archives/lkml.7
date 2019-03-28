Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D7BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49536204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ4RnTvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfC1AmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:42:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40710 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1AmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:42:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id x12so21173621qts.7;
        Wed, 27 Mar 2019 17:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VX7TOipQDYu/BXRwV77Z5LbrVCYOYcudfIqoghcIYM=;
        b=pQ4RnTvjAPG7/SCx2XqjWKTmMMTyctD5ZSUSIc33R50l4SpuK0ytSronU0yuJsSs57
         G8Ei6gNU38jWrocgCykttuBdPgIk9hdlraPQnZqWrtXK0opm+cWHXQpX1eWF62c44Bb1
         oDTNVwT3dOOH2lT4hW+xKsR4mMIS7QlBMmTT2gnaGoUMy45SsNBCAWyCs/sEBwAfjHpD
         IT0N8PClNGUptAryxys2jv0LFXWisxKkAH7qE4F3YMMdEoeUPJwL6UsTGLRHhNMiZIZv
         OgEjxMyqPbVIuZ0qL2I1vP+BjTaL7W3Zag4kqLMt9zLEnLvRUjNO4seWSyzFMI8es1Lu
         EiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VX7TOipQDYu/BXRwV77Z5LbrVCYOYcudfIqoghcIYM=;
        b=BBkrAcEY1LC8gauJeAIHqNn8R70mR0LwS+B60f830LkCbtJBqQcGeM+LT1ffxpBBw/
         Ppu80XR3Bq/VPWLhkWX8pppavFKFais2DIZ3BB0NowPwISGcZeNSEzVNePba8benkoTT
         gIrScSMxK6gBk7UtBaM3VVBfwp0fD83tpq46wQzwuGjQeEh029nCtxwH/z+rA3bw2FF3
         7a/AhV8AWynN64FM7t9gWtLJ2oCVTCdn1XQgc0PaRQNW8f+oaKDKtIK30ngEc7kQa0Je
         OmIzKtnpj5FIutfuLowRtg03YU8+B9wZYwhfvZBV9NxjxKatSYAN6EKt4xy7Fh6ex6uV
         C92A==
X-Gm-Message-State: APjAAAXBpK0redTrXPLrBpf4uvAPZNU6kBZ/smZ+jHP4rw5xrMcwNtB5
        HoURSH7BLejXLc+OZDn2nN49LF3aK3/FuZaS57E=
X-Google-Smtp-Source: APXvYqwTPd7WgMmLe+phDVaV03N7UdLwUfryARgyWZC4F+s8OmV/0YUIdJ1auJXSIuBLg5GamHzndMh5UeD9v0aPcyI=
X-Received: by 2002:a0c:d6c9:: with SMTP id l9mr33122332qvi.58.1553733741108;
 Wed, 27 Mar 2019 17:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190327162147.23198-1-christian@brauner.io> <20190327162147.23198-3-christian@brauner.io>
 <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
 <20190327213404.pv4wqtkjbufkx36u@brauner.io> <CAGLj2rHpYAOGz0h0k2pS4JwFSQkMmRSUWxa4BtO+7BUMD21vdQ@mail.gmail.com>
 <20190327222543.huugotqcew6jyytv@brauner.io>
In-Reply-To: <20190327222543.huugotqcew6jyytv@brauner.io>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Thu, 28 Mar 2019 00:42:10 +0000
Message-ID: <CAGLj2rG0Sbho6MnPSmcS73Xj=oG92E4W_QLRu4dD8NfweoUm5Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pidfd_open is open pidfd for pid relative to pidns, so a better
analogy is that it is like openat for a relative pathname wrt dirfd.
O_DIRECTORY is analogous to what type of object, so a TIDFD flag in
the future which interprets pid (pathname) as thread id only and pins
that specific struct pid. That has now limited you to the specific
object and operations you can perform on said object with other pidfd
APIs.

procfd_open in my proposed signature is just a fancy race free openat
on the corresponding pid of the pidfd relative to the procrootfd
(which becomes the dirfd if i were doing it in userspace), which might
as well been implemented in userspace if things were not racy. Andy
suggested something similar.

My point is, when I am talking of the pidfd API, procfs is irrelevant.
You are thinking of it as a process directory and a process file, I am
thinking of it in terms of a process object and the proc dir fd as an
file system based interface to query process state (through read)
which is why I object to them being usable with pidfd_send_signal as
well, in principle. In the future, people may use task_diag for the
same purpose or a different interface, to work around its limitations.
This would just be another interface of the kernel to query process
state, not representative of the process object itself. Hence, keeping
the pidfd to procfd translation entirely separate (as already
suggested) sounds much, much better to me.

The pidfd API and related calls are untouched and unaffected by
presence, absence of procfs or not (they are, but you do unrelated
stuff in the same system call). To me atleast, munging opening (and
then changing what the procfd means to support the flag use case),
having flags like PIDFD_TO_PROCFD that will work only without
CLONE_NEWPID, then having eg. GET_TIDFID that may work with
CLONE_NEWPID, etc.

I find this interface confusing.

I have a few steps when starting to work with a pidfd:

1. Acquire

pidfd_open(pid, ns, flags) or pidfd_clone(...)

2. Operate

pidfd_send_signal(...)

For those who need a race free way to open the correct /proc/<PID> for
a pidfd relative to a /proc dir fd, for the purposes of metadata
access, you will have procfd_open, which is in the kernel because the
same thing is racy to do in userspace.

Otherwise, pidfd_open in this patchset is this and also a polymorphic
system call that can become procfd_open in my example when passed a
flag. It is doing vastly different things given the presence and
absence of options. This is similar to a multiplexor again, but it
looks more confusing. You have to mask options.

pidfd_open currently:

pidfd_open(pid, -1, -1, 0); gets pidfd in current active ns
pidfd_open(-1, procrootfd, pidfd, PIDFD_TO_PROCFD); returns dir fd of
/proc/<PID> it maps to rel. to proc rootfd
pidfd_open(-1, nsfd, pidfd, CLONE_NEWPID); as you propose this
searches pid in pidns pinned by nsfd, and returns a pidfd file
descriptor.

Extend this to threads in the future, and the combination and
permutation starts getting confusing. Based on the flag, it is
entirely changing what will it work upon, and what it will do.

I can reasonably summarise my pidfd_open and procfd_open in their man
page in one line:

pidfd_open(pid, ns, flags) returns pidfd for pid, searching it in the
pidns pinned by ns fd, and flags will determine further if this is
thread local or process local (i.e. tid or tgid, and tgid == tid for
single threaded) (in the future) (so you could do thread directed
signals by passing a flag to pidfd_send_signal and this pidfd).

Your call without CONFIG_PROC_FS will be literally this, but a few
options will have to be set as -1.

procfd_open(procrootfd, pidfd, flags), returns the proc dir fd for the
pid/tid depending on if the pidfd is thread local, process local, hint
it in flags, etc. It is just a race free wrapper around an openat in
userspace, undergoing the same access control checks.

Yes, pidfd_open as it is now works *just fine*, but it is more
confusing to use and discuss. The conclusion from the previous
discussion also seemed to be to split pidctl's PIDCMD_GET_PIDFD into
its own thing, and provide a translation from pidfd to its proc dir fd
on its own. Then, translate_pid can be its own thing, or you could
extend ioctl_ns(2) if you want.

All that said, thanks for the work on this once again. My intention is
just that we don't end up with an API that could have been done better
and be cleaner to use for potential users in the coming years.
