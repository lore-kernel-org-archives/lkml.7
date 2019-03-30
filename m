Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409C0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C9D218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIOfPhlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfC3HjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:39:17 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35420 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfC3HjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:39:17 -0400
Received: by mail-ua1-f66.google.com with SMTP id f88so1463726uaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=199HryMslZmTwY/IDNVbuJ8haSGqPyxWj0R+Nri07wI=;
        b=tIOfPhlD3SSmLwWQKBO+b7NQbxJvhSkM0VTpYqIUtwwa/LWLzkjK+hmbGyTh0MRsFN
         havRP7/DGu2ClBCx+coyaCF2JZjoPHoszd5xTB8bRmS0ZnSXs1ickaA+ovLjww9uEGMa
         L4ejbWcUmKtiGVe5XNU/lsR6ox+0ncBbOiPKg40pVIyo+bk1XORkDyDBGbAHYy3lzVQz
         B9qymyHypTg5h1asQSljQ62BbnZL82hE7cyW8siE/9RBOPmYrOs4j3dFaEvivYmMwWgb
         +vxadE4bbG1myots9eLdARu+lCik29fz9sr469md/h3XeqVBCemi4/M1H+XRGNrF1iyQ
         ilFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=199HryMslZmTwY/IDNVbuJ8haSGqPyxWj0R+Nri07wI=;
        b=QXXtDgj4LIoFTIkOTTlF4Qd8ZAX7qHdc/tGP7/qK47WUSEMLd1ADmW42E4kXGs1+dv
         bP15Gna+FGJt1WrfQefgMlQQFdj6wgk9JXqrXlUrt9ST/WXNeHLGjNHygN+8EGYMF1aQ
         5gKEn7W61y7QfZqygBFzH5/3OPKs2fBpy+AyuPklOFriOjg72OGEemvVLx/Kx45ZWdKS
         b/W1wtgiieNHkDrAeUSrxqaXk29lXdEXN81CrzfBw05iar4czeBqBHoFJSN7L0Yq8tBC
         psQvMfonlFRLXDai1g8ZBPcYi044AsWihAtUhAvG/nMmfidmz2v4Liy5yMdZwpXMaisJ
         KIUA==
X-Gm-Message-State: APjAAAW7MULgKzBomznYYInoXHBkWt1VWFa+5a9ANzjJroPRAm+Jos21
        JvA60Za+2E6Bk8aG3CXDZ97huUYx+h51wI1/4RMWXA==
X-Google-Smtp-Source: APXvYqy/E4ocOPs6MBEcEoZfQbv5Ob/XDiHCd9sOWy6h6+zXoE+1aG3eTQTDiEPbVVSrTolQ5U0LEXFvnR/u1qLqahc=
X-Received: by 2002:ab0:73d3:: with SMTP id m19mr31439808uaq.46.1553931555540;
 Sat, 30 Mar 2019 00:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190327162147.23198-1-christian@brauner.io> <20190327162147.23198-3-christian@brauner.io>
 <CAGLj2rG8xMMt8-+r-pauA_qi4aun2y_kBZMCZGkXWQsKJrb-Ww@mail.gmail.com>
 <20190327213404.pv4wqtkjbufkx36u@brauner.io> <CAGLj2rHpYAOGz0h0k2pS4JwFSQkMmRSUWxa4BtO+7BUMD21vdQ@mail.gmail.com>
 <20190327222543.huugotqcew6jyytv@brauner.io> <CAGLj2rG0Sbho6MnPSmcS73Xj=oG92E4W_QLRu4dD8NfweoUm5Q@mail.gmail.com>
 <20190328103813.eogszrqbitw3e7k7@brauner.io> <CAKOZueusdFurOb_uFZ3PDmZeJvYvHVKMx6=TpiWPERkKRiHfiw@mail.gmail.com>
 <CAGLj2rEtgiJfmKgo4bJvmBYp1Y5f1SELVfEu7Ayfi62zOAxjGQ@mail.gmail.com>
In-Reply-To: <CAGLj2rEtgiJfmKgo4bJvmBYp1Y5f1SELVfEu7Ayfi62zOAxjGQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 30 Mar 2019 00:39:03 -0700
Message-ID: <CAKOZuesjdfNptM9Pt_uzsDVefW6LXhHPHG2a3rJRAe0rpeWX6g@mail.gmail.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
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

