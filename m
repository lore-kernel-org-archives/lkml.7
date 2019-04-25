Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDAE20878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vcbq47qD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfDYURo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:17:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40312 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfDYURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:17:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so392083pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fA5KHm6WYeqpbYfv6EOm14l5ImEX/Mjdl/+EKZUHPNk=;
        b=Vcbq47qDVPeF8IWnK7max0BflmgJkP/VmZSdCFTqJLYPbNIOsdYWCc+p/4EOYkkNhy
         tnCqIsZW5upw4Jo4iffX+PjdGqktr/fJObI4vSTvKSyUnq2cszeZIV9ivAKMNyR6iXIk
         hrZihzPyOkEgedegO1/lRZcvbKKBlf9eLeAeI0yJglExsJD2fjMTM+kZHk/AcsoVsht4
         HO9MFEu55YLkWOO3L9IQVDGXMN+bEBWZuh5hn0GYMNloari/j16lOxIRGjeIvOiSTo9g
         +7wDhecQCFYmj3aTgmamVMn2REZPUi1QFQocJC+2LhiGETiQJvj5fWjEZ1UK7Zmnc6l5
         Q4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fA5KHm6WYeqpbYfv6EOm14l5ImEX/Mjdl/+EKZUHPNk=;
        b=YFwOU0k867oPhYeUU7CpOJ24zCGa1vNdxqFi0WTyNxie71vArYs0XQhvF5a9hRYx3F
         2LkxKWrwBQonfIT7RNhiewREoYTNEqfTGLOWVCtOgzq1WMP2//ErCuG19tQjZQ7/VCWy
         DAzB2dv30c99ELvHqlpdOI1glYKqg2dg4SF/UsdR6XnVx5bsKamOMRA99dHuZBzCdymQ
         Jop3QmniY03zlKwF0hfWKbf8ao1bQMrvOBFFplgVYeH3puqtXCBzKzTJIcBbVIvag5s3
         Xkvzku9HViRZ8GsFmuRLo/im0+iMNcw27Tma5KtHY8QiVHjSuQvWYilC1J8RRKHgsUsW
         yAiw==
X-Gm-Message-State: APjAAAV9q1WTolYiPY31xi6yPhTBI2ngU/fs3lL9x9S8lKcziqRdQNZ6
        3POW+Wn5Ww6y8siCYkLAKhjD3LTp4ng=
X-Google-Smtp-Source: APXvYqw0Jw7SDAvQhijd6DulFd4/QSMb1rNE5tFSJiOnCpdjd7KC8iuteodKG/6pa2bIqLGYuboCzg==
X-Received: by 2002:a65:484a:: with SMTP id i10mr39358793pgs.408.1556223460514;
        Thu, 25 Apr 2019 13:17:40 -0700 (PDT)
Received: from localhost ([134.134.139.92])
        by smtp.gmail.com with ESMTPSA id w23sm33833071pgj.72.2019.04.25.13.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 13:17:39 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:17:39 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Apr 2019 13:16:38 PDT (-0700)
Subject:     Re: [2/3] RISC-V: Update tlb flush counters
In-Reply-To: <20190410224449.10877-3-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, bp@alien8.de,
        gary@garyguo.net, hpa@zytor.com, mingo@redhat.com,
        linux-riscv@lists.infradead.org, luc.vanoostenryck@gmail.com,
        tglx@linutronix.de,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-beb18d22-55b3-4a5f-9e29-a560ab168dff@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 15:44:48 PDT (-0700), atish.patra@wdc.com wrote:
> The TLB flush counters under vmstat seems to be very helpful while
> debugging TLB flush performance in RISC-V.
>
> Update the counters in every TLB flush methods respectively.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/tlbflush.h |  5 +++++
>  arch/riscv/mm/tlbflush.c          | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 29a780ca232a..19779a083f52 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -9,6 +9,7 @@
>  #define _ASM_RISCV_TLBFLUSH_H
>
>  #include <linux/mm_types.h>
> +#include <linux/vmstat.h>
>
>  /*
>   * Flush entire local TLB.  'sfence.vma' implicitly fences with the instruction
> @@ -16,11 +17,13 @@
>   */
>  static inline void local_flush_tlb_all(void)
>  {
> +	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>  	__asm__ __volatile__ ("sfence.vma" : : : "memory");
>  }
>
>  static inline void local_flush_tlb_mm(struct mm_struct *mm)
>  {
> +	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>  	/* Flush ASID 0 so that global mappings are not affected */
>  	__asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (0) : "memory");
>  }
> @@ -28,6 +31,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
>  static inline void local_flush_tlb_page(struct vm_area_struct *vma,
>  	unsigned long addr)
>  {
> +	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
>  	__asm__ __volatile__ ("sfence.vma %0, %1"
>  			      : : "r" (addr), "r" (0)
>  			      : "memory");
> @@ -35,6 +39,7 @@ static inline void local_flush_tlb_page(struct vm_area_struct *vma,
>
>  static inline void local_flush_tlb_kernel_page(unsigned long addr)
>  {
> +	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
>  	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
>  }
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index ceee76f14a0a..8072d7da32bb 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -4,6 +4,8 @@
>   */
>
>  #include <linux/mm.h>
> +#include <linux/vmstat.h>
> +#include <linux/cpumask.h>
>  #include <asm/sbi.h>
>
>  #define SFENCE_VMA_FLUSH_ALL ((unsigned long) -1)
> @@ -110,6 +112,7 @@ static void ipi_remote_sfence_vma(void *info)
>  	unsigned long size = data->size;
>  	unsigned long i;
>
> +	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
>  	if (size == SFENCE_VMA_FLUSH_ALL) {
>  		local_flush_tlb_all();
>  	}
> @@ -129,6 +132,8 @@ static void ipi_remote_sfence_vma_asid(void *info)
>  	unsigned long size = data->size;
>  	unsigned long i;
>
> +	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
> +	/* Flush entire MM context */
>  	if (size == SFENCE_VMA_FLUSH_ALL) {
>  		__asm__ __volatile__ ("sfence.vma x0, %0"
>  				      : : "r" (asid)
> @@ -158,6 +163,13 @@ static void remote_sfence_vma(unsigned long start, unsigned long size)
>  static void remote_sfence_vma_asid(cpumask_t *mask, unsigned long start,
>  				   unsigned long size, unsigned long asid)
>  {
> +	int cpuid = smp_processor_id();
> +
> +	if (cpumask_equal(mask, cpumask_of(cpuid)))
> +		count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
> +	else
> +		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
> +
>  	if (tlbi_ipi) {
>  		struct tlbi info = {
>  			.start = start,

Looks good, but it's not applying on for-next (based on rc6).  Do you mind
re-spinning the patches?

