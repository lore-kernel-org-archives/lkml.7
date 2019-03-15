Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FEAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1751A218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8LYmT80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfCOWGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:06:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34173 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfCOWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:06:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id v64so7255282pfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GffhP1lzT/9QnGTLJuMoGy+pwIvjorMbN0edjXFgvwA=;
        b=c8LYmT80gU9Xmy923nSLf1+9R4P9q3sb11tYHIhIidZS5nyy5pT7kF1b3lkywuaiDa
         OYv6DWkLBt796OBSFGOrSXg6eHo3jjZaMhZj0eNkgJWyyYi8u3bKPqIubNXtRTqFh2eQ
         OuF54AHrG4qo7UGYytAbF3LAgpT5zQqYlHROS615ZRvWYi/pFFlh8d5CtbY1Cm9/Dl6X
         8m/gcQ5W9RZ6cVc1glkjIbept6QLA260S6ny29Z9l5d5y9ZWwY6xRZw4etUnIr2ofM8x
         4tAuIS2R33OyT9zN5g2zXi6RQC9XCPe+ZHJOghAw8u2+wExUdu0f60VxbwRJSBP7xKRf
         MC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GffhP1lzT/9QnGTLJuMoGy+pwIvjorMbN0edjXFgvwA=;
        b=jf0w4RxHA/Ji5ohWvjSPZXqy8RXUHGcukSJyTG5hG/IGCHwQZ39RIbuQUVX9hHXXfm
         ZoYltV8TI3Ua1N1x2T4Vh73PXQIZFNIU7A8V8aL10BUT32iFF35rapZvCd12hxiY4Of7
         5+2RvhVT+Co1iF/fhShlW2ftSfpp6KJ8+7je08Cz4eiCSVO0S5Wfu7ZICydsc5rzIy8s
         PUL28a0s97eAsihRPufiewy7uhDz5NH8e941mK623rBBBttYOvbgdrsjgipBP65oQXLC
         rl2dt18AWMHZevaQWPyZJq1DkWt0ezMpJpkSzfQCf7Z7x7SIwIxlfbzCzBs87oSqyVxd
         g5gQ==
X-Gm-Message-State: APjAAAU6gk4QRxkQXUdl5Lx2d9jB55e2a0/o+R8WQRalONp9ALN3IFaX
        dnkK2I/c5Vwt51AllCFpMJ3stiHvaBoyXOeQO/elqg==
X-Google-Smtp-Source: APXvYqxdKjV3Y4oQ43rVOb9CSyNJCfMwR5HeBAGejZe3GJ1Gmv9h6A7503eSjj8ZMoPjfDP7JMWr9YIa2PGj0Pz4vJ4=
X-Received: by 2002:a63:5a20:: with SMTP id o32mr5372773pgb.225.1552687608418;
 Fri, 15 Mar 2019 15:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
