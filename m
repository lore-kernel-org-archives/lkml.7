Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BF5C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF3F2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDSy7Jjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJFQ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 12:29:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfJFQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fQHPal319uXdVbBLOPVrt8n9xI6EBxPDz/8t7OE1Y0w=; b=XDSy7Jjyh6TR2x5L+YbJI07jSS
        9AZijgCkfuVARv4MHOW/4Qegx6uk42JZ7pMV1NMdAdBLxSRv+Sb189Q93fkE4vgEbFVOawF8NcHj8
        hu8AuWowJS9Xc7pfXD/kGThczZKnsBbq5jEEh1i9SpTt1s991smjzQZmRiYduhj/ggGNuTKWL6o22
        /yDgi209kKZOKlkLYa3vdB1mXjYOHkV3p/ddlU1G7Z5mgV7TCQwEHDcJ0NPo6IfxtvEwlyy37pPb5
        /12SPreeIqB6EJVvklNomcePzsBDI+63ppZJPsuRhsRRlBG3l3JqE9jK/6DXHuNhxGI06OoU2/oBV
        maSTOSig==;
Received: from 089144211233.atnat0020.highway.a1.net ([89.144.211.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iH9Pt-0005XS-GE; Sun, 06 Oct 2019 16:29:53 +0000
Date:   Sun, 6 Oct 2019 18:27:40 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping regression fix for 5.4-rc2
Message-ID: <20191006162740.GA27870@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this has only sat in my tree for a day, but it is a very obvious bug
fix for a regression introduced this merge window reported by two
people, and simply is a revert of a bogus hunk.


The following changes since commit 4ea655343ce4180fe9b2c7ec8cb8ef9884a47901:

  Merge tag 'mips_fixes_5.4_1' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux (2019-10-04 13:31:56 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.4-1

for you to fetch changes up to 2cf2aa6a69db0b17b3979144287af8775c1c1534:

  dma-mapping: fix false positivse warnings in dma_common_free_remap() (2019-10-05 10:24:17 +0200)

----------------------------------------------------------------
dma-mapping regression fix for 5.4-rc2

 - revert an incorret hunk from a patch that caused problems
   on various arm boards (Andrey Smirnov)

----------------------------------------------------------------
Andrey Smirnov (1):
      dma-mapping: fix false positivse warnings in dma_common_free_remap()

 kernel/dma/remap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
