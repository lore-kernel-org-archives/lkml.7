Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DCEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61DC218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LTOACvOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfCOXeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:34:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44336 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfCOXeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:34:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id a3so7347013pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 16:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ir9ttkQ1CiAYtX6fgzXb09UuqQKWka5j2fxnc9hcEA=;
        b=LTOACvOYK6zESiQl66UnQ7DJc0XVFk2W+3ZcWB0Rh5WH/NZvLmNXRpPSWBOichAnoP
         2g0hZZWnrbv9wUk+S42xYS8fPkr32T4J4usvDl87PgtB0bzJvFEx0/lR5GTwv8vOFyiI
         MI3X7kDKSITArWLq2tH+sY5cCdth29IadZSMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ir9ttkQ1CiAYtX6fgzXb09UuqQKWka5j2fxnc9hcEA=;
        b=GTX8wy11gOehQqgS+57iVgZ8WTuKL7Oajy/v4mFiiZDV0iwu77VRJqv2jDw2pUzBmS
         7bhTON0icqWJmOjYsCVVCu5CSRdolAlQGjDW9jtMv2CMXWuwbNK/j1+q5qqoxGtSoxlL
         KhV9mQoIpC9SMpBrTxQD/Fmy1G/ELFkVZSA6ukepV+qWBmnAe6MpNFeLu48Cf7ZU3nxd
         qbsnXvBffGRiA5KGz8869Y30FhcK47BygkovyTsXEmU2SCiM71ZpegJmFQOeEaIAjkx3
         /l0ZHA42VXzf5J/riR5FufSH+ONIQLUuRL/T/UExxJArH8dRh9ptuAjm+OcCafAj2KOU
         L7uA==
X-Gm-Message-State: APjAAAVdI/UZ//g0KSsyHWspsxtOmX/fTw2TXxdoyEMI6UyZYieqGAO+
        9+wAvFJzJf61pD60D7+2Uysrrg==
X-Google-Smtp-Source: APXvYqzso6tZ3hLHXqe337MC2CP8eYYa3qyuTeXpVi7bJB0rvs89dMhkDiLAQYAUc6DUIdL3rYiBUg==
X-Received: by 2002:a63:e654:: with SMTP id p20mr5953582pgj.345.1552692851693;
        Fri, 15 Mar 2019 16:34:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e8sm4101829pfn.103.2019.03.15.16.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 16:34:11 -0700 (PDT)
Date:   Fri, 15 Mar 2019 16:34:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     hpa@zytor.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
Message-ID: <20190315233410.GE112750@google.com>
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
 <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
 <9C4AC321-B808-40B4-B16A-B3E28DFA3591@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9C4AC321-B808-40B4-B16A-B3E28DFA3591@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Mar 15, 2019 at 03:08:57PM -0700, hpa@zytor.com wrote:
