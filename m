Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DEC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49994206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tynKo5h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfG3RDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:03:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfG3RDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sjiuOj4pMy3XulfjH+DlQM2jh5+llnycx9G2HKmD8Vc=; b=tynKo5h1HQy7lnlRTfMfJI0pk
        7ax4izVZLE13fK7Cnt+YJSjkC5S9KF2xgwaJexGTyyumMr0wljno8OXBZ9dFLeaEl/Qz3rmVPNRoW
        g7B8mddz/HHVNh4rJzkAfwNzwxZ/hOWEqoD+MX2L5jW7MVuNp+H5Y2L+e2RmPd1mwKAoQ2MEPPj6J
        eYhy22Kd64NFLgHXi/mfKsOOcSQBC2LuBDXYS3LG0ePdhgsD/Tple33zqS2yLdqY8XkmblbgsSd9z
        rzb83uC2QeEG1fK6eSlKeg4bne9CZYu0mshYUz07DDDpYDRj4eejwt92HEifZNS9M8C/NW7YbHMFB
        hyUrU+BXQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hsVX1-0006YE-Pq; Tue, 30 Jul 2019 17:03:23 +0000
Date:   Tue, 30 Jul 2019 10:03:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <Mark.Brown@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/pgtable/debug: Add test validating architecture page
 table helpers
Message-ID: <20190730170323.GA4700@bombadil.infradead.org>
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
 <20190725143920.GW363@bombadil.infradead.org>
 <c3bb0420-584c-de3b-2439-8702bc09595e@arm.com>
 <20190726195457.GI30641@bombadil.infradead.org>
 <10ed1022-a5c0-c80c-c0c9-025bb2307666@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ed1022-a5c0-c80c-c0c9-025bb2307666@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 02:02:52PM +0530, Anshuman Khandual wrote:
> On 07/27/2019 01:24 AM, Matthew Wilcox wrote:
> > On Fri, Jul 26, 2019 at 10:17:11AM +0530, Anshuman Khandual wrote:
> >>> But 'page' isn't necessarily PMD-aligned.  I don't think we can rely on
> >>> architectures doing the right thing if asked to make a PMD for a randomly
> >>> aligned page.
> >>>
> >>> How about finding the physical address of something like kernel_init(),
> >>
> >> Physical address corresponding to the symbol in the kernel text segment ?
> > 
> > Yes.  We need the address of something that's definitely memory.
> > The stack might be in vmalloc space.  We can't allocate memory from the
> > allocator that's PUD-aligned.  This seems like a reasonable approximation
> > to something that might work.
> 
> Okay sure. What is about vmalloc space being PUD aligned and how that is
> problematic here ? Could you please give some details. Just being curious.

Those were two different sentences.

We can't use the address of something on the stack, because we don't
know whether the stack is in vmalloc space or in the direct map.

We can't use the address of something we've allocated from the page
allocator, because the page allocator can't give us PUD-aligned memory.

> > I think that's a mistake.  As Russell said, the ARM p*d manipulation
> > functions expect to operate on tables, not on individual entries
> > constructed on the stack.
> 
> Hmm. I assume that it will take care of dual 32 bit entry updates on arm
> platform through various helper functions as Russel had mentioned earlier.
> After we create page table with p?d_alloc() functions and pick an entry at
> each page table level.

Right.

> > So I think the right thing to do here is allocate an mm, then do the
> > pgd_alloc / p4d_alloc / pud_alloc / pmd_alloc / pte_alloc() steps giving
> > you real page tables that you can manipulate.
> > 
> > Then destroy them, of course.  And don't access through them.
> 
> mm_alloc() seems like a comprehensive helper to allocate and initialize a
> mm_struct. But could we use mm_init() with 'current' in the driver context or we
> need to create a dummy task_struct for this purpose. Some initial tests show that
> p?d_alloc() and p?d_free() at each level with a fixed virtual address gives p?d_t
> entries required at various page table level to test upon.

I think it's wise to start a new mm.  I'm not sure exactly what calls
to make to get one going.

> >>>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >>>> +static void pud_basic_tests(void)
> >>>
> >>> Is this the right ifdef?
> >>
> >> IIUC THP at PUD is where the pud_t entries are directly operated upon and the
> >> corresponding accessors are present only when HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >> is enabled. Am I missing something here ?
> > 
> > Maybe I am.  I thought we could end up operating on PUDs for kernel mappings,
> > even without transparent hugepages turned on.
> 
> In generic MM ? IIUC except ioremap mapping all other PUD handling for kernel virtual
> range is platform specific. All the helpers used in the function pud_basic_tests() are
> part of THP and used in mm/huge_memory.c

But what about hugetlbfs?  And vmalloc can also use larger pages these days.
I don't think these tests should be conditional on transparent hugepages.
