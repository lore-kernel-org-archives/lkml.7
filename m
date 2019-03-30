Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9D8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543C2217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWSxm5LC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfC3Ru2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:50:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41431 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbfC3Ru1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:50:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id o129so3278358qke.8;
        Sat, 30 Mar 2019 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjmT9JSBixV9ZplO7X4LpJ4/7aBZYStDxsJ3dPUlulQ=;
        b=XWSxm5LCEVkKOTQwP4VKFPqin2om/iwP0pyUnVcVUXWrARdqF8m73+n/9iSINDumFb
         zN+qRrdTgaHZPh92qaU3MybkmFLkY/0GAQkRr+xZb8n/BxdNS/58ixvhDvuv55GmxZWS
         i9/OP8kSZ+gimqiYN+/6qgm6R7O/XFGDD8Z9T7mfTwgIyCGIU22Am1fCeRvnfyapGnF5
         rLZh50im1do+smK7eGgb+8GK/MZC9eL1kn5X3L1+tMWsioHVLG14pEj5QtSNGSkHBkYA
         BP7UCOkJZ2rWoB4LK3JsMHrGdsBScoRYvpcPKNCysz6+oinfx3VGBKpwyBD0m+WewrhZ
         lS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjmT9JSBixV9ZplO7X4LpJ4/7aBZYStDxsJ3dPUlulQ=;
        b=CvZT+nNc2Qlco3WOYhuCOwovDkdSoYoNunvfaClK7ds2rw8usxSFIL9QQ/aI14dBJ3
         fwqgKKafN57zyC5YrkX6IgafMOJMQnFA1qAkyXeVCzR11vcYUIKQBIU6lgU7CbEFF7BU
         p2UEml9QkniuJzpZa1dk88lulmsHj1o9GWRa9NVFYQj67w6EKF7V5IGeSYzCLeXgOQxw
         y/mVlp/zxFRDBipo/1bV7Rr3fuqpFKZs0qDlXJBNJimsHhA3TOdZ/dm8JYpQcSLeOUNE
         Adm83uVOXfjlQL5Zagavp3xaoriBhU8t/IULgxtdZdj+MOI5pNZze5YwR4GG32krZ3fR
         nqjw==
X-Gm-Message-State: APjAAAU8WXPYrqnoJJmRqcdwrp+edCOCvBLobvaH/CYFqcXXjrvj4Ras
        4OuQX3ukoHHAuh0FDGe9sKq8Y/zMSe0tHRBxkuI=
X-Google-Smtp-Source: APXvYqw6vJWf+AtwHc0w/aCag46uiW93na0sd8pTkru/gaTu1oKcXbI6/eLKYoPSpg9NcWbQefH2C3Y+ZUEcyepRx20=
X-Received: by 2002:a05:620a:1438:: with SMTP id k24mr41627983qkj.165.1553968226775;
 Sat, 30 Mar 2019 10:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
In-Reply-To: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
From:   Jonathan Kowalski <bl0pbl33p@gmail.com>
Date:   Sat, 30 Mar 2019 17:50:20 +0000
Message-ID: <CAGLj2rHk5pPYg-uo4HjYQQkJJjM0ePohtLJr2TrucuOaU_skxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
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

On Sat, Mar 30, 2019 at 5:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Mar 30, 2019 at 10:12 AM Christian Brauner <christian@brauner.io> wrote:
> >
> >
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
>
> Yeah, yeah, if you want to avoid going through the pathname
> translation, that's one thing, but if that's your aim, then you again
> should also just admit that PIDFD_TO_PROCFD is disgusting and wrong,
> and you're basically saying "ok, I'm not going to do /proc at all".
>
> So I'm ok with the whole "simpler, faster, no-proc pidfd", but then it
> really has to be *SIMPLER* and *NO PROCFS*.
>

(Resending because accidently it wasn't a reply-all)

If you go with pidfd_open, that should also mean you remove the
ability to be able to use /proc/<PID> dir fds in pidfd_send_signal.

Otherwise the semantics are hairy: I can only pidfd_open a task
reachable from my active namespace, but somehow also be able to open a
pidfd if I happen to see someone's /proc in my mount namespace and
have the access to open it?

> PIDFD_TO_PROCFD violates *everything*.
>
>                       Linus
