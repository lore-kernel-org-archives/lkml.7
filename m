Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEC1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E442081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfLDQco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:32:44 -0500
Received: from foss.arm.com ([217.140.110.172]:58606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbfLDQco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:32:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3168F31B;
        Wed,  4 Dec 2019 08:32:43 -0800 (PST)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B6333F52E;
        Wed,  4 Dec 2019 08:32:40 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:32:35 +0000
From:   Steven Price <steven.price@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <James.Morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH v15 00/23] Generic page walk and ptdump
Message-ID: <20191204163235.GA1597@arm.com>
References: <20191101140942.51554-1-steven.price@arm.com>
 <1572896147.5937.116.camel@lca.pw>
 <7B040741-EC8A-4CC0-964B-4046AE2E617A@lca.pw>
 <16da6118-ac4d-a165-6202-0731a776ac72@arm.com>
 <911fac4a-2204-f994-a101-16a60fba12e8@redhat.com>
 <0FA196FD-3FCD-431A-AA3E-21BF00EA07DC@lca.pw>
 <9d5f1689-db82-a6da-d51d-08070aa4bad5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d5f1689-db82-a6da-d51d-08070aa4bad5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 02:56:58PM +0000, David Hildenbrand wrote:
> On 04.12.19 15:54, Qian Cai wrote:
> > 
> > 
> >> On Dec 3, 2019, at 6:02 AM, David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 06.11.19 16:05, Steven Price wrote:
> >>> On 06/11/2019 13:31, Qian Cai wrote:
> >>>>
> >>>>
> >>>>> On Nov 4, 2019, at 2:35 PM, Qian Cai <cai@lca.pw> wrote:
> >>>>>
> >>>>> On Fri, 2019-11-01 at 14:09 +0000, Steven Price wrote:
> >>> [...]
> >>>>>> Changes since v14:
> >>>>>> https://lore.kernel.org/lkml/20191028135910.33253-1-steven.price@arm.com/
> >>>>>> * Switch walk_page_range() into two functions, the existing
> >>>>>>   walk_page_range() now still requires VMAs (and treats areas without a
> >>>>>>   VMA as a 'hole'). The new walk_page_range_novma() ignores VMAs and
> >>>>>>   will report the actual page table layout. This fixes the previous
> >>>>>>   breakage of /proc/<pid>/pagemap
> >>>>>> * New patch at the end of the series which reduces the 'level' numbers
> >>>>>>   by 1 to simplify the code slightly
> >>>>>> * Added tags
> >>>>>
> >>>>> Does this new version also take care of this boot crash seen with v14? Suppose
> >>>>> it is now breaking CONFIG_EFI_PGT_DUMP=y? The full config is,
> >>>>>
> >>>>> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> >>>>>
> >>>>
> >>>> V15 is indeed DOA here.
> >>>
> >>> Thanks for finding this, it looks like EFI causes issues here. The below fixes
> >>> this for me (booting in QEMU).
> >>>
> >>> Andrew: do you want me to send out the entire series again for this fix, or
> >>> can you squash this into mm-pagewalk-allow-walking-without-vma.patch?
> >>>
> >>> Thanks,
> >>>
> >>> Steve
> >>>
> >>> ---8<---
> >>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> >>> index c7529dc4f82b..70dcaa23598f 100644
> >>> --- a/mm/pagewalk.c
> >>> +++ b/mm/pagewalk.c
> >>> @@ -90,7 +90,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
> >>>  			split_huge_pmd(walk->vma, pmd, addr);
> >>>  			if (pmd_trans_unstable(pmd))
> >>>  				goto again;
> >>> -		} else if (pmd_leaf(*pmd)) {
> >>> +		} else if (pmd_leaf(*pmd) || !pmd_present(*pmd)) {
> >>>  			continue;
> >>>  		}
> >>>
> >>> @@ -141,7 +141,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
> >>>  			split_huge_pud(walk->vma, pud, addr);
> >>>  			if (pud_none(*pud))
> >>>  				goto again;
> >>> -		} else if (pud_leaf(*pud)) {
> >>> +		} else if (pud_leaf(*pud) || !pud_present(*pud)) {
> >>>  			continue;
> >>>  		}
> >>>
> >>>
> >>
> >> Even with this fix, booting for me under QEMU fails. See
> >>
> >> https://lore.kernel.org/linux-mm/b7ce62f2-9a48-6e48-6685-003431e521aa@redhat.com/
> >>
> > 
> > Yes, for some reasons, this starts to crash on almost all arches here, so it might be worth
> > for Andrew to revert those in the meantime while allowing Steven to rework.
> 
> I agree, this produces too much noise.

I've bisected this problem and it's a merge conflict with:

ace88f1018b8 ("mm: pagewalk: Take the pagetable lock in walk_pte_range()")

Reverting that commit "fixes" the problem. That commit adds a call to
pte_offset_map_lock(), however that isn't necessarily safe when
considering an "unusual" mapping in the kernel. Combined with my patch
set this leads to the BUG when walking the kernel's page tables.

At this stage I think it's best if Andrew drops my series and I'll try
to rework it on top -rc1 fixing up this conflict and the other x86
32-bit issue that has cropped up.

Steve
