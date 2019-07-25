Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8224C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02D122BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e/Yzp6j8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfGYVme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:42:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGYVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JNOo0Dhi9UDinqug0uYA1LHheZfDibP+WEcEG6xvIBA=; b=e/Yzp6j8Alk5/730XXwU0FDWq
        rr3okQdzLCE/J4OLyeEPbCRO5XaSEEqvUQNRuRdDTG/W3OlD1FAjSaxvbulJP4bbEv2K/AQ2pdD7U
        C25B6yg420c7m5I/Iv0H7H3aTu60UCDWNz1VIrgdDL7SjaSToKp3xhjFnK0FAT+OdGd8tjn7T0BiL
        FVnp2v5FBeoStt238IAx1keeH1uoGWywMyOzwIoA2i0vmW6dd0U6Kfa62LYSOi7Vnd4DWO1YOgjNg
        0PLrZ06JDUhTYMwDhiWauSPYZcheWxkHZREuSCfc07MneufWREPlpo1Hg9S9UoGbIioPLs5HnL1tq
        WlAQZfXjQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqlVG-0004iU-Tb; Thu, 25 Jul 2019 21:42:22 +0000
Date:   Thu, 25 Jul 2019 14:42:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
Message-ID: <20190725214222.GG30641@bombadil.infradead.org>
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
 <20190725143920.GW363@bombadil.infradead.org>
 <20190725213858.GK1330@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725213858.GK1330@shell.armlinux.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:38:58PM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Jul 25, 2019 at 07:39:21AM -0700, Matthew Wilcox wrote:
> > But 'page' isn't necessarily PMD-aligned.  I don't think we can rely on
> > architectures doing the right thing if asked to make a PMD for a randomly
> > aligned page.
> > 
> > How about finding the physical address of something like kernel_init(),
> > and using the corresponding pte/pmd/pud/p4d/pgd that encompasses that
> > address?  It's also better to pass in the pfn/page rather than using global
> > variables to communicate to the test functions.
> 
> There are architectures (32-bit ARM) where the kernel is mapped using
> section mappings, and we don't expect the Linux page table walking to
> work for section mappings.

This test doesn't go so far as to insert the PTE/PMD/PUD/... into the
page tables.  It merely needs an appropriately aligned PFN to create a
PTE/PMD/PUD/... from.

