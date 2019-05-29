Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19454C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED31923B8C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfE2PLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:11:40 -0400
Received: from foss.arm.com ([217.140.101.70]:47848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2PLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:11:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19717341;
        Wed, 29 May 2019 08:11:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B701F3F5AF;
        Wed, 29 May 2019 08:11:37 -0700 (PDT)
Date:   Wed, 29 May 2019 16:11:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 4/4] arm64/mm: Drop vm_fault_t argument from
 __do_page_fault()
Message-ID: <20190529151134.GH31777@lakrids.cambridge.arm.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
 <1559133285-27986-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559133285-27986-5-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 06:04:45PM +0530, Anshuman Khandual wrote:
> __do_page_fault() is over complicated with multiple goto statements. This
> cleans up code flow and while there drops the vm_fault_t argument.
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com> 
> Cc: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/mm/fault.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 170c71f..a53a30e 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -397,37 +397,31 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
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
> -	 * Ok, we have a good vm_area for this memory access, so we can handle
> -	 * it.
> +	 * Check if the VMA has got the required permssion with respect
> +	 * to the access fault here.
>  	 */

We already had a perfectly good comment for this check:

	/*
	 * Check that the permissions on the VMA allow for the fault which
	 * occurred.
	 */

... so please keep that and minimize the diff.

> -good_area:
> +	if (!(vma->vm_flags & vm_flags))
> +		return VM_FAULT_BADACCESS;
> +
>  	/*
> -	 * Check that the permissions on the VMA allow for the fault which
> -	 * occurred.
> +	 * There is a valid VMA for this access. But before proceeding
> +	 * make sure that it has required flags if there is an attempt
> +	 * to expand the stack downwards.
>  	 */

I think we can drop this comment, given we didn't have it previously.

> -	if (!(vma->vm_flags & vm_flags)) {
> -		fault = VM_FAULT_BADACCESS;
> -		goto out;
> -	}
> +	if (unlikely(vma->vm_start > addr)) {
> +		if (!(vma->vm_flags & VM_GROWSDOWN))
> +			return VM_FAULT_BADMAP;
>  
> +		if (expand_stack(vma, addr))
> +			return VM_FAULT_BADMAP;

You can drop the line space between these two if statements.

> +	}
>  	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags);
> -
> -check_stack:
> -	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
> -		goto good_area;
> -out:
> -	return fault;

We used to check the stack before the checknig the rest of the vm_flags,
so this changes the precedence of the VM_FAULT_BADMAP and
VM_FAULT_BADACCESS return codes.

Please check the stack before checking the other vm_flags.

Otherwise, this looks like a nice cleanup -- the old control flow was
hideous.

Thanks,
Mark.
