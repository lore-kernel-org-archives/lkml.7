Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DC7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73386205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nygdDVLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfD2M3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:29:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfD2M3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EW2iFwNqNlht0+s6NLZ+G7rAKMXqi0WCLFnU84fEvkg=; b=nygdDVLb/m+CHDFtCRuiQ8nNi
        pUi5ycISG+ucbS2NSkUmrIVLmBPKgPu76P1ik4GSxBXwkDCYul7a5ClBaLMu+K+QFLcKfT2DW2j9h
        8Kp8ijK628X79p4wqr7vZeW9edWMPukUyQN1xxsoVaUpEpOuFHCHxGfytmu2zOPZZFMVaLQ+bg1tx
        gVKDuO7Vz2xZaLlmcjVB2kH7K+gszrqeuM+SvPvuF0cOLk5ewB1yIBWaLyNerv1IKMmWX+xkRS9em
        IYGLimdeSugWxXYmyymg6uUvlP2nDBhNyxndCaeGNQKDS5Wn0M4lhGELi/AUneYCwTtFwt1ceVdss
        S8KuLGR3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hL5PC-0003U0-Ql; Mon, 29 Apr 2019 12:29:10 +0000
Date:   Mon, 29 Apr 2019 05:29:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Murphy <tmurphy@arista.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190429122910.GA13153@infradead.org>
References: <20190424165051.13614-1-tmurphy@arista.com>
 <20190426140429.GG24576@8bytes.org>
 <CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com>
 <20190429115916.GA5349@infradead.org>
 <CAPL0++7G4zNp76z_8bzV84ky2vXeoX2jTCLSCC-CCWZMgwP5Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPL0++7G4zNp76z_8bzV84ky2vXeoX2jTCLSCC-CCWZMgwP5Pw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 01:17:44PM +0100, Tom Murphy wrote:
> Yes. My patches depend on the "iommu/vt-d: Delegate DMA domain to
> generic iommu" patch which is currently being reviewed.

Nice!
