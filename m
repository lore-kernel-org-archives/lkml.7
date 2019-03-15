Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E85BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E117E218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfCOWMb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:12:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35253 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfCOWMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:12:31 -0400
Received: from [IPv6:2607:fb90:363e:8b8e:45:329:f804:e0bb] ([IPv6:2607:fb90:363e:8b8e:45:329:f804:e0bb])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2FMCBS11753937
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 15 Mar 2019 15:12:11 -0700
Date:   Fri, 15 Mar 2019 15:12:08 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com> <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From:   hpa@zytor.com
Message-ID: <18F0D032-4FC4-4194-A2F4-B7ED68C2C5F2@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 15, 2019 3:06:37 PM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
>On Fri, Mar 15, 2019 at 1:54 PM Matthias Kaehlcke <mka@chromium.org>
>wrote:
>>
>> The compiler may emit calls to __lshrti3 from the compiler runtime
>> library, which results in undefined references:
>>
>> arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
>>   include/linux/math64.h:186: undefined reference to `__lshrti3'
>
>Looks like Clang will emit this at -Oz (but not -O2):
>https://godbolt.org/z/w1_2YC
>
>>
>> Add a copy of the __lshrti3 libgcc routine (from gcc v4.9.2).
>
>Has it changed since? If so why not a newer version of libgcc_s?
>
>>
>> Include the function for x86 builds with clang, which is the
>> environment where the above error was observed.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  arch/x86/Kconfig       |  1 +
>>  include/linux/libgcc.h | 16 ++++++++++++++++
>>  lib/Kconfig            |  3 +++
>>  lib/Makefile           |  1 +
>>  lib/lshrti3.c          | 31 +++++++++++++++++++++++++++++++
>>  5 files changed, 52 insertions(+)
>>  create mode 100644 lib/lshrti3.c
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index c1f9b3cf437c..a5e0d923845d 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -105,6 +105,7 @@ config X86
>>         select GENERIC_IRQ_PROBE
>>         select GENERIC_IRQ_RESERVATION_MODE
>>         select GENERIC_IRQ_SHOW
>> +       select GENERIC_LIB_LSHRTI3              if CC_IS_CLANG
>>         select GENERIC_PENDING_IRQ              if SMP
>>         select GENERIC_SMP_IDLE_THREAD
>>         select GENERIC_STRNCPY_FROM_USER
>> diff --git a/include/linux/libgcc.h b/include/linux/libgcc.h
>> index 32e1e0f4b2d0..a71036471838 100644
>> --- a/include/linux/libgcc.h
>> +++ b/include/linux/libgcc.h
>> @@ -22,15 +22,26 @@
>>  #include <asm/byteorder.h>
>>
>>  typedef int word_type __attribute__ ((mode (__word__)));
>> +typedef int TItype __attribute__ ((mode (TI)));
>
>Well that's an interesting new compiler attribute.
>https://stackoverflow.com/questions/4559025/what-does-gcc-attribute-modexx-actually-do
>Please use `__mode(TI)` from include/linux/compiler_attributes.h ex.
>typedef int TItype __mode(TI);
>
>>
>>  #ifdef __BIG_ENDIAN
>>  struct DWstruct {
>>         int high, low;
>>  };
>> +
>> +struct DWstruct128 {
>> +       long long high, low;
>> +};
>> +
>>  #elif defined(__LITTLE_ENDIAN)
>>  struct DWstruct {
>>         int low, high;
>>  };
>> +
>> +struct DWstruct128 {
>> +       long long low, high;
>> +};
>> +
>>  #else
>>  #error I feel sick.
>>  #endif
>> @@ -40,4 +51,9 @@ typedef union {
>>         long long ll;
>>  } DWunion;
>>
>> +typedef union {
>> +       struct DWstruct128 s;
>> +       TItype ll;
>> +} DWunion128;
>> +
>>  #endif /* __ASM_LIBGCC_H */
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index a9e56539bd11..369e10259ea6 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -624,6 +624,9 @@ config GENERIC_LIB_ASHRDI3
>>  config GENERIC_LIB_LSHRDI3
>>         bool
>>
>> +config GENERIC_LIB_LSHRTI3
>> +       bool
>> +
>>  config GENERIC_LIB_MULDI3
>>         bool
>>
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 4e066120a0d6..42648411f451 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -277,6 +277,7 @@ obj-$(CONFIG_PARMAN) += parman.o
>>  obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
>>  obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
>>  obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
>> +obj-$(CONFIG_GENERIC_LIB_LSHRTI3) += lshrti3.o
>>  obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
>> diff --git a/lib/lshrti3.c b/lib/lshrti3.c
>> new file mode 100644
>> index 000000000000..2d2123bb3030
>> --- /dev/null
>> +++ b/lib/lshrti3.c
>> @@ -0,0 +1,31 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/export.h>
>> +#include <linux/libgcc.h>
>> +
>> +long long __lshrti3(long long u, word_type b)
>> +{
>> +       DWunion128 uu, w;
>> +       word_type bm;
>> +
>> +       if (b == 0)
>> +               return u;
>> +
>> +       uu.ll = u;
>> +       bm = 64 - b;
>> +
>> +       if (bm <= 0) {
>> +               w.s.high = 0;
>> +               w.s.low = (unsigned long long) uu.s.high >> -bm;
>> +       } else {
>> +               const unsigned long long carries =
>> +                       (unsigned long long) uu.s.high << bm;
>> +               w.s.high = (unsigned long long) uu.s.high >> b;
>> +               w.s.low = ((unsigned long long) uu.s.low >> b) |
>carries;
>> +       }
>> +
>> +       return w.ll;
>> +}
>> +#ifndef BUILD_VDSO
>> +EXPORT_SYMBOL(__lshrti3);
>> +#endif
>
>I don't think you want this.  Maybe that was carried over from
>https://lkml.org/lkml/2019/3/15/669
>by accident?  The above linkage error mentions arch/x86/kvm/x86.o
>which I wouldn't expect to be linked into the VDSO image?

Or just "u64"...
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
