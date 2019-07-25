Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E4C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BD2218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eLpLsIpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGYVj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:39:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40490 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kavq+eip1im675O4/bBLmRIQNPqz1C3eZxq/uo8ufXg=; b=eLpLsIpHT3C0NpVJISxE4wDFP
        0m9PzZxBOyaV1z++UwBohppQQiDGlRoxJgo8tE7vvbhAe0pv+aRmtEdRR79cc8X1YcIrIpfQrmeyO
        EFzavlvQKFeMAPS54eto2mb6JhC0HxzSj38xaLArlIOk7NxOpTKvVDSbeKuD03Mli22Mu7hNeqZEM
        SkZ6oXyf3A+yKcqm6Xk45/zIAP3YQV3zX7VmOauPyiBxJ5XH1H9lcgUkMY/B0Erq2DOy/5UdosSfp
        hkRP/vFoPTpMcJI4fOfZhjaZwLZ24C3sKtAqcajQ7tHjWA6lfmcEN/ctpkjvb6ZeQNA7U/yIjfXDq
        6W1P95aSw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:44656)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hqlS8-0002Sy-46; Thu, 25 Jul 2019 22:39:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hqlRy-00061g-Ob; Thu, 25 Jul 2019 22:38:58 +0100
Date:   Thu, 25 Jul 2019 22:38:58 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, Steven Price <Steven.Price@arm.com>,
        linux-mm@kvack.org, Mark Brown <Mark.Brown@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC] mm/pgtable/debug: Add test validating architecture page
 table helpers
Message-ID: <20190725213858.GK1330@shell.armlinux.org.uk>
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
 <20190725143920.GW363@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725143920.GW363@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 07:39:21AM -0700, Matthew Wilcox wrote:
> On Thu, Jul 25, 2019 at 12:25:23PM +0530, Anshuman Khandual wrote:
> > This adds a test module which will validate architecture page table helpers
> > and accessors regarding compliance with generic MM semantics expectations.
> > This will help various architectures in validating changes to the existing
> > page table helpers or addition of new ones.
> 
> I think this is a really good idea.
> 
> >  lib/Kconfig.debug       |  14 +++
> >  lib/Makefile            |   1 +
> >  lib/test_arch_pgtable.c | 290 ++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Is this the right place for it?  I worry that lib/ is going to get overloaded
> with test code, and this feels more like mm/ test code.
> 
> > +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > +static void pmd_basic_tests(void)
> > +{
> > +	pmd_t pmd;
> > +
> > +	pmd = mk_pmd(page, prot);
> 
> But 'page' isn't necessarily PMD-aligned.  I don't think we can rely on
> architectures doing the right thing if asked to make a PMD for a randomly
> aligned page.
> 
> How about finding the physical address of something like kernel_init(),
> and using the corresponding pte/pmd/pud/p4d/pgd that encompasses that
> address?  It's also better to pass in the pfn/page rather than using global
> variables to communicate to the test functions.

There are architectures (32-bit ARM) where the kernel is mapped using
section mappings, and we don't expect the Linux page table walking to
work for section mappings.

> > +	/*
> > +	 * A huge page does not point to next level page table
> > +	 * entry. Hence this must qualify as pmd_bad().
> > +	 */
> > +	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
> 
> I didn't know that rule.  This is helpful because it gives us somewhere
> to document all these tricksy little rules.
> 
> > +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > +static void pud_basic_tests(void)
> 
> Is this the right ifdef?
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
