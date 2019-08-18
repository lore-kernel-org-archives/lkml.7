Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D4DC3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DCB2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 18:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ntz5wM7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfHRSVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 14:21:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRSVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XNQs7Di+mM9yt212dkcy63xyYz2ozujjbw82lN1H2+Y=; b=ntz5wM7H3nuUqsH1lwnc8DUmO
        f5ZeIKbzfGZsihhaDdi529Q1c1Hyygv5F01cHltn3KNzKzIBXcNt9rBbTO/LGMTU4HibqxMuK31I1
        RLSPA9T1xaePXTODF2rI8t3C1+6Y/ypla2v9yoowWGBHU9R5YS9741Aurfbck0FxQvUgi6hJgFeVy
        5r9SUfZWKQkON4qWv4UYIKbsDNlH3iX2YVGN6Rsb71+3ysYfPsCc1bi0RU7lihj4RSfPmhbeWkHum
        hm+ZR5xt23gbS3B3ivSS/6tHzRiGcZWk49og1v6pqrhLov+ipP59uwkjU8oPLISrCTEFg3P9djp8i
        6+DzEXYpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hzPnq-0008Lf-H5; Sun, 18 Aug 2019 18:21:18 +0000
Date:   Sun, 18 Aug 2019 11:21:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, zhang_jian5@dahuatech.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
Message-ID: <20190818182118.GA30141@infradead.org>
References: <1565868537-17753-1-git-send-email-guoren@kernel.org>
 <20190816070348.GA13766@infradead.org>
 <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 10:20:18AM +0800, Guo Ren wrote:
> > > Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.
> >
> > Looks generally fine, but two comments:
> >
> >  - do you have a need for ioremap_cache?  We are generally try to
> >    phase it out in favour of memremap, and it is generally only used
> >    by arch specific code.
> Yes, some drivers of our customers use ioremap_cache to map phy_addr
> which isn't belong to system memory.

Which driver?  We should move it over to memremap instead of adding
a new ioremap_cache.

> I agree to use GENERIC_IOREMAP, but I want to add csky support
> GENERIC_IOREMAP patch by myself.
> You could remove "csky: use generic ioremap" in your patchset first
> and I'll add support GENERIC_IORMAP patch later.
> Then we won't get confilct :)

Ok.
