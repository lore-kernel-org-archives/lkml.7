Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CDFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47242063F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iNZ3bBhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCOX3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:29:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43069 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCOX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:29:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so692541pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1dMUwAW70xgwX9LsmeR0YFeFJv0qMn6l++pVSnfrUVk=;
        b=iNZ3bBhPiRaIzCXPZDFKxc6mbWaX3RTPC3zDkaQY+MrGrvEmUbkEPNbL60sRuhQYE8
         T2tlTRmrHqPyf7Z3ED0XjQUvA4AJ9G5aZcsEK1hhoDVkHdnaKmWgPVMTmDotBNvnb1Ry
         1dZsIkRNgln5Z0LgVAMJ5eI9IuatxtSJ65nwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1dMUwAW70xgwX9LsmeR0YFeFJv0qMn6l++pVSnfrUVk=;
        b=cFI6jz6Qxt14rHQCNYzP1Fh+vX53F40c5kjbsn4xQ24Lq64FoNIHB+vnOuw8NQli2T
         /Pa+dzifnWuAPNCt4c3cNjihSNuEps9F3v5kcW8z/etKdcYsZVqhUi8uY36ZIq7N1HDo
         RfbHUV7rPh5Nswp9zEvfubtOctE8W1AZL60IZxlLYGZJvcK3u/FQ7WPwmqaznNXogfbV
         oE5VJ9RbXApAJJiWJ+sFyz7fGxmdoHIyLH4BNVCVaKOaoDM/fsTmoLw2C7BQEgYB8+4q
         ARBeJLkpmUaN22ebNwSQum3h7Afk44011LEoH9HL/arv3SEnQB+Rvw2atGXzC/dRHQBs
         VvTg==
X-Gm-Message-State: APjAAAXwJ84u07D3rGG5yhYeychny0IZB7IK0Cdq6PzXgXOHY9CeK7rz
        aGo1hzrKvzabTl7VVy2RcfqCgQ==
X-Google-Smtp-Source: APXvYqz7Yydbc2e/fxrwFVzjoe09z4MpYf4uAG9zMjdTrQcMSXU2LqyJFYgy2C5ewnHHyRr9ttYd6w==
X-Received: by 2002:a65:4306:: with SMTP id j6mr4381391pgq.304.1552692576604;
        Fri, 15 Mar 2019 16:29:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b65sm4995911pfm.127.2019.03.15.16.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 16:29:36 -0700 (PDT)
Date:   Fri, 15 Mar 2019 16:29:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
Message-ID: <20190315232935.GD112750@google.com>
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
 <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 03:06:37PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Fri, Mar 15, 2019 at 1:54 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > The compiler may emit calls to __lshrti3 from the compiler runtime
