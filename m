Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A78C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2747020B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="thDMYxZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfDVRwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:52:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38957 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfDVRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:52:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id l18so6048930pgj.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BVfIoaRzcFgswyb/ZmlPJirKbp+PRUX6kpqCr5EiX4=;
        b=thDMYxZBsodJaZILDA+kgqawRCy77cHFDOq6Ct5eFjOk5gsyqAnlKKMWV8ozuZF5Z4
         OYU5ONOr7R9wG0UNx4cAmUFdVke8i8oI6UP/rG76oSjskfSfF7icpwMIX/okyvoRLMz4
         RSYjeHT0p50s1m5r1uuOM1fmtsZqvPoGLXFFyY4/s6hU7JsHYV1QhL7V6sVTEOCuYyem
         c5Fqt52x/R1Jd3YsQ24ppFYx45WzIYfe3lnXGEL67+3fmaT6h638nib71ckTSahVGvPD
         Z84Hin5Gt4MLJp4ySCp8lJ2xtNf2JGz6C+gxzpuA4qibINL/FGCo2HXCJeUY2ykpFeij
         CXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BVfIoaRzcFgswyb/ZmlPJirKbp+PRUX6kpqCr5EiX4=;
        b=foMN77m3OyUgxr0dKd9kiQNOGOxSsUcUsFSYYhUfsMSGoG433JxQz5FNlkLPEImAgO
         dcX6xoIkvJhuldrO3LaZzpNBk+Ds+R95W4ove0rLbD40URV0HTuwGRJQCzbrc3k8ljdz
         X6af4zyV+3tFWy5nOWKrKOlPXCkXepnZ8dHwXmU+5MG9uq8B5NEhe1CuA3c/1Sg+gjYm
         dXRJhg28VP/Gmce//q/LS1aA9a7Pt4ubruG7Zz2nzfcaIZEFmYmBZ7mlZ8XYdxfQkbiu
         pyfupl4UhjArYZhob97u1Fe5jU9p4DnLqt5anVeX6d17y4yN0qK9lCLh/huaC3GTNfbK
         EpPA==
X-Gm-Message-State: APjAAAU/qeBoXgn0aHS5CKN5JIp+dvzpRX8oSlH+yMTiyChaactGTjsF
        6okgcTQU15onk8HhuUtBOyG5NwaLQKYk0QCdaJjZag==
X-Google-Smtp-Source: APXvYqx+M27NyHnFWWv+9hyx/JpZW+54B57Kwqcq8wmbCLE4R6JmUvBo/7C9srs44+nbrt7rguTzszFXAE/v9BMCFs4=
X-Received: by 2002:a63:84c7:: with SMTP id k190mr20089806pgd.255.1555955519734;
 Mon, 22 Apr 2019 10:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190415083605.2560074-1-arnd@arndb.de> <20190415083605.2560074-4-arnd@arndb.de>
In-Reply-To: <20190415083605.2560074-4-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Apr 2019 10:51:48 -0700
Message-ID: <CAKwvOd=761wDZ-g-E7kqOFCftH=CONpzc52WU0-ZQztZ3U=x4w@mail.gmail.com>
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

On Mon, Apr 15, 2019 at 1:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The arch/s390/boot directory is built with its own set of compiler
> options that does not include -Wno-pointer-sign like the rest of
> the kernel does, this causes a lot of harmess but correct warnings

s/harmess/harmless/

