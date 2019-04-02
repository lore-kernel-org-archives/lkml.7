Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EA12146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSTj7NOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfDBLdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:33:19 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33513 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDBLdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:33:19 -0400
Received: by mail-ua1-f66.google.com with SMTP id g8so4238429uaj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H0eTdk6uzNDFIwYQK+kuczC2cDXLvK1beowcJIYlzTU=;
        b=dSTj7NOadU4OY9mSZrD/7G9973Ua2Ipb3fgKQIcgJw2kgBuBgpur+PbXKzOHaeW4lg
         jbRWCD7NRhET4zHe7zfu5j6yb6rhmKhpL7mKSPgkggNt6asCzUMEX/jjQE5XVs2+38y8
         qAo9KF5FU+QAxlbh3+3WPIV/7CQHXJVrVzINz+svHx6J7GkSu8OvHnV9CFxDVvA1p0CY
         CNp0yoHOOXxjYmrKQvs8rgnPOVTjiWDq2axmPaNyxiLqYn69PTTHr6DFvsL/JpsqaaIo
         cYbLh5pS8+tQlk1DcVeWYQKt45gni5Ai2WM7e+AEyRY01fdJ+2YraSS+MhRGL8EU9Wjz
         N2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H0eTdk6uzNDFIwYQK+kuczC2cDXLvK1beowcJIYlzTU=;
        b=HXu0I+17qir+ikpdNY/KtJws2Ys693KmWC+D1cm3IEAisd363xloYiFSsLLXJJm52s
         Z834OPOfQ2SsqkyouzuNwN2h7m8+8RSbtq9t7Colsh5zOwRYWe+V8tCtCSJRkkATJM5E
         beY3xBA/9lA57g2NoV3VNp/zXESUcVFwDq1QjDN8kaQap0IVzhS3EbaQt9lZ9Tj6LbHj
         vV2xhpz2T3t0RdMB49z0GEOLiKYQfczlnLrQVE9FYjsLZ+/s6f3lUrom7cXrEansweCc
         R+QBLORULvuYAGGb/TaeEhbSjHOCb6N42UNMqtUEn1YYL/jnPUuuOjkJC++ZeFMKndo1
         7f8Q==
X-Gm-Message-State: APjAAAVYrxZc4WdgNCK7ZR+Y0Og36AIOLGNc4hb0hGRibCS3BA+9/1ta
        lK4iCg81fpdihrEc39IfU0P67CsnRMohheZIh3LHLQ==
X-Google-Smtp-Source: APXvYqzIruEPnAe+rWQc2cCBnYdNxMSX7+0A0W9urs2Ni2HWozZRkkEs+MqTM1kaiQNI9j+4Y8uu6noXMajCKDilKK4=
X-Received: by 2002:ab0:1d82:: with SMTP id l2mr4072065uak.120.1554204797632;
 Tue, 02 Apr 2019 04:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190402112813.193378-1-glider@google.com>
