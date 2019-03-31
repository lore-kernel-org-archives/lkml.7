Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396E1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D322086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UZ4LatSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfCaVTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 17:19:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34670 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbfCaVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 17:19:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id x14so6456066eds.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qk56VuHZRHzMV1NFW0ejKgyMp3L43kw3+DUWA5PqkHo=;
        b=UZ4LatSzgrruQRm5/XqZHYHKRrGtvEmlDI782KK1NWlTR8OY2eBr7Zu2OYyXzbiL7V
         N2eDu6fE5h/tUhlLOElddkB8J4N+BcQ4I1JxhljnADK0jiuC4Uvjv4YsFJY65ej0RNBr
         FEO9CwiaNm3pDduxTVy4Vr8VSVEMlZ4YRpx3uFBWfkkjAAhlYwmsxgWD9eCr3hSIFO7j
         5Lvmb+tgMfO5zkAqWhsBdYcMHxzkVHPCy8fwMKsXtzCln2fUPQnBPHQ6XWY6yjiZEJ5D
         z6uWTCDZTCKtAvDubv1kXYe9Dagt2dI/4jacHNI2ctZPkizelkrcQPJEMBDk5EfHU2px
         TSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qk56VuHZRHzMV1NFW0ejKgyMp3L43kw3+DUWA5PqkHo=;
        b=fY53EvfG3yUZHyy9jpdmQPHqRScLMo2mgb0g+t1zIY3+nCN2DNPw2RzYq+ij96Ti5P
         fT0WDAmN07EHqwYnb8ZfMlK0imCxeih0w0qOcyhsKJ2uHAS/0uQXGJUX/64r/30nlGfX
         VuLCi9ow6ciWhsk85PnO1d7UC+PiGSDEOL9FJBzNA+PQBjkw8UkSm5WAcrtSsm2fwpoj
         OcA24kJibQdnmuhEekpcTcx4aFgn1CalazJ529xwER7ZOw4scOStBweqSdewowD5I2ef
         zlYiXP2OovLQRRKqmGWVFoLyxJdMeoeff9px9D2aR8Q062/qx5d201aVzf7cSFh6iWSG
         M6Ag==
X-Gm-Message-State: APjAAAUuhaF2U4wVX1ED8Cs+qeLZvdhwNskYJ/RLRdQkOIzjRruqLdMo
        7hHtGDcHjD9cgUqCcIBW0pGMvQ==
X-Google-Smtp-Source: APXvYqzU/zkK+bNz3TrlfwrAQ4c5VetwHPz+hvOehh7X5JIBvXrLO5U7+mBbNzIwhAf+KlyGgnEXmg==
X-Received: by 2002:a17:906:3c5:: with SMTP id c5mr33873356eja.24.1554067173434;
        Sun, 31 Mar 2019 14:19:33 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id x3sm2572156ede.25.2019.03.31.14.19.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 31 Mar 2019 14:19:32 -0700 (PDT)
Date:   Sun, 31 Mar 2019 23:19:31 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@amacapital.net>
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
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190331211930.wxkqhfvexdupfem6@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 02:09:03PM -0600, Andy Lutomirski wrote:
> 
> 
> > On Mar 30, 2019, at 11:24 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> >> On Sat, Mar 30, 2019 at 10:12 AM Christian Brauner <christian@brauner.io> wrote:
> >> 
> >> 
> >> To clarify, what the Android guys really wanted to be part of the api is
> >> a way to get race-free access to metadata associated with a given pidfd.
> >> And the idea was that *if and only if procfs is mounted* you could do:
> >> 
> >> int pidfd = pidfd_open(1234, 0);
> >> 
> >> int procfd = open("/proc", O_RDONLY | O_CLOEXEC);
> >> int procpidfd = ioctl(pidfd, PIDFD_TO_PROCFD, procfd);
> > 
> > And my claim is that this is three system calls - one of them very
> > hacky - to just do
> > 
> >    int pidfd = open("/proc/%d", O_PATH);
> 
> Hi Linus-
> 
> I want to re-check this because I think Christian’s example was bad.  I proposed these ioctls, but that wasn’t the intended use.  The real point is:

Getting metadata access was pushed as essential originally which is why
this ioctl() came up in the first place. The concerns about
CLONE_PIDFD were not relevant when this came up [1]:

<quote>
> And how do you propose, given one of these handle objects, getting a
> process's current priority, or its current oom score, or its list of
> memory maps? As I mentioned in my original email, and which nobody has
> addressed, if you don't use a dirfd as your process handle or you
> don't provide an easy way to get one of these proc directory FDs, you
> need to duplicate a lot of metadata access interfaces.

An API that takes a process handle object and an fd pointing at /proc
(the root of the proc fs) and gives you back a proc dirfd would do the
trick.  You could do this with no new kernel features at all if you're
willing to read the pid, call openat(2), and handle the races in user
code.
<quote>

[1]: https://lore.kernel.org/lkml/CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com/

> 
> int pidfd = new_improved_clone(...);
> 
> To be useful, this type of API *must* work without proc mounted.
> 
> And, later:
> 
> openat(fd to pidfd’s proc directory, “status”, ...);
> 
> And we want a non-utterly-crappy way to do this.  The ioctl is certainly ugly, but it *works*.
> 
> Another approach is:
> 
> pid_t pid = pidfd_get_pid(pidfd);
> sprintf(buf, “/proc/%d”, pid);
> int procfd = open(buf, O_PATH);
> if (pidfd_get_pid(pidfd) != pid) {
>   we lose;
> }
> 
> But this is clunky.
> 
> Do you think the clunky version is okay, or do you have a suggestion for making it better?
> 
> —Andy
