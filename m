Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C0EC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70F0207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 18:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="vMyr0IFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLVShU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 13:37:20 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38363 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLVShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 13:37:20 -0500
Received: by mail-ed1-f68.google.com with SMTP id i16so13471065edr.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 10:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGhNUIzJMJyjZ2lQMcwlFSfme2wg/EgX12x/9dSkpig=;
        b=vMyr0IFwsgCoJRkRweRpmoEPM3ypc4bRNhc6Tv6bmG032rS++QGZZjbSj8wSk0ICsu
         /BcwT3KjQs7CF/dBJ2ELRNZ+03VlPY1ci/h5UEjw9NPing+AxKBvO3lajy2l1ynf8wIG
         6dk2aF84AE8+vPTXOUjOG6kxXfBfB11s1b23U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGhNUIzJMJyjZ2lQMcwlFSfme2wg/EgX12x/9dSkpig=;
        b=SmsT3fLg3yIVnhiw+OHZ127hFOUBcQ+iCgQRtS+MjXQ3RF9oikGs6e1C6y4bF1YKKU
         Qpafl9PqbLKPzLD65MglgVd55kl4n4pwbpLBskcRMIXKAmw9PC2O88elf8G/81y2OnRV
         8pGxQ550sdpYa1qgsaShZ3bnJj8fInlx+wU6Xqrc3e0G66lXO0Mt/ysng/wyH0Tlm4Jl
         AexdF389NJ7to91xNr5AIs9eSR2gHvdI/b5k5hlVuQdLTvavDTUnulIH7BbioNHghF80
         pMNZLXOyetW8H37IDoAybQhCOsbPbFV9rB3OYlb5KXAmX0QZ6mj0ArRn4UWQFZ72J4r+
         CE3A==
X-Gm-Message-State: APjAAAUt6AliYaT1tnv13iHOIgYycHp0WQXsezjtgagJmU1Ax5sqOHAw
        DCYxJ1YawkFrBKoaOFJUYXXvmKKStKeGsSI/LjEg/Q==
X-Google-Smtp-Source: APXvYqwFlBOs9SzrWjvLB2ETA689RwKB5PflxcNP/7fMNuF1vJfaCENMmnrfLW3fygry8F4AJbr8ZWDoQZvsK+o0qic=
X-Received: by 2002:aa7:cd49:: with SMTP id v9mr28874799edw.269.1577039838241;
 Sun, 22 Dec 2019 10:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20191220232810.GA20233@ircssh-2.c.rugged-nimbus-611.internal> <20191222124756.o2v2zofseypnqg3t@wittgenstein>
In-Reply-To: <20191222124756.o2v2zofseypnqg3t@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 22 Dec 2019 10:36:42 -0800
Message-ID: <CAMp4zn-x3wiYVgmoVfkA61Epfh7JoEHUn5QCpULERxLPkLoMYA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] pid: Introduce pidfd_getfd syscall
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

, On Sun, Dec 22, 2019 at 4:48 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Dec 20, 2019 at 11:28:13PM +0000, Sargun Dhillon wrote:
> > This syscall allows for the retrieval of file descriptors from other
> > processes, based on their pidfd. This is possible using ptrace, and
> > injection of parasitic code along with using SCM_RIGHTS to move
> > file descriptors between a tracee and a tracer. Unfortunately, ptrace
> > comes with a high cost of requiring the process to be stopped, and
> > breaks debuggers. This does not require stopping the process under
> > manipulation.
> >
> > One reason to use this is to allow sandboxers to take actions on file
> > descriptors on the behalf of another process. For example, this can be
> > combined with seccomp-bpf's user notification to do on-demand fd
> > extraction and take privileged actions. For example, it can be used
> > to bind a socket to a privileged port.
> >
> > /* prototype */
> >   /*
> >    * pidfd_getfd_options is an extensible struct which can have options
> >    * added to it. If options is NULL, size, and it will be ignored be
> >    * ignored, otherwise, size should be set to sizeof(*options). If
> >    * option is newer than the current kernel version, E2BIG will be
> >    * returned.
> >    */
> >   struct pidfd_getfd_options {};
> >   long pidfd_getfd(int pidfd, int fd, unsigned int flags,
> >                  struct pidfd_getfd_options *options, size_t size);
That's embarrassing. This was supposed to read:
long pidfd_getfd(int pidfd, int fd, struct pidfd_get_options *options,
size_t size);

>
> The prototype advertises a flags argument but the actual
>
> +SYSCALL_DEFINE4(pidfd_getfd, int, pidfd, int, fd,
> +               struct pidfd_getfd_options __user *, options, size_t, usize)
>
> does not have a flags argument...
>
> I think having a flags argument makes a lot of sense.
>
> I'm not sure what to think about the struct. I agree with Aleksa that
> having an empty struct is not a great idea. From a design perspective it
> seems very out of place. If we do a struct at all putting at least a
> single reserved field in there might makes more sense.
>
> In general, I think we need to have a _concrete_ reason why putting a
> struct versioned by size as arguments for this syscall.
> That means we need to have at least a concrete example for a new feature
> for this syscall where a flag would not convey enough information.
I can think of at least two reasons we need flags:
* Clearing cgroup flags
* Closing the process under manipulation's FD when we fetch it.

The original reason for wanting to have two places where we can put
flags was to have a different field for fd flags vs. call flags. I'm not sure
there's any flags you'd want to set.

Given this, if we want to go down the route of a syscall, we should just
leave it as a __u64 flags, and drop the pointer to the struct, if we're
not worried about that.

>
> And I'm not sure that there is a good one... I guess one thing I can
> think of is that a caller might want dup-like semantics, i.e. a caller
> might want to say:
>
> pidfd_getfd(<pidfd>, <fd-to-get>, <fd-number-to-want>, <flags>, ...)
>
> such that after pidfd_getfd() returns <fd-to-get> corresponds to
> <fd-number-to-want> in the caller. But that can also be achieved via:
> int fd = pidfd_getfd(<pidfd>, <fd-to-get>, <flags>, ...)
> int final_fd = dup3(fd, <newfd>, O_CLOEXEC)
>
> >
> > /* testing */
> > Ran self-test suite on x86_64
>
> +1
>