In-Reply-To: <20190402112813.193378-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Apr 2019 13:33:06 +0200
Message-ID: <CAG_fn=Xt4VTMqUq6_WQVHnpLOumsatKcg32+bpUNNhkqXV42xA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/asm: fix assembly constraints in bitops
To:     Paul McKenney <paulmck@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 1:28 PM Alexander Potapenko <glider@google.com> wrot=
e:
>
> 1. Use memory clobber in bitops that touch arbitrary memory
>
> Certain bit operations that read/write bits take a base pointer and an
> arbitrarily large offset to address the bit relative to that base.
> Inline assembly constraints aren't expressive enough to tell the
> compiler that the assembly directive is going to touch a specific memory
> location of unknown size, therefore we have to use the "memory" clobber
> to indicate that the assembly is going to access memory locations other
> than those listed in the inputs/outputs.
> To indicate that BTR/BTS instructions don't necessarily touch the first
> sizeof(long) bytes of the argument, we also move the address to assembly
> inputs.
>
> This particular change leads to size increase of 124 kernel functions in
> a defconfig build. For some of them the diff is in NOP operations, other
> end up re-reading values from memory and may potentially slow down the
> execution. But without these clobbers the compiler is free to cache
> the contents of the bitmaps and use them as if they weren't changed by
> the inline assembly.
>
> 2. Use byte-sized arguments for operations touching single bytes.
>
> Passing a long value to ANDB/ORB/XORB instructions makes the compiler
> treat sizeof(long) bytes as being clobbered, which isn't the case. This
> may theoretically lead to worse code in the case of heavy optimization.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: James Y Knight <jyknight@google.com>
> ---
>  v2:
>   -- renamed the patch
>   -- addressed comment by Peter Zijlstra: don't use "+m" for functions
>   returning void
>   -- fixed input types for operations touching single bytes
> ---
>  arch/x86/include/asm/bitops.h | 41 +++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.=
h
> index d153d570bb04..c0cb9c5d3476 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -36,16 +36,17 @@
>   * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
>   */
>
> -#define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
> +#define RLONG_ADDR(x) "m" (*(volatile long *) (x))
> +#define WBYTE_ADDR(x) "+m" (*(volatile char *) (x))
>
> -#define ADDR                           BITOP_ADDR(addr)
> +#define ADDR                           RLONG_ADDR(addr)
>
>  /*
>   * We do the locked ops that don't return the old value as
>   * a mask operation on a byte.
>   */
>  #define IS_IMMEDIATE(nr)               (__builtin_constant_p(nr))
> -#define CONST_MASK_ADDR(nr, addr)      BITOP_ADDR((void *)(addr) + ((nr)=
>>3))
> +#define CONST_MASK_ADDR(nr, addr)      WBYTE_ADDR((void *)(addr) + ((nr)=
>>3))
>  #define CONST_MASK(nr)                 (1 << ((nr) & 7))
>
>  /**
> @@ -73,7 +74,7 @@ set_bit(long nr, volatile unsigned long *addr)
>                         : "memory");
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> -                       : BITOP_ADDR(addr) : "Ir" (nr) : "memory");
> +                       : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
>         }
>  }
>
> @@ -88,7 +89,7 @@ set_bit(long nr, volatile unsigned long *addr)
>   */
>  static __always_inline void __set_bit(long nr, volatile unsigned long *a=
ddr)
>  {
> -       asm volatile(__ASM_SIZE(bts) " %1,%0" : ADDR : "Ir" (nr) : "memor=
y");
> +       asm volatile(__ASM_SIZE(bts) " %1,%0" : : ADDR, "Ir" (nr) : "memo=
ry");
>  }
>
>  /**
> @@ -110,8 +111,7 @@ clear_bit(long nr, volatile unsigned long *addr)
>                         : "iq" ((u8)~CONST_MASK(nr)));
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
> -                       : BITOP_ADDR(addr)
> -                       : "Ir" (nr));
> +                       : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
>         }
>  }
>
> @@ -131,7 +131,7 @@ static __always_inline void clear_bit_unlock(long nr,=
 volatile unsigned long *ad
>
>  static __always_inline void __clear_bit(long nr, volatile unsigned long =
*addr)
>  {
> -       asm volatile(__ASM_SIZE(btr) " %1,%0" : ADDR : "Ir" (nr));
> +       asm volatile(__ASM_SIZE(btr) " %1,%0" : : ADDR, "Ir" (nr) : "memo=
ry");
>  }
>
>  static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, v=
olatile unsigned long *addr)
> @@ -139,7 +139,7 @@ static __always_inline bool clear_bit_unlock_is_negat=
ive_byte(long nr, volatile
>         bool negative;
>         asm volatile(LOCK_PREFIX "andb %2,%1"
>                 CC_SET(s)
> -               : CC_OUT(s) (negative), ADDR
> +               : CC_OUT(s) (negative), WBYTE_ADDR(addr)
>                 : "ir" ((char) ~(1 << nr)) : "memory");
>         return negative;
>  }
> @@ -155,13 +155,9 @@ static __always_inline bool clear_bit_unlock_is_nega=
tive_byte(long nr, volatile
>   * __clear_bit() is non-atomic and implies release semantics before the =
memory
>   * operation. It can be used for an unlock if no other CPUs can concurre=
ntly
>   * modify other bits in the word.
> - *
> - * No memory barrier is required here, because x86 cannot reorder stores=
 past
> - * older loads. Same principle as spin_unlock.
>   */
>  static __always_inline void __clear_bit_unlock(long nr, volatile unsigne=
d long *addr)
>  {
> -       barrier();
Should have reflected this in the patch description.
>         __clear_bit(nr, addr);
>  }
>
> @@ -176,7 +172,7 @@ static __always_inline void __clear_bit_unlock(long n=
r, volatile unsigned long *
>   */
>  static __always_inline void __change_bit(long nr, volatile unsigned long=
 *addr)
>  {
> -       asm volatile(__ASM_SIZE(btc) " %1,%0" : ADDR : "Ir" (nr));
> +       asm volatile(__ASM_SIZE(btc) " %1,%0" : : ADDR, "Ir" (nr) : "memo=
ry");
>  }
>
>  /**
> @@ -196,8 +192,7 @@ static __always_inline void change_bit(long nr, volat=
ile unsigned long *addr)
>                         : "iq" ((u8)CONST_MASK(nr)));
>         } else {
>                 asm volatile(LOCK_PREFIX __ASM_SIZE(btc) " %1,%0"
> -                       : BITOP_ADDR(addr)
> -                       : "Ir" (nr));
> +                       : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
>         }
>  }
>
> @@ -242,8 +237,8 @@ static __always_inline bool __test_and_set_bit(long n=
r, volatile unsigned long *
>
>         asm(__ASM_SIZE(bts) " %2,%1"
>             CC_SET(c)
> -           : CC_OUT(c) (oldbit), ADDR
> -           : "Ir" (nr));
> +           : CC_OUT(c) (oldbit)
> +           : ADDR, "Ir" (nr) : "memory");
>         return oldbit;
>  }
>
> @@ -282,8 +277,8 @@ static __always_inline bool __test_and_clear_bit(long=
 nr, volatile unsigned long
>
>         asm volatile(__ASM_SIZE(btr) " %2,%1"
>                      CC_SET(c)
> -                    : CC_OUT(c) (oldbit), ADDR
> -                    : "Ir" (nr));
> +                    : CC_OUT(c) (oldbit)
> +                    : ADDR, "Ir" (nr) : "memory");
>         return oldbit;
>  }
>
> @@ -294,8 +289,8 @@ static __always_inline bool __test_and_change_bit(lon=
g nr, volatile unsigned lon
>
>         asm volatile(__ASM_SIZE(btc) " %2,%1"
>                      CC_SET(c)
> -                    : CC_OUT(c) (oldbit), ADDR
> -                    : "Ir" (nr) : "memory");
> +                    : CC_OUT(c) (oldbit)
> +                    : ADDR, "Ir" (nr) : "memory");
>
>         return oldbit;
>  }
> @@ -326,7 +321,7 @@ static __always_inline bool variable_test_bit(long nr=
, volatile const unsigned l
>         asm volatile(__ASM_SIZE(bt) " %2,%1"
>                      CC_SET(c)
>                      : CC_OUT(c) (oldbit)
> -                    : "m" (*(unsigned long *)addr), "Ir" (nr));
> +                    : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory"=
);
>
>         return oldbit;
>  }
> --
> 2.21.0.392.gf8f6787159e-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
