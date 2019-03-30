Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631A7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 06:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7272184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 06:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELr8fceC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfC3GZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 02:25:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36155 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfC3GZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 02:25:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so5218896qtn.3;
        Fri, 29 Mar 2019 23:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=So+1AjqY2B3hpkxsqiZAinMeQ5z4HoPx4le+MMpEwD8=;
        b=ELr8fceCtBEORgYwia9kSiZbhR68x8euvkj7NnMre69NFWLGJjQseDBpe2R4+eEsCm
         qp/+a5zypayLB0nuoMaPTO7XjmXHAueaFqP0CC++t3LnzvEZn0MNzZQAhIYoknnh6QrK
         gdKOyZlKA8bvgbWDqiGDhEK7zgeoGAM6/J2MDasyx2cdOX1lIahv5d582yOmWHbU91j1
         ME3H3JJUzr2eauewMfHdAyg+niTF/rIW1xu4b6A267p0fLN+sxTk4BjzWs5QXamfaEow
         thOwljj+5oT+GXdZ1d0viBifEyciOmyHhuyE6A9bt5ci2RIjx8ujPOP7x/vdxsxZD2tG
         1msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=So+1AjqY2B3hpkxsqiZAinMeQ5z4HoPx4le+MMpEwD8=;
        b=dYDgJBFblvuYEiL5tb9YytHtlTYTN7tFreELagagT6jolDi0licST958NKmNMxHkrG
         BAKIoibO2AOvLiAQ1NeFc2ahcX2f+to5kar+ifqyrGPMSqOJ6QKeMnXeOMIUW8D9hFdG
         tplUVw7KOHWvYFNIti+LDS1/tcBsEkRcvpgD5oQpbnp/AB/UyVeniHQNoOqs/XjWiNAh
         Y5VWYoxKgcrquFUC50POQT8OmF+xMuawmnxtG45Jxa8ka/by32os8I125imHNUNg/M8B
         Jt53J5RTRgAH5Dw9KLmWccwr7RWI4haxE5vj4M1uFSi9wtYIs+NZ149k9x/v2Vo/tJbX
         ia3g==
X-Gm-Message-State: APjAAAUOR5bFOkOsxLa9BFB56A6Y07ToB1XqvayMk0Prcj14u9B5FqQY
        KmAJG4QLsaD9mGzg+nmVFos7tq+uKCAXfkkgGGY=
X-Google-Smtp-Source: APXvYqy4WpvLF/0GOLGbDmi0Q6CIpTeqJIAASNcNvLhz9tU2PaF1K6pYCiLQJvIayb9/+5XeBbp/JSXmZamyQYAWdFM=
X-Received: by 2002:ac8:3042:: with SMTP id g2mr44122464qte.1.1553927115292;
 Fri, 29 Mar 2019 23:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190327162147.23198-1-christian@brauner.io> <20190327162147.23198-3-christian@brauner.io>
 <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
 <20190327213404.pv4wqtkjbufkx36u@brauner.io> <CAGLj2rHpYAOGz0h0k2pS4JwFSQkMmRSUWxa4BtO+7BUMD21vdQ@mail.gmail.com>
 <20190327222543.huugotqcew6jyytv@brauner.io> <CAGLj2rG0Sbho6MnPSmcS73Xj=oG92E4W_QLRu4dD8NfweoUm5Q@mail.gmail.com>
 <20190328103813.eogszrqbitw3e7k7@brauner.io> <CAKOZueusdFurOb_uFZ3PDmZeJvYvHVKMx6=TpiWPERkKRiHfiw@mail.gmail.com>
In-Reply-To: <CAKOZueusdFurOb_uFZ3PDmZeJvYvHVKMx6=TpiWPERkKRiHfiw@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Sat, 30 Mar 2019 06:25:09 +0000
Message-ID: <CAGLj2rEtgiJfmKgo4bJvmBYp1Y5f1SELVfEu7Ayfi62zOAxjGQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
To:     Daniel Colascione <dancol@google.com>
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

On Sat, Mar 30, 2019 at 5:35 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Thu, Mar 28, 2019 at 3:38 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > > All that said, thanks for the work on this once again. My intention is
> > > just that we don't end up with an API that could have been done better
> > > and be cleaner to use for potential users in the coming years.
> >
> > Thanks for your input on all of this. I still don't find multiplexers in
> > the style of seccomp()/fsconfig()/keyctl() to be a problem since they
> > deal with a specific task. They are very much different from ioctl()s in
> > that regard. But since Joel, you, and Daniel found the pidctl() approach
> > not very nice I dropped it. The interface needs to be satisfactory for
> > all of us especially since Android and other system managers will be the
> > main consumers.
>
> Thanks.
>
> > So let's split this into pidfd_open(pid_t pid, unsigned int flags) which
> > allows to cleanly get pidfds independent procfs and do the translation
> > to procpidfds in an ioctl() as we've discussed in prior threads. This
>
> I sustain my objection to adding an ioctl. Compared to a system call,
> an ioctl has a more rigid interface, greater susceptibility to
> programmer error (due to the same ioctl control code potentially doing
> different things for different file types), longer path length, and
> more awkward filtering/monitoring/auditing/tracing. We've discussed
> this issue at length before, and I thought we all agreed to use system
> calls, not ioctl, for core kernel functionality. So why is an ioctl
> suddenly back on the table? The way I see it, an ioctl has no
> advantages except for 1) conserving system call numbers, which are not
> scarce, and 2) avoiding the system call number coordination problem
> (and the coordination problem isn't a factor for core kernel code). I
> don't understand everyone's reluctance to add new system calls. What
> am I missing? Why would we give up all the advantages that a system
> call gives us?
>

I agree in general, but in this particular case a system call or an
ioctl doesn't matter much, all it does is take the pidfd, the command,
and /proc's dir fd.

If you start adding a system call for every specific operation on file
descriptors, it *will* become a problem. Besides, the translation is
just there because it is racy to do in userspace,  it is not some well
defined core kernel functionality. Therefore, it is just a way to
enter the kernel to do the openat in a race free and safe manner.

As is, the facility being provided through an ioctl on the pidfd is
not something I'd consider a problem. I think the translation stuff
should also probably be an extension of ioctl_ns(2) (but I wouldn't be
opposed if translate_pid is resurrected as is).

For anything more involved than ioctl(pidfd, PIDFD_TO_PROCFD,
procrootfd), I'd agree that a system call would be a cleaner
interface, otherwise, if you cannot generalise it, using ioctls as a
command interface is probably the better tradeoff here.

> I also don't understand Andy's argument on the other thread that an
> ioctl is okay if it's an "operation on an FD" --- *most* system calls
> are operations on FDs. We don't have an ioctl for sendmsg(2) and it's
> an "operation on an FD".
