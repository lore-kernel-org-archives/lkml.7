Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA0FC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7772070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfFFLbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:31:22 -0400
Received: from foss.arm.com ([217.140.101.70]:45846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfFFLbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:31:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61922A78;
        Thu,  6 Jun 2019 04:31:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA95C3F246;
        Thu,  6 Jun 2019 04:31:19 -0700 (PDT)
Date:   Thu, 6 Jun 2019 12:31:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 4/4] arm64/mm: Drop local variable vm_fault_t from
 __do_page_fault()
Message-ID: <20190606113117.GC37821@lakrids.cambridge.arm.com>
References: <1559544085-7502-1-git-send-email-anshuman.khandual@arm.com>
 <1559544085-7502-5-git-send-email-anshuman.khandual@arm.com>
 <20190604145612.GM6610@arrakis.emea.arm.com>
 <1d89177a-e7af-ac4e-1a04-e8b750c2c768@arm.com>
 <20190606112739.GB56860@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606112739.GB56860@arrakis.emea.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 12:27:40PM +0100, Catalin Marinas wrote:
> On Thu, Jun 06, 2019 at 10:24:01AM +0530, Anshuman Khandual wrote:
> > On 06/04/2019 08:26 PM, Catalin Marinas wrote:
> > > On Mon, Jun 03, 2019 at 12:11:25PM +0530, Anshuman Khandual wrote:
> > >> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > >> index 4bb65f3..41fa905 100644
> > >> --- a/arch/arm64/mm/fault.c
> > >> +++ b/arch/arm64/mm/fault.c
> > >> @@ -397,37 +397,29 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
> > >>  static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
> > >>  			   unsigned int mm_flags, unsigned long vm_flags)
> > >>  {
> > >> -	struct vm_area_struct *vma;
> > >> -	vm_fault_t fault;
> > >> +	struct vm_area_struct *vma = find_vma(mm, addr);
> > >>  
> > >> -	vma = find_vma(mm, addr);
> > >> -	fault = VM_FAULT_BADMAP;
> > >>  	if (unlikely(!vma))
> > >> -		goto out;
> > >> -	if (unlikely(vma->vm_start > addr))
> > >> -		goto check_stack;
> > >> +		return VM_FAULT_BADMAP;
> > >>  
> > >>  	/*
> > >>  	 * Ok, we have a good vm_area for this memory access, so we can handle
> > >>  	 * it.
> > >>  	 */
> > >> -good_area:
> > >> +	if (unlikely(vma->vm_start > addr)) {
> > >> +		if (!(vma->vm_flags & VM_GROWSDOWN))
> > >> +			return VM_FAULT_BADMAP;
> > >> +		if (expand_stack(vma, addr))
> > >> +			return VM_FAULT_BADMAP;
> > >> +	}
> > > 
> > > You could have a single return here:
> > > 
> > > 	if (unlikely(vma->vm_start > addr) &&
> > > 	    (!(vma->vm_flags & VM_GROWSDOWN) || expand_stack(vma, addr)))
> > > 		return VM_FAULT_BADMAP;
> > > 
> > > Not sure it's any clearer though.
> > 
> > TBH the proposed one seems clearer as it separates effect (vma->vm_start > addr)
> > from required permission check (vma->vm_flags & VM_GROWSDOWN) and required action
> > (expand_stack(vma, addr)). But I am happy to change as you have mentioned if that
> > is preferred.
> 
> Not bothered really. You can leave them as in your proposal (I was just
> seeing the VM_GROWSDOWN check tightly coupled with the expand_stack(),
> it's fine either way).

Personally, I find it clearer as separate statements, so I'd suggest
keeping it as per Anshuman's proposal.

Thanks,
Mark.
