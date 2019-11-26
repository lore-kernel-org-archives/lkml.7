Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D583AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B295206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Qb7enzkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKZEKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:10:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33430 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfKZEKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 23:10:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so20781640wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 20:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDU9SOnEXlxmjpW27p7gTfRh1I6Y2z5UwP4peUS5RXo=;
        b=Qb7enzkJG72Y47JjTS9HYx9+YQyJsgtL8sosNOnYvSiu9ml63Xoe2+/NDoBc6MqbJW
         9LGDACQsosWnZ9H6nto87PFQjkqmT+bHBhgVp14MuabqgTkAZSGbNXRg01oq7+tPq3UK
         s1qLlJ6zrBRz/UIyf+2oSyyQPoSR4od4rc2jPBzJ8qSsW/9qeMNAyajIv0nG091310fo
         fKrciO/juyLrocXzi1q+4IrXnjZS81MbS+D4YrAw0MPLEb2Wyd6V9m57xAGdM8Doxe99
         oeiXbCFKWKN2hxrWU+Olqipi1ylfBErK8roMloI1S7XLPABfpvgUaVeWjiCPk17x19G2
         tsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDU9SOnEXlxmjpW27p7gTfRh1I6Y2z5UwP4peUS5RXo=;
        b=TDJfbyBpJzH+KdzRv/yn8n0GkRzyq1WVmn92RfXXYYsRbrIQvB0dnDMVPXTDhwCrUV
         R01bnSqwH8gwemcCJKiO083rgFr5GYFU3UF7eUu99IvG/l/COkMCTzEU1vM3RJICzqg8
         PYuE6+yoItsfGo9l/rlgS04aaNobcuW1nJHJIL6/9XqWGCkhKHd7W14Uhq+qdrXkmdr8
         0JhSjGxhABQkZthH0O7mlxCf6+z/ASzZJjtp2PghNx1PZiLKn4eBiJwCrVbCBTfTU5wm
         NQBuF9brpRc1kCdhGmobRsHvk59m0kV8afYrqElt7L2COPW2zAix1LPjzyj6pu/e+lRH
         BmYQ==
X-Gm-Message-State: APjAAAWYNTjbgynep8McM2rYnolqjgYNxTTdPAdKGhIjA0oONGcksq3r
        UbOs0Dq1T1xJ+tr5+UoN+uEUxaH/kas8ssowsFUYmQ==
X-Google-Smtp-Source: APXvYqzpjKgt7Sqwc9NkQuq+/SvLVJOjWLtIa1ls1rKXoC2qKJOPtk/als4efzrusjaGAlGagPLvXQb/CSdLG9xCtDw=
X-Received: by 2002:a5d:6b4d:: with SMTP id x13mr33167179wrw.96.1574741433222;
 Mon, 25 Nov 2019 20:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20191126032033.14825-1-atish.patra@wdc.com> <20191126032033.14825-2-atish.patra@wdc.com>
In-Reply-To: <20191126032033.14825-2-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 26 Nov 2019 09:40:22 +0530
Message-ID: <CAAhSdy0cvPbUxCzPH5u63=byjNeu2cmah_DscYf_mSx0a6eynA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] RISC-V: Mark existing SBI as 0.1 SBI.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 8:50 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> As per the new SBI specification, current SBI implementation version
> is defined as 0.1 and will be removed/replaced in future. Each of the
> function call in 0.1 is defined as a separate extension which makes
> easier to replace them one at a time.
>
> Rename existing implementation to reflect that. This patch is just
> a preparatory patch for SBI v0.2 and doesn't introduce any functional
> changes.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 43 +++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 2570c1e683d3..96aaee270ded 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -9,17 +9,17 @@
>  #include <linux/types.h>
>
>  #ifdef CONFIG_RISCV_SBI
> -#define SBI_SET_TIMER 0
> -#define SBI_CONSOLE_PUTCHAR 1
> -#define SBI_CONSOLE_GETCHAR 2
> -#define SBI_CLEAR_IPI 3
> -#define SBI_SEND_IPI 4
> -#define SBI_REMOTE_FENCE_I 5
> -#define SBI_REMOTE_SFENCE_VMA 6
> -#define SBI_REMOTE_SFENCE_VMA_ASID 7
> -#define SBI_SHUTDOWN 8
> +#define SBI_EXT_0_1_SET_TIMER 0x0
> +#define SBI_EXT_0_1_CONSOLE_PUTCHAR 0x1
> +#define SBI_EXT_0_1_CONSOLE_GETCHAR 0x2
> +#define SBI_EXT_0_1_CLEAR_IPI 0x3
> +#define SBI_EXT_0_1_SEND_IPI 0x4
> +#define SBI_EXT_0_1_REMOTE_FENCE_I 0x5
> +#define SBI_EXT_0_1_REMOTE_SFENCE_VMA 0x6
> +#define SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID 0x7
> +#define SBI_EXT_0_1_SHUTDOWN 0x8
>
> -#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \
> +#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \
>         register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);   \
>         register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);   \
>         register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);   \
> @@ -43,48 +43,50 @@
>
>  static inline void sbi_console_putchar(int ch)
>  {
> -       SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
> +       SBI_CALL_1(SBI_EXT_0_1_CONSOLE_PUTCHAR, ch);
>  }
>
>  static inline int sbi_console_getchar(void)
>  {
> -       return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
> +       return SBI_CALL_0(SBI_EXT_0_1_CONSOLE_GETCHAR);
>  }
>
>  static inline void sbi_set_timer(uint64_t stime_value)
>  {
>  #if __riscv_xlen == 32
> -       SBI_CALL_2(SBI_SET_TIMER, stime_value, stime_value >> 32);
> +       SBI_CALL_2(SBI_EXT_0_1_SET_TIMER, stime_value,
> +                         stime_value >> 32);
>  #else
> -       SBI_CALL_1(SBI_SET_TIMER, stime_value);
> +       SBI_CALL_1(SBI_EXT_0_1_SET_TIMER, stime_value);
>  #endif
>  }
>
>  static inline void sbi_shutdown(void)
>  {
> -       SBI_CALL_0(SBI_SHUTDOWN);
> +       SBI_CALL_0(SBI_EXT_0_1_SHUTDOWN);
>  }
>
>  static inline void sbi_clear_ipi(void)
>  {
> -       SBI_CALL_0(SBI_CLEAR_IPI);
> +       SBI_CALL_0(SBI_EXT_0_1_CLEAR_IPI);
>  }
>
>  static inline void sbi_send_ipi(const unsigned long *hart_mask)
>  {
> -       SBI_CALL_1(SBI_SEND_IPI, hart_mask);
> +       SBI_CALL_1(SBI_EXT_0_1_SEND_IPI, hart_mask);
>  }
>
>  static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
>  {
> -       SBI_CALL_1(SBI_REMOTE_FENCE_I, hart_mask);
> +       SBI_CALL_1(SBI_EXT_0_1_REMOTE_FENCE_I, hart_mask);
>  }
>
>  static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
>                                          unsigned long start,
>                                          unsigned long size)
>  {
> -       SBI_CALL_3(SBI_REMOTE_SFENCE_VMA, hart_mask, start, size);
> +       SBI_CALL_3(SBI_EXT_0_1_REMOTE_SFENCE_VMA, hart_mask,
> +                         start, size);
>  }
>
>  static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> @@ -92,7 +94,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>                                               unsigned long size,
>                                               unsigned long asid)
>  {
> -       SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
> +       SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
> +                         start, size, asid);
>  }
>  #else /* CONFIG_RISCV_SBI */
>  /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
> --
> 2.23.0
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
