Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB97C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABF120678
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IhX+gfX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLBX7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:59:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45692 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLBX7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:59:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1so613028pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YT4uEP8VQn4YJkJtyGgPiJyFzwEjXrAA5S6YuB+2oi8=;
        b=IhX+gfX151SePSf80mnvPgfzBNoi7l160I1leUO8vw4z6sGDLcawYqngZmXTaYaA75
         GJinrWzAwG2n5eF9F9+S6HuQdd7ZtVcd6T+4BeESFGHTPpYjlXj0pIDtaErhR4vmX+tZ
         JvR7D8JR6oeDxcGX58aa31OkGssNtqY1w0yHn/sUhAbF5ID4rwBZFjzw5tXUwWmNwX0k
         cIGxjhmmgZxRm4xWQCKHgneT9Mm//RPE9y1iQ1zdNGAIOZzXzmaIM52vl69TwHXOmaVF
         GqBpXQq31FdJplaUh3xKALDCK5RxmVYE9HrniTz7crfD7HKthBIqbjB6xX9YiYlN/kHs
         6gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YT4uEP8VQn4YJkJtyGgPiJyFzwEjXrAA5S6YuB+2oi8=;
        b=ktXY4Al6PNGSd1kTmTWx6GrC7kyO9qwy1N85LxLcAeGpo5OWyIUaJ9Uy2Z+5IsNGi1
         C4uNUTVWzFz1ho7SW8H2h4E4JSfLDxUxDwvQNvHs1mlbgJqwHbmeGwO/WbI1bP8fEecP
         8Nt9258iBnndIrd0Y41UQLkDxUEgyMsaZEo0pozc355xQFWRMeyVRHFaGwhKmozxCZ0O
         UdRXPiRmYc9BU+ZMxLyvNyy1sJ6agYLmCE5Zv8yjOAgVvEld6PWQMx7WV4iTlVoKl7fV
         HnKWWvpBUGjTDpw84Gvnv7LBhaZaHFEhdrATqamFR9fyugFh5eYEvpzCGZICjsvCaEQh
         rA+Q==
X-Gm-Message-State: APjAAAVF7mfwnlsIyZfClPgyVYiyk5itiKtRRLDn+tiwqFTcUIaFHlyE
        cUCGk+FqMNk1DqRs+7ZDsXDAkXClNVI=
X-Google-Smtp-Source: APXvYqykaR/R8TB3hQac8uHJ7QdwdCLs0KiSo+C3wn7tXDCMm9hYQ7g5cySoXmTQM2Gjg5ylFx9ebw==
X-Received: by 2002:a63:3404:: with SMTP id b4mr1966314pga.438.1575331185704;
        Mon, 02 Dec 2019 15:59:45 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id 203sm618912pfy.185.2019.12.02.15.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:59:45 -0800 (PST)
Date:   Mon, 02 Dec 2019 15:59:45 -0800 (PST)
X-Google-Original-Date: Mon, 02 Dec 2019 15:55:49 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v5 1/4] RISC-V: Mark existing SBI as 0.1 SBI.
In-Reply-To: <20191126190503.19303-2-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        alexios.zavras@intel.com, linux-riscv@lists.infradead.org,
        han_mao@c-sky.com, rppt@linux.ibm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-18ffe96a-7a03-475f-ae9b-2d450fc3d29e@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 11:05:00 PST (-0800), Atish Patra wrote:
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
> Reviewed-by: Anup Patel <anup@brainfault.org>
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
> -#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({		\
> +#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \
>  	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
>  	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
>  	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
> @@ -43,48 +43,50 @@
>
>  static inline void sbi_console_putchar(int ch)
>  {
> -	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
> +	SBI_CALL_1(SBI_EXT_0_1_CONSOLE_PUTCHAR, ch);
>  }
>
>  static inline int sbi_console_getchar(void)
>  {
> -	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
> +	return SBI_CALL_0(SBI_EXT_0_1_CONSOLE_GETCHAR);
>  }
>
>  static inline void sbi_set_timer(uint64_t stime_value)
>  {
>  #if __riscv_xlen == 32
> -	SBI_CALL_2(SBI_SET_TIMER, stime_value, stime_value >> 32);
> +	SBI_CALL_2(SBI_EXT_0_1_SET_TIMER, stime_value,
> +			  stime_value >> 32);
>  #else
> -	SBI_CALL_1(SBI_SET_TIMER, stime_value);
> +	SBI_CALL_1(SBI_EXT_0_1_SET_TIMER, stime_value);
>  #endif
>  }
>
>  static inline void sbi_shutdown(void)
>  {
> -	SBI_CALL_0(SBI_SHUTDOWN);
> +	SBI_CALL_0(SBI_EXT_0_1_SHUTDOWN);
>  }
>
>  static inline void sbi_clear_ipi(void)
>  {
> -	SBI_CALL_0(SBI_CLEAR_IPI);
> +	SBI_CALL_0(SBI_EXT_0_1_CLEAR_IPI);
>  }
>
>  static inline void sbi_send_ipi(const unsigned long *hart_mask)
>  {
> -	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
> +	SBI_CALL_1(SBI_EXT_0_1_SEND_IPI, hart_mask);
>  }
>
>  static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
>  {
> -	SBI_CALL_1(SBI_REMOTE_FENCE_I, hart_mask);
> +	SBI_CALL_1(SBI_EXT_0_1_REMOTE_FENCE_I, hart_mask);
>  }
>
>  static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
>  					 unsigned long start,
>  					 unsigned long size)
>  {
> -	SBI_CALL_3(SBI_REMOTE_SFENCE_VMA, hart_mask, start, size);
> +	SBI_CALL_3(SBI_EXT_0_1_REMOTE_SFENCE_VMA, hart_mask,
> +			  start, size);
>  }
>
>  static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> @@ -92,7 +94,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  					      unsigned long size,
>  					      unsigned long asid)
>  {
> -	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
> +	SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
> +			  start, size, asid);
>  }
>  #else /* CONFIG_RISCV_SBI */
>  /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
