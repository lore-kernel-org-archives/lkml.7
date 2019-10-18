Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111D3CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD702222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="wp/0Fljr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442062AbfJRFpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:45:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46785 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395467AbfJRFpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:45:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so4746384wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2q04YyZCM/Y6pG2YfTJ87FPtLWST+udBScdMOgSCybA=;
        b=wp/0Fljr7FKzaAAjHiELGcBO2MBzYFb3WAHCKN2gWiKfdN3vbVJj0CJBtTNt1Ip3Um
         XJ+0HPYP6nSkopngeeKUUHaSeHNqUD4n0JQ42me/qDadwWJ29ZIMF7Y05nPpl0QBRqAw
         EJ1CYwJ1bj0QAfRDk6cRraD6k7YnUYdxwjO2kwecL0HSRAx2TzRTpil2DNvC/swOVq/4
         YaKq50Sjn4Kq+BIZrzssPJYFWmgR5fKZwqrOUEmrD2YEqCI3RIdZ83DSeprd3VK7iDE6
         ip5Tu4VUb3OvyGrDIUM5RtgHdYhhVUz9DQ8tXeIARNBVBL9Vl1KbJWOW+40UGm6QCqH/
         6KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2q04YyZCM/Y6pG2YfTJ87FPtLWST+udBScdMOgSCybA=;
        b=krhzP+WwAAJIUBTEsQWemRZheryWlTgOiWli/nzSawfdL0fZ8ozF4XBG6eTcaFDgCE
         GLEG+t6+66UWe+BDvC4Cwe9/Xf6Aj/E7cRcfCgvJJ39FKRS7V7OL2MIXfHXpu1qOwGM0
         boqhrZMEZzDHcXkAhbJkw10o4Gl4xyW9Tz4ViCmElCzMoUOUQhKlRqmUk9dIG9ZhcnkE
         7zzdQfHPC444XGu1FgvLgSneO7FL/7ovGUelfykUswQxs48ywv2ksHpzkSajrV9elDmh
         rlkZ0YePtsD/O9DlprRnUKwzd79t//L/RNEArLJ1f4opG+r2Ls6oQxyINZlV0DygEZEy
         2E6A==
X-Gm-Message-State: APjAAAXFnX1/cMbEOdjE73jkn2oq7xQrXwt6ed+jYynFamjUWWKwzrvF
        nyiIknvxvQBM+CtSGpsC9vprj2Uyycl9l1bQTjyKj79Kn+I=
X-Google-Smtp-Source: APXvYqw+kT7L4okfWQnJGTlaxVb3SG2O2Mm0cc0zb+BRP+yT5R0kSZXnWzsi8ELl1o1vA/xXtDWk1ljCWhsCHVJ8+C0=
X-Received: by 2002:adf:8567:: with SMTP id 94mr2627476wrh.65.1571367925553;
 Thu, 17 Oct 2019 20:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-13-hch@lst.de>
In-Reply-To: <20191017173743.5430-13-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:35:14 +0530
Message-ID: <CAAhSdy2mjtH68Ce+h4u3pa79pB-Vs_iu1zfRRcGoaYr=r6xnQw@mail.gmail.com>
Subject: Re: [PATCH 12/15] riscv: clear the instruction cache and all
 registers when booting
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

