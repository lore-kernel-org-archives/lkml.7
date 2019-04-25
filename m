Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4723C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952A4217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bMPCxBqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfDYICq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:02:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDYICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kX6WudnBQj5n7sbBrsCnVPT+f1bs4n2zdzHDcQh0phI=; b=bMPCxBqCiOddfeqSk0+VS8Xqc
        MfkUVUhjKK4M3OMBXbGusKRNNKvBTJ4uiGCR6WXq3QKslD6NPW937RfNOek5tei1sJOxxq3mR00Xb
        H2lvtQHWdw3sBl/o7hYHYoaE+whNsAZzZx9FRE1hDFddP1trHeOlLh4O4gY7JUj5Azi9pnyx9iMYf
        Jec4qEmOziNR8yM2eTVjQSgZFUxTDKlUnzSD38SceyHnfgjPW3OkBWQdoUCKwiW5Wd02oUQ90s6eq
        OWLsNoZ8qA/CzVPkoiKMsiXBcJyDqv5EFWUL/vG6T/msjqKwzrqvq0PDkn6LctlTe4w6rDZfryIm/
        LWngP7HlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJZL9-0002oM-JL; Thu, 25 Apr 2019 08:02:43 +0000
Date:   Thu, 25 Apr 2019 01:02:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     jgg@mellanox.com, imre.deak@intel.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: sg_dma_page_iter offset & length considerations
Message-ID: <20190425080243.GA10677@infradead.org>
References: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that mmc uses block layer helpers to build the sg list you
just have to set the right block layer and DMA layer (in case an
iommu merges during map_sg) dma_boundary paramters (PAGE_SIZE - 1),
and you should get sglists formatted to your requirements, no need
to use an iterator.
