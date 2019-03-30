Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B696BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718D5218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Zp1oHYXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfC3RhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:37:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46871 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbfC3RhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:37:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so4633664edd.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P970KdoaWOa/M6m1Hf5UxD3ug05A6bjJlWyxMz3zgw4=;
        b=Zp1oHYXQVr+DizGr7O90yBtO+g+ziKgBIVeyHpG6d0R8jfO8KxfEYhnUYjzqJh9Pt1
         Hto5hk2U8Ug4XxkHEvv8PqQAkVqbaLX2SjDYVD9nPvZIwIDq9idCL4ZKX2RfqD9kV59v
         9SODDXvc4LUiSR6k9LPflVf5HM6x2KwnkeTLw/acBlWjhcD2W4xWUW+bm2sqO88LJlMl
         BXM4tW7G0NJWNa9Y5oJrS+yEa8DOmNsBfEQ9e/gLnIDbcUI8Ko5DQ/hYTO2nj3hxHniY
         emH915EzjH30vvzBnbOOMNNeM2NKqAbg6lc/JtFtbrOGLGBkgyff7z3JxUFgUufSPAiu
         4Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P970KdoaWOa/M6m1Hf5UxD3ug05A6bjJlWyxMz3zgw4=;
        b=GP5gJisdbLqFcp8XwY2EaYKa3LtE4pqUXVvQ6NHygdKuybo80ZAkeuAhpq3U/QbrOg
         uttDjH8PtQ5cMDGfjOKVfKYz1yhzhyyQoIb3jsrh0FzOoDfzfA8E5K3U34RttTBNUdG8
         k4FJ9EJNWRm3fWjOnswSEJFIJtB0pOloPVT7JV58LKN5MWFZBz08s523EUMWdgbaC706
         XKJo1uHPL4ur4NuY7MU6YJtkPpm42FEjIHeI9alKs66UfuZleiOFoRJbmYF/D6ecKS9Z
         UT5ql9ISHhHFLIHoF2YJrDsfHKC4DVp8zOIYbTtwaoO1XJflocEtC2VZrTRdSGs1Ev2i
         a3NA==
X-Gm-Message-State: APjAAAXTlmqlOcFiuWmFAycdPwYtHLpsKDBxV+ZEaUF6I65MV/uSSkM1
        zy2qHqGVMxu/L/LHhlR1fQUuQw==
X-Google-Smtp-Source: APXvYqw5h5XBGTdyFjCoQMUwLAKvkRzJsp9Rtdgst5dJ1RtBfEAfxHIGioNdq9JA3b8WFv/Q9QTHOQ==
X-Received: by 2002:a17:906:924e:: with SMTP id c14mr30615322ejx.230.1553967441341;
        Sat, 30 Mar 2019 10:37:21 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id h33sm1488309ede.18.2019.03.30.10.37.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 30 Mar 2019 10:37:20 -0700 (PDT)
Date:   Sat, 30 Mar 2019 18:37:19 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>,
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
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190330173718.hqopamhtxsq2l5bm@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 10:24:19AM -0700, Linus Torvalds wrote:
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

Understood.

> really has to be *SIMPLER* and *NO PROCFS*.
> 
> PIDFD_TO_PROCFD violates *everything*.