> when building with clang.
>
> For the atomics, we can add type casts to avoid the warnings, for
> everything else the easiest way is to slightly adapt the types
> to be more consistent.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/boot/ipl_parm.c       |  2 +-
>  arch/s390/include/asm/bitops.h  | 12 ++++++------
>  arch/s390/include/asm/ebcdic.h  |  2 +-
>  arch/s390/include/asm/lowcore.h |  2 +-
>  drivers/s390/char/sclp.h        |  4 ++--
>  5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
> index 36beb56de021..3f2f0a9f1dad 100644
> --- a/arch/s390/boot/ipl_parm.c
> +++ b/arch/s390/boot/ipl_parm.c
> @@ -51,7 +51,7 @@ void store_ipl_parmblock(void)
>                 early_ipl_block_valid = 1;
>  }
>
> -static size_t scpdata_length(const char *buf, size_t count)
> +static size_t scpdata_length(const u8 *buf, size_t count)
>  {
>         while (count) {
>                 if (buf[count - 1] != '\0' && buf[count - 1] != ' ')
> diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
> index d1f8a4d94cca..9900d655014c 100644
> --- a/arch/s390/include/asm/bitops.h
> +++ b/arch/s390/include/asm/bitops.h
> @@ -73,7 +73,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *ptr)
>         }
>  #endif
>         mask = 1UL << (nr & (BITS_PER_LONG - 1));
> -       __atomic64_or(mask, addr);
> +       __atomic64_or(mask, (long *)addr);
>  }
>
>  static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
> @@ -94,7 +94,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
>         }
>  #endif
>         mask = ~(1UL << (nr & (BITS_PER_LONG - 1)));
> -       __atomic64_and(mask, addr);
> +       __atomic64_and(mask, (long *)addr);
>  }
>
>  static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
> @@ -115,7 +115,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
>         }
>  #endif
>         mask = 1UL << (nr & (BITS_PER_LONG - 1));
> -       __atomic64_xor(mask, addr);
> +       __atomic64_xor(mask, (long *)addr);
>  }
>
>  static inline int
> @@ -125,7 +125,7 @@ test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
>         unsigned long old, mask;
>
>         mask = 1UL << (nr & (BITS_PER_LONG - 1));
> -       old = __atomic64_or_barrier(mask, addr);
> +       old = __atomic64_or_barrier(mask, (long *)addr);
>         return (old & mask) != 0;
>  }
>
> @@ -136,7 +136,7 @@ test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
>         unsigned long old, mask;
>
>         mask = ~(1UL << (nr & (BITS_PER_LONG - 1)));
> -       old = __atomic64_and_barrier(mask, addr);
> +       old = __atomic64_and_barrier(mask, (long *)addr);
>         return (old & ~mask) != 0;
>  }
>
> @@ -147,7 +147,7 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
>         unsigned long old, mask;
>
>         mask = 1UL << (nr & (BITS_PER_LONG - 1));
> -       old = __atomic64_xor_barrier(mask, addr);
> +       old = __atomic64_xor_barrier(mask, (long *)addr);

Thanks for the follow up.  This hunk and above all LGTM.

>         return (old & mask) != 0;
>  }
>
> diff --git a/arch/s390/include/asm/ebcdic.h b/arch/s390/include/asm/ebcdic.h
> index 29441beb92e6..d3ce6adacb10 100644
> --- a/arch/s390/include/asm/ebcdic.h
> +++ b/arch/s390/include/asm/ebcdic.h
> @@ -20,7 +20,7 @@ extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
>  extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
>
>  static inline void
> -codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
> +codepage_convert(const __u8 *codepage, volatile char* addr, unsigned long nr)
>  {
>         if (nr-- <= 0)
>                 return;

There are many call sites of ASCEBC which is defined in terms of this
function. Do they all use `char*`?  grep shows an explicit cast to
`unsigned char*` in drivers/s390/char/tape_std.c for example.

> diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> index cc0947e08b6f..f3a637afd485 100644
> --- a/arch/s390/include/asm/lowcore.h
> +++ b/arch/s390/include/asm/lowcore.h
> @@ -128,7 +128,7 @@ struct lowcore {
>         /* SMP info area */
>         __u32   cpu_nr;                         /* 0x0398 */
>         __u32   softirq_pending;                /* 0x039c */
> -       __u32   preempt_count;                  /* 0x03a0 */
> +       __s32   preempt_count;                  /* 0x03a0 */

This change is less obvious. Do you still have the warning for that
this hunk fixes?

>         __u32   spinlock_lockval;               /* 0x03a4 */
>         __u32   spinlock_index;                 /* 0x03a8 */
>         __u32   fpu_flags;                      /* 0x03ac */
> diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
> index 367e9d384d85..5918479ffa0e 100644
> --- a/drivers/s390/char/sclp.h
> +++ b/drivers/s390/char/sclp.h
> @@ -365,14 +365,14 @@ sclp_ascebc(unsigned char ch)
>
>  /* translate string from EBCDIC to ASCII */
>  static inline void
> -sclp_ebcasc_str(unsigned char *str, int nr)
> +sclp_ebcasc_str(char *str, int nr)
>  {
>         (MACHINE_IS_VM) ? EBCASC(str, nr) : EBCASC_500(str, nr);
>  }
>
>  /* translate string from ASCII to EBCDIC */
>  static inline void
> -sclp_ascebc_str(unsigned char *str, int nr)
> +sclp_ascebc_str(char *str, int nr)
>  {
>         (MACHINE_IS_VM) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
>  }
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
