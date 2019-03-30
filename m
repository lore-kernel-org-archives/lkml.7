Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE21C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4C52184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prdfcf46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfC3R7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:59:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42253 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfC3R7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:59:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id b74so3282384qkg.9;
        Sat, 30 Mar 2019 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1NBa54fTgslAZ+4TBm7qu5vEcTvq37GddI32idRhStE=;
        b=prdfcf46TC6nTtTbMc2Tih0xrAESd/0wkwgW8SLV+sq2s5IiyeqoWTpmZaSMYVRi7w
         ncC5AKRojkn4I6u9dRxaJVQdD+I8MoxLkJJvbxyEN1onhG2TQ5SUC9OBXVmdylBlKGKg
         HtWg1EgJQkHYwLz2ssVsMIIjnU07WiLfWgAQBahsV5MrKKyXF/9B2Si5/H+rJtH/aWxc
         0UF0mqNwxhPKQbFAZvrcM+ba28rDyoQlHyUYgjvi7tVGBwVTizcrtq2oQKUt7qs/853D
         SeBE8S8PbuGcjZ60Qf2PEl/EXcMMck+P2JWhItV4lfxdn8xerGcQiYNGXOQ/ticLMQGL
         qSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NBa54fTgslAZ+4TBm7qu5vEcTvq37GddI32idRhStE=;
        b=QwI4LKydh9YL4YAym2tB6d4frFj0RcvQm/SC/CMsYcBwqIGl4BXLhRJ9pGPzr+Umbq
         t7HWvx+52a+iMLG8vQ6l+c0MMqIwc5/cIl0ULNcLQYAB3xDvRNSherQkFzyumePPPHD5
         3cb7+Cen9WZVsNwZ3BVQ6/koLM6u61T2smHn+AAX6YMrwSCC4wnaewzSF0bRNwc3uzGf
         XaqYvHs5m4gsY+gfoeRNNuQXE3rLgA9aYcxQJNWzkXFUaA551eec5eYeuYb6qiDvJOfz
         MKc9RHlx4pgR4315mZ9HoJC7mlsQajFBao9svvXKEemDZ8In1Nq3COGETDiz9vkxUrTP
         ea7A==
X-Gm-Message-State: APjAAAXorK+x3gaINXQ+ErVkAL6HLRLNmgh8aEFLheRizS1EpPlhZRSl
        hOcHr75HGkGNE1+vOGN9CDTgcowwSVwV2100CRk=
X-Google-Smtp-Source: APXvYqw5rywMl93VZ5/BUfTldK9VAaF5FewWsZHCGj9i4xQoOJp9vt0Kkqb5RAkuGK4YqzHKc5G3BDk1TUaiWI4eRQo=
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr34724685qkk.190.1553968781411;
 Sat, 30 Mar 2019 10:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <CAGLj2rHk5pPYg-uo4HjYQQkJJjM0ePohtLJr2TrucuOaU_skxw@mail.gmail.com> <20190330175241.4itdnx3tl5upzjxd@brauner.io>
In-Reply-To: <20190330175241.4itdnx3tl5upzjxd@brauner.io>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Sat, 30 Mar 2019 17:59:34 +0000
Message-ID: <CAGLj2rEtNNs0BXHuGkjpT4seHuh=Lj79iVYP-n117+Dv+ThcJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 5:52 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Sat, Mar 30, 2019 at 05:50:20PM +0000, Jonathan Kowalski wrote:
> > On Sat, Mar 30, 2019 at 5:24 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Sat, Mar 30, 2019 at 10:12 AM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > >
> > > > To clarify, what the Android guys really wanted to be part of the api is
> > > > a way to get race-free access to metadata associated with a given pidfd.
> > > > And the idea was that *if and only if procfs is mounted* you could do:
> > > >
> > > > int pidfd = pidfd_open(1234, 0);
> > > >
> > > > int procfd = open("/proc", O_RDONLY | O_CLOEXEC);
> > > > int procpidfd = ioctl(pidfd, PIDFD_TO_PROCFD, procfd);
> > >
> > > And my claim is that this is three system calls - one of them very
> > > hacky - to just do
> > >
> > >     int pidfd = open("/proc/%d", O_PATH);
> > >
> > > and you're done. It acts as the pidfd _and_ the way to get the
> > > associated status files etc.
> > >
> > > So there is absolutely zero advantage to going through pidfd_open().
> > >
> > > No. No. No.
> > >
> > > So the *only* reason for "pidfd_open()" is if you don't have /proc in
> > > the first place. In which case the whole PIDFD_TO_PROCFD is bogus.
> > >
> > > Yeah, yeah, if you want to avoid going through the pathname
> > > translation, that's one thing, but if that's your aim, then you again
> > > should also just admit that PIDFD_TO_PROCFD is disgusting and wrong,
> > > and you're basically saying "ok, I'm not going to do /proc at all".
> > >
> > > So I'm ok with the whole "simpler, faster, no-proc pidfd", but then it
> > > really has to be *SIMPLER* and *NO PROCFS*.
> > >
> >
> > (Resending because accidently it wasn't a reply-all)
> >
> > If you go with pidfd_open, that should also mean you remove the
> > ability to be able to use /proc/<PID> dir fds in pidfd_send_signal.
> >
> > Otherwise the semantics are hairy: I can only pidfd_open a task
> > reachable from my active namespace, but somehow also be able to open a
>
> You can easily setns() to another pid namespace and get a pidfd there.
> That's how most namespace interactions work right now. We already had
> that discussion.

Only if it is a child namespace, or you have the relevant capabilities to setns.

Currently, if I just put a task in PID namespace, it can see /proc of
an ancestor PID namespace, and opendir /proc/<PID>, this is accepted
by pidfd_send_signal.

If you ever allow signalling across PID namespaces (because file
descriptors should be able to do that, they are not namespaced, see
files, sockets, etc), it will become a problem. Getting pidfds from
outside my active namespace should require userspace cooperation.

So, opening a pidfd should be limited to what *I* can see in my
namespace, like every other namespace. That is what a namespace is,
and PIDs have their own namespace, they're not exposed in the
filesystem namespace.
