Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D64C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B76B2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfDJTBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:01:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38194 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDJTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:01:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id g1so1922391qki.5;
        Wed, 10 Apr 2019 12:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ct8LsGcjmi/0XPKOcfnklNuVfe53Ye0OTVxjS5AHnFE=;
        b=METN/d8MhngOE+H4qm6s2+vR5B90HwwGFtQDwNQMkQbJTr+3oupZpLVZYs/LMkKRC8
         SeNayclio8/VXh22iL9uevex3ub7mDgWtnTzFAB1H4X8Tw7jFIxaHDYJOhfEvqQGXBH9
         3rau7TlfP6UXoa4QLLsrf3wShnhwmVpA70CIm8mul0qZHrWRbioAJ1ZcARwzcvc4KJjO
         0sbc481erI03+SJfaL07qC7PCEk1GLdRngUSanDtNqRjAEkVD6t8SIuBgLhbD7+siYmP
         5fYD2xgz0XY+szPyH0tnW+JQFweRiECk/oMB/Lfot612JTtlzF7eyF4EY/FrkoGFcw9S
         lG1Q==
X-Gm-Message-State: APjAAAV9N2/t5i4TqrUc2LZlAhjEZLDJ3CsemYtw0pxtFC7+hw07U0Ah
        tazTDjriEijoJlQhejzEdvPZant9dv+VHDbal4g=
X-Google-Smtp-Source: APXvYqxrvWuBkdeIf78jrs6AeI6/AGBXeGqohqTt34FkjGfq2DyOXV3TWwha+Kwm9V8GS7ik96+cinzCM1Q+OoLzsOs=
X-Received: by 2002:a37:9e8a:: with SMTP id h132mr33945458qke.74.1554922868286;
 Wed, 10 Apr 2019 12:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-2-arnd@arndb.de>
 <CAKwvOdmRVK8t=CL5h0MXykm00R39e17dy8EkgFrLuhg1Yr0HJQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmRVK8t=CL5h0MXykm00R39e17dy8EkgFrLuhg1Yr0HJQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Apr 2019 21:00:52 +0200
Message-ID: <CAK8P3a3ytjz5KarSPyk4G=HOGopBMN65j0eYaWZanUbGoe=wXw@mail.gmail.com>
Subject: Re: [PATCH 02/12] s390: don't build vdso32 with clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 6:26 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Mon, Apr 8, 2019 at 2:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > clang does not support 31 bit object files on s390, so skip
> > the 32-bit vdso here, and only build it when using gcc to compile
> > the kernel.
>
> What's the build failure?  Would you mind filing a bug against LLVM's
> issue tracker for it, please?

As far as I can tell, llvm does only supports 64-bit output for s390, so this
is not a bug but rather a missing feature that seems highly unlikely to
ever get added.

32-bit (31-bit) mode on s390 is only used for very old existing binaries,
and the vdso support is optional there.

      Arnd
