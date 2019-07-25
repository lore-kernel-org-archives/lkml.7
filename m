Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5C6C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EC322BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="1Q6ULOyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfGYVep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:34:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35430 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYVep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:34:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so23405807pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiYRj7E3Dy6V2t5m7sV8jSh+kJY2gTdBXaMARRXcvtk=;
        b=1Q6ULOyUGM+dXIraIPHDKr1jbbBGlCFF5Wtucww7rlIh8qmfYsWyj1KuPu64Gxyscb
         YPmC9wHQ72iksF1wY8Eckqd5wRPeSHMrImmA4fICv6x52bGcMcyAIaZUucKNHTYNt/tJ
         TimAfRYm+v5T5W+DEVzXEA+sjFEiq4CG9oTFbqNR3k2f2xOM+Z4P0sxv/ou94ePbjYoa
         xGPKMPghxQsbILuHftK99D/kC5LAIntF+tZWLoOj6M3FbFBWsyAceAywdln+aKqpZ1pm
         CZWUSNVasPHJxemw1Plg0zhJ/qOzKAUDw/hp6S9/G/2Te3x77x006ZuPdhckbWmr3XKB
         rw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiYRj7E3Dy6V2t5m7sV8jSh+kJY2gTdBXaMARRXcvtk=;
        b=rWnd5rGrjtnWX5dnzjARFL1XQjpSDEzKbwRDqn4v+8XP4nkWQ5OqgDJ22N4EYc5gnx
         8XDaCDzmFSbLX/AC/1n2LzhaArZ5yKjYi985PhH66Cj+iu4vlRA2ulUTDhLHcrpZrSyH
         5NRIUCsoX8yiIcez6p4ZrKfvfr3iNsblJNWQjOF7bfmH2UNn7SwYG3KbrfKHK/Gg4g0s
         wrFEstBWcbVNrT2Bb7sQmD/DKESnz9u1X3IT4aEd7pCtJydb5Z94AwHaXrRaf9BgpQTO
         Zh3vTHFFfPlIRKpJvSnYQtT7KNc6F4hOEQNDV9MwaVVrFPDB+Vp9MZme4pibBsAYwXiA
         LJ9Q==
X-Gm-Message-State: APjAAAUymVzDbL6BKNioEobZeXSNCc3Bmg06OKAGXvs8Q1uguYRy+w1k
        4CretzbfTZtA+ggL3afSusO/izAMdAlXWMjp56/23muM
X-Google-Smtp-Source: APXvYqyCnT13NwDrcOJPEGqTyUcS5rkM5iWvbLxEEDHraXXR5SV9vV35zNL0WhOxkpVwu6FamU9JZP08/tMVNpqCQCk=
X-Received: by 2002:a63:c203:: with SMTP id b3mr89265365pgd.450.1564090483811;
 Thu, 25 Jul 2019 14:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
 <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com>
In-Reply-To: <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Fri, 26 Jul 2019 03:04:07 +0530
Message-ID: <CAG=yYwkP34+uz2vVTdYyV8KJVj_Z26Mo3gUPqss6mk6tpFkWsw@mail.gmail.com>
Subject: Re: BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
To:     Nick Desaulniers <ndesaulniers@google.com>, axboe@kernel.dk
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello Jens Axboe,

Please can you take a look at related code and also patch from Kees ?

On Tue, Jul 16, 2019 at 11:58 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jul 10, 2019 at 10:44 AM Jeffrin Thalakkottoor
> <jeffrin@rajagiritech.edu.in> wrote:
> >
> > hello all ,
> >
> > i encountered a KASAN bug related .    here are some related information...
> >
> >
> > -------------------x-----------------------------x------------------
> > [   30.037312] BUG: KASAN: global-out-of-bounds in
> > ata_exec_internal_sg+0x50f/0xc70
> > [   30.037447] Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
> >
> >
> > [   30.039935] The buggy address belongs to the variable:
> > [   30.040059]  cdb.48319+0x0/0x40
> >
> > [   30.040241] Memory state around the buggy address:
> > [   30.040362]  ffffffff91f41e80: fa fa fa fa 00 00 fa fa fa fa fa fa
> > 00 00 07 fa
> > [   30.040498]  ffffffff91f41f00: fa fa fa fa 00 00 00 00 00 00 00 03
> > fa fa fa fa
> > [   30.040628] >ffffffff91f41f80: 00 04 fa fa fa fa fa fa 00 00 fa fa
> > fa fa fa fa
> > [   30.040755]                       ^
> > [   30.040868]  ffffffff91f42000: 00 00 00 04 fa fa fa fa 00 fa fa fa
> > fa fa fa fa
> > [   30.041003]  ffffffff91f42080: 04 fa fa fa fa fa fa fa 00 04 fa fa
> > fa fa fa fa
> >
> > ---------------------------x--------------------------x----------------
> > $uname -a
> > Linux debian 5.2.0-rc7+ #4 SMP Tue Jul 9 02:54:07 IST 2019 x86_64 GNU/Linux
> > $
> >
> > --------------------x----------------------------x---------------------------
> > (gdb) l *ata_exec_internal_sg+0x50f
> > 0xffffffff81c7b59f is in ata_exec_internal_sg (./include/linux/string.h:359).
>
> So looks like ata_exec_internal_sg() is panic'ing when...
>
> > 354 if (q_size < size)
> > 355 __read_overflow2();
> > 356 }
> > 357 if (p_size < size || q_size < size)
> > 358 fortify_panic(__func__);
> > 359 return __builtin_memcpy(p, q, size);
> > 360 }
> > 361
> > 362 __FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
>
> ...a call to memmove is made? Without having looked at the source of
> ata_exec_internal_sg(), it's possible that either through inlining, or
> the compiler generating a memmove, that one of the arguments was not
> quite right.  I suggest spending more time isolating where this is
> coming from, if you can reliably reproduce, or CC whoever wrote or
> maintains the code and ask them to take a look.
>
> The cited code looks like a check comparing that the pointer distance
> is greater than the size of bytes being passed in.  I'd wager
> someone's calling memmove with overlapping memory regions when they
> really wanted memcpy.  Maybe a better question, is why was memmove
> ever used; if there was some invariant that the memory regions
> overlapped, why is that invariant no longer holding.
>
> Anyways, sorry I don't have more time to look into this.  Thank you
> for the report.
>
> > 363 {
> > (gdb)
> > --------------------------x--------------------------
> > GNU Make            4.2.1
> > Binutils            2.31.1
> > Util-linux          2.33.1
> > Mount                2.33.1
> > Linux C Library      2.28
> > Dynamic linker (ldd) 2.28
> > Procps              3.3.15
> > Kbd                  2.0.4
> > Console-tools        2.0.4
> > Sh-utils            8.30
> > Udev                241
> > ---------------------x--------------------------------x
> > Thread model: posix
> > gcc version 8.3.0 (Debian 8.3.0-7)
> > ---------------------x--------------------------------x
> >
> > Please ask if more information is needed.
> >
> > --
> > software engineer
> > rajagiri school of engineering and technology
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
software engineer
rajagiri school of engineering and technology
