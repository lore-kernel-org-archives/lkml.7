Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02BAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A08E212F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfFDOmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:42:14 -0400
Received: from foss.arm.com ([217.140.101.70]:45466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfFDOmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:42:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F094A78;
        Tue,  4 Jun 2019 07:42:13 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4656E3F690;
        Tue,  4 Jun 2019 07:42:12 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:42:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH V2 3/4] arm64/mm: Consolidate page fault information
 capture
Message-ID: <20190604144209.GJ6610@arrakis.emea.arm.com>
References: <1559544085-7502-1-git-send-email-anshuman.khandual@arm.com>
 <1559544085-7502-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559544085-7502-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 12:11:24PM +0530, Anshuman Khandual wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index da02678..4bb65f3 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -435,6 +435,14 @@ static bool is_el0_instruction_abort(unsigned int esr)
>  	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
>  }
>  
> +/*
> + * This is applicable only for EL0 write aborts.
> + */
> +static bool is_el0_write_abort(unsigned int esr)
> +{
> +	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
> +}

What makes this EL0 only?

> +
>  static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  				   struct pt_regs *regs)
>  {
> @@ -443,6 +451,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	vm_fault_t fault, major = 0;
>  	unsigned long vm_flags = VM_READ | VM_WRITE;
>  	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> +	bool is_user = user_mode(regs);
> +	bool is_el0_exec = is_el0_instruction_abort(esr);
> +	bool is_el0_write = is_el0_write_abort(esr);
>  
>  	if (notify_page_fault(regs, esr))
>  		return 0;
> @@ -454,12 +465,12 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
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
> +	} else if (is_el0_write) {
>  		vm_flags = VM_WRITE;
>  		mm_flags |= FAULT_FLAG_WRITE;
>  	}

This can be triggered by an EL1 write to a user mapping, so is_el0_write
is misleading.

-- 
Catalin
