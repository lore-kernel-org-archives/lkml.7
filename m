Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E9C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED8A21903
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbfGWLzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:55:21 -0400
Received: from foss.arm.com ([217.140.110.172]:53516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730821AbfGWLzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:55:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D35F0337;
        Tue, 23 Jul 2019 04:55:19 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B56943F71A;
        Tue, 23 Jul 2019 04:55:18 -0700 (PDT)
Date:   Tue, 23 Jul 2019 12:55:16 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Takao Indoh <indou.takao@jp.fujitsu.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        QI Fuli <qi.fuli@fujitsu.com>,
        Takao Indoh <indou.takao@fujitsu.com>
Subject: Re: [PATCH 1/2] arm64: mm: Restore mm_cpumask (revert commit
 38d96287504a ("arm64: mm: kill mm_cpumask usage"))
Message-ID: <20190723115516.GA16928@arrakis.emea.arm.com>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <20190617143255.10462-2-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617143255.10462-2-indou.takao@jp.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know Will is on the case but just expressing some thoughts of my own.

On Mon, Jun 17, 2019 at 11:32:54PM +0900, Takao Indoh wrote:
> From: Takao Indoh <indou.takao@fujitsu.com>
> 
> mm_cpumask was deleted by the commit 38d96287504a ("arm64: mm: kill
> mm_cpumask usage") because it was not used at that time. Now this is needed
> to find appropriate CPUs for TLB flush, so this patch reverts this commit.
> 
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> Signed-off-by: Takao Indoh <indou.takao@fujitsu.com>
> ---
>  arch/arm64/include/asm/mmu_context.h | 7 ++++++-
>  arch/arm64/kernel/smp.c              | 6 ++++++
>  arch/arm64/mm/context.c              | 2 ++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 2da3e478fd8f..21ef11590bcb 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -241,8 +241,13 @@ static inline void
>  switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	  struct task_struct *tsk)
>  {
> -	if (prev != next)
> +	unsigned int cpu = smp_processor_id();
> +
> +	if (prev != next) {
>  		__switch_mm(next);
> +		cpumask_clear_cpu(cpu, mm_cpumask(prev));
> +		local_flush_tlb_mm(prev);
> +	}

That's not actually a revert as we've never flushed the TLBs on the
switch_mm() path. Also, this flush is not sufficient on a CnP capable
CPU since another thread of the same CPU could have the prev TTBR0_EL1
value set and loading the TLB back.

-- 
Catalin
