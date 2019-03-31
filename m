Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8970C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6688520857
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Mhv39Tba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfCaVKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 17:10:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36500 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbfCaVKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 17:10:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16so6429501edr.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QMYZKV8w3K7zsSovYcs2Yb7Li2RouumghnMebcv29RA=;
        b=Mhv39TbazztYpO6XJAM4TS6LjIF6VNJXMBKIa/KxcCLqcHhNjTL//pcBpIzf5Lm9XQ
         TIL5TZrQ7Nw1DrdWn9xi9irPwrMRCdJ2COgORrrySxq9aW3L+ZoLoLkytIodVPa+y/XB
         lSbozEy37uGgpqt3QYZEmyET4kli3kAN02eEgOWHD/j+UU//tWOhUXkizzrzEF7/UK4/
         RxDlrz+lPgjSRqnDnXNpb5bMEN+FUuDOQJN+n6VuFap0NRTbD01nuAjB7Rqr5Ryq6PN0
         7vW35lb+vHmfeAHZVo+TSMjezSZMp4ZxjT/dV+++GQqEauy/jFdtSUtidWIDMt6U2fcP
         conQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QMYZKV8w3K7zsSovYcs2Yb7Li2RouumghnMebcv29RA=;
        b=N14Wzl6n2HpaGWx4q9Ce7JhHA3zYpPH+83VdgrihEm4L8rKHsEuYqzT/3b12z3jWxK
         8+8xpL/DBpkx8t18Mq7hzR9FmuAy8WoDxAb1A4Fj9QmpyKUBdDcuxQu4tmVyRYlh1IUk
         mwf5I7j0jb2ukv38sNbJSQwJzF8iuQKYSnr4Yl9xFeYibXQQ+LBYbupNlfrvOdFbLqfT
         xm7MUPdPiVAqH8KXd+cZq+5eWbcqmegnV/Nx7MVJf7J/66+A2qN39IjCMD15WX/Mgb6Q
         vqb2r8fLJzHw/BVIpNtKHhMTaiyWltUcvVVXzxoqNlTOkyGQSHsl3UjYMOXy8EeuCPwH
         4I5Q==
X-Gm-Message-State: APjAAAXXf76/gBI2+eRnDZwY1AXIjHbmDjDnY4IdYhNP52czeVHeH9Cy
        CSPmAErVFoNMrcZABPTKbjTMvg==
X-Google-Smtp-Source: APXvYqysdxJoo8IaMjJHXBQdWDDnUoMwiyIYB2+D3DjOuVPCev+hGn14GF2D21V1BimHRVslW42X2Q==
X-Received: by 2002:a17:906:a291:: with SMTP id i17mr34303036ejz.180.1554066644871;
        Sun, 31 Mar 2019 14:10:44 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id ay12sm1557523ejb.15.2019.03.31.14.10.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 31 Mar 2019 14:10:44 -0700 (PDT)
Date:   Sun, 31 Mar 2019 23:10:42 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
Message-ID: <20190331211041.vht7dnqg4e4bilr2@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 02:03:25PM -0700, Linus Torvalds wrote:
> On Sun, Mar 31, 2019 at 1:38 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > openat(fd to pidfd’s proc directory, “status”, ...);
> >
> > And we want a non-utterly-crappy way to do this.  The ioctl is certainly ugly, but it *works*.
> 
> It's beyond clunky. It's a disgrace.
> 
> If people really want equivalency between open("/proc/%d") and some
> new pidfd_open(), then just *make* the two equivalent.

I don't think that we want or can make them equivalent since that would
mean we depend on procfs. If userspace really wants to turn a pidfd into
an fd for /proc/<pid> then they can be burdened to do so by parsing out
the pid relative to their procfs pid namespace from the pidfds fdinfo:

int pidfd = pidfd_open(pid, 0);
int pid = parse_fdinfo("/proc/self/fdinfo/<pidfd>");
int procpidfd = open("/proc/<pid>", ...);

/* Test if process still exists by sending signal 0 through our pidfd. */
int ret = pidfd_send_signal(pid, 0, NULL, PIDFD_SIGNAL_THREAD);
if (ret < 0 && errno == ESRCH) {
        /* pid has been recycled and procpidfd refers to another process */
}

it's race free and no ioctl() is needed.

> 
> No effing crappy ioctl idiocy to create one from the other. Just make
> the damn things be the exact same thing (and then if we extend clone()
> to return one, make that return the same exact thing too).
> 
> Btw, we have several clone bits left:
> 
>  - if we don't have CLONE_PARENT set, the low 8 bits are still available
> 
>  - ignoring that, wehave bit #12 free: It used to be CLONE_IDLETASK
> long long ago, but it was always kernel-only so it's never been
> exposed as a user space bit.

That's good to know.
