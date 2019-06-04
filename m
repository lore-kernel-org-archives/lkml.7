Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E059C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176C723426
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfFDO4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:56:18 -0400
Received: from foss.arm.com ([217.140.101.70]:45960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfFDO4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:56:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E82BC341;
        Tue,  4 Jun 2019 07:56:16 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 664F33F690;
        Tue,  4 Jun 2019 07:56:15 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:56:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 4/4] arm64/mm: Drop local variable vm_fault_t from
 __do_page_fault()
Message-ID: <20190604145612.GM6610@arrakis.emea.arm.com>
References: <1559544085-7502-1-git-send-email-anshuman.khandual@arm.com>
 <1559544085-7502-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559544085-7502-5-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 12:11:25PM +0530, Anshuman Khandual wrote:
> __do_page_fault() is over complicated with multiple goto statements. This
> cleans up the code flow and while there drops local variable vm_fault_t.

I'd change the subject as well here to something like refactor or
simplify __do_page_fault().

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 4bb65f3..41fa905 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -397,37 +397,29 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
>  static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
>  			   unsigned int mm_flags, unsigned long vm_flags)
>  {
> -	struct vm_area_struct *vma;
> -	vm_fault_t fault;
> +	struct vm_area_struct *vma = find_vma(mm, addr);
>  
> -	vma = find_vma(mm, addr);
> -	fault = VM_FAULT_BADMAP;
>  	if (unlikely(!vma))
> -		goto out;
> -	if (unlikely(vma->vm_start > addr))
> -		goto check_stack;
> +		return VM_FAULT_BADMAP;
>  
>  	/*
>  	 * Ok, we have a good vm_area for this memory access, so we can handle
>  	 * it.
>  	 */
> -good_area:
> +	if (unlikely(vma->vm_start > addr)) {
> +		if (!(vma->vm_flags & VM_GROWSDOWN))
> +			return VM_FAULT_BADMAP;
> +		if (expand_stack(vma, addr))
> +			return VM_FAULT_BADMAP;
> +	}

You could have a single return here:

	if (unlikely(vma->vm_start > addr) &&
	    (!(vma->vm_flags & VM_GROWSDOWN) || expand_stack(vma, addr)))
		return VM_FAULT_BADMAP;

Not sure it's any clearer though.

-- 
Catalin
