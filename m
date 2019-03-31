Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3221FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 20:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D102086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 20:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="AGnN356U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfCaUib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 16:38:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45483 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfCaUib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 16:38:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so3466026pfi.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=GYOZQm4vYbyUdQFi8rHe4bvj6vFGTwbbXOBuIqEShGI=;
        b=AGnN356UX2DjQrmYSKwgx9TPPQS0bvawlmliOoIfJ9L27/IL8K/jPrRpTiOTJRxZ/v
         jgcXHVUoVwODzclaD/vEPfn2ToceLDNoioESQt1q9+ieoBNvM31E+mmut7/PKNO/DRq4
         WjxNNB5GiEJgOHUGrvL2Q4FhU9NUOAV2ZH5hTnqRGG8X+9Ve/7P17f3kvYsxKTMj7viG
         Lam8aJ1GtgnMuf3mQq2eaaOh++tfEvNocMoGFemMBSali/vvUGd+nZo6J77q1WKdej0I
         aiJum73DsBIcszEekomHceFcwDXiXFGmbeV5712qwLVpZzrat+eDbBApCBouBUJ+lwQN
         fBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=GYOZQm4vYbyUdQFi8rHe4bvj6vFGTwbbXOBuIqEShGI=;
        b=lCKFnSeQF8lMYXgnNsE6DJbDw/WcjuenJskjkmbfYNpV5Ok0gZHxYXFmYXR24x8FBw
         zY0GeQfi9AXXzzyWWd6IpnaQvMJBPcIxRmjKen1Jt70mX+OL2J8qUAqsLRcGnaTl39qM
         RbwJn+vdTIAmENUPr7O/RpLhHMia4fUhxDO9MSi2fBp4ta6mtvUrerh2RiP0CEtbP65k
         TrF1VlEjNXC5EFoR7Tuk4NsoJMgCfUZm3gn5jK1gRZOJNIg1nbtq5Ug2ONwHFNTbhJZW
         ImTbIQ6RSfgGrxmSftpuqcISo2F4vG5t587o0+YHT2CRzUyxFT6zS3ejO/RDNfO6EtFV
         6gOA==
X-Gm-Message-State: APjAAAWFb8P0x1OY1PYRczZCmKdJlmH78xfWPeHZ3lrb5wk/NstLRYTG
        S9tdk9YQ3yP4880K59QbSbS5Vg==
X-Google-Smtp-Source: APXvYqzT7OiKsSypY5pHqL4u0+JGt2a3wi3D0yhJLZWuMJZMrvoIOIg0qw+wRiZNkZJoBX/DkG4Q4Q==
X-Received: by 2002:a63:145f:: with SMTP id 31mr7981828pgu.16.1554064710590;
        Sun, 31 Mar 2019 13:38:30 -0700 (PDT)
Received: from ?IPv6:2600:100e:b13e:a3af:389b:29a:6d03:f8bf? ([2600:100e:b13e:a3af:389b:29a:6d03:f8bf])
        by smtp.gmail.com with ESMTPSA id g73sm15291060pfd.185.2019.03.31.13.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 13:38:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Date:   Sun, 31 Mar 2019 14:09:03 -0600
Message-Id: <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com> <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com> <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com> <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com> <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
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
In-Reply-To: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (16D57)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 30, 2019, at 11:24 AM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=20
>> On Sat, Mar 30, 2019 at 10:12 AM Christian Brauner <christian@brauner.io>=
 wrote:
>>=20
>>=20
>> To clarify, what the Android guys really wanted to be part of the api is
>> a way to get race-free access to metadata associated with a given pidfd.
>> And the idea was that *if and only if procfs is mounted* you could do:
>>=20
>> int pidfd =3D pidfd_open(1234, 0);
>>=20
>> int procfd =3D open("/proc", O_RDONLY | O_CLOEXEC);
>> int procpidfd =3D ioctl(pidfd, PIDFD_TO_PROCFD, procfd);
>=20
> And my claim is that this is three system calls - one of them very
> hacky - to just do
>=20
>    int pidfd =3D open("/proc/%d", O_PATH);

Hi Linus-

I want to re-check this because I think Christian=E2=80=99s example was bad.=
  I proposed these ioctls, but that wasn=E2=80=99t the intended use.  The re=
al point is:

int pidfd =3D new_improved_clone(...);

To be useful, this type of API *must* work without proc mounted.

And, later:

openat(fd to pidfd=E2=80=99s proc directory, =E2=80=9Cstatus=E2=80=9D, ...);=


And we want a non-utterly-crappy way to do this.  The ioctl is certainly ugl=
y, but it *works*.

Another approach is:

pid_t pid =3D pidfd_get_pid(pidfd);
sprintf(buf, =E2=80=9C/proc/%d=E2=80=9D, pid);
int procfd =3D open(buf, O_PATH);
if (pidfd_get_pid(pidfd) !=3D pid) {
  we lose;
}

But this is clunky.

Do you think the clunky version is okay, or do you have a suggestion for mak=
ing it better?

=E2=80=94Andy
