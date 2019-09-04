Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC70C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0659522CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfIDHAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:00:38 -0400
Received: from verein.lst.de ([213.95.11.211]:36623 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfIDHAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:00:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 57523227A8A; Wed,  4 Sep 2019 09:00:33 +0200 (CEST)
Date:   Wed, 4 Sep 2019 09:00:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] swiotlb-xen: always use dma-direct helpers to
 alloc coherent pages
Message-ID: <20190904070033.GA11643@lst.de>
References: <20190902130339.23163-1-hch@lst.de> <20190902130339.23163-9-hch@lst.de> <5799ca4b-7993-b1c5-73fa-396a560f58e8@oracle.com> <8a7f9e23-ef26-e83b-8d1e-dcd7d233642a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7f9e23-ef26-e83b-8d1e-dcd7d233642a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:25:54PM -0400, Boris Ostrovsky wrote:
> > If I am reading __dma_direct_alloc_pages() correctly there is a path
> > that will force us to use GFP_DMA32 and as Juergen pointed out in
> > another message that may not be desirable.

Yes, it will add GFP_DMA32.  So I guess for now we'll just keep the
direct page allocator calls and resend.  I don't think this is the
right thing to do long term, but I'd really like to get this series
finished.
