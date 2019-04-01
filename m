Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06289C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C856A20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rT/D/yQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfDAPzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:55:14 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38204 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfDAPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:55:14 -0400
Received: by mail-vk1-f196.google.com with SMTP id h71so2218594vkf.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7/rx8kfm8QGsJgOqP/8KsvWO/rWVk9ak4OY5DbbGG0=;
        b=rT/D/yQUnxE1aBwNYv7bkZKdwiEMSxyUof6uxgHS2UE99VtFhWf6KfN/Hyk0DJlAab
         +FdVwDa5qTfWz/OePS/9Xo7dVQ9uxnzqJM+k4DWiCEJfEdMtLVOoB0+n+da+PINGJM7X
         Hmfru2iRJvx41HmReXhI29JENFtRM9tRM5kLQV7ht92Kag7FI3vR6Qir9CCuQ1jRKtuB
         ygdFFwIUmMwSgQUHHeDdHaihlsYTAq7sxxrbkwWQFFHKc6V3PPYkDE3vbL2WoQWdnQyB
         9GRexG11ENmANZV3plhJV5nqx6SGRtHc1A33SyPqexPtB9bf+IgmiUpv4Dgg87g5vsbZ
         L6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7/rx8kfm8QGsJgOqP/8KsvWO/rWVk9ak4OY5DbbGG0=;
        b=pWfn0x8Pg9jFkN271d3qPJW2sbbm8dHOHq2CD5JpSJap2HZXFJKJgCOELFWuiQt7Hg
         H6WiIRyAas5I9iJOGNdezDjFMJPuZybDRoIlDt1SZLnys3y8g82kMO+lXB94gcAe5ZnC
         ZnqD7oUSpvckDZxBlVwkdcuaySuMkEbgyTTNgEqGUvIrDyI7zDrSNZDFP5RWcGhbomG8
         NrpOzxUVKoeTe+RUPEJpBcyHKlENLYXFTOF9ah8i9o/z65F0GlBGutMTLvxFlo9cdwHu
         Fiw+c1h8cCAl0+8418p/oAiJ3W518KICJBhbvjY1MlB7RLQXBwbohztJLySRO+N2Rm9I
         W/pw==
X-Gm-Message-State: APjAAAWE1wAl7BY9rls2WOnGinZw7RlQRPgQ96fDnfvda5Cf7s4dfXUF
        knmdkddkeQVhGfuCcEVo6Tp/9B1h5ZZ7mZAq6tZz1Q==
X-Google-Smtp-Source: APXvYqydjDpjHY419WvilZ3zl64TvJ/9OMvDFB1gieKh6WKQ3Q+MrnsresALUo9v3mZnZKyOXG1oZoMVJWdCx/p+7ns=
X-Received: by 2002:a1f:32c7:: with SMTP id y190mr33352092vky.15.1554134112614;
 Mon, 01 Apr 2019 08:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
In-Reply-To: <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 1 Apr 2019 08:55:00 -0700
Message-ID: <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
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
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
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

On Mon, Apr 1, 2019 at 8:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 1, 2019 at 4:41 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > Eric pitched a procfs2 which would *just* be the PIDs some time ago (in
> > an attempt to make it possible one day to mount /proc inside a container
> > without adding a bunch of masked paths), though it was just an idea and
> > I don't know if he ever had a patch for it.

Couldn't this mode just be a relatively simple procfs mount option
instead of a whole new filesystem? It'd be a bit like hidepid, right?
The internal bind mount option and the no-dotdot-traversal options
also look good to me.

> I wonder if we really want a fill procfs2, or maybe we could just make
> the pidfd readable (yes, it's a directory file descriptor, but we
> could allow reading).

What would read(2) read?

> What are the *actual* use cases for opening /proc files through it? If
> it's really just for a small subset that android wants to do this
> (getting basic process state like "running" etc), rather than anything
> else, then we could skip the whole /proc linking entirely and go the
> other way instead (ie open_pidfd() would get that limited IO model,
> and we could make the /proc directory node get the same limited IO
> model).

We do a lot of process state inspection and manipulation, including
reading and writing the oom killer adjustment score, reading smaps,
and the occasional cgroup manipulation. More generally, I'd also like
to be able to write a race-free pkill(1). Doing this work via pidfd
would be convenient. More generally, we can't enumerate the specific
use cases, because what we want to do with processes isn't bounded in
advance, and we regularly find new things in /proc/pid that we want to
read and write. I'd rather not prematurely limit the applicability of
the pidfd interface, especially when there's a simple option (the
procfs directory file descriptor approach) that doesn't require
in-advance enumeration of supported process inspection and
manipulation actions or a separate per-option pidfd equivalent. I very
much want a general-purpose API that reuses the metadata interfaces
the kernel already exposes. It's not clear to me how this rich
interface could be matched by read(2) on a pidfd.
