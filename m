Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27631C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A3A20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvbmZyEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfDANnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:43:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44946 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfDANnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:43:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id i21so7240323oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jla+Bdd5U7AFgedEhKnt5dtq8Qxhz2PpA3OTawHZGkY=;
        b=IvbmZyEV+7qn9rj6hb4RPzC5r0rSTcsCc66f47CC/8pq7YWWL03WASWiV407HvaIJ2
         fDKrLrjGHjdiBW48Z1BUdUHuWw38NvQwAF8nGpKe9uwoGwYWI27MXwRhCERaqo5muR4C
         69NCDAL8Ae70qWBnSK2douGjrkjD8/kCR6P6Ym7uQYWzhWLbc90Qa4BuysZ77LeAH5tI
         j8EUJsYc3R+CP40EIsptU/rWR5TG5dR/Ge86O4WvUnOLjv5E1SfxusvHT6Yaow/61oG6
         nZTMXk0Zz/fGQDHSDt3vU8iNVY0MV/hVcImy+xfyMZY+1gptoHkvJj/kouAcd46t4W6a
         8Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jla+Bdd5U7AFgedEhKnt5dtq8Qxhz2PpA3OTawHZGkY=;
        b=SGufUP6/ZkLnQZWaJLBFZKl+qjQLO9rehGEKWCxrF89oaE30a7bd8N6bvXaHpYkSdR
         Q1FzQHr/YyJcT7pumMaF87bBh9qQOCBYgQP1EGgcD8IovTBLQsCJG3Q5Nxny5evmUg6H
         UjzOp82NYYGYrU4QxTf6eS2do7yILO76NmNbcsU6EJ0VOAYRLsRIJeHA2O/TFd7YgOtf
         nB9RhY1dAbZ89y8O2YO0HJ3JlT8rQQhSMkLmsylz1nHP3NIroCTSsgZcxwjRJqGj7FnG
         0odVcNO2DbzZdCpuyMgbYWt7zM4YU3hn+45QRGYzrRqn26EyLH+NpCy9e3cRwul8X9Js
         psCg==
X-Gm-Message-State: APjAAAVBl1Xw6nOSOgAoqoA+Tdyw+Z8pxj3PdZHWBm4H6S284pYsMiOu
        c8dLS9tZglJNmfTbRpL864w01yaNtpjFxri0HFkp2Q==
X-Google-Smtp-Source: APXvYqzwjiYah+eN6KqYzwTwTSbj2h8Mv9nnkJJ51nQens0uCmELd69Xc2OM62FlzkgtCTaBSsnrrwlBYuu4xv87s6k=
X-Received: by 2002:aca:3806:: with SMTP id f6mr12306401oia.47.1554126220999;
 Mon, 01 Apr 2019 06:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401120450.e4k2m434qyqj4yrn@brauner.io>
In-Reply-To: <20190401120450.e4k2m434qyqj4yrn@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Apr 2019 15:43:13 +0200
Message-ID: <CAG48ez0KeQU32HV8OGY4-LNPF0Q+PtaH7H47GmKAd1Hhho=jXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
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
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 2:04 PM Christian Brauner <christian@brauner.io> wro=
te:
> On Sun, Mar 31, 2019 at 08:13:38PM -0600, Andy Lutomirski wrote:
> > > On Mar 31, 2019, at 3:17 PM, Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
> > >> On Sun, Mar 31, 2019 at 2:10 PM Christian Brauner <christian@brauner=
.io> wrote:
> > >>
> > >> I don't think that we want or can make them equivalent since that wo=
uld
> > >> mean we depend on procfs.
> > >
> > > Sure we can.
> > >
> > > If /proc is enabled, then you always do that dance YOU ALREADY WROTE
> > > THE CODE FOR to do the stupid ioctl.
> > >
> > > And if /procfs isn't enabled, then you don't do that.
> > >
> > > Ta-daa. Done. No stupid ioctl, and now /proc and pidfd_open() return
> > > the same damn thing.
> > >
> > > And guess what? If /proc isn't enabled, then obviously pidfd_open()
> > > gives you the /proc-less thing, but at least there is no crazy "two
> > > different file descriptors for the same thing" situation, because the=
n
> > > the /proc one doesn't exist.
> > >
> >
> > I wish we could do this, and, in a clean design, it would be a no-brain=
er.  But /proc has too much baggage.  Just to mention two such things, ther=
e=E2=80=99s =E2=80=9Cnet=E2=80=9D and =E2=80=9C../sys=E2=80=9D.  This crud =
is why we have all kinds of crazy rules that prevent programs in sandboxes =
from making a new mounts and mounting /proc in it.  If we make it possible =
to clone a new process and this access /proc without having /proc mounted, =
we=E2=80=99ll open up a big can of worms.
> >
> > Maybe we could have a sanitized view of /proc and make a pidfd be a dir=
ectory fd pointing at that.
>
> We can also just create something like an internal bind-mount without a
> parent, i.e. similar to
>
> open_tree(<internal-procfs-mount>, "<pid>", OPEN_TREE_CLONE);
>
> on a clone(CLONE_PIDFD);
>
> that would block any openat(fd, "..");

Or we add a check to follow_dotdot()/follow_dotdot_rcu() that throws
an error if nd->path.mnt->mnt_flags has some new flag for "no dotdot
traversal on this mountpoint", and then set that on the internal procfs
mount... if Al Viro doesn't think that that's too hideous.
