Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4F6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4E12089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfEVNJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:09:45 -0400
Received: from verein.lst.de ([213.95.11.211]:39448 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbfEVNJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:09:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DC0B267358; Wed, 22 May 2019 15:09:21 +0200 (CEST)
Date:   Wed, 22 May 2019 15:09:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Message-ID: <20190522130921.GA26874@lst.de>
References: <20190522072018.10660-1-horia.geanta@nxp.com> <20190522123243.GA26390@lst.de> <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 01:50:47PM +0100, Robin Murphy wrote:
> Would that work out any different from the existing DMA_ATTR_SKIP_CPU_SYNC? 
>
> If drivers are prepared to handle this issue from their end, they can 
> already do so for single mappings by using that attr along with explicit 
> partial syncs via dma_sync_single(). For page/sg mappings we'd still have 
> the problem of identifying what part of "partial" actually matters, and 
> probably having to add some additional new sync operations to cope.

Except that the same optimization we are tripping over here is also
present in dma_sync_* - dma_sync_*_to_device with DMA_FROM_DEVICE is a
no-op in swiotlb.
