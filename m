Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCBAC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EF820872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="yY5KD/GG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfI0FsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:48:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39108 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfI0FsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:48:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so1208309wrj.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNHNOk7RAkOzjjDpc3+FWKTYKs/qbdc+SGcdmjw2A60=;
        b=yY5KD/GGMJ35MPttTgHk9foQdpE71oxiqLXzKEzQHLMrjrUaQXE0TfU+WE30C+mV81
         wqAbp2aCJa90YNy/Y6YPU5HIyErI6I80I8Kl+vhfLmiO+V3ntvmeu1jKLyMUVLeroSq2
         MOQHOwLQ0o8ssdaT0cs5H7dTcl632Cm+hZ9MamLqGyibDOSu9cbeXWsQrUmY145RAp1h
         09001CgIue4dSD6KpNxNySJIDwORI0sg8zGArZ0n7/8nB6K2SQ5LcG0EtOgW4QXWsM0U
         nQKfs1NI2K8YbSin9smqcs08/SlxV2Gj16lBO5cUba9Au2Sk2A4iXIB/b7wmzELZ1a2H
         v1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNHNOk7RAkOzjjDpc3+FWKTYKs/qbdc+SGcdmjw2A60=;
        b=pcZv8CBYuAd9Ed8xA4K2qPY7D6Q9DybCunCK7FQOmbyUJHdtBRxnqnGlOnvc9gk8FO
         TfI8AgJ+Zcfzb6EwutlOEUAQH4SPZWfpc4fnOAeU15tA0MZQ/U3SCkCdmp6tFb5yCP+c
         a08cg0+ElhcLVPGDOGaKx0N6ZF/jd6TNyyOMmQrJh4s+i0hRXiSxEkFCp4kOUS8966uK
         AJ038kMdvqeDdJNoQDtyB1v4Pi4jZb3cSglKPmKBIdIqKq4WKUTRvMS0bb4LuIJyPtVZ
         Me9+aEhl4+2n6A6r9g9icYE7TSvRqT3usSUQYP/RW84PGvzFffUN17t1BkQ47bVwxsYk
         H7GQ==
X-Gm-Message-State: APjAAAXdvcmyOKa9GpP/M/F2s7c4RmO3xlz5V5SxV9R2L3iGv7pQExhI
        9yGvVWFcgiDdXKlWzqb5+1w/Df2fm7lHOL6oef4+NQ==
X-Google-Smtp-Source: APXvYqzcBC/L+PvVbST/H1UWPRh2Tzz+gQoNHQlWUEhiGxexKbrh66DxGkOAEBw3s9CfNQZ9Z5LxQRLgW53Fe5dnwKk=
X-Received: by 2002:adf:ec44:: with SMTP id w4mr1343622wrn.251.1569563288334;
 Thu, 26 Sep 2019 22:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190927000915.31781-1-atish.patra@wdc.com> <20190927000915.31781-2-atish.patra@wdc.com>
In-Reply-To: <20190927000915.31781-2-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 27 Sep 2019 11:17:56 +0530
Message-ID: <CAAhSdy2o1B+8DtjknNaE=JQty-vfivEhiCHw9jMB9daXTFnKkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] RISC-V: Mark existing SBI as 0.1 SBI.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 5:39 AM Atish Patra <atish.patra@wdc.com> wrote:
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
> index 21134b3ef404..2147f384fad0 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -8,17 +8,17 @@
>
>  #include <linux/types.h>
>
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
> @@ -42,48 +42,50 @@
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
> @@ -91,7 +93,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>                                               unsigned long size,
>                                               unsigned long asid)
>  {
> -       SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
> +       SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
> +                         start, size, asid);
>  }
>
>  #endif
> --
> 2.21.0
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
