Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B3D208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9/XLfO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfDAQpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:45:36 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44006 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfDAQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:45:35 -0400
Received: by mail-vs1-f68.google.com with SMTP id i207so5905650vsd.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAbcN6cBCqeqTNzKtohbGa72KbiSDzlsAims65Bpf/c=;
        b=O9/XLfO1D/h9EbV7CtDD8L2fyiUlcSfeQwb0cCdcHK+j4NGRTQic5X0OfSbvHbxalk
         uO3f8XMUBflbKQ0gzW98MhpkPFdzicMaOy41z6DzkxiGn+oeVRjEsbfMV6260Ki+f05W
         uwTU6wEzqwpI0xYj1eT+0SAlRP8ZAkjz6cBTq1RBcpP0Qi0uWCmdRfccErUNgIhQL+gz
         plbMX6nkmsYi7gLPvex+cej3ZH9aTTpGK2yo+wn++GMTZ8F9pBQyz5y+oDzysCQojcGy
         P+pkqmv5dNIkNDRlLi6r4l4c7A3ro7jj9zcOhSJ2yvQ4j6pfmoZsml14/R2AF6l+bWgN
         sktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAbcN6cBCqeqTNzKtohbGa72KbiSDzlsAims65Bpf/c=;
        b=M2LpgQ1iGx2vcNDYO+rDtIRq3mGRCeqcrwf1yIXHd8NDqf8RQSIk4dTMB5ILPrr/xL
         MGZK4Co6W4AjHbdH4IO9o6+mvWWo6/LO40NjOle5mFYXEclrbhB7AeXoZvLADCe43AXf
         NsgBVMJSep2XqJLOMxGhmzdxtMoHMZUZ/zpJLT4iVnmQPyWBKPJ1oGzzWu8/XLmgqOmk
         jDgf408U+e6ASnRF4nEcsn9siFQrOcR3PDI1YBiGaJ+gp7BWn+4T6yTVLFeWA0g4QsyC
         vghjYBhqP+fqKMasXSz2y1X+gO4/KlJhRuvb6VnrQcm6So0sY+mK0jOlUNoA7WlEH6bj
         ZFUw==
X-Gm-Message-State: APjAAAWTXi2tepABybc4jqBqJ0gBEd4Nhip5BRQk4BdW7iIrujXsS/pH
        UCxUmmeM1py6K/KTCZPOHIJHp0FHWvKXG6YWCscvcLjNH2M=
X-Google-Smtp-Source: APXvYqwq8qPRAP2tZruayuudL1iZkkkXWUBZEsDind3mgDddYs2SEZsIxJCQ9pZpyp42dBZVZ9MU4n2fIotxKkqJGXE=
X-Received: by 2002:a05:6102:212:: with SMTP id z18mr17511804vsp.218.1554137134009;
 Mon, 01 Apr 2019 09:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
 <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com>
 <CAKOZuetovU9NawSjUfGTAwXVfnmKC9GFtmS8FxAE5Hjmzq0HHA@mail.gmail.com> <CAHk-=wjgENV0pT8=MjB1UVBeWCrECCNXv15AKKX7Kfg7Eak7qw@mail.gmail.com>
In-Reply-To: <CAHk-=wjgENV0pT8=MjB1UVBeWCrECCNXv15AKKX7Kfg7Eak7qw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 1 Apr 2019 09:45:22 -0700
Message-ID: <CAKOZuet2QCoW1XMpTAzXS868PhF-gh14czFn4gwE4A=oX=Yr8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 9:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 1, 2019 at 9:22 AM Daniel Colascione <dancol@google.com> wrote:
> >
> > There's a subtlety: suppose I'm a library and I want to create a
> > private subprocess. I use the new clone facility, whatever it is, and
> > get a pidfd back. I need to be able to read the child's exit status
> > even if the child exits before clone returns in the parent. Doesn't
> > this requirement imply that the pidfd, kernel-side, contain something
> > a bit more than a struct pid?
>
> Note that clone() has always supported this, but it has basically
> never been used.
>
> One of the early thinkings behind clone() was that it could be used
> for basically "AIO in user space", by having exactly these kinds of
> library-private internal subthreads that are hidden as real threads.
>
> It's why we have that special CSIGNAL mask for setting the exit
> signal. It doesn't *just* set the signal to be sent when the thread
> exits - setting the signal to something else than SIGCHLD actually
> changes behavior in other ways too.
>
> In particular a non-SIGCHLD thread won't be found by a regular
> "waitpid()". You have to explicitly wait for it with __WCLONE (which
> in turn is supposed to be used with the explicit pid to be waited
> for).

But doesn't the CSIGNAL approach still require that libraries somehow
coordinate which non-SIGCHLD signal they use? (Signal coordination a
separate problem, unfortunately.) If you don't set a signal, you don't
get any notification at all, and in that case, you have to burn a
thread on a blocking wait, right? And you don't *have* to wait for a
specific PID with __WCLONE. If two libraries each did a separate
__WCLONE or __WALL wait on all subprocesses, they'd still interfere,
AIUI, even if the interface isn't supposed to be used that way.

I like the pidfd way of doing private subprocesses a bit more than the
CSIGNAL approach because it's more "natural" (in that a pidfd is just
a handle like we have handles to tons of other things), integrates
with existing event and wait facilities, doesn't require any global
coordination at all, and works for more than this one use case.
(CSIGNAL is limited to immediate parents. You could, in principle,
SCM_RIGHTS a pidfd to someone else.)

> Now, none of this was ever really used. The people who wanted AIO
> wanted the brain-damaged POSIX kind of AIO, not something cool and
> clever. So I suspect the whole exit-signal thing was just used for
> random small per-project things.

AIO is a whole other ball of wax. :-)
