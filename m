Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC19BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C8120818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKKJdJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:33:09 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37501 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfKKJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:33:05 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N3Xvv-1hmXq031f9-010c8d; Mon, 11 Nov 2019 10:33:03 +0100
Received: by mail-qt1-f169.google.com with SMTP id i17so3427310qtq.1;
        Mon, 11 Nov 2019 01:33:03 -0800 (PST)
X-Gm-Message-State: APjAAAURrjL9lSo1/lhXvCwwaHgw4a7Egm+xqt4M4B/vnou+5fvBE93I
        o/IXm5K/AdyiDnMYa4NzpnSeMGx5sPcF2k9GNAk=
X-Google-Smtp-Source: APXvYqwOhN6uGhpVV7oJjqzny+sTYzdo1sn49fbiHpAlcC9Kw6k8lGkjxmDhtfyM6aJGaXQYZ3jsCTErYxjUnsB4S54=
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr24767924qtp.7.1573464782536;
 Mon, 11 Nov 2019 01:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20191108170120.22331-1-will@kernel.org> <20191108170120.22331-2-will@kernel.org>
 <CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com> <93f80017-d65e-7c3a-29b0-d9a568d08f58@de.ibm.com>
In-Reply-To: <93f80017-d65e-7c3a-29b0-d9a568d08f58@de.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 10:32:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a21KdGKMDDPs3jc9XEg3=LbzFnGwVm+xDTB+EqGXiZorA@mail.gmail.com>
Message-ID: <CAK8P3a21KdGKMDDPs3jc9XEg3=LbzFnGwVm+xDTB+EqGXiZorA@mail.gmail.com>
Subject: Re: [PATCH 01/13] compiler.h: Split {READ,WRITE}_ONCE definitions out
 into rwonce.h
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:5vTUeZVKZsm8p4fRceaPnnbV7UUKqQe+zXfZWql/hhv4b8yiJK5
 IqdJHHEoHwgfYywSYW6BDZaAFENI20ZZvi60GP5zq7dmTsPIb1rBCRU/v5J5BWt1HxQSgCl
 3QFgCRm4+wMgHwlsVWvTxb8JPePQKjcHNpr4KLw7Paj+GuEUS6dHx133Sp/Ge/VzbAEj+Xy
 2EES4VTSoF7OO8uMKC4xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HmaHvMo4ELQ=:dWEo9CK8fojEWWfVWxtit/
 b4ptuDBuqPdE4BczXGK65KQTt3ALnytgcwtHgXMEsKUbC8bYkISOiW5I+0tG/V+OEN0sQS8dE
 nXb+rQEDMb0MyMQUYHGMfOybKwMDmwQWDuG0SV5mKk4yBFyZXmEVMafPwx49uKITx+s0+4gDN
 pWdWFfQGubOYUfVgJSLWBrZIi3SqM3X8lLe6Aj7zRck8tk/LqVUDsW7/ZuYYtcsUcSo9Gp5Fl
 UJKuVY66G/eim3V5ctB2w2YQSkfmZUDk18z5M5Qf+Si5YTRt4IOUhRJWcjel58vaZBfS9RWfk
 RQgZh7QlD9oUD0HH+pXhZ47rE4rpMybQWOJfvSQJFnkL0+3B6XGiZSXEIl7uFs7EAjo/3cEXp
 80gYOec8DoOInGxngQ7q/jy+OFiZI/LVFgddCvcw/FbnOFxxrm+Ql5X7DxQey9f9WTPmWgNsA
 B8/PQcmGAcjRpIFD0HMzCH5vILlQUKrb02NE4ADGxnGFyKfWDxUtTcEiupDyup2y19Jf+br/6
 IQ9oCcaWt2PjpVHmJCamgDmQgFiUZ3Jybozp11mIgfmsKHHls8wU+W/FS3lLjOQIp0tEuX9z7
 Gsp7g8npa66aVaSLCnzuMBJgTBznyQHQRoxOP9Gbj85tCshhjJUr0JYy4jgxOmGDdF03guem7
 Hvd7nBxRAT2j3E6uv/NJyTdXE19p0RU7WpK5mf70+utvySbWMA6Wd4aOxNrwv71ZJ1/j0CABx
 XI4kA0GLvbQ/kRGAejBel87kBzeGeJsvFqsrT7qeONyicTVdY5vp3RoKsMZk3imHbGw4VG7uI
 dhApGCHk42wHAw6Q7B07GB43y/OciYsDnFbCRzoGjc1+f8UrqyHEn46a2ZHnOhc3io7ooLl71
 7mPRFREm6/O4DINcGiXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 9:10 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 08.11.19 20:57, Arnd Bergmann wrote:
> > On Fri, Nov 8, 2019 at 6:01 PM Will Deacon <will@kernel.org> wrote:
> >>
> >> In preparation for allowing architectures to define their own
> >> implementation of the 'READ_ONCE()' macro, move the generic
> >> '{READ,WRITE}_ONCE()' definitions out of the unwieldy 'linux/compiler.h'
> >> and into a new 'rwonce.h' header under 'asm-generic'.
> >
> > Adding Christian Bornträger to Cc, he originally added the
> > READ_ONCE()/WRITE_ONCE()
> > code.
> >
> > I wonder if it would be appropriate now to revert back to a much simpler version
> > of these helpers for any modern compiler. As I understand, only gcc-4.6 and
> > gcc4.7 actually need the song-and-dance version with the union and switch/case,
> > while for others, we can might be able back to a macro doing a volatile access.
>
> As far as I know this particular issue with  volatile access on aggregate types
> was fixed in gcc 4.8. On the other hand we know that the current construct will
> work on all compilers. Not so sure about the orignal ACCESS_ONCE implementation.

I've seen problems with clang on the current version, leading to unnecessary
temporaries being spilled to the stack in some cases, so I think it would still
help to simplify it.

We probably don't want the exact ACCESS_ONCE() implementation back
that existed before, but rather something that implements the stricter
READ_ONCE() and WRITE_ONCE(). I'd probably also want to avoid the
__builtin_memcpy() exception for odd-sized accesses and instead have
a separate way to do those.

      Arnd