On Fri, Mar 29, 2019 at 11:25 PM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
>
> On Sat, Mar 30, 2019 at 5:35 AM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Thu, Mar 28, 2019 at 3:38 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > > All that said, thanks for the work on this once again. My intention is
> > > > just that we don't end up with an API that could have been done better
> > > > and be cleaner to use for potential users in the coming years.
> > >
> > > Thanks for your input on all of this. I still don't find multiplexers in
> > > the style of seccomp()/fsconfig()/keyctl() to be a problem since they
> > > deal with a specific task. They are very much different from ioctl()s in
> > > that regard. But since Joel, you, and Daniel found the pidctl() approach
> > > not very nice I dropped it. The interface needs to be satisfactory for
> > > all of us especially since Android and other system managers will be the
> > > main consumers.
> >
> > Thanks.
> >
> > > So let's split this into pidfd_open(pid_t pid, unsigned int flags) which
> > > allows to cleanly get pidfds independent procfs and do the translation
> > > to procpidfds in an ioctl() as we've discussed in prior threads. This
> >
> > I sustain my objection to adding an ioctl. Compared to a system call,
> > an ioctl has a more rigid interface, greater susceptibility to
> > programmer error (due to the same ioctl control code potentially doing
> > different things for different file types), longer path length, and
> > more awkward filtering/monitoring/auditing/tracing. We've discussed
> > this issue at length before, and I thought we all agreed to use system
> > calls, not ioctl, for core kernel functionality. So why is an ioctl
> > suddenly back on the table? The way I see it, an ioctl has no
> > advantages except for 1) conserving system call numbers, which are not
> > scarce, and 2) avoiding the system call number coordination problem
> > (and the coordination problem isn't a factor for core kernel code). I
> > don't understand everyone's reluctance to add new system calls. What
> > am I missing? Why would we give up all the advantages that a system
> > call gives us?
> >
>
> I agree in general, but in this particular case a system call or an
> ioctl doesn't matter much, all it does is take the pidfd, the command,
> and /proc's dir fd.

Thanks again.

I agree that the operation we're discussing has a simple signature,
but signature flexibility isn't the only reason to prefer a system
call over an ioctl. There are other reasons for preferring system
calls to ioctls (safety, tracing, etc.) that apply even if the
operation we're discussing has a relatively simple signature: for
example, every system call has a distinct and convenient ftrace event,
but ioctls don't; strace filtering Just Works on a
system-call-by-system-call basis, but it doesn't for ioctls; and
documentation for system calls is much more discoverable (e.g., man
-k) than documentation for ioctls. Even if the distinction doesn't
matter much, IMHO, it still matters a little, enough to favor a system
call without an offsetting advantage for the ioctl option.

> If you start adding a system call for every specific operation on file
> descriptors, it *will* become a problem.

I'm not sure what you mean. Do you mean that adding a top-level system
call for every operation that might apply to one specific kind of file
descriptor would lead, as the overall result, to the kernel having
enough system calls to cause negative consequences? I'm not sure I
agree, but accepting this idea for the sake of discussion: shouldn't
we be more okay with system calls for features present on almost all
systems --- like procfs --- even if we punt to ioctls very rarely-used
functionality, e.g., some hypothetical special squeak noise that you
could get some specific 1995 adlib clone to make?

> Besides, the translation is
> just there because it is racy to do in userspace,  it is not some well
> defined core kernel functionality.
> Therefore, it is just a way to
> enter the kernel to do the openat in a race free and safe manner.

I agree that the translation has to be done in the kernel, not
userspace, and that the kernel must provide to userspace some
interface for requesting that the translation happen: we're just
discussing the shape of this interface. Shouldn't all interfaces
provided by the kernel to userspace be equally well defined? I'm not
sure that the internal simplicity of the operation matters much
either. There are already explicit system calls for some
simple-to-implement things, e.g., timerfd_gettime. It's worth noting
that timerfd is (IIRC), like procfs, a feature that's both ubiquitous
and optional.

> As is, the facility being provided through an ioctl on the pidfd is
> not something I'd consider a problem.

You're right that from a signature perspective, using an ioctl isn't a
problem. I just want to make sure we take into account the other,
non-signature advantages that system calls have over ioctls.

> I think the translation stuff
> should also probably be an extension of ioctl_ns(2) (but I wouldn't be
> opposed if translate_pid is resurrected as is).
> For anything more involved than ioctl(pidfd, PIDFD_TO_PROCFD,
> procrootfd), I'd agree that a system call would be a cleaner
> interface, otherwise, if you cannot generalise it, using ioctls as a
> command interface is probably the better tradeoff here.

Sure: I just want to better understand everyone else's thought process
here, having been frustrated with things like the termios ioctls being
ioctls.