> On March 15, 2019 3:06:37 PM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >On Fri, Mar 15, 2019 at 1:54 PM Matthias Kaehlcke <mka@chromium.org>
> >wrote:
> >>
> >> The compiler may emit calls to __lshrti3 from the compiler runtime
> >> library, which results in undefined references:
> >>
> >> arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
> >>   include/linux/math64.h:186: undefined reference to `__lshrti3'
> >
> >Looks like Clang will emit this at -Oz (but not -O2):
> >https://godbolt.org/z/w1_2YC
> >
> >>
> >> Add a copy of the __lshrti3 libgcc routine (from gcc v4.9.2).
> >
> >Has it changed since? If so why not a newer version of libgcc_s?
> >
> >>
> >> Include the function for x86 builds with clang, which is the
> >> environment where the above error was observed.
> >>
> >> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >> ---
> >>  arch/x86/Kconfig       |  1 +
> >>  include/linux/libgcc.h | 16 ++++++++++++++++
> >>  lib/Kconfig            |  3 +++
> >>  lib/Makefile           |  1 +
> >>  lib/lshrti3.c          | 31 +++++++++++++++++++++++++++++++
> >>  5 files changed, 52 insertions(+)
> >>  create mode 100644 lib/lshrti3.c
> >>
> >> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >> index c1f9b3cf437c..a5e0d923845d 100644
> >> --- a/arch/x86/Kconfig
> >> +++ b/arch/x86/Kconfig
> >> @@ -105,6 +105,7 @@ config X86
> >>         select GENERIC_IRQ_PROBE
> >>         select GENERIC_IRQ_RESERVATION_MODE
> >>         select GENERIC_IRQ_SHOW
> >> +       select GENERIC_LIB_LSHRTI3              if CC_IS_CLANG
> >>         select GENERIC_PENDING_IRQ              if SMP
> >>         select GENERIC_SMP_IDLE_THREAD
> >>         select GENERIC_STRNCPY_FROM_USER
> >> diff --git a/include/linux/libgcc.h b/include/linux/libgcc.h
> >> index 32e1e0f4b2d0..a71036471838 100644
> >> --- a/include/linux/libgcc.h
> >> +++ b/include/linux/libgcc.h
> >> @@ -22,15 +22,26 @@
> >>  #include <asm/byteorder.h>
> >>
> >>  typedef int word_type __attribute__ ((mode (__word__)));
> >> +typedef int TItype __attribute__ ((mode (TI)));
> >
> >Well that's an interesting new compiler attribute.
> >https://stackoverflow.com/questions/4559025/what-does-gcc-attribute-modexx-actually-do
> >Please use `__mode(TI)` from include/linux/compiler_attributes.h ex.
> >typedef int TItype __mode(TI);
> >
> >>
> >>  #ifdef __BIG_ENDIAN
> >>  struct DWstruct {
> >>         int high, low;
> >>  };
> >> +
> >> +struct DWstruct128 {
> >> +       long long high, low;
> >> +};
> >> +
> >>  #elif defined(__LITTLE_ENDIAN)
> >>  struct DWstruct {
> >>         int low, high;
> >>  };
> >> +
> >> +struct DWstruct128 {
> >> +       long long low, high;
> >> +};
> >> +
> >>  #else
> >>  #error I feel sick.
> >>  #endif
> >> @@ -40,4 +51,9 @@ typedef union {
> >>         long long ll;
> >>  } DWunion;
> >>
> >> +typedef union {
> >> +       struct DWstruct128 s;
> >> +       TItype ll;
> >> +} DWunion128;
> >> +
> >>  #endif /* __ASM_LIBGCC_H */
> >> diff --git a/lib/Kconfig b/lib/Kconfig
> >> index a9e56539bd11..369e10259ea6 100644
> >> --- a/lib/Kconfig
> >> +++ b/lib/Kconfig
> >> @@ -624,6 +624,9 @@ config GENERIC_LIB_ASHRDI3
> >>  config GENERIC_LIB_LSHRDI3
> >>         bool
> >>
> >> +config GENERIC_LIB_LSHRTI3
> >> +       bool
> >> +
> >>  config GENERIC_LIB_MULDI3
> >>         bool
> >>
> >> diff --git a/lib/Makefile b/lib/Makefile
> >> index 4e066120a0d6..42648411f451 100644
> >> --- a/lib/Makefile
> >> +++ b/lib/Makefile
> >> @@ -277,6 +277,7 @@ obj-$(CONFIG_PARMAN) += parman.o
> >>  obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
> >>  obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
> >>  obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
> >> +obj-$(CONFIG_GENERIC_LIB_LSHRTI3) += lshrti3.o
> >>  obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
> >>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
> >>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
> >> diff --git a/lib/lshrti3.c b/lib/lshrti3.c
> >> new file mode 100644
> >> index 000000000000..2d2123bb3030
> >> --- /dev/null
> >> +++ b/lib/lshrti3.c
> >> @@ -0,0 +1,31 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include <linux/export.h>
> >> +#include <linux/libgcc.h>
> >> +
> >> +long long __lshrti3(long long u, word_type b)
> >> +{
> >> +       DWunion128 uu, w;
> >> +       word_type bm;
> >> +
> >> +       if (b == 0)
> >> +               return u;
> >> +
> >> +       uu.ll = u;
> >> +       bm = 64 - b;
> >> +
> >> +       if (bm <= 0) {
> >> +               w.s.high = 0;
> >> +               w.s.low = (unsigned long long) uu.s.high >> -bm;
> >> +       } else {
> >> +               const unsigned long long carries =
> >> +                       (unsigned long long) uu.s.high << bm;
> >> +               w.s.high = (unsigned long long) uu.s.high >> b;
> >> +               w.s.low = ((unsigned long long) uu.s.low >> b) |
> >carries;
> >> +       }
> >> +
> >> +       return w.ll;
> >> +}
> >> +#ifndef BUILD_VDSO
> >> +EXPORT_SYMBOL(__lshrti3);
> >> +#endif
> >
> >I don't think you want this.  Maybe that was carried over from
> >https://lkml.org/lkml/2019/3/15/669
> >by accident?  The above linkage error mentions arch/x86/kvm/x86.o
> >which I wouldn't expect to be linked into the VDSO image?
> 
> If we compile with the default ABI we can simply link with libgcc;
> with -mregparm=3 all versions of gcc are broken.

I suppose you refer to linking the VDSO against libgcc? Would this be
acceptable (as opposed to linking the kernel against it)?
