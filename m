Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5DEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2D02070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfDJSzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:55:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41819 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJSzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:55:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id o129so1898780qke.8;
        Wed, 10 Apr 2019 11:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aj8PUHxvs/xbauw0iCG1WEDHVI0PEO9pv0el34MtXJ4=;
        b=YSn1QgqVs9PpkLcPXy6+cjDcaJ4pXmMZLQGvTbXsv6ERP62oqrLzrG4oPFgwxM69Ed
         IFI2RMkVaUheg0l2066DkncScrFIsZRMPEYlAwthFi9ruZRaVIr09l67SRLWU2U+NJSn
         JYiU81+56ohA0iWbRI1lZo/ksS1Hwt/aXPb/r6AoeMqjNK5UOLcve9BhzBu6EJKRGLg/
         LB6oMnFunqwqMJLsDC9eA/o/zsFyU46rPVwCo4dBiuVWsUoFt6LbDtZlM1c+YGjW/Mcj
         PirRcNjAK7eQ0wzZAglN9w58oekkupINWqPzpO428MluclKTBT3N9m8Xyot+J3vqyRnn
         uVew==
X-Gm-Message-State: APjAAAVKNiJZpvu/udilmamWRxCeW8lKvY+plS6ZowxsqNST98ZBhltI
        Kl+ciBey9W0BUWixmwmZs2nvoZEG61nv06maaco=
X-Google-Smtp-Source: APXvYqzAzL16vJQF0ou3rq0k56Uu5CJGOP+xOUGVB4Mf6/qS5Xtaf4/ds3f5jRbcyM0F5SM5ItrE66q1VxLSl+vGoAA=
X-Received: by 2002:a37:f511:: with SMTP id l17mr35610010qkk.296.1554922543926;
 Wed, 10 Apr 2019 11:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-12-arnd@arndb.de>
 <20190410155513.1609f1a1@mschwideX1>
In-Reply-To: <20190410155513.1609f1a1@mschwideX1>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Apr 2019 20:55:27 +0200
Message-ID: <CAK8P3a0xg+-w5KVx5ti_354qKHTNES78eyRaRCQUnnRx33sDfQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] [PROBABLY WRONG] s390: void '0' constraint in
 inline assembly
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 3:55 PM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Mon,  8 Apr 2019 23:26:25 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> > index 700c650ffd4f..84c59c99668a 100644
> > --- a/arch/s390/include/asm/processor.h
> > +++ b/arch/s390/include/asm/processor.h
> > @@ -262,7 +262,7 @@ static __no_kasan_or_inline unsigned short stap(void)
> >       register unsigned long r4 asm("6") = (unsigned long)(arg5)
> >
> >  #define CALL_FMT_0
> > -#define CALL_FMT_1 CALL_FMT_0, "0" (r2)
> > +#define CALL_FMT_1 CALL_FMT_0, "d" (r2)
> >  #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
> >  #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
> >  #define CALL_FMT_4 CALL_FMT_3, "d" (r5)
>
> This is (slightly) wrong. %r2 is used as the input register for the first argument
> and the result value for the call. With your patch you force the compiler to load
> the first argument in two registers. One solution would be to CALL_FMT1 as
>
>         #define CALL_FMT1 CALL_FMT_0
>
> It still is not optimal though as for CALL_FMT_0 the "+&d" (r2) indicates an
> input but CALL_ARGS_0 does not initialize r2.

Ok, thanks for taking a closer look!

> I am thinking about the following patch to cover all cases:
> --
> From 91a4abbec91a9f26f84f7386f2c0f96de669b0eb Mon Sep 17 00:00:00 2001
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date: Wed, 10 Apr 2019 15:48:43 +0200
> Subject: [PATCH] s390: fine-tune stack switch helper
>
> The CALL_ON_STACK helper currently does not work with clang and for
> calls without arguments it does not initialize r2 although the contraint
> is "+&d". Rework the CALL_FMT_x and the CALL_ON_STACK macros to work
> with clang and produce optimal code in all cases.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

I did another build test to confirm that your patch works fine with clang
as well, looks good to me.

      Arnd
