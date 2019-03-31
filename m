Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D3EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AF4206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554066537;
	bh=biocq5PutOXM0Frg8zpYhqsnothHm4kz3lLiAvttwl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nq0ySSP8ccoMVkwgkvbsecKs0pjZchJ3kX0t2WA84waW0xzbZxmCeys4tZYctjW4E
	 SAHlew4Je18nCu8L38gqe374qpcEytyld5ycmsUCxd/NQkxadecpxA7NDRXCIq44xX
	 gc1RxnYOS5AWENDoy6icBx2fwuUamz0bLL6fQ1nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfCaVI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 17:08:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43753 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaVIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 17:08:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so6257844lja.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 14:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NZ6pzV6QHfbHCL8L+ezA32HXQct3ZB9v5O//edAOK4I=;
        b=EZUihtkGeKLmRMhGIeuSik8uxrcGxdsIQ/fjmtKQiBsK39R01RVJ6NZHgEprrOmAVh
         L+yrS8FMizlaNeCysFug8AUXaROL1GIavFYLb/5FkkZ3TS4wnD9Dib9605c/iO+6mWn8
         yIPOoaQ3MVt4RTenKDqBuWKSqkXsYgnzFoaMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NZ6pzV6QHfbHCL8L+ezA32HXQct3ZB9v5O//edAOK4I=;
        b=frIkq06Fhy1HuLq7zPwdz1RA2DbsUbxwtu+G6duQADO92z2sEEtigoFiytv+DTKXap
         6YD1aNlznHwlK3o1/ApCBIXqj1RxX1TKjzR1iuFKcM3oy7G0FJQovoLm+6u+a7fVDEj8
         1B2wMzk8sVXcSzz3T9xLcvmk64h1i09LBBCmIfKI7qLv/zTklPdrX2zKA+bCbRazUdT7
         pqvWGjtET4ol5eYT3/H1KtGQUe7wI/9MTS+WItK14VQlVZ9AduWhFunQCiu/o5JgtwDf
         xDpIHsPDv0a/i6k0aRSMO4615LGJka39BKWnvOCJKrxZCCxoVGmx0TQeDZY6i5RoEh3k
         XB5A==
X-Gm-Message-State: APjAAAUlIfPURY1m2Q4kPupW2e5/8+r31+bN10e5KkvFmJuW7THiqtD+
        VVWHLg3Y7NhvxrnCrviL26YEf9+IdRU=
X-Google-Smtp-Source: APXvYqywrzVQXCwQztD3HGlMBD+JmhQIpKzR2UqSVSdsSt4TVLDZChPH9nEfDEtWtrgpGUmhm96p+A==
X-Received: by 2002:a2e:128a:: with SMTP id 10mr35782903ljs.170.1554066533507;
        Sun, 31 Mar 2019 14:08:53 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id c64sm1450702lfg.70.2019.03.31.14.08.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 14:08:53 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t4so6287939ljc.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 14:08:52 -0700 (PDT)
X-Received: by 2002:a2e:960b:: with SMTP id v11mr22820985ljh.135.1554066221711;
 Sun, 31 Mar 2019 14:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
In-Reply-To: <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Mar 2019 14:03:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
Message-ID: <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Andy Lutomirski <luto@amacapital.net>
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
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 1:38 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> openat(fd to pidfd=E2=80=99s proc directory, =E2=80=9Cstatus=E2=80=9D, ..=
.);
>
> And we want a non-utterly-crappy way to do this.  The ioctl is certainly =
ugly, but it *works*.

It's beyond clunky. It's a disgrace.

If people really want equivalency between open("/proc/%d") and some
new pidfd_open(), then just *make* the two equivalent.

No effing crappy ioctl idiocy to create one from the other. Just make
the damn things be the exact same thing (and then if we extend clone()
to return one, make that return the same exact thing too).

Btw, we have several clone bits left:

 - if we don't have CLONE_PARENT set, the low 8 bits are still available

 - ignoring that, wehave bit #12 free: It used to be CLONE_IDLETASK
long long ago, but it was always kernel-only so it's never been
exposed as a user space bit.

                  Linus
