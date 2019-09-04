Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB9C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E332339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EPgCnv3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfIDNQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:16:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbfIDNQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ngepyp17twGTeYQ8Cw2V78KUkItUxdkjHkfPYs5tJiE=; b=EPgCnv3/3HMoDmVsbpFjvbyTDM
        0neIHRURrGJEadkGkuEjNUD1pZiPkf4j+wRMTw/4qqa9FCC0XT9d8K1r9moXgys751vncLs835TX4
        okmT3e8VY548HAPx1xrCQz/lrTC5V1mAmkfOTGQGOfbqhQvJHmm6t8YFCyRyqgDOdfticjqyeKmgn
        aprsSCdziDmx/xCEXAIEo1LvYpFjlvJs7xLtZ/FuYxgMBrNCnsIVi2KcbG8dsXBlcgc0Fm5N2Uvmm
        sf7DBwSRYPg0yaXJ0GPXLkTaNRd3qXnHAsE9h0BSjZmA2UVws5dm6VaOKye6MBJ5Gr8Gc1SMmr+IR
        xaC9yM/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5V9K-0000oJ-GN; Wed, 04 Sep 2019 13:16:38 +0000
Date:   Wed, 4 Sep 2019 06:16:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma api errors with swiotlb
Message-ID: <20190904131638.GA29164@infradead.org>
References: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
 <20190904121722.GA15601@infradead.org>
 <4e21951d-025a-2b3d-14c8-878c6f237525@shipmail.org>
 <20190904125538.GA30177@infradead.org>
 <a78c4100-4f93-d96d-60d1-d965a7769fca@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a78c4100-4f93-d96d-60d1-d965a7769fca@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:02:14PM +0200, Thomas Hellström (VMware) wrote:
> It looks like it does that, although when we send it, the SWIOTLB error has
> already occured and been printed out, and then the sequence starts again.

Well, the only way to really find out is to try.  We also have a
backoff algorithm in the SCSI midlayer, so it should not be much of
an inpact.  If you care about the warnings they can be disabled using
DMA_ATTR_NO_WARN.  I have to admit that I'm not even sure the warnings
are all that useful, but that's something you need to take up with
the swiotlb maintainer.
