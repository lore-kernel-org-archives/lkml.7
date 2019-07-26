Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43285C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1698922BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qLaE1wkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfGZTzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:55:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfGZTzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jbv0LbZynJFOQcTJN5oGebnbSqk/idAThN/ynHRXZp8=; b=qLaE1wkKgoy7MM+GpS8n4h0G5
        ore0CpfVTIbcdEbcRmCa3upn43Xm+UHEcbYtITzvkm+EW5hIfq1Vkb4nLIvE1cbnvqtSp3poIxCwo
        Z2e7Qsak865u/eh3Yug9ba7yjlnjT7jbooxL03UhvtaENYgbBDfeBxNn7xs++60Pbll5RIqAzZAtH
        9PHtgtW9psv9Sqlz05XEV7HAfHOqSzG2R0ZGzfs4G1mjtBgBB29R+rwCVdhfIkLeKQNMAjYpdTWry
        11Nicdi23ixiLKeLhOIAXCwfF6d2yqDdDSUDgD1LRimA9qyYq9uzv9aukemW6TAcgADgf6BU/zBrR
        miBBXLelQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hr6Ir-00045T-GC; Fri, 26 Jul 2019 19:54:57 +0000
Date:   Fri, 26 Jul 2019 12:54:57 -0700
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
Message-ID: <20190726195457.GI30641@bombadil.infradead.org>
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
 <20190725143920.GW363@bombadil.infradead.org>
 <c3bb0420-584c-de3b-2439-8702bc09595e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3bb0420-584c-de3b-2439-8702bc09595e@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 10:17:11AM +0530, Anshuman Khandual wrote:
> > But 'page' isn't necessarily PMD-aligned.  I don't think we can rely on
> > architectures doing the right thing if asked to make a PMD for a randomly
> > aligned page.
> > 
> > How about finding the physical address of something like kernel_init(),
> 
> Physical address corresponding to the symbol in the kernel text segment ?

Yes.  We need the address of something that's definitely memory.
The stack might be in vmalloc space.  We can't allocate memory from the
allocator that's PUD-aligned.  This seems like a reasonable approximation
to something that might work.

> > and using the corresponding pte/pmd/pud/p4d/pgd that encompasses that
> 
> So I guess this will help us use pte/pmd/pud/p4d/pgd entries from a real and
> present mapping rather then making them up for test purpose. Although we are
> not creating real page tables here just wondering if this could some how
> affect these real mapping in anyway from some accessors. The current proposal
> stays clear from anything real - allocates, evaluates and releases.

I think that's a mistake.  As Russell said, the ARM p*d manipulation
functions expect to operate on tables, not on individual entries
constructed on the stack.

So I think the right thing to do here is allocate an mm, then do the
pgd_alloc / p4d_alloc / pud_alloc / pmd_alloc / pte_alloc() steps giving
you real page tables that you can manipulate.

Then destroy them, of course.  And don't access through them.

> >> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >> +static void pud_basic_tests(void)
> > 
> > Is this the right ifdef?
> 
> IIUC THP at PUD is where the pud_t entries are directly operated upon and the
> corresponding accessors are present only when HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> is enabled. Am I missing something here ?

Maybe I am.  I thought we could end up operating on PUDs for kernel mappings,
even without transparent hugepages turned on.
