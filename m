Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AF4C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADEA23B05
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfE2OxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:53:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47446 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfE2OxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:53:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07741341;
        Wed, 29 May 2019 07:53:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3F8E3F5AF;
        Wed, 29 May 2019 07:53:15 -0700 (PDT)
Date:   Wed, 29 May 2019 15:53:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 3/4] arm64/mm: Consolidate page fault information capture
Message-ID: <20190529145312.GG31777@lakrids.cambridge.arm.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
 <1559133285-27986-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559133285-27986-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 06:04:44PM +0530, Anshuman Khandual wrote:
> This consolidates page fault information capture and move them bit earlier.
> While here it also adds an wrapper is_write_abort(). It also saves some
> cycles by replacing multiple user_mode() calls into a single one earlier
> during the fault.

To be honest, I doubt this has any measureable impact, but I agree that
using variables _may_ make the flow control easier to understand.

> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com> 
> Cc: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/mm/fault.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index da02678..170c71f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -435,6 +435,11 @@ static bool is_el0_instruction_abort(unsigned int esr)
>  	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
>  }
>  
> +static bool is_write_abort(unsigned int esr)
> +{
> +	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
> +}

In off-list review, I mentioned that this isn't true for EL1, and I
think that we should name this 'is_el0_write_abort()' or add a comment
explaining the caveats if factored into a helper.

Thanks,
Mark.

> +
>  static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  				   struct pt_regs *regs)
>  {
> @@ -443,6 +448,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	vm_fault_t fault, major = 0;
>  	unsigned long vm_flags = VM_READ | VM_WRITE;
>  	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> +	bool is_user = user_mode(regs);
> +	bool is_el0_exec = is_el0_instruction_abort(esr);
> +	bool is_write = is_write_abort(esr);
>  
>  	if (notify_page_fault(regs, esr))
>  		return 0;
> @@ -454,12 +462,12 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	if (faulthandler_disabled() || !mm)
>  		goto no_context;
>  
> -	if (user_mode(regs))
> +	if (is_user)
>  		mm_flags |= FAULT_FLAG_USER;
>  
> -	if (is_el0_instruction_abort(esr)) {
> +	if (is_el0_exec) {
>  		vm_flags = VM_EXEC;
> -	} else if ((esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM)) {
> +	} else if (is_write) {
>  		vm_flags = VM_WRITE;
>  		mm_flags |= FAULT_FLAG_WRITE;
>  	}
> @@ -487,7 +495,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	 * we can bug out early if this is from code which shouldn't.
>  	 */
>  	if (!down_read_trylock(&mm->mmap_sem)) {
> -		if (!user_mode(regs) && !search_exception_tables(regs->pc))
> +		if (!is_user && !search_exception_tables(regs->pc))
>  			goto no_context;
>  retry:
>  		down_read(&mm->mmap_sem);
> @@ -498,7 +506,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  		 */
>  		might_sleep();
>  #ifdef CONFIG_DEBUG_VM
> -		if (!user_mode(regs) && !search_exception_tables(regs->pc)) {
> +		if (!is_user && !search_exception_tables(regs->pc)) {
>  			up_read(&mm->mmap_sem);
>  			goto no_context;
>  		}
> @@ -516,7 +524,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  		 * in __lock_page_or_retry in mm/filemap.c.
>  		 */
>  		if (fatal_signal_pending(current)) {
> -			if (!user_mode(regs))
> +			if (!is_user)
>  				goto no_context;
>  			return 0;
>  		}
> @@ -561,7 +569,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	 * If we are in kernel mode at this point, we have no context to
>  	 * handle this fault with.
>  	 */
> -	if (!user_mode(regs))
> +	if (!is_user)
>  		goto no_context;
>  
>  	if (fault & VM_FAULT_OOM) {
> -- 
> 2.7.4
> 