> > library, which results in undefined references:
> >
> > arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
> >   include/linux/math64.h:186: undefined reference to `__lshrti3'
> 
> Looks like Clang will emit this at -Oz (but not -O2):
> https://godbolt.org/z/w1_2YC
> 
> >
> > Add a copy of the __lshrti3 libgcc routine (from gcc v4.9.2).
> 
> Has it changed since? If so why not a newer version of libgcc_s?

Our compiler folks who maintain this gcc version dug this up for
me. In the gcc sources there is no direct implementation of __lshrti3,
I was told it is somehow derived from __lshrdi3.

> > Include the function for x86 builds with clang, which is the
> > environment where the above error was observed.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/x86/Kconfig       |  1 +
> >  include/linux/libgcc.h | 16 ++++++++++++++++
> >  lib/Kconfig            |  3 +++
> >  lib/Makefile           |  1 +
> >  lib/lshrti3.c          | 31 +++++++++++++++++++++++++++++++
> >  5 files changed, 52 insertions(+)
> >  create mode 100644 lib/lshrti3.c
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index c1f9b3cf437c..a5e0d923845d 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -105,6 +105,7 @@ config X86
> >         select GENERIC_IRQ_PROBE
> >         select GENERIC_IRQ_RESERVATION_MODE
> >         select GENERIC_IRQ_SHOW
> > +       select GENERIC_LIB_LSHRTI3              if CC_IS_CLANG
> >         select GENERIC_PENDING_IRQ              if SMP
> >         select GENERIC_SMP_IDLE_THREAD
> >         select GENERIC_STRNCPY_FROM_USER
> > diff --git a/include/linux/libgcc.h b/include/linux/libgcc.h
> > index 32e1e0f4b2d0..a71036471838 100644
> > --- a/include/linux/libgcc.h
> > +++ b/include/linux/libgcc.h
> > @@ -22,15 +22,26 @@
> >  #include <asm/byteorder.h>
> >
> >  typedef int word_type __attribute__ ((mode (__word__)));
> > +typedef int TItype __attribute__ ((mode (TI)));
> 
> Well that's an interesting new compiler attribute.
> https://stackoverflow.com/questions/4559025/what-does-gcc-attribute-modexx-actually-do
> Please use `__mode(TI)` from include/linux/compiler_attributes.h ex.
> typedef int TItype __mode(TI);

ok

> >  #ifdef __BIG_ENDIAN
> >  struct DWstruct {
> >         int high, low;
> >  };
> > +
> > +struct DWstruct128 {
> > +       long long high, low;
> > +};
> > +
> >  #elif defined(__LITTLE_ENDIAN)
> >  struct DWstruct {
> >         int low, high;
> >  };
> > +
> > +struct DWstruct128 {
> > +       long long low, high;
> > +};
> > +
> >  #else
> >  #error I feel sick.
> >  #endif
> > @@ -40,4 +51,9 @@ typedef union {
> >         long long ll;
> >  } DWunion;
> >
> > +typedef union {
> > +       struct DWstruct128 s;
> > +       TItype ll;
> > +} DWunion128;
> > +
> >  #endif /* __ASM_LIBGCC_H */
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index a9e56539bd11..369e10259ea6 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -624,6 +624,9 @@ config GENERIC_LIB_ASHRDI3
> >  config GENERIC_LIB_LSHRDI3
> >         bool
> >
> > +config GENERIC_LIB_LSHRTI3
> > +       bool
> > +
> >  config GENERIC_LIB_MULDI3
> >         bool
> >
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 4e066120a0d6..42648411f451 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -277,6 +277,7 @@ obj-$(CONFIG_PARMAN) += parman.o
> >  obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
> >  obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
> >  obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
> > +obj-$(CONFIG_GENERIC_LIB_LSHRTI3) += lshrti3.o
> >  obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
> >  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
> >  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
> > diff --git a/lib/lshrti3.c b/lib/lshrti3.c
> > new file mode 100644
> > index 000000000000..2d2123bb3030
> > --- /dev/null
> > +++ b/lib/lshrti3.c
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/export.h>
> > +#include <linux/libgcc.h>
> > +
> > +long long __lshrti3(long long u, word_type b)

This signature matches with the gcc documentation
(https://gcc.gnu.org/onlinedocs/gccint/Integer-library-routines.html),
however the gcc implementation of the function has 128-bit values as
input/output, so I guess to meet gcc's expectations the 'long long's
need to be changed to TItype.

> > +{
> > +       DWunion128 uu, w;
> > +       word_type bm;
> > +
> > +       if (b == 0)
> > +               return u;
> > +
> > +       uu.ll = u;
> > +       bm = 64 - b;
> > +
> > +       if (bm <= 0) {
> > +               w.s.high = 0;
> > +               w.s.low = (unsigned long long) uu.s.high >> -bm;
> > +       } else {
> > +               const unsigned long long carries =
> > +                       (unsigned long long) uu.s.high << bm;
> > +               w.s.high = (unsigned long long) uu.s.high >> b;
> > +               w.s.low = ((unsigned long long) uu.s.low >> b) | carries;
> > +       }
> > +
> > +       return w.ll;
> > +}
> > +#ifndef BUILD_VDSO
> > +EXPORT_SYMBOL(__lshrti3);
> > +#endif
> 
> I don't think you want this.  Maybe that was carried over from
> https://lkml.org/lkml/2019/3/15/669
> by accident?  The above linkage error mentions arch/x86/kvm/x86.o
> which I wouldn't expect to be linked into the VDSO image?

I put it preemptively, since I know from
https://lkml.org/lkml/2019/3/15/669 that the vDSO build is unhappy
about EXPORT_SYMBOL. Obviously we can also wait until a vDSO needs to
include this file.

Thanks

Matthias
