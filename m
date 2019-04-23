Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB61C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507572077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfDWIGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:06:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43970 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:06:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id i68so10990033lfi.10;
        Tue, 23 Apr 2019 01:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjdPQCnqQqU763ZbK7OggS7CEeR2gDfKdbMjF9AbiaE=;
        b=SfXTk2fCnNq25gug/g/ylL8dqnsbUH0/zB8wxJK47z2KxEkuK+XqlHvQfoypKyaZC/
         D4MxqDvzdmmLjvhXEA+yHzm4oAQLy/lUEvsP/9EOcRwpafgUk9Gf1CxnXWdcZ//81OWR
         PLffAWYjPGMluXKlSUIpEx021SEZc9NJa1U1AOwD3k6RK2Z644aZlfukken/Kw/UkK2S
         xCiIBGAajo48Vt7tAa/Obhcd/upRdcmqzb1uvKO4X8Gy6xo8DAic2tsv4yiQ2ki7cchJ
         T2dB2d52wVX9aQAm37vR9Hk2hfQ6dzlJ6v2zAMYgAfUfaBm++qrnNs/rZja00MbD+wuz
         txng==
X-Gm-Message-State: APjAAAUfkwPM2WHkjUELfFjE+C80L5CwRFw4TamuoLfAf2vwCEDhT+q1
        MRGMavhPc9stZu53hxqzSvtCtN6D5+OYZOkJNTM=
X-Google-Smtp-Source: APXvYqxnxL57mRbZuYknNZo+buspLh75eVs2BYw/B2HOzQn0dzaJ+VYYbTL+crWkQdFRxoTgBLvPZNypXuRKPBzTjYk=
X-Received: by 2002:a19:761a:: with SMTP id c26mr12859356lff.8.1556006769219;
 Tue, 23 Apr 2019 01:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190415083605.2560074-1-arnd@arndb.de> <20190415083605.2560074-4-arnd@arndb.de>
 <CAKwvOd=761wDZ-g-E7kqOFCftH=CONpzc52WU0-ZQztZ3U=x4w@mail.gmail.com>
In-Reply-To: <CAKwvOd=761wDZ-g-E7kqOFCftH=CONpzc52WU0-ZQztZ3U=x4w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Apr 2019 10:05:50 +0200
Message-ID: <CAK8P3a2_Rkz3y662mxKTva_rrzHpOQ9fQ+pedenWCZCehxgxPw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] s390: fix clang -Wpointer-sign warnigns in boot code
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Mon, Apr 22, 2019 at 7:52 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:

> > @@ -20,7 +20,7 @@ extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
> >  extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
> >
> >  static inline void
> > -codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
> > +codepage_convert(const __u8 *codepage, volatile char* addr, unsigned long nr)
> >  {
> >         if (nr-- <= 0)
> >                 return;
>
> There are many call sites of ASCEBC which is defined in terms of this
> function. Do they all use `char*`?  grep shows an explicit cast to
> `unsigned char*` in drivers/s390/char/tape_std.c for example.

Generally speaking, the kernel is full of Wpointer-sign warnings, that's why
this warning is disabled in the top-level Makefile by default. My patch fixes
the ones in the s390 boot code that is not built with those default flags, but
I made no attempt to fix the rest of the kernel.

Fun fact: on most architectures, 'char' is signed, but on s390 and 32-bit
arm it is unsigned. The compiler treats 'char', 'unsigned char' and
'signed char'
as three distinct types here for that reason.

> > diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> > index cc0947e08b6f..f3a637afd485 100644
> > --- a/arch/s390/include/asm/lowcore.h
> > +++ b/arch/s390/include/asm/lowcore.h
> > @@ -128,7 +128,7 @@ struct lowcore {
> >         /* SMP info area */
> >         __u32   cpu_nr;                         /* 0x0398 */
> >         __u32   softirq_pending;                /* 0x039c */
> > -       __u32   preempt_count;                  /* 0x03a0 */
> > +       __s32   preempt_count;                  /* 0x03a0 */
>
> This change is less obvious. Do you still have the warning for that
> this hunk fixes?

I can't find it now, but there are multiple users that would cause
this, like:

static inline void preempt_count_set(int pc)
{
        int old, new;

        do {
                old = READ_ONCE(S390_lowcore.preempt_count);
                new = (old & PREEMPT_NEED_RESCHED) |
                        (pc & ~PREEMPT_NEED_RESCHED);
        } while (__atomic_cmpxchg(&S390_lowcore.preempt_count,
                                  old, new) != old);
}


      Arnd
