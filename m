Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98035C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A12D206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Mm8c/h7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfEQIrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:47:49 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35174 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfEQIrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:47:45 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x4H8lfpY011895;
        Fri, 17 May 2019 17:47:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x4H8lfpY011895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558082862;
        bh=WnpLsGsAmml7Dms1w83QAyOBiQmZaG3wlsmHMldsj2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mm8c/h7MoQAjKtaXJFbsIiwDOhCleo62G2yN0ENEumdsR3x9bkTim8ZUAsmvNKYGb
         YjzTHjmOZ5eEoT6dxf96KaN4cwDoBx0EA7QLggY+Uc4rEkV/+egiiQChRb8v7K7mME
         103BM4I9xO6+LhP0loRJJ7E5IYURnrnnwstvc9exSd9DuvfxeeZUFgfNa/hXC9jT9h
         iWv5o81UBz3vJxNzCokSyHdEDhZEGmx6/CuEyUH1kiKR5e3N8X4kvsR9JG6ORi5XxH
         MAJIfA9u79h3mxvKDN5Gc3QnyESVoO1lY8MDBQKEmGZvEcHCGaMDmj4lbJqEnkghsG
         O4PFPPHrMLNGg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id u4so2383169uau.10;
        Fri, 17 May 2019 01:47:41 -0700 (PDT)
X-Gm-Message-State: APjAAAWJ+ByAKllsN7h+g/gKhpy3B6yDoAGymOIkoizqVF7ggfBGCPSN
        PCxal3wWG45u8hFqahH4soFuFubrfsx/WrGWd/k=
X-Google-Smtp-Source: APXvYqyVijenelCKJTr3dR3tNdWYeFjirxBi3vBWfk+iMvtHCpXVw8zXnJei85wZq4UZx3PsZban60vlcYzKC/KrM/g=
X-Received: by 2002:a9f:3381:: with SMTP id p1mr2948947uab.40.1558082860964;
 Fri, 17 May 2019 01:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190517065424.24453-1-yamada.masahiro@socionext.com> <20190517090735.6906c2fa@mschwideX1>
In-Reply-To: <20190517090735.6906c2fa@mschwideX1>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 17 May 2019 17:47:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkcSdb=ky2Mb0A48tUpnkXfZmC1B+JwPjkhdGM+EZJdQ@mail.gmail.com>
Message-ID: <CAK7LNAQkcSdb=ky2Mb0A48tUpnkXfZmC1B+JwPjkhdGM+EZJdQ@mail.gmail.com>
Subject: Re: [PATCH] s390: mark __cpacf_check_opcode() and cpacf_query_func()
 as __always_inline
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 5:09 PM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Fri, 17 May 2019 15:54:24 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > Commit e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> > was not enough to make sure to meet the 'i' (immediate) constraint for the
> > asm operands.
> >
> > With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> > with gcc 9.1.1:
> >
> >   In file included from arch/s390/crypto/prng.c:29:
> >   ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query_func':
> >   ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
> >     170 |  asm volatile(
> >         |  ^~~
> >   ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
> >
> > Add more __always_inline to force inlining.
> >
> > Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> > Reported-by: Laura Abbott <labbott@redhat.com>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Added to our internal tree and I will add it to s390/linux soon. Thanks.
>
> Do you have a Kconfig patch in the works to enable OPTIMIZE_INLINING?
> Otherwise we could just add it.

No.
It is up to you.


Thanks.


-- 
Best Regards
Masahiro Yamada
