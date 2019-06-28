Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9F4C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2B321670
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfF1KUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:20:08 -0400
Received: from foss.arm.com ([217.140.110.172]:44402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfF1KUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:20:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED6828;
        Fri, 28 Jun 2019 03:20:07 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F05873F718;
        Fri, 28 Jun 2019 03:20:05 -0700 (PDT)
Date:   Fri, 28 Jun 2019 11:20:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] arm64/mm: Change THP helpers to comply with generic MM
 semantics
Message-ID: <20190628102003.GA56463@arrakis.emea.arm.com>
References: <1561639696-16361-1-git-send-email-anshuman.khandual@arm.com>
 <1561639696-16361-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561639696-16361-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Thu, Jun 27, 2019 at 06:18:15PM +0530, Anshuman Khandual wrote:
> pmd_present() and pmd_trans_huge() are expected to behave in the following
> manner during various phases of a given PMD. It is derived from a previous
> detailed discussion on this topic [1] and present THP documentation [2].
> 
> pmd_present(pmd):
> 
> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)
> 
> pmd_trans_huge(pmd):
> 
> - Returns true if pmd refers to system RAM and is a trans huge mapping
> 
> -------------------------------------------------------------------------
> |	PMD states	|	pmd_present	|	pmd_trans_huge	|
> -------------------------------------------------------------------------
> |	Mapped		|	Yes		|	Yes		|
> -------------------------------------------------------------------------
> |	Splitting	|	Yes		|	Yes		|
> -------------------------------------------------------------------------
> |	Migration/Swap	|	No		|	No		|
> -------------------------------------------------------------------------

Before we actually start fixing this, I would strongly suggest that you
add a boot selftest (see lib/Kconfig.debug for other similar cases)
which checks the consistency of the page table macros w.r.t. the
expected mm semantics. Once the mm maintainers agreed with the
semantics, it will really help architecture maintainers in implementing
them correctly.

You wouldn't need actual page tables, just things like assertions on
pmd_trans_huge(pmd_mkhuge(pmd)) == true. You could go further and have
checks on pmdp_invalidate(&dummy_vma, dummy_addr, &dummy_pmd) with the
dummy_* variables on the stack.

> The problem:
> 
> PMD is first invalidated with pmdp_invalidate() before it's splitting. This
> invalidation clears PMD_SECT_VALID as below.
> 
> PMD Split -> pmdp_invalidate() -> pmd_mknotpresent -> Clears PMD_SECT_VALID
> 
> Once PMD_SECT_VALID gets cleared, it results in pmd_present() return false
> on the PMD entry.

I think that's an inconsistency in the expected semantics here. Do you
mean that pmd_present(pmd_mknotpresent(pmd)) should be true? If not, do
we need to implement our own pmdp_invalidate() or change the generic one
to set a "special" bit instead of just a pmd_mknotpresent?

> +static inline int pmd_present(pmd_t pmd)
> +{
> +	if (pte_present(pmd_pte(pmd)))
> +		return 1;
> +
> +	return pte_special(pmd_pte(pmd));
> +}
[...]
> +static inline pmd_t pmd_mknotpresent(pmd_t pmd)
> +{
> +	pmd = pte_pmd(pte_mkspecial(pmd_pte(pmd)));
> +	return __pmd(pmd_val(pmd) & ~PMD_SECT_VALID);
> +}

I'm not sure I agree with the semantics here where pmd_mknotpresent()
does not actually make pmd_present() == false.

-- 
Catalin
