Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD27C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E76D2189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGCRwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:52:55 -0400
Received: from foss.arm.com ([217.140.110.172]:54398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCRwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:52:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D5B2344;
        Wed,  3 Jul 2019 10:52:54 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 250823F718;
        Wed,  3 Jul 2019 10:52:53 -0700 (PDT)
Date:   Wed, 3 Jul 2019 18:52:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 1/2] arm64/mm: Change THP helpers to comply with generic MM
 semantics
Message-ID: <20190703175250.GF48312@arrakis.emea.arm.com>
References: <1561639696-16361-1-git-send-email-anshuman.khandual@arm.com>
 <1561639696-16361-2-git-send-email-anshuman.khandual@arm.com>
 <20190628102003.GA56463@arrakis.emea.arm.com>
 <82237e21-1f14-ab6e-0f80-9706141e2172@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82237e21-1f14-ab6e-0f80-9706141e2172@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 09:07:28AM +0530, Anshuman Khandual wrote:
> On 06/28/2019 03:50 PM, Catalin Marinas wrote:
> > On Thu, Jun 27, 2019 at 06:18:15PM +0530, Anshuman Khandual wrote:
> >> pmd_present() and pmd_trans_huge() are expected to behave in the following
> >> manner during various phases of a given PMD. It is derived from a previous
> >> detailed discussion on this topic [1] and present THP documentation [2].
> >>
> >> pmd_present(pmd):
> >>
> >> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
> >> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)
> >>
> >> pmd_trans_huge(pmd):
> >>
> >> - Returns true if pmd refers to system RAM and is a trans huge mapping
[...]
> > Before we actually start fixing this, I would strongly suggest that you
> > add a boot selftest (see lib/Kconfig.debug for other similar cases)
> > which checks the consistency of the page table macros w.r.t. the
> > expected mm semantics. Once the mm maintainers agreed with the
> > semantics, it will really help architecture maintainers in implementing
> > them correctly.
> 
> Sure and it will help all architectures to be in sync wrt semantics.
> 
> > You wouldn't need actual page tables, just things like assertions on
> > pmd_trans_huge(pmd_mkhuge(pmd)) == true. You could go further and have
> > checks on pmdp_invalidate(&dummy_vma, dummy_addr, &dummy_pmd) with the
> > dummy_* variables on the stack.
> 
> Hmm. I guess macros which operate directly on a page table entry will be
> okay but the ones which check on specific states for VMA or MM might be
> bit tricky. Try to emulate VMA/MM states while on stack ?. But sure, will
> explore adding such a test.

You can pretend that the page table is on the stack. See the _pmd
variable in do_huge_pmd_wp_page_fallback() and
__split_huge_zero_page_pmd(). Similarly, the vma and even the mm can be
faked on the stack (see the arm64 tlb_flush()).

> >> The problem:
> >>
> >> PMD is first invalidated with pmdp_invalidate() before it's splitting. This
> >> invalidation clears PMD_SECT_VALID as below.
> >>
> >> PMD Split -> pmdp_invalidate() -> pmd_mknotpresent -> Clears PMD_SECT_VALID
> >>
> >> Once PMD_SECT_VALID gets cleared, it results in pmd_present() return false
> >> on the PMD entry.
> > 
> > I think that's an inconsistency in the expected semantics here. Do you
> > mean that pmd_present(pmd_mknotpresent(pmd)) should be true? If not, do
[...]
> pmd_present() and pmd_mknotpresent() are not exact inverse.

I find this very confusing (not your fault, just the semantics expected
by the core code). I can see that x86 is using _PAGE_PSE to make
pmd_present(pmd_mknotpresent()) == true. However, for pud that's not the
case (because it's not used for transhuge).

I'd rather have this renamed to pmd_mknotvalid().

> In absence of a positive section mapping bit on arm64, PTE_SPECIAL is being set
> temporarily to remember that it was a mapped PMD which got invalidated recently
> but which still points to memory. Hence pmd_present() must evaluate true.

I wonder if we can encode this safely for arm64 in the bottom two bits
of a pmd :

0b00 - not valid, not present
0b10 - not valid, present, huge
0b01 - valid, present, huge
0b11 - valid, table (not huge)

Do we ever call pmdp_invalidate() on a table entry? I don't think we do.

So a pte_mknotvalid would set bit 1 and I think swp_entry_to_pmd() would
have to clear it so that pmd_present() actually returns false for a swp
pmd entry.

> > we need to implement our own pmdp_invalidate() or change the generic one
> > to set a "special" bit instead of just a pmd_mknotpresent?
> 
> Though arm64 can subscribe __HAVE_ARCH_PMDP_INVALIDATE and implement it's own
> pmdp_invalidate() in order to not call pmd_mknotpresent() and instead operate
> on the invalid and special bits directly. But its not going to alter relevant
> semantics here. AFAICS it might be bit better as it saves pmd_mknotpresent()
> from putting in that special bit in there which it is not supposed do.
> 
> IFAICS there is no compelling reason for generic pmdp_invalidate() to change
> either. It calls pmd_mknotpresent() which invalidates the entry through valid
> or present bit and platforms which have dedicated huge page bit can still test
> positive for pmd_present() after it's invalidation. It works for such platforms.
> Platform specific override is required when invalidation via pmd_mknotpresent()
> is not enough.

I'd really like the mknotpresent to be renamed to mknotvalid and then we
can keep pmdp_invalidate unchanged (well, calling mknotvalid instead).

-- 
Catalin
