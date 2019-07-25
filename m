Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCACC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22894229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sHapK5Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfGYV62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:58:28 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40794 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfGYV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3G0DbANSEEz3gBLVg4LbmF0CvfiTNd4gqwl2oAi+YHw=; b=sHapK5Dv01/JCHeQu/SjqvySW
        pH6NXKfPa0ocMNU8dGO4QMKJt+V/hxIZBWxflM6ndEmDYOb+0THMyDtpoiwsq1QwIEczr5gydc+AX
        ukWeOWFYxCs1H6b9ICoaEjcsxGhK/oWcWJZ2XRa7t1VukD9tmGNPRuMHBe/ljDRZlPMihyMqVlK2D
        Zix8A5XlQ9FwZM/jPoOI9e2CCXMdN+i0KM+peI6omltOm/LQWwmL8ST1sdCM4dZxZpjZ50MpqviaZ
        xvkaCb3IbY8GQo0+w56JWRDQeiSn6vs2kO1h0XtKVS+EnAzq8fGF8RKxA0nrZQogQb0j3TfenlS3k
        s2G1lrXVA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:37148)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hqlkb-0002Yr-TM; Thu, 25 Jul 2019 22:58:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hqlka-00062y-II; Thu, 25 Jul 2019 22:58:12 +0100
Date:   Thu, 25 Jul 2019 22:58:12 +0100
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
Message-ID: <20190725215812.GN1330@shell.armlinux.org.uk>
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
 <20190725143920.GW363@bombadil.infradead.org>
 <20190725213858.GK1330@shell.armlinux.org.uk>
 <20190725214222.GG30641@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725214222.GG30641@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 02:42:22PM -0700, Matthew Wilcox wrote:
> On Thu, Jul 25, 2019 at 10:38:58PM +0100, Russell King - ARM Linux admin wrote:
> > On Thu, Jul 25, 2019 at 07:39:21AM -0700, Matthew Wilcox wrote:
> > > But 'page' isn't necessarily PMD-aligned.  I don't think we can rely on
> > > architectures doing the right thing if asked to make a PMD for a randomly
> > > aligned page.
> > > 
> > > How about finding the physical address of something like kernel_init(),
> > > and using the corresponding pte/pmd/pud/p4d/pgd that encompasses that
> > > address?  It's also better to pass in the pfn/page rather than using global
> > > variables to communicate to the test functions.
> > 
> > There are architectures (32-bit ARM) where the kernel is mapped using
> > section mappings, and we don't expect the Linux page table walking to
> > work for section mappings.
> 
> This test doesn't go so far as to insert the PTE/PMD/PUD/... into the
> page tables.  It merely needs an appropriately aligned PFN to create a
> PTE/PMD/PUD/... from.

Well, in any case,

c085ac68 t kernel_init

so I'm not sure that would be an improvement.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
