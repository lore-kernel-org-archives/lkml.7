Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27D7C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80259208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFslVtbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfD0QqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:46:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0QqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3A4MMVFyJaHzHHkM6gHiD57x9smeH3QHU7KPXmbZSDw=; b=JFslVtbqb8Xk7UezEFwCOzsYq
        Z5Aq2Y8zTTk/51MJN1Ed1yMVT19PprZKmDEFj46MAfuXJV5chkPuzPZqP0Lplm7tgTy+m9hW1IPMI
        Dlvjg0nWkgVsCdsVf0JGrGxcrLXnafW00jFTiJxun/0fMpr10ILMzOjXnhdKzwuNpGy6Xzh4kw8Hi
        fa/PPcK89psBW4qLC510FYerG4xn0hYW8TuaG+SnKEdUvdEnIc47HCZGllN6BlIFHTrxiuQnVgilo
        vSqlQ/Ov084psRj/0LeF7fevR94oXo07muDL90zv2NWuemOC+yjiDtNedJg0sR/cw8Or3XA1cLRa7
        WErQZxx0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKQSr-0004Wb-09; Sat, 27 Apr 2019 16:46:13 +0000
Date:   Sat, 27 Apr 2019 09:46:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     laurentiu.tudor@nxp.com
Cc:     netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/9] dpaa_eth: fix iova handling for contiguous frames
Message-ID: <20190427164612.GA12450@infradead.org>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
 <20190427071031.6563-8-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427071031.6563-8-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 10:10:29AM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> The driver relies on the no longer valid assumption that dma addresses
> (iovas) are identical to physical addressees and uses phys_to_virt() to
> make iova -> vaddr conversions. Fix this by adding a function that does
> proper iova -> phys conversions using the iommu api and update the code
> to use it.
> Also, a dma_unmap_single() call had to be moved further down the code
> because iova -> vaddr conversions were required before the unmap.
> For now only the contiguous frame case is handled and the SG case is
> split in a following patch.
> While at it, clean-up a redundant dpaa_bpid2pool() and pass the bp
> as parameter.

Err, this is broken.  A driver using the DMA API has no business
call IOMMU APIs.  Just save the _virtual_ address used for the mapping
away and use that again.  We should not go through crazy gymnastics
like this.
