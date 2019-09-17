Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE1DC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BFE20665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uS+mNOPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfIQQgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:36:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfIQQgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GqRJ2GhiTNh8OtBngBM3P/jCzeuLxp057cr1YC1H4dQ=; b=uS+mNOPWA66TCc3Sdi47jrH+3
        mpiiPL+sdOSO+bkMGO0J+UDueJaneeNZJyRKkHb7OyxKxBFOXUle3lPb3Iskzkzzd62nExmCS4HqM
        bSzls4wrq57D7HXd6I2Og2biO4paFtUn6W8QLyYCZLL/d9k24JfewfNS1/lwy02M82T5HgCaasL5I
        UVGrzbMOeidW0SyTYs8NcW1ySxM1ddC8eeEGT7Qh8rKZXAwpzPLJ7V7JAjUJbzbtJ6CtbVRV3Cl03
        +eStJWdCArjl5NLZgww+/7iFEKtotH3oJJNXGLgQ58Y+ugr+DU9mHE4pusJDHSwn7vP9EbhBas7gb
        h0xA1Vz1w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAGSU-0002Sy-7A; Tue, 17 Sep 2019 16:36:06 +0000
Date:   Tue, 17 Sep 2019 09:36:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] usercopy: Skip HIGHMEM page checking
Message-ID: <20190917163606.GU29434@bombadil.infradead.org>
References: <201909161431.E69B29A0@keescook>
 <20190917003209.GS29434@bombadil.infradead.org>
 <201909162003.FEEAC65@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909162003.FEEAC65@keescook>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 08:05:00PM -0700, Kees Cook wrote:
> On Mon, Sep 16, 2019 at 05:32:09PM -0700, Matthew Wilcox wrote:
> > On Mon, Sep 16, 2019 at 02:32:56PM -0700, Kees Cook wrote:
> > > When running on a system with >512MB RAM with a 32-bit kernel built with:
> > > 
> > > 	CONFIG_DEBUG_VIRTUAL=y
> > > 	CONFIG_HIGHMEM=y
> > > 	CONFIG_HARDENED_USERCOPY=y
> > > 
> > > all execve()s will fail due to argv copying into kmap()ed pages, and on
> > > usercopy checking the calls ultimately of virt_to_page() will be looking
> > > for "bad" kmap (highmem) pointers due to CONFIG_DEBUG_VIRTUAL=y:
> > 
> > I don't understand why you want to skip the check.  We must not cross a
> > page boundary of a kmapped page.
> 
> That requires a new test which hasn't existed before. First I need to
> fix the bug, and then we can add a new test and get that into -next,
> etc.

I suppose that depends where your baseline is.  From the perspective
of "before Kees added this feature", your point of view makes sense.
From the perspective of "what's been shipping for the last six months",
this is a case which has simply not happened before now (or we'd've seen
a bug report).

I don't think you need to change anything for check_page_span() to do
the right thing.  The rodata/data/bss checks will all fall through.
If the copy has the correct bounds, the 'wholly within one base page'
check will pass and it'll return.  If the copy does span a page,
the virt_to_head_page(end) call will return something bogus, then the
PageReserved and CMA test will cause the usercopy_abort() test to fail.

So I think your first patch is the right patch.
