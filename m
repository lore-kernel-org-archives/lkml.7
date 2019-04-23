Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E172C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3CA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3qa2eNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfDWSVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:21:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37814 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:21:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so8016280pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5RQU4EyaShn7ES1Et2UEJDFFRacmhuQJUjXc17xW2Q=;
        b=u3qa2eNFA2/UJ2E5nOWKiPqrPzB2E++XYIVXcvXUm03gq52TwZFgH5z2qdj+71s7d+
         DTVTtRzrh50UDlWLwFhUu/Aaw+5FMoBWv1Z6yMM94lyWkUta9oeOameAGucLvLa9MqVq
         lUW/ssGT/bbHbwGUA4lBq51W4eOBneQXXknJsLGbXEQkEcr36clkyyS20Cd9FAUz0kLk
         Jop8AF1JwOZOGZV3T0wpbMhEyyzxVYfylNhtsrdSYsiDKkto1Lh74N/ESR4xoCUc+Ft+
         dMH8gaoBoxKRdXLEUqalEAYvJ1Z2BAHYJf52MfeqWRQsH32qVBU1K2zcl46Jn8ReYDMj
         dbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5RQU4EyaShn7ES1Et2UEJDFFRacmhuQJUjXc17xW2Q=;
        b=hTr0BS0nISceUY9SjCQe2W8FCHZgAPl/GNvTk+1Cf6GUNRrpDA8P67F4aA/BZ8p8rx
         V3ylL3+CZiEQzqiVJ5oDL/UE0DxU/A9Au/wdk12cc1OVA01f66kNDfxsQlGHugV7iAS+
         SbGYK+HmpmBJX9SEky81BCc4VpSFyEkhI3pz99dMjsmz0Ut45u7CdaydfKCXOj85QPIc
         ThHeXE1Ybu41bqNyLCsFM1FCSVz397V5MWh3rU2uPoRPZnB7StYuA3KmcKqAqWtFFtBN
         aa2LNjFu1sm+mwcEZxiZi801/TFzbTZK5wVXhIsOkAUwx0picGF4cRvqVVhL/h59TEOP
         40+Q==
X-Gm-Message-State: APjAAAU7AePl3sKnDhTcR1WbdeBAyH7kTWksjtkx7AeOQV5dV1vZ7C3v
        c7goFOY5kCE7ySQnO0tlK7ipypXZtDkQLuk70GQ40w==
X-Google-Smtp-Source: APXvYqyEcsui/GMruRfUAJp8QeZcmer2yUhPRi8jrSvAkDjfYYcbUbVMOTJ7fxeoS9Vl8rQetND6kF92ISYylvYpjew=
X-Received: by 2002:aa7:8096:: with SMTP id v22mr28352978pff.94.1556043699691;
 Tue, 23 Apr 2019 11:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190415083605.2560074-1-arnd@arndb.de> <20190415083605.2560074-4-arnd@arndb.de>
 <CAKwvOd=761wDZ-g-E7kqOFCftH=CONpzc52WU0-ZQztZ3U=x4w@mail.gmail.com> <CAK8P3a2_Rkz3y662mxKTva_rrzHpOQ9fQ+pedenWCZCehxgxPw@mail.gmail.com>
In-Reply-To: <CAK8P3a2_Rkz3y662mxKTva_rrzHpOQ9fQ+pedenWCZCehxgxPw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Apr 2019 11:21:28 -0700
Message-ID: <CAKwvOdmrOdzb3N3oNZL1kKYYSKzrVR+Opc7af9cYDL9cd2QpOg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] s390: fix clang -Wpointer-sign warnigns in boot code
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 1:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 22, 2019 at 7:52 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
>
> > > @@ -20,7 +20,7 @@ extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
> > >  extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
> > >
> > >  static inline void
> > > -codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
> > > +codepage_convert(const __u8 *codepage, volatile char* addr, unsigned long nr)
> > >  {
> > >         if (nr-- <= 0)
> > >                 return;
> >
> > There are many call sites of ASCEBC which is defined in terms of this
> > function. Do they all use `char*`?  grep shows an explicit cast to
> > `unsigned char*` in drivers/s390/char/tape_std.c for example.
>
> Generally speaking, the kernel is full of Wpointer-sign warnings, that's why
> this warning is disabled in the top-level Makefile by default. My patch fixes
> the ones in the s390 boot code that is not built with those default flags, but
> I made no attempt to fix the rest of the kernel.

Right, sorry, I forgot about that.  This patch looks good to me.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fun fact: on most architectures, 'char' is signed, but on s390 and 32-bit
> arm it is unsigned. The compiler treats 'char', 'unsigned char' and
> 'signed char'
> as three distinct types here for that reason.

I think I recall reading about that in:
https://www.amazon.com/ARM-System-Developers-Guide-Architecture/dp/1558608745
(I'll try to dig it up and post what the explanation was).

-- 
Thanks,
~Nick Desaulniers
