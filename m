Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B0C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223A021BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbfGXOJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:09:14 -0400
Received: from foss.arm.com ([217.140.110.172]:41720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfGXOJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:09:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4428D28;
        Wed, 24 Jul 2019 07:09:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB3973F71A;
        Wed, 24 Jul 2019 07:09:10 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:09:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v9 11/21] mm: pagewalk: Add p4d_entry() and pgd_entry()
Message-ID: <20190724140908.GE2624@lakrids.cambridge.arm.com>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-12-steven.price@arm.com>
 <20190723101432.GC8085@lakrids.cambridge.arm.com>
 <60ee20ef-62a3-5df1-6e24-24973b69be70@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ee20ef-62a3-5df1-6e24-24973b69be70@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 02:53:04PM +0100, Steven Price wrote:
> On 23/07/2019 11:14, Mark Rutland wrote:
> > On Mon, Jul 22, 2019 at 04:42:00PM +0100, Steven Price wrote:
> >> pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
> >> ("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
> >> no users. We're about to add users so reintroduce them, along with
> >> p4d_entry() as we now have 5 levels of tables.
> >>
> >> Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
> >> PUD-sized transparent hugepages") already re-added pud_entry() but with
> >> different semantics to the other callbacks. Since there have never
> >> been upstream users of this, revert the semantics back to match the
> >> other callbacks. This means pud_entry() is called for all entries, not
> >> just transparent huge pages.
> >>
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >> ---
> >>  include/linux/mm.h | 15 +++++++++------
> >>  mm/pagewalk.c      | 27 ++++++++++++++++-----------
> >>  2 files changed, 25 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 0334ca97c584..b22799129128 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -1432,15 +1432,14 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
> >>  
> >>  /**
> >>   * mm_walk - callbacks for walk_page_range
> >> - * @pud_entry: if set, called for each non-empty PUD (2nd-level) entry
> >> - *	       this handler should only handle pud_trans_huge() puds.
> >> - *	       the pmd_entry or pte_entry callbacks will be used for
> >> - *	       regular PUDs.
> >> - * @pmd_entry: if set, called for each non-empty PMD (3rd-level) entry
> >> + * @pgd_entry: if set, called for each non-empty PGD (top-level) entry
> >> + * @p4d_entry: if set, called for each non-empty P4D entry
> >> + * @pud_entry: if set, called for each non-empty PUD entry
> >> + * @pmd_entry: if set, called for each non-empty PMD entry
> > 
> > How are these expected to work with folding?
> > 
> > For example, on arm64 with 64K pages and 42-bit VA, you can have 2-level
> > tables where the PGD is P4D, PUD, and PMD. IIUC we'd invoke the
> > callbacks for each of those levels where we found an entry in the pgd.
> > 
> > Either the callee handle that, or we should inhibit the callbacks when
> > levels are folded, and I think that needs to be explcitly stated either
> > way.
> > 
> > IIRC on x86 the p4d folding is dynamic depending on whether the HW
> > supports 5-level page tables. Maybe that implies the callee has to
> > handle that.
> 
> Yes, my assumption is that it has to be up to the callee to handle that
> because folding can be dynamic. I believe this also was how these
> callbacks work before they were removed. However I'll add a comment
> explaining that here as it's probably non-obvious.

That sounds good to me.

Thanks,
Mark.
