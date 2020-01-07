Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF099C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8003C208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxeJppXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgAGNfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:35:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35646 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgAGNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:35:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so23201625pfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 05:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SE22RGLOYKiz1eXSXS7nfYqv4Wy/fOrGKZNHN2DjzL8=;
        b=RxeJppXyzqEudNTXxLvL/ymqLOJKtt2gWuCec3JaGwouR9QaWeZEskwDCIH+8qlRbS
         4CAwKDVFG1d9/damMkNxQ01+n06IQBiMMUDMdZmHln6z+UC6E8oL3dICa7QNyWA3ILbz
         yG67ldNQKTKsEikztP/9BCbFksRlDPiw4WEopOrpxMXjNWY7mv6wV5uD4eS2ocwAs45g
         +I+ss9UBgaBJdK1xB7iBkDI3UtCqBORs/t2Ngmltz1TmdfRYCfL8Xh0mXNCG1WyX8pGn
         Bmqhsy/YqkoWJV4txFMYcTHFxS9X3VbWi772EOtc7AnLhPMzShKT6h7kuI3LcORdZbYE
         KTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SE22RGLOYKiz1eXSXS7nfYqv4Wy/fOrGKZNHN2DjzL8=;
        b=X2ICeS8iNunki/F3YigV4JT2NgoFEloy+eENS9TaC0eOmxrb0nwgOFc5m8+HEHjhVW
         40RV8EwnX8F9+QQxpN7a7VvJDAFkeCzY45S21DoRu6KLo6WGUfTmNCz0cUSUjClw+Z29
         DzMoKnWP/sf5KSrLpjV0Lu5W+NxehIv7zLiXrqHx4dBqkyOCYlYqJhQpDF0XNm76I0AX
         uFfXgqnL0slzsV060/K6pvdIXb8pIfnd9dIEXVjFUBY/OJ+7DZkju+WmXLtlUkaTvsfk
         ij7s9LMGUdlvW+aklbbHYP3phZLOGcqc2T4e6wqso5lQcbwwRv3dK0dzd7P4tdozrH/T
         cYsg==
X-Gm-Message-State: APjAAAVvU78G6o7T0qdd1rkfXwTjuHqJvLHvJ92CTQzic84MC3dtdPvn
        x5G5DB8M7O69OK6QxOSjfyZaLhjLU53Cqc8zIvRqlQ==
X-Google-Smtp-Source: APXvYqzEmJiP4Ezi3jo9KBQt5b917BVQ66ypaKo593gkrn4sefwV/e/2+Z3LG64tfJWo2hRtSFGGrfD1i/Gg/zIjFMk=
X-Received: by 2002:a63:597:: with SMTP id 145mr112265397pgf.384.1578404134220;
 Tue, 07 Jan 2020 05:35:34 -0800 (PST)
MIME-Version: 1.0
References: <688d8f4b-266f-2c47-d4e9-d0336316a0a9@petrovitsch.priv.at> <20200107115220.25574-1-sjpark@amazon.com>
In-Reply-To: <20200107115220.25574-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Jan 2020 05:35:21 -0800
Message-ID: <CAFd5g47-wi0duBAVxvevDKT7eb7WGT9JMFoKgCJQQSa0P0h9Jw@mail.gmail.com>
Subject: Re: Re: What is the best way to compare an unsigned and a constant?
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj38.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay, I was on vacation. (I still am, but I was too ;-).)

On Tue, Jan 7, 2020 at 3:52 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> On   Fri, 27 Dec 2019 13:52:27 +0100   Bernd Petrovitsch <bernd@petrovits=
ch.priv.at> wrote:
>
> > This is a multi-part message in MIME format.
> > --------------D98A0A31D62B0BC2939BAEE9
> > Content-Type: text/plain; charset=3Dutf-8
> > Content-Transfer-Encoding: quoted-printable
> >
> > Hi all!
> >
> > On 27/12/2019 13:39, SeongJae Park wrote:
> > [...]
> > > I have a function returning 'unsigned long', and would like to write =
a =3D
> > kunit
> > > test for the function, as below.
> > >=3D20
> > >     unsigned long foo(void)
> > >     {
> > >             return 42;
> > >     }
> > >=3D20
> > >     static void foo_test(struct kunit *test)
> > >     {
> > >         KUNIT_EXPECT_EQ(test, 42, foo());
> > >     }
> >
> > For this case: shouldn't=3D20
> > ----  snip  ----
> > static void foo_test(struct kunit *test)
> > {
> >      KUNIT_EXPECT_EQ(test, 42ul, foo());
> > }
> > ----  snip  ----
> > do the trick?
>
> Unfortunately, it doesn't works.
>
>     [13:04:58] Building KUnit Kernel ...
>     In file included from /.../linux/include/linux/list.h:9:0,
>                      from /.../linux/include/linux/wait.h:7,
>                      from /.../linux/include/linux/wait_bit.h:8,
>                      from /.../linux/include/linux/fs.h:6,
>                      from /.../linux/include/linux/debugfs.h:15,
>                      from /.../linux/mm/damon.c:12:
>     /.../linux/mm/damon-test.h: In function =E2=80=98damon_test_foo=E2=80=
=99:
>     /.../linux/include/linux/kernel.h:842:29: warning: comparison of dist=
inct pointer types lacks a cast
>        (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
>                                  ^
>     /.../linux/include/kunit/test.h:493:9: note: in expansion of macro =
=E2=80=98__typecheck=E2=80=99
>       ((void)__typecheck(__left, __right));           \
>              ^~~~~~~~~~~
>     /.../linux/include/kunit/test.h:517:2: note: in expansion of macro =
=E2=80=98KUNIT_BASE_BINARY_ASSERTION=E2=80=99
>       KUNIT_BASE_BINARY_ASSERTION(test,           \
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /.../linux/include/kunit/test.h:606:2: note: in expansion of macro =
=E2=80=98KUNIT_BASE_EQ_MSG_ASSERTION=E2=80=99
>       KUNIT_BASE_EQ_MSG_ASSERTION(test,           \
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /.../linux/include/kunit/test.h:616:2: note: in expansion of macro =
=E2=80=98KUNIT_BINARY_EQ_MSG_ASSERTION=E2=80=99
>       KUNIT_BINARY_EQ_MSG_ASSERTION(test,           \
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /.../linux/include/kunit/test.h:979:2: note: in expansion of macro =
=E2=80=98KUNIT_BINARY_EQ_ASSERTION=E2=80=99
>       KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
>       ^~~~~~~~~~~~~~~~~~~~~~~~~
>     /.../linux/mm/damon-test.h:565:2: note: in expansion of macro =E2=80=
=98KUNIT_EXPECT_EQ=E2=80=99
>       KUNIT_EXPECT_EQ(test, 42ul, (int)foo());
>       ^~~~~~~~~~~~~~~

Isn't the issue here that you fixed the 42, but are now casting the
result of foo() to an int?

Or have you fixed that now too?

Worst case (gross) scenario, you could just cast 42 to whatever type
foo() returns.

> Some other thoughts?
>
>
> Thanks,
> SeongJae Park
>
>
> >
> > MfG,
> >       Bernd
> > --=3D20
> > "I dislike type abstraction if it has no real reason. And saving
> > on typing is not a good reason - if your typing speed is the main
> > issue when you're coding, you're doing something seriously wrong."
> >     - Linus Torvalds
