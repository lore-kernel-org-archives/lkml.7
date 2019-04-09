Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE34C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7822084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LQ4ImRmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDIJjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:39:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDIJjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/6LRRno5QhoLuot52XNJUgJ+A/EAa4IMdtUDvkeQ950=; b=LQ4ImRmOSpQr8ePvX5oizt+t5
        mYNM2AZMu/77qgoM+a65uwvsWfD12VHWeYlhFl0/2DCg6+WtkCCvx06hgZ3Lcxd0KwutikTpb/xIS
        aye4+pRtlgLjX+wZU9r2HdwI7eVhI84/Oo+Up0Jhsn0dJub/8yfK0ys2GVPm6afPR+QjNc2Rm80vi
        vrvozUOzhPntWYRF2JNDM4Q+HnqpAJqnF5J9mDVFx9FjG3S1NwAg9wtRalH+URqgirwDmjFxLzIVJ
        CutHjXTeRfu7bGzxpbWWaQlrrmR23Zzdu1EWlwgEReHuJKtNrYCWpcu9Mf0HC4UY5N2ez++E+krVp
        RsLax0Z5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDnE9-0004R5-B4; Tue, 09 Apr 2019 09:39:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18A3A201F29BA; Tue,  9 Apr 2019 11:39:35 +0200 (CEST)
Date:   Tue, 9 Apr 2019 11:39:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Message-ID: <20190409093935.GH14281@hirez.programming.kicks-ass.net>
References: <20190408191103.13501-1-brijesh.singh@amd.com>
 <20190409084031.GO4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409084031.GO4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 10:40:31AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 08, 2019 at 07:11:21PM +0000, Singh, Brijesh wrote:
> > The following commit 0a9fe8ca844d ("x86/mm: Validate kernel_physical_mapping_init()
> > PTE population") triggers the below warning in the SEV guest.
> > 
> > WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/pgalloc.h:87 phys_pmd_init+0x30d/0x386
> > Call Trace:
> >  kernel_physical_mapping_init+0xce/0x259
> >  early_set_memory_enc_dec+0x10f/0x160
> >  kvm_smp_prepare_boot_cpu+0x71/0x9d
> >  start_kernel+0x1c9/0x50b
> >  secondary_startup_64+0xa4/0xb0
> > 
> > The SEV guest calls kernel_physical_mapping_init() to clear the encryption
> > mask from an existing mapping. While clearing the encryption mask
> > kernel_physical_mapping_init() splits the large pages into the smaller.
> > To split the page, the kernel_physical_mapping_init() allocates a new page
> > and updates the existing entry. The set_{pud,pmd}_safe triggers warning
> > when updating the entry with page in the present state. We should use the
> > set_{pud,pmd} when updating an existing entry with the new entry.
> > 
> > Updating an entry will also requires a TLB flush. Currently the caller
> > (early_set_memory_enc_dec()) is taking care of issuing the TLB flushes.
> 
> I'm not entirely sure I like this, this means all users of
> kernel_physical_mapping_init() now need to be aware and careful.
> 
> That said; the alternative is adding an argument to the function and
> propagating it through the callchain and dynamically switching between
> _safe and not. Which doesn't sound ideal either.
> 
> Anybody else got clever ideas?

The more I think about it, I think that is in fact the right thing to
do.

Rename kernel_physical_mapping_init() to __& and add that flag, thread
it down to all the set_{pud,pmd.pte}() thingies. Then add:

unsigned long kernel_physical_mapping_init(unsigned long paddr_start, unsigned
		long paddr_end, unsigned long page_size_mask)
{
	return __kernel_physical_mapping_init(paddr_start, paddr_end, page_size_mask, true);
}

unsigned long kernel_physical_mapping_change(unsigned long paddr_start, unsigned
		long paddr_end, unsigned long page_size_mask)
{
	unsigned long last;

	last = __kernel_physical_mapping_init(paddr_start, paddr_end, page_size_mask, false);

	__flush_tlb_all();

	return last;
}

Or something along those lines.


