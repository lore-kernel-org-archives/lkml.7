Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E41AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082A62067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 05:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4LZ3dc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfHNFQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 01:16:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfHNFQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N5UgffLx0K9E7sg8gJhbNytPcPQiUdiEfXRwQzPYz8M=; b=T4LZ3dc4L7KIXFyNLJInPyudn
        B/ntFTV2Au8ljYqdObvWwLB/8U2dwgaV7MhxXWpfSy6/RZJZCp7VJ0KDvTogqmgcIJWxOwVqGoqAm
        d7WGhRVuSLvtFMzyYwrFSrbQj9kFsBzqw6OIxsmOTpcV2Y6C4drERFtKvvXDjoUll8X6l+XLz3Pks
        59L/rbuv+kTE+bAgEWUSIfqbjl98Odw0hAS5k5xAvxgopQLYs7QHi5KWP50nV3XLonvnGLE4P0hwL
        GCdw2ky9NRSES21nonHbSkpQTOAA8cEnMR80zexx1I8iiLsupG0ABL2/LZiVvhOSKQSRKS6pPttDP
        O1OK21zQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxldr-0001tl-8b; Wed, 14 Aug 2019 05:16:11 +0000
Date:   Tue, 13 Aug 2019 22:16:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mmap.c: extract __vma_unlink_list as counter part
 for __vma_link_list
Message-ID: <20190814051611.GA1958@infradead.org>
References: <20190814021755.1977-1-richardw.yang@linux.intel.com>
 <20190814021755.1977-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814021755.1977-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, is there any good reason we don't use a list_head for vma linkage?
