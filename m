Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C9820882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG8tAR0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbfCaPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:33:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46651 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731229AbfCaPdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 11:33:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id s81so4139845qke.13;
        Sun, 31 Mar 2019 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4az699/ItXcqB4rUuwqQwTNBLxb/aNzr48w+MPX4VyY=;
        b=TG8tAR0lIEnRybo7yzbwnF/T2o23MvnFjwIOuRJNTKFWMUYzEome/bpuB4nQB144a1
         YB6AoZlmikv+wNkTe8sHCXoO4AEcTYR58YNe1r45MSKfivR9/wD2unYuiJ9eGPHWV2rJ
         JA7moKggJSOLs5XRVcTGtVA3NsOJpwn3LsVNMSqzk3WYOZlr8DqnOBx3c1z/GacShxY5
         kX13KP/cPEbSHkkslzjgYT3WT1YjMUrwkNnayr6x4LR2ZfpZvlNVvh86z8V6GF/eeUWK
         tS9pgTYoot1XayadIi3wnJqgG+ZJX9awVurbokr2rvlSJxGT/rTkCU1mBWjja8d5wmnQ
         06eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4az699/ItXcqB4rUuwqQwTNBLxb/aNzr48w+MPX4VyY=;
        b=ikTGRgBoi5eQct8hmJbTWCQ2M1Z8vVsH0Fq8Uyb5T3rz/68f/4y+op95VjHJ+1GB0E
         e5p5b89xWzjx3DFPDR8pNmkXm/OwsXmdiPdwLQYmuzxn8vAzKxtsdXt1JlGc2qM4XXyu
         Fu+49plDE2SOvj4gEtT69NiMD9er36OI/KJv20VzhAMr8Glh3G1CdS/ipfFfYy6mo3lm
         lpJUZXKnana3g+7HDotvRHaOQuwvyf4t7ZqfyudG7LbXJx6/BE9EwNWilJJOdqfR2P+C
         FeVQ+FFtgHrNzvYsXnYlPu6OOQ/H9eaO9Ia3GX3ioseq7YT4ZhJR4TIa8k0Anq+hOzyV
         KmWw==
X-Gm-Message-State: APjAAAXEK2qIdD5A4kxKy/ZZ+AnsFz14j5XzS+df2e7/EJLGjr/VYEOe
        J4BR5H7kfT35e66EpXB5O9qHt+eMsQOuzZlgs7Q=
X-Google-Smtp-Source: APXvYqxR17+10wB2CQjl4pPD64Y2a18t9xMPttJABxTy4p4iyGmMdOIhHwlbM9M77auhPwQt3+csyxZkRI5X4HFx9uA=
X-Received: by 2002:a05:620a:1438:: with SMTP id k24mr44521117qkj.165.1554046433442;
 Sun, 31 Mar 2019 08:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
 <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
 <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com>
 <20190331010716.GA189578@google.com> <CAG48ez387kGbD_dLqEbZ1U9rKFbfP0EF9cMVjQT6nwc9=Y9CNw@mail.gmail.com>
 <20190331040810.GB189578@google.com> <CAG48ez2gb94SqS30Ai4+VBHhnzBp5Po9_u00nMrvUW6Wqq6hPA@mail.gmail.com>
 <CAHk-=wiZ40LVjnXSi9iHLE_-ZBsWFGCgdmNiYZUXn1-V5YBg2g@mail.gmail.com>
In-Reply-To: <CAHk-=wiZ40LVjnXSi9iHLE_-ZBsWFGCgdmNiYZUXn1-V5YBg2g@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Sun, 31 Mar 2019 16:33:48 +0100
Message-ID: <CAGLj2rELekFugPJ8OGH8wxFabmZ1UJBORwywpZrStKjohTF63A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
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
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 3:59 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Mar 30, 2019 at 9:47 PM Jann Horn <jannh@google.com> wrote:
> >
> > Sure, given a pidfd_clone() syscall, as long as the parent of the
> > process is giving you a pidfd for it and you don't have to deal with
> > grandchildren created by fork() calls outside your control, that
> > works.
>
> Don't do pidfd_clone() and pidfd_wait().
>
> Both of those existing system calls already get a "flags" argument.
> Just make a WPIDFD (for waitid) and CLONE_PIDFD (for clone) bit, and
> make the existing system calls just take/return a pidfd.

clone is out of flags, so there will have to be a new system call.

I am not sure about the waitid bit. Are you suggesting it takes a
pidfd and waits using it? I was thinking if we could make the pidfd
itself pollable and readable for exit status. At pidfd_open time, you
pass the flag and only if you're a parent you get a readable instance,
if not, a pollable one for everyone (eg. for an indirect child as a
reaper), and it fails for threads.

Then, the pidfd clone2 returns can also be polled and read from.

The main pain point is, currently when I ptrace from a thread a
process, I need to use waitpid (waitid throws away ptrace critical
information), and since ptrace works on a thread by thread basis, only
the attached thread can do the waitpid. This means I cannot do
anything else from the attached thread concurrently. waitfd was
supposed to solve this (back in 2009) but it never made it in, and
clone4 from Josh Triplett did something similar (returned exit status
over the clonefd).

FreeBSD's process descriptors are also pollable (which is where all
this work was originally inspired from) and it would help with
adoption if semantics were similar. Besides that, it would help
libraries to be able to host their own set of children without
affecting the entire process's waiting logic oe mucking with the
SIGCHLD handler (you wouldn't need signals).

>
> Side note: we could (should?) also make the default maxpid just be
> larger. It needs to fit in an 'int', but MAXINT instead of 65535 would
> likely alreadt make a lot of these attacks harder.
>
> There was some really old legacy reason why we actually limited it to
> 65535 originally.  It was old and crufty even back when..
>
>                Linus
>
>               Linus