On Thu, Oct 17, 2019 at 11:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> When we get booted we want a clear slate without any leaks from previous
> supervisors or the firmware.  Flush the instruction cache and then clear
> all registers to known good values.  This is really important for the
> upcoming nommu support that runs on M-mode, but can't really harm when
> running in S-mode either.  Vaguely based on the concepts from opensbi.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/csr.h |  1 +
>  arch/riscv/kernel/head.S     | 88 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index d0b5113e1a54..ee0101278608 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -83,6 +83,7 @@
>  /* symbolic CSR names: */
>  #define CSR_MHARTID            0xf14
>  #define CSR_MSTATUS            0x300
> +#define CSR_MISA               0x301
>  #define CSR_MIE                        0x304
>  #define CSR_MTVEC              0x305
>  #define CSR_MSCRATCH           0x340
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 583784cb3a32..25867b99cc95 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -11,6 +11,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/page.h>
>  #include <asm/csr.h>
> +#include <asm/hwcap.h>
>  #include <asm/image.h>
>
>  __INIT
> @@ -51,12 +52,18 @@ _start_kernel:
>         csrw CSR_XIP, zero
>
>  #ifdef CONFIG_RISCV_M_MODE
> +       /* flush the instruction cache */
> +       fence.i
> +
> +       /* Reset all registers except ra, a0, a1 */
> +       call reset_regs
> +
>         /*
>          * The hartid in a0 is expected later on, and we have no firmware
>          * to hand it to us.
>          */
>         csrr a0, CSR_MHARTID
> -#endif
> +#endif /* CONFIG_RISCV_M_MODE */
>
>         /* Load the global pointer */
>  .option push
> @@ -203,6 +210,85 @@ relocate:
>         j .Lsecondary_park
>  END(_start)
>
> +#ifdef CONFIG_RISCV_M_MODE
> +ENTRY(reset_regs)
> +       li      sp, 0
> +       li      gp, 0
> +       li      tp, 0
> +       li      t0, 0
> +       li      t1, 0
> +       li      t2, 0
> +       li      s0, 0
> +       li      s1, 0
> +       li      a2, 0
> +       li      a3, 0
> +       li      a4, 0
> +       li      a5, 0
> +       li      a6, 0
> +       li      a7, 0
> +       li      s2, 0
> +       li      s3, 0
> +       li      s4, 0
> +       li      s5, 0
> +       li      s6, 0
> +       li      s7, 0
> +       li      s8, 0
> +       li      s9, 0
> +       li      s10, 0
> +       li      s11, 0
> +       li      t3, 0
> +       li      t4, 0
> +       li      t5, 0
> +       li      t6, 0
> +       csrw    sscratch, 0
> +
> +#ifdef CONFIG_FPU
> +       csrr    t0, CSR_MISA
> +       andi    t0, t0, (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
> +       bnez    t0, .Lreset_regs_done
> +
> +       li      t1, SR_FS
> +       csrs    CSR_XSTATUS, t1
> +       fmv.s.x f0, zero
> +       fmv.s.x f1, zero
> +       fmv.s.x f2, zero
> +       fmv.s.x f3, zero
> +       fmv.s.x f4, zero
> +       fmv.s.x f5, zero
> +       fmv.s.x f6, zero
> +       fmv.s.x f7, zero
> +       fmv.s.x f8, zero
> +       fmv.s.x f9, zero
> +       fmv.s.x f10, zero
> +       fmv.s.x f11, zero
> +       fmv.s.x f12, zero
> +       fmv.s.x f13, zero
> +       fmv.s.x f14, zero
> +       fmv.s.x f15, zero
> +       fmv.s.x f16, zero
> +       fmv.s.x f17, zero
> +       fmv.s.x f18, zero
> +       fmv.s.x f19, zero
> +       fmv.s.x f20, zero
> +       fmv.s.x f21, zero
> +       fmv.s.x f22, zero
> +       fmv.s.x f23, zero
> +       fmv.s.x f24, zero
> +       fmv.s.x f25, zero
> +       fmv.s.x f26, zero
> +       fmv.s.x f27, zero
> +       fmv.s.x f28, zero
> +       fmv.s.x f29, zero
> +       fmv.s.x f30, zero
> +       fmv.s.x f31, zero
> +       csrw    fcsr, 0
> +       /* note that the caller must clear SR_FS */
> +#endif /* CONFIG_FPU */
> +.Lreset_regs_done:
> +       ret
> +END(reset_regs)
> +#endif /* CONFIG_RISCV_M_MODE */
> +
>  __PAGE_ALIGNED_BSS
>         /* Empty zero page */
>         .balign PAGE_SIZE
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
