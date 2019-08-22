Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F061C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7711021655
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfHVBqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:46:46 -0400
Received: from verein.lst.de ([213.95.11.211]:42627 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfHVBqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:46:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79BEB68BFE; Thu, 22 Aug 2019 03:46:42 +0200 (CEST)
Date:   Thu, 22 Aug 2019 03:46:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <Anup.Patel@wdc.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3 1/3] RISC-V: Issue a local tlbflush if possible.
Message-ID: <20190822014642.GA11922@lst.de>
References: <20190822004644.25829-1-atish.patra@wdc.com> <20190822004644.25829-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822004644.25829-2-atish.patra@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 05:46:42PM -0700, Atish Patra wrote:
> In RISC-V, tlb flush happens via SBI which is expensive. If the local
> cpu is the only cpu in cpumask, there is no need to invoke a SBI call.
> 
> Just do a local flush and return.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index df93b26f1b9d..36430ee3bed9 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -2,6 +2,7 @@
>  
>  #include <linux/mm.h>
>  #include <linux/smp.h>
> +#include <linux/sched.h>
>  #include <asm/sbi.h>
>  
>  void flush_tlb_all(void)
> @@ -13,9 +14,23 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
>  		unsigned long size)
>  {
>  	struct cpumask hmask;
> +	unsigned int cpuid = get_cpu();
>  
> +	if (!cmask) {
> +		riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
> +		goto issue_sfence;
> +	}
> +
> +	if (cpumask_test_cpu(cpuid, cmask) && cpumask_weight(cmask) == 1) {
> +		local_flush_tlb_all();
> +		goto done;
> +	}

I think a single core on a SMP kernel is a valid enough use case given
how litte distros still have UP kernels.  So Maybe this shiuld rather be:

	if (!cmask)
		cmask = cpu_online_mask;

	if (cpumask_test_cpu(cpuid, cmask) && cpumask_weight(cmask) == 1) {
		local_flush_tlb_all();
	} else {
	 	riscv_cpuid_to_hartid_mask(cmask, &hmask);
	  	sbi_remote_sfence_vma(hmask.bits, start, size);
	}
