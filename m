Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1319DCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97D1222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="pUdAa7J2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437421AbfJRFVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:21:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43179 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJRFVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:21:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so4721103wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMtJ/rq4br1ldAroW8Dm9Xv9y05Fk6K5c9x3oKp9k7Q=;
        b=pUdAa7J2Gehc3Z5S9pU0pPhmaabw9SjD3IScdYFCqeiH3a9/O0nd+npGP8SCaXV7ud
         Mq/tpXJ03zoiJlySIp+C2bLcFQE3kz3xaUxLuoAgZsHlPhtDFPgaJgtQMwLCgRcyLqKl
         pdNCMoaioINJYJGKaVPopoS23vLTZ8HYzl0/Toz2zbNO7gNdxWPh+lUW8akLY5nFvoaB
         kR88ZMGqusSaZpH70Hpwo8f62b5xlkn/owvdAxJezCkYbdpfqMAygH4I6W6zwMcqPTrZ
         jBxqiBp9fNjosicT7b99eNAyLeQ51Exl8xFWH245qIEAIQFebZQvModDW1RNp3gphBe/
         N/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMtJ/rq4br1ldAroW8Dm9Xv9y05Fk6K5c9x3oKp9k7Q=;
        b=l9NlFYldSqrVPYL8e3JlyFcmr6Xfa75RZjOiK3LxEfLj2hKNX6R83gvjUUYyoX51Ss
         obj3ZjUXMxMPkqH8vMdPV+ZdPuMltskh73rz+2IPv7M70kVxntPhcG9w7HBjItQlc8YH
         5fnZ9aPCBqVOCTwKe6BOGONMe1Q2e8hE6l0QZ6O0lwZEOQtq+qLz/GH4UaU+y02x7cHs
         4UEtNULoV+QxXgEmZBVjNBAkVrYYcTP8t5YzO7s+CY3MSwhFz2UJ2S4R5yYqo4lQB3jT
         OEjYMNV0Yj2KfztCpbzizaQz6b0XA9yAl4cH8ndOEYatMsWB0s0x2yTzZNmY/Jt9JUk2
         kw6w==
X-Gm-Message-State: APjAAAW9k29JZMtWCpWqTxxK2lHssUtpWeR0boCvoC7T/94swFFRFB24
        YU43SH+KdD7IPmLff3DnWPVPF6tI5m11/EI7r7cKWMiQ
X-Google-Smtp-Source: APXvYqyzL5PfqPUeOPJfIRSruOHCy55CDY3oAd0o+CVn7dWhpcrArUiDxTSajhvUF6JsyyNVFOA2Vcdi1oVTjp+LITs=
X-Received: by 2002:a5d:440b:: with SMTP id z11mr5349333wrq.309.1571367051591;
 Thu, 17 Oct 2019 19:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-2-hch@lst.de>
In-Reply-To: <20191017173743.5430-2-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:20:40 +0530
Message-ID: <CAAhSdy2fKnGbNHQHaxcthEsVDX_Jv3ZqPWHfmqn1gpB4sPho5g@mail.gmail.com>
Subject: Re: [PATCH 01/15] riscv: cleanup <asm/bug.h>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:07 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Remove various not required ifdefs and externs.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/bug.h | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index 07ceee8b1747..75604fec1b1b 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -12,7 +12,6 @@
>
>  #include <asm/asm.h>
>
> -#ifdef CONFIG_GENERIC_BUG
>  #define __INSN_LENGTH_MASK  _UL(0x3)
>  #define __INSN_LENGTH_32    _UL(0x3)
>  #define __COMPRESSED_INSN_MASK _UL(0xffff)
> @@ -20,7 +19,6 @@
>  #define __BUG_INSN_32  _UL(0x00100073) /* ebreak */
>  #define __BUG_INSN_16  _UL(0x9002) /* c.ebreak */
>
> -#ifndef __ASSEMBLY__
>  typedef u32 bug_insn_t;
>
>  #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
> @@ -43,6 +41,7 @@ typedef u32 bug_insn_t;
>         RISCV_SHORT " %2"
>  #endif
>
> +#ifdef CONFIG_GENERIC_BUG
>  #define __BUG_FLAGS(flags)                                     \
>  do {                                                           \
>         __asm__ __volatile__ (                                  \
> @@ -58,14 +57,10 @@ do {                                                                \
>                   "i" (flags),                                  \
>                   "i" (sizeof(struct bug_entry)));              \
>  } while (0)
> -
> -#endif /* !__ASSEMBLY__ */
>  #else /* CONFIG_GENERIC_BUG */
> -#ifndef __ASSEMBLY__
>  #define __BUG_FLAGS(flags) do {                                        \
>         __asm__ __volatile__ ("ebreak\n");                      \
>  } while (0)
> -#endif /* !__ASSEMBLY__ */
>  #endif /* CONFIG_GENERIC_BUG */
>
>  #define BUG() do {                                             \
> @@ -79,15 +74,10 @@ do {                                                                \
>
>  #include <asm-generic/bug.h>
>
> -#ifndef __ASSEMBLY__
> -
>  struct pt_regs;
>  struct task_struct;
>
> -extern void die(struct pt_regs *regs, const char *str);
> -extern void do_trap(struct pt_regs *regs, int signo, int code,
> -       unsigned long addr);
> -
> -#endif /* !__ASSEMBLY__ */
> +void die(struct pt_regs *regs, const char *str);
> +void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr);
>
>  #endif /* _ASM_RISCV_BUG_H */
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
