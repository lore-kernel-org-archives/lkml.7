Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC3C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06AA21BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="udjl5wYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfHGPMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:12:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfHGPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SXYk4z8+XUcrwUH0ETJaYqTcSP2s+uqNvgDYI9B18iM=; b=udjl5wYerj8dDNl2/fe+MAu0v
        f/qpzJRnWO7ODN7/yx2FSts8Kyy/VfdtWN5KqxBo5hatblPpnqCq9omj1Og+q0enzLXvAUS+R8cKX
        SMrL74pvvUCrOIhjyOxcGuxDPIldGfpkiLR2K0C9dHQxvDpVWjWJS6asUIY0mTYOGj2iMbYr0jYhV
        pxwdwQl6kVq61ioceD4eVKLupH/2Gnf0vDW/ekvUkJEdin9WBef+/s4DMwW7Sovp52ML9t5PjNzW0
        RxppFwk0RbheSj5EqY/F+dnNjEgWx/PWSYymR6ZFWmBosM0tSt0dslaoSGH9FhjduHmTLL3Omp+cP
        +RCtISIIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvNc6-0004bD-1i; Wed, 07 Aug 2019 15:12:30 +0000
Date:   Wed, 7 Aug 2019 08:12:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kbuild: add virtual memory system selection
Message-ID: <20190807151229.GA16432@infradead.org>
References: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com>
 <20190802084453.GA1410@infradead.org>
 <alpine.DEB.2.21.9999.1908061648220.13971@viisi.sifive.com>
 <20190807054246.GB1398@infradead.org>
 <c331e389-5f33-634a-f62f-e48251ca4cfe@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c331e389-5f33-634a-f62f-e48251ca4cfe@ghiti.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 09:04:40AM +0200, Alexandre Ghiti wrote:
> I took a look at how x86 deals with 5-level page table: it allows to handle
> 5-level and 4-level at runtime by folding the last page table level (cf
> Documentation/x86/x86_64/5level-paging.rst). So we might want to be able to
> do the same and deal with that at runtime.

Yes, following the X86_5LEVEL model is the right thing.
