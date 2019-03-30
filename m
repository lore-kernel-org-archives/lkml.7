Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9AFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715A82184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnzRtJVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfC3SAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:00:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41227 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfC3SAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:00:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so4934494otb.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3FFXH4gxkuC/G1c7qfWR3wOIcaso97fHrNrqzwKqK8=;
        b=TnzRtJVIaaWfjZ/Sl5J5P/2gFhl3R3rbWB7NCIe5p8uzMLdsrZht9mVoXUutesB9kP
         tjoaoV7pbmeuLQY4Ht7KUZTUMbe/ESd2f1eu0y9PQFbvNq/F1csye0aL/bLdY3SeEge1
         DnZd6RDHdODb93Wg+S6Uw3berNAkIehoWlmrecEka1a02cLMuaHad40k/lUDFVHK9AAT
         4KecuJkGQpwtW+ycig2iiStbaj239iLmlO9PB5acpxA316coBoulgkZjn9x7Z7VUfdPT
         f6lFI1u9U/hoidPd5gGpRSlwBAWD1MoKaYyv7gNGNzrELcLCGLFVw/4daNITTDPW3AEn
         YYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3FFXH4gxkuC/G1c7qfWR3wOIcaso97fHrNrqzwKqK8=;
        b=RG/NijQYKZ0UhqX6vTKThALQTczHNz7S0v1AMQAklLcKRMdFY0KAOi6VuLoieVdT31
         3vAqnHYdmpcY/EMrTQ39TdDq9NyIlpF0Wpnb13PnblZOCpDxzjM02C9QAR+3a0MFSxS3
         dZJT+bD6d4TsIaP5+rNF/uz1beYHsg9aUi83g8CoGrVT5uWyac3qY6u+rX0nnKHkvJUm
         8bF+CpdEpv1JJwRaLZ0AVdJ8WTKk/uqynNmJojw3SebFbjszYwlS3J8ii9Xm7eOKyDqO
         NBoBV++rHoIaoc4rQwcN6YwzgOAhGwRQHXYtk0RoRzsgwGYVbcGsBPC4WPFGEbg5RKxe
         XSQA==
X-Gm-Message-State: APjAAAU40MZOKknJB2o1msQYNtdQgEkxgFashofm01S1IQ2PjRe/keCw
        doM6Gmt2DMIFPsnhTXfGSZbR7Knja4ccwS0WLSTdGA==
X-Google-Smtp-Source: APXvYqxM7O1pfgYC70jc2l2KC/r6w6ibNRp/bfL/Ss9pP2OzwdmaBikbIDHBUsFk2auq3IF1PgBfyd3CyPgg1k9MlYg=
X-Received: by 2002:a9d:694c:: with SMTP id p12mr38290862oto.242.1553968830984;
 Sat, 30 Mar 2019 11:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
In-Reply-To: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 30 Mar 2019 19:00:03 +0100
Message-ID: <CAG48ez0F0FLcp_cd_aBVxp+M9k6RJYzOqKCjnD+oUBvt8+VM2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
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
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 6:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Mar 30, 2019 at 10:12 AM Christian Brauner <christian@brauner.io> wrote:
> > To clarify, what the Android guys really wanted to be part of the api is
> > a way to get race-free access to metadata associated with a given pidfd.
> > And the idea was that *if and only if procfs is mounted* you could do:
> >
> > int pidfd = pidfd_open(1234, 0);
> >
> > int procfd = open("/proc", O_RDONLY | O_CLOEXEC);
> > int procpidfd = ioctl(pidfd, PIDFD_TO_PROCFD, procfd);
>
> And my claim is that this is three system calls - one of them very
> hacky - to just do
>
>     int pidfd = open("/proc/%d", O_PATH);
>
> and you're done. It acts as the pidfd _and_ the way to get the
> associated status files etc.
>
> So there is absolutely zero advantage to going through pidfd_open().
>
> No. No. No.
>
> So the *only* reason for "pidfd_open()" is if you don't have /proc in
> the first place. In which case the whole PIDFD_TO_PROCFD is bogus.

So if, in the future, there is some sort of "create a new task and
return an fd to it" syscall, do you think it should always return
pidfds, or do you think it should return fds to /proc if procfs is
available? And if it should return fds to /proc, does that mean that
this "create a task" API should take an extra argument with a file
descriptor to the procfs instance you want to use?
(This can't always be implemented easily in userspace on top of normal
clone(), because if you create a task without a termination signal -
like a thread -, its PID can be recycled under you.)
An API like this would have less complexity stuffed into a single
syscall if it always returns pidfds, and if you then actually want an
fd to procfs, you can do the conversion that requires specifying a
procfs instance separately.

Of course, if you think that we shouldn't add an API for
pidfd-to-procfs conversion before we have an API for
clone()-with-an-fd-retval, that's understandable.
