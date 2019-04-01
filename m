Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B5FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABB72146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7ifQzOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfDAWeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:34:19 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46089 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfDAWeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:34:19 -0400
Received: by mail-ua1-f68.google.com with SMTP id v7so3700570uak.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIl6Nv8SoAdnTvEZqoGZYoHIMxKCtv09ETb/8qis78k=;
        b=I7ifQzORrkkHIAYp9GrG3X9vXc73517ekEpYdYiL260BXT6pPydK7WRTsaHJYFbSOi
         AOY8MuMOlOveaLLSczae1Oh449jLJqwVV/J31ycx4uw+uEFTH36264sRDC4OOU41ijva
         dXq1/y6juqsJ9223+S+qgUZhSr2RYyupaGfCqUTdy5hz+aw0/X4IG+ivW3aBhiIvryA6
         MD2pNCGhZC3xPFBpfxghRd1jmred4mAMgeMJGM7w9jdY7wprGF3t34ygUuRSsr8Vv3it
         +POl6SsTU8TEzs3fbrBfX/gfNcRleyGx8gURq49/wru+xgwlwpIzT5XNuvBfj4Q+uqMt
         H6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIl6Nv8SoAdnTvEZqoGZYoHIMxKCtv09ETb/8qis78k=;
        b=hw0hWWHvES8BNyjQT6QHjolcdYz14MolqnIe4oR8klv/9hmrcnNhYDKNW2IblOHTFd
         6WQnU684RsCVsHcEz8CA1ecvGiobHfmdyNVrZkCMMd2OnmqxWPzOhNui49Ifo/N8ndKS
         c/cb94dgNA/WecmAE9wBA2HES9sNUPOCBc6j6Nj8nBm6k6m9i8uZ4FvzehvHg729eZUZ
         0VSpTZ3SwSRBF2XcG50GhZsAQMQFTTkPaE382yS/2sLaz3jCSS4aIMH4hQxqPvpQMm7W
         +pPBIOw0aVUUCYiYVGKofs8IBajLrPHyRNvW6MJUaP0GaUrQbjIvxEwFm8WGTQxjNwy+
         ZO5Q==
X-Gm-Message-State: APjAAAVqDg2GlOhyansHs7UK6a+hKTPkpd9Phn8vvfP5JpTKAopyA71h
        IALBKdvN4T0+qRpOxzijjREo+MJsPq+HBd6UIkEVUA==
X-Google-Smtp-Source: APXvYqwQ0+942ik1BZbhOvR3ubipCwkZOzjv6VnMTIvOT0kBF7DX+6ssMTjqpgsH15OcQKu4IptK74MIMJYkqGL8rnI=
X-Received: by 2002:ab0:3b8:: with SMTP id 53mr38281103uau.118.1554158057582;
 Mon, 01 Apr 2019 15:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
 <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com>
 <20190401194214.4rbvmwogpke3cjcx@brauner.io> <CAHk-=wgjndAqzMBxgXZxbSRXLRqdXtNM3aHc9X-xj+Px1fsG-Q@mail.gmail.com>
 <CAGLj2rFvWE6ENFyKSbZMrhqSrLjkm0YrRh2+O0LC04HmJuEY5g@mail.gmail.com> <CAHk-=wiDjdoS4erUTjWaHMY+ZT28omwA24pPMRoQEE-rtNcRpw@mail.gmail.com>
In-Reply-To: <CAHk-=wiDjdoS4erUTjWaHMY+ZT28omwA24pPMRoQEE-rtNcRpw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 1 Apr 2019 15:34:05 -0700
Message-ID: <CAKOZuettqvG0S=3XBjnBLZvMEQMPcQswwPXogSfxwJZA85fdBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Mon, Apr 1, 2019 at 3:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 1, 2019 at 2:58 PM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> >
> > You mention the race about learning the PID, PID being recycled, and
> > pidfd_open getting the wrong reference.
> >
> > This exists with the /proc model to way. How do you propose to address this?
>
> Note that that race exists _regardless_ of any interfaces.
> pidfd_open() has the same race: any time you have a pid, the lifetime
> of it is only as long as the process existing.
>
> That's why we talked about the CLONE_PIDFD flag, which would return
> the pidfd itself when creating a new process. That's one truly
> race-free way to handle it.

Yes. Returning a pidfd from clone seems like a simple and robust approach.

> Or just do the fork(), and know that the pid won't be re-used until
> you've done the wait() for it, and block SIGCHLD until you've done the
> lookup.

That doesn't work when some other thread is running a waitpid(-1)
loop. I think it's important to create an interface that libraries can
use without global coordination.

> That said, in *practice*, you can probably use any of the racy "look
> up pidfd using pid" models, as long as you just verify the end result
> after you've opened it.
>
> That verification could be as simple as "look up the parent pid of the
> pidfd I got", if you know you created it with fork() (and you can
> obviously track what _other_ thread you yourself created, so you can
> verify whether it is yours or not).
>
> For example, using "openat(pidfd, "status", ..)", but also by just
> tracking what you've done waitpid() on (but you need to look out for
> subtle races with another thread being in the process of doing so).
>
> Or you can just say that as long as you got the pidfd quickly after
> the fork(), any pid wrapping attack is practically not possible even
> if it might be racy in theory.

I don't like ignoring races just because they're rare. The cost of
complete race freedom for the process interface is low considering the
work we're doing on pidfds anyway.
