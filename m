Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDECCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0665920820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="P7b8jX1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437597AbfJRFxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:53:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54030 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391881AbfJRFxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:53:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so4783216wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKBYmqBKnM/fTox+DxH/j6jDg0wBrXkD7WU8TmLcePI=;
        b=P7b8jX1ijvI/1bRMfMuCiF0DEfoT7NClM6s9cMKR7dPyvouJu3HRaHo0oNEOiIahvW
         LnPgQ7tzaz6FV2kJQH7KN0daOdPvxM/i8MQyIWUjxhfUwumj9stzNXKAyHHcvFdn4OI/
         t8qPLUyAZ+NvrqlrlxFWHnMKvbZHDa0pnlb2cgzexpgcQQzLIjqlxum+EFN5TA1U1mcn
         wjB+Ni93KTrNJB7Ncrk/ysFSdGxHwows7K8UvOp1offJm7vaxd9gggcXKetxJilyGmE5
         y3s8l4JLTbm8cp5/1FfpR+C9aw1JnFbY61P4A8w45w431ia/nPKYBTcieXjzaowvKALO
         4JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKBYmqBKnM/fTox+DxH/j6jDg0wBrXkD7WU8TmLcePI=;
        b=bX/t594LAAupm6OVmcIr2zFI2620J+InaDqVieA8N5uhzlzZYWOr3DlaKbkdPpeMAp
         1yWhB+zTyeZyguGY4NPxsmYBNnJlgQ8QW/TNX8Qt9xDmj00VTk99zZYGqaCxx3XmxYRO
         K6sURlAGsykJBHCqxjLklXLDYCaM9apdwsHw7549fZcYPziFRufvU3DfEiSZm1HfHVPg
         vGlIDiM5EV0yFGgxznyLm31KiTyNZ2idfAezmxZrEwGOATRec/wuGppuvNEzqrCmAWsh
         Ttyiw99E4DiNtoDEErK/cFyzI7EjP3qVTx6qpqTwuu8KtUPAa3QeJIDpElbojyiJEVvs
         PLXQ==
X-Gm-Message-State: APjAAAV+ypQGon2CvU7MKv12dd/+KvzRyDOi4SJZQMYEOwIO9oGfD+T7
        2+LsDbJN8d9bLPwoiR0OA+SZBRLnFWaqv4CIBSJduOHYmvA=
X-Google-Smtp-Source: APXvYqw+zZ6m5fPdynWeKKLdxpqE/Ya5xs97ZcCWMTHNwCMgBFStCutZthRzJj95DpqP7ZHXHVJR1o+avys8gdz7thE=
X-Received: by 2002:a1c:bc07:: with SMTP id m7mr5449292wmf.103.1571367327709;
 Thu, 17 Oct 2019 19:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-8-hch@lst.de>
In-Reply-To: <20191017173743.5430-8-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:25:17 +0530
Message-ID: <CAAhSdy2DpOh2FZUUjiYdHf0Oh-j_RJyXv6AvJDg+DNNfSdJSOw@mail.gmail.com>
Subject: Re: [PATCH 07/15] riscv: implement remote sfence.i using IPIs
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
> The RISC-V ISA only supports flushing the instruction cache for the
> local CPU core.  Currently we always offload the remote TLB flushing to
> the SBI, which then issues an IPI under the hoods.  But with M-mode
> we do not have an SBI so we have to do it ourselves.   IPI to the
> other nodes using the existing kernel helpers instead if we have
> native clint support and thus can IPI directly from the kernel.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/sbi.h |  3 +++
>  arch/riscv/mm/cacheflush.c   | 24 ++++++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index b167af3e7470..0cb74eccc73f 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -94,5 +94,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  {
>         SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
>  }
> +#else /* CONFIG_RISCV_SBI */
> +/* stub to for code is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
> +void sbi_remote_fence_i(const unsigned long *hart_mask);
>  #endif /* CONFIG_RISCV_SBI */
>  #endif /* _ASM_RISCV_SBI_H */
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 3f15938dec89..794c9ab256eb 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -10,9 +10,17 @@
>
>  #include <asm/sbi.h>
>
> +static void ipi_remote_fence_i(void *info)
> +{
> +       return local_flush_icache_all();
> +}
> +
>  void flush_icache_all(void)
>  {
> -       sbi_remote_fence_i(NULL);
> +       if (IS_ENABLED(CONFIG_RISCV_SBI))
> +               sbi_remote_fence_i(NULL);
> +       else
> +               on_each_cpu(ipi_remote_fence_i, NULL, 1);
>  }
>
>  /*
> @@ -28,7 +36,7 @@ void flush_icache_all(void)
>  void flush_icache_mm(struct mm_struct *mm, bool local)
>  {
>         unsigned int cpu;
> -       cpumask_t others, hmask, *mask;
> +       cpumask_t others, *mask;
>
>         preempt_disable();
>
> @@ -46,10 +54,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>          */
>         cpumask_andnot(&others, mm_cpumask(mm), cpumask_of(cpu));
>         local |= cpumask_empty(&others);
> -       if (mm != current->active_mm || !local) {
> -               riscv_cpuid_to_hartid_mask(&others, &hmask);
> -               sbi_remote_fence_i(hmask.bits);
> -       } else {
> +       if (mm == current->active_mm && local) {
>                 /*
>                  * It's assumed that at least one strongly ordered operation is
>                  * performed on this hart between setting a hart's cpumask bit
> @@ -59,6 +64,13 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>                  * with flush_icache_deferred().
>                  */
>                 smp_mb();
> +       } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> +               cpumask_t hartid_mask;
> +
> +               riscv_cpuid_to_hartid_mask(&others, &hartid_mask);
> +               sbi_remote_fence_i(cpumask_bits(&hartid_mask));
> +       } else {
> +               on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
>         }
>
>         preempt_enable();
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
