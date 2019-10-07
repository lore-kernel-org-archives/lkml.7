Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429E6ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176DA20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="foHrCerJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfJGR4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:56:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJGR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6cJm3mXnu96oSCyEtClKGow4gq/ZNSvLzJ0zlA1dpF8=; b=foHrCerJqy+WcaZ34i5vWdP0z
        JfR/2qjb1sXRAMZrkoViHNafxNIzaEY3k/KyzjsfKeaw01FHMq5GFpiDpU7RT050s20gTzb3/uzeZ
        FqLVFZW8nx7C0g+jyAKzxbwfRSZhUVtRo1kWo8GrPRie2TfSpkKmVvBU9t9Lnor9SBmHJBQxQcO+W
        7eGkA2VZxodwK1krZHQjmz2vAiPWC1/wqk6EhtceRb8z652uQk/u/wtNSFnsnlmHJfHUbLoezCDk1
        Hq74K/xI8qc5ID2BXWz0rrzc4qkg0GGq1fOcBGbTk44/tpZaoa1xI94fhxyKRSAheDtXIThuyDFLd
        rNlqRe77Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHXFG-0007bf-Ci; Mon, 07 Oct 2019 17:56:30 +0000
Date:   Mon, 7 Oct 2019 10:56:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007175630.GA28861@infradead.org>
References: <20191007022454.GA5270@rani.riverdale.lan>
 <20191007073448.GA882@lst.de>
 <20191007175430.GA32537@rani.riverdale.lan>
 <20191007175528.GA21857@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007175528.GA21857@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 07:55:28PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 07, 2019 at 01:54:32PM -0400, Arvind Sankar wrote:
> > It doesn't boot with the patch. Won't it go
> > 	dma_get_required_mask
> > 	-> intel_get_required_mask
> > 	-> iommu_need_mapping
> > 	-> dma_get_required_mask
> > ?
> > 
> > Should the call to dma_get_required_mask in iommu_need_mapping be
> > replaced with dma_direct_get_required_mask on top of your patch?
> 
> Yes, sorry.

Actually my patch already calls dma_direct_get_required_mask.
How did you get the loop?
