Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071CBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D3620700
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z11OVFj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfC3QeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:34:15 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46579 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfC3QeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:34:15 -0400
Received: by mail-vs1-f66.google.com with SMTP id e2so2396559vsc.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJlkPNizVF+Qb0ZGxKZFsp+UcFxnswGnvXVIUjOU9lM=;
        b=Z11OVFj8Bg29I9qcG4RQ9+ya10+DIpMrc16ThZb0TgSK+ryAxkezx+/hAqyc/Ewg1K
         U20s5X1GzD4hkbadd0W69ZqzZuj1MAsg6ExqnYcK+WT+oGBACiagEE2P1r8/RUXjclSe
         17zPWicTu98EQUsDhjr7HlF+mOF3GyFL0ncVMeg8lgtVHM2Kd4anwKBE/RaF9ix/KzzE
         SpWEkwJP7O2u+//KTDBvgiQJArBruEoW9O6ok30uDfb2E5/nSpLicMnC9Gm6nrmazYkZ
         fUEW0D7Uxd5cCo4MuR0SizjJqn5TYIwhhAkx2XDr7Vs5g0f3GKoR1NPKbhsRL2xzqOOD
         SmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJlkPNizVF+Qb0ZGxKZFsp+UcFxnswGnvXVIUjOU9lM=;
        b=T2P10sE+P/k27JxAVRZ8INxQH92EFNSjnVQyTV6oSNq6fbd+XWoPVBT27PIt7F+teR
         02LGdr+g+CihmDk5XIanbOzo7pgW57qrgwnBOWYfmDxdRjYRIEF9JxYfF1oa081zAN6x
         gslnmRughYl6j+CIfjYxqT93qU5NX21dRvl6dHde1v3jmIrxtNXioZWgaHGcCjf5ZJF0
         d/g3j0vB0wNQM9MAndMAbMpBJreqM551gFu3hLh0c5DSroRYRqmolnWnv5LENbINyenO
         R2H9ioQum3dwn/wKf9EjvlEwAZOu3YIJjCsi8zV9nUPFXoCE/rKF8/OciyYh/FxCEgNj
         b5gA==
X-Gm-Message-State: APjAAAXtUu4P/KkZw7R5KR9D1ZSfCQx67nHlQFnIx+FNupvyvl/9uC8A
        HP8Jh5BJ08NIL1xgoXjAf1QZ1sMhMkk7KWsvUfyezA==
X-Google-Smtp-Source: APXvYqy5C6fdvALp5N4V3RqsVZu0ystOZZGBwhC0YeHpLpR+25W7tkfoIa702aWhN3PtNJRlJQhcf9r44+JlQmP2Ajc=
X-Received: by 2002:a67:f353:: with SMTP id p19mr33902362vsm.114.1553963653811;
 Sat, 30 Mar 2019 09:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
In-Reply-To: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 30 Mar 2019 09:34:02 -0700
Message-ID: <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
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

On Sat, Mar 30, 2019 at 9:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Mar 30, 2019 at 9:19 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > From pure API perspective that's all I care about: independence of procfs.
> > Once we have pidfd_open() we can cleanly signal threads etc.
>
> But "independence from procfs" means that you damn well don't then do
> "oh, now I have a pidfd, I want to turn it into a /proc fd and then
> munge around there".
>
> So I'm literally saying that it had better really *be* independent
> from /proc. It is the standalone version, but it's most definitely
> also the version that doesn't then give you secret access to /proc.

Just to be clear, I'm not proposing granting secret access to procfs,
and as far as I can see, nobody else is either. We've been talking
about making it easier to avoid races when you happen to want a pidfd
and a procfs fd that point to the same process, not granting access
that you didn't have before. If you'd rather not connect procfs and
pidfds, we can take this functionality off the table.
