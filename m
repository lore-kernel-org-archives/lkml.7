Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26EAC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B39217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bZAG/LpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbfGYMp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:45:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387824AbfGYMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=emJzk9odpy1wnlUGcXdIzUFv1SXJfSlgageYxVB9ttk=; b=bZAG/LpGP+NKh/MRi5Jp7hN47
        vKXsFv3Bu6+0/pdl2vCAYrsqSPKfBRywv94yzvNfiMY6g6uX3kw6mM4o81ToVJDZv/pFkaZyTjZUu
        I/Q4jl9/olAhVQ9D0Uz9XdfucTea6rY9EjI0Rav6U1Z8bDIq/oFRdysjtDIUa1gSMKpEIapfAQH5T
        xW/kxfgeS724msQMeqnj/mTwjNZJPOtWgplC5gYmbPAXeDTWrS7FPmcHpweGDlN3XnlwABxrrvIla
        Yf3iJxbBuVoBI6Eq//Lv8a0s3zzjq8GefmXitCKCK9SQMB+SEAlBTstJ7hKELthxI2NxL8b687Y05
        kCM2zAFxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqd7c-0008GX-Lj; Thu, 25 Jul 2019 12:45:24 +0000
Date:   Thu, 25 Jul 2019 05:45:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Message-ID: <20190725124524.GB20286@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <CA+M3ks6yPTV4i=wEu41bHqMsn_VkYUj=y9BXGmgDgovnT9ESfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+M3ks6yPTV4i=wEu41bHqMsn_VkYUj=y9BXGmgDgovnT9ESfA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:08:54AM +0200, Benjamin Gaignard wrote:
> CMA has made possible to get large regions of memories and to give some
> priority on device allocating pages on it. I don't think that possible
> with system
> heap so I suggest to keep CMA heap if we want to be able to port a maximum
> of applications on dma-buf-heap.

Yes, CMA is a way to better allocate contigous regions, but it isn't
the only way to do that.

So at least for the system default CMA area it really should be a helper
for the system heap, especially given that CMA is an optional feature
and we can do high order contigous allocations using alloc_pages as
well.

Something like:

	if (!require_contigous && order > 0) {
		for (i = 0; i < nr_pages; i++)
			page[i] = alloc_page();
		goto done;
	} else if (order > 0)
		page = cma_alloc();
		if (page)
			goto done;
	}

	page = alloc_pages(order);
