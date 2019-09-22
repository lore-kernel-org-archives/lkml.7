Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 12:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAE620830
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo0txVpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfIVMOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 08:14:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36489 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfIVMOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 08:14:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id h2so10266914edn.3;
        Sun, 22 Sep 2019 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bapqg0axGoCoiojzRpaF0T/C3zoEUk4uuMPjaIgioo=;
        b=Eo0txVpq1/oGcQtlLHGiItCW18S9y8GIIJO2UMmQQpdPyRmU9mWBkD6JPQPgNIeGhn
         EHj9D0Wbb2rfm1vMqzUoZU5dZFuvQndT4NZx9l6FSIwCT2F5YyssoZep5kVzvpKC1Gc2
         /hDZXPLWMNErOvLeGaqIA0E4AQm8QNntu+aoUFVJcbFV3uR9x1ia6Qb1dZCvQ8pox8c0
         Ds5sct02ox9AxAOdkdM7kXO/V6gHS3bLSjs7fxes4olzAJjSSJlKArjkXMXUblyNlr2o
         LZ4cZ7vkj4pmK9pzrxyMr/Z+etoXffnrdIPg2ZZtK3CFi1HNOOsV9T8BvKYKFWqmsz4x
         f2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bapqg0axGoCoiojzRpaF0T/C3zoEUk4uuMPjaIgioo=;
        b=snIGCQCERZUe1Kj78L/hfVnocZ5XzWLYPEr7uoIUCKFY0iAck7QZpvv5y4imICYiMb
         +zFF16szAdbIe/zHyH8k6f681wIzmSeRczFmkKJwsghv1J4tqZzd1x1ZLcWgsMLxjvo3
         sNPGlU8t5xI6PILFyd+ghl1UhN2BNKzAV/kMZWLwAQ3gXX+ehCAdJzrcwRWSDQTJ6qKJ
         jzRKbsWdgE0luDbetF5j/Xp4f4TdMGNtN71LAsdmWmwOXwUkE22eTtAPETXfs5oqd7Zq
         MufBi8wu4QVFrGoucYAr2PXUYSoqyrTVZDR6BRX7DpaYDJBgxHJGH9l6X+mAJDO9+aNO
         hscg==
X-Gm-Message-State: APjAAAVGqmitkiQ7gVE0QdDLg3pgb25WPMLmFs5VpvzdwVgwHHmy8N/g
        c9lnKKyno8TolpL6OTD3ZdmYtgcKaRQD8vTd+NI=
X-Google-Smtp-Source: APXvYqy0OT3wqBIzCmzH5tYHO7MpduKdGxjqkkADRtGngTQ3G9yD4jl/NWegMXDJ7sXrsLwhuzJh/0sRoOXkpTKb/GI=
X-Received: by 2002:aa7:c34b:: with SMTP id j11mr31544525edr.245.1569154457791;
 Sun, 22 Sep 2019 05:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqwizJ2HXdiU7aSH9t=ecBEHnxdVVsQ4wUpTYRpCgdXf=w@mail.gmail.com>
 <CADxRZqzx=8jNQuvi8WN=7U_G5a0f+v_GODHH8q3QJVYmg=n1LA@mail.gmail.com> <CAK7LNAR3szhzH89ujCPq5Xz8rm0xvSjJdx0TebsaU8yiroXXVg@mail.gmail.com>
In-Reply-To: <CAK7LNAR3szhzH89ujCPq5Xz8rm0xvSjJdx0TebsaU8yiroXXVg@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sun, 22 Sep 2019 15:14:10 +0300
Message-ID: <CADxRZqy-muFfpfCj6ZMPboSMEKXukTDg0oUZc6udvNreoJ6pgA@mail.gmail.com>
Subject: Re: latest git kernel (v5.3-11506-gf7c3bf8fa7e5) does not compile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 2:38 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Anatoly,
>
> On Sun, Sep 22, 2019 at 5:33 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> >
> > On Sun, Sep 22, 2019 at 11:13 AM Anatoly Pugachev <matorola@gmail.com> wrote:
> > >
> > > Hello!
> > >
> > > Latest git kernel does not compile for me:
> > >
> > > ~/linux-2.6$ git desc
> > > v5.3-11506-gf7c3bf8fa7e5
> > >
> > > ~/linux-2.6$ make
> > >   CALL    scripts/checksyscalls.sh
> > > <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   CHK     include/generated/compile.h
> > >   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> > > unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> > > arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> > > make[2]: *** [scripts/Makefile.build:266:
> > > arch/sparc/vdso/vdso32/vclock_gettime.o] Error 1
> > > make[2]: *** Deleting file 'arch/sparc/vdso/vdso32/vclock_gettime.o'
> > > make[1]: *** [scripts/Makefile.build:509: arch/sparc/vdso] Error 2
> > > make: *** [Makefile:1667: arch/sparc] Error
> > >
> > > but I was able to compile successfully v5.3-10169-g574cc4539762
>
>
> Thanks for the report, and apology for the breakage.
>
> Please check this patch.
> https://lore.kernel.org/patchwork/patch/1130469/
>
> I hope it will fix the build error.


It does. Thanks Masahiro!
