Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98501C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5882B21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lyf0Ue09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfDAQNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:13:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38878 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfDAQNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:13:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id a6so4367969oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWpt8sWnrUp7nM/XGIxo9u0cVgp4+vUOvus+dJto+50=;
        b=Lyf0Ue09Nd1tOatU42yL8u7cpj+p/6td+bwqcCBNgda8mW7BcPrSF/2hMbWzSoGBR4
         MCRX+Bpig/u6MqFN+/mh0akFJu5bBddwU9maL9LoJpFtw6YjiaZn8Dn3vPtVw436Cm0S
         dUG9gAQWCBuEyhJ+ETb2zv1yamz30ss3c1YamCEXuC85vL/a9tdGNtnCfoFmRmj+yyTw
         DJLA4gkEiIgEgFrg9dYy3eoozyX76If68TGbYTznZ+aor6lIDq1ITvDaYod630Iisg6o
         pIK71zGak5EqVNXaKkheOwcEWpPI4pxxAEOznhQ+b520XdgCUrrepqlmDXZLIsatLd7W
         dQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWpt8sWnrUp7nM/XGIxo9u0cVgp4+vUOvus+dJto+50=;
        b=Z85fZp6bMGseqSYOKyjugOt0y5C8/mqnANUWIaRmvaqYyHW8S+eGU31pbbpALalWB3
         Hj0uTFq8dtwFXYf/juFAc8avEGsUGQvSy4qtntvOQYhF1NAgfj/Eoy2Uca7k0JEySB/J
         unPkOCAqmYGZXHj9IIDfZiXH21dzOcnBHeyWSCqZRXY6iO+6/EMcoNDHytHvhmfdPRUh
         UPRiGXACqPz9I8U/Gykgkvd5RWXoa6I5RlllZxOIxNpM8+OYF5N3Nr+knvA5klV8GFyN
         SnZoeqOyNPTbhjKFnAKNid1wexEpYGv7XaEW1hUSx8iScNhG2OKUHN3la8+npwN3qQTj
         yMFQ==
X-Gm-Message-State: APjAAAW/cL1JK1BK8DOnMNDB8ibBRS0e/y1HS4FqM60/8l8ihJ6nECJn
        UFzcXrfEACewAcWsUqVTLCYLyzCqWja3VqBEZG36Yw==
X-Google-Smtp-Source: APXvYqzFW2OG+7HDYpoLMJensdtGtgLIhfTx1IksXFq/Qc3DaxB8AxBTKFJS34bbAay/8LeqGTv/ODfzRP8nNrFuBfs=
X-Received: by 2002:aca:550c:: with SMTP id j12mr13767315oib.52.1554135234224;
 Mon, 01 Apr 2019 09:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com> <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com>
In-Reply-To: <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 1 Apr 2019 09:13:42 -0700
Message-ID: <CAKOZuethE6Yv9xrw6jjDncanbggqm1Phyy=i5hx-c-GPXF9JOA@mail.gmail.com>
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

On Mon, Apr 1, 2019 at 9:01 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 1, 2019 at 8:55 AM Daniel Colascione <dancol@google.com> wrote:
> >
> >
> > > I wonder if we really want a fill procfs2, or maybe we could just make
> > > the pidfd readable (yes, it's a directory file descriptor, but we
> > > could allow reading).
> >
> > What would read(2) read?
>
> We could make it read anything, but it would have to be something
> people agree is sufficient (and not so expensive to create that rare
> users of that data would find the overhead excessive).

In my exithand patch last year, I took a minimal approach and just had
read(2) read EOF once the process exited and blocked until then. Maybe
we could do that? But if we're supported waitid(2) on pidfds instead,
then we don't need read(2) at all on pidfds, right? Right now, I don't
see a situation in which I'd take advantage of a pidfd read(2) that
just gave me the running/sleeping/zombie state.

I'm also a bit worried about the implications of making a directory FD
also readable. Didn't problems with that come up in one of the
multiple-named-streams proposals?

> Eg we could make it return the same thing that /proc/<pid>/status
> reads right now.
>
> But it sounds like you need pretty much all of /proc/<pid>/xyz:
>
> > We do a lot of process state inspection and manipulation, including
> > reading and writing the oom killer adjustment score, reading smaps,
> > and the occasional cgroup manipulation. More generally, I'd also like
> > to be able to write a race-free pkill(1)
>
> I suspect most of what pkill wants is indeed in that 'status' file,
> but other things aren't.

Right. It's hard to predict what we might need. pkill also needs
/proc/pid/cmdline, FWIW.