In-Reply-To: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Mar 2019 15:06:37 -0700
Message-ID: <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
Subject: Re: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
To:     Matthias Kaehlcke <mka@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 1:54 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The compiler may emit calls to __lshrti3 from the compiler runtime
> library, which results in undefined references:
>
> arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
>   include/linux/math64.h:186: undefined reference to `__lshrti3'

Looks like Clang will emit this at -Oz (but not -O2):
https://godbolt.org/z/w1_2YC

>
> Add a copy of the __lshrti3 libgcc routine (from gcc v4.9.2).

Has it changed since? If so why not a newer version of libgcc_s?

>
> Include the function for x86 builds with clang, which is the
> environment where the above error was observed.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/x86/Kconfig       |  1 +
>  include/linux/libgcc.h | 16 ++++++++++++++++
>  lib/Kconfig            |  3 +++
>  lib/Makefile           |  1 +
>  lib/lshrti3.c          | 31 +++++++++++++++++++++++++++++++
>  5 files changed, 52 insertions(+)
>  create mode 100644 lib/lshrti3.c
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c1f9b3cf437c..a5e0d923845d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -105,6 +105,7 @@ config X86
>         select GENERIC_IRQ_PROBE
>         select GENERIC_IRQ_RESERVATION_MODE
>         select GENERIC_IRQ_SHOW
> +       select GENERIC_LIB_LSHRTI3              if CC_IS_CLANG
>         select GENERIC_PENDING_IRQ              if SMP
>         select GENERIC_SMP_IDLE_THREAD
>         select GENERIC_STRNCPY_FROM_USER
> diff --git a/include/linux/libgcc.h b/include/linux/libgcc.h
> index 32e1e0f4b2d0..a71036471838 100644
> --- a/include/linux/libgcc.h
> +++ b/include/linux/libgcc.h
> @@ -22,15 +22,26 @@
>  #include <asm/byteorder.h>
>
>  typedef int word_type __attribute__ ((mode (__word__)));
> +typedef int TItype __attribute__ ((mode (TI)));

Well that's an interesting new compiler attribute.
https://stackoverflow.com/questions/4559025/what-does-gcc-attribute-modexx-actually-do
Please use `__mode(TI)` from include/linux/compiler_attributes.h ex.
typedef int TItype __mode(TI);

>
>  #ifdef __BIG_ENDIAN
>  struct DWstruct {
>         int high, low;
>  };
> +
> +struct DWstruct128 {
> +       long long high, low;
> +};
> +
>  #elif defined(__LITTLE_ENDIAN)
>  struct DWstruct {
>         int low, high;
>  };
> +
> +struct DWstruct128 {
> +       long long low, high;
> +};
> +
>  #else
>  #error I feel sick.
>  #endif
> @@ -40,4 +51,9 @@ typedef union {
>         long long ll;
>  } DWunion;
>
> +typedef union {
> +       struct DWstruct128 s;
> +       TItype ll;
> +} DWunion128;
> +
>  #endif /* __ASM_LIBGCC_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index a9e56539bd11..369e10259ea6 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -624,6 +624,9 @@ config GENERIC_LIB_ASHRDI3
>  config GENERIC_LIB_LSHRDI3
>         bool
>
> +config GENERIC_LIB_LSHRTI3
> +       bool
> +
>  config GENERIC_LIB_MULDI3
>         bool
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 4e066120a0d6..42648411f451 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -277,6 +277,7 @@ obj-$(CONFIG_PARMAN) += parman.o
>  obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
>  obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
>  obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
> +obj-$(CONFIG_GENERIC_LIB_LSHRTI3) += lshrti3.o
>  obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
> diff --git a/lib/lshrti3.c b/lib/lshrti3.c
> new file mode 100644
> index 000000000000..2d2123bb3030
> --- /dev/null
> +++ b/lib/lshrti3.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/libgcc.h>
> +
> +long long __lshrti3(long long u, word_type b)
> +{
> +       DWunion128 uu, w;
> +       word_type bm;
> +
> +       if (b == 0)
> +               return u;
> +
> +       uu.ll = u;
> +       bm = 64 - b;
> +
> +       if (bm <= 0) {
> +               w.s.high = 0;
> +               w.s.low = (unsigned long long) uu.s.high >> -bm;
> +       } else {
> +               const unsigned long long carries =
> +                       (unsigned long long) uu.s.high << bm;
> +               w.s.high = (unsigned long long) uu.s.high >> b;
> +               w.s.low = ((unsigned long long) uu.s.low >> b) | carries;
> +       }
> +
> +       return w.ll;
> +}
> +#ifndef BUILD_VDSO
> +EXPORT_SYMBOL(__lshrti3);
> +#endif

I don't think you want this.  Maybe that was carried over from
https://lkml.org/lkml/2019/3/15/669
by accident?  The above linkage error mentions arch/x86/kvm/x86.o
which I wouldn't expect to be linked into the VDSO image?
-- 
Thanks,
~Nick Desaulniers
