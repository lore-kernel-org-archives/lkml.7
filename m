Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11072C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12BD2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbfEWQn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:43:58 -0400
Received: from verein.lst.de ([213.95.11.211]:47936 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731156AbfEWQn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:43:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 941CA68AFE; Thu, 23 May 2019 18:43:32 +0200 (CEST)
Date:   Thu, 23 May 2019 18:43:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Message-ID: <20190523164332.GA22245@lst.de>
References: <20190522072018.10660-1-horia.geanta@nxp.com> <20190522123243.GA26390@lst.de> <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com> <20190522130921.GA26874@lst.de> <fdfd7318-7999-1fe6-01b6-ae1fb7ba8c30@arm.com> <20190522133400.GA27229@lst.de> <CGME20190522135556epcas2p34e0c14f2565abfdccc7035463f60a71b@epcas2p3.samsung.com> <ed26de5e-aee4-4e19-095c-cc551012d475@arm.com> <0c79721a-11cb-c945-5626-3d43cc299fe6@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c79721a-11cb-c945-5626-3d43cc299fe6@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 07:35:07AM +0200, Marek Szyprowski wrote:
> Don't we have DMA_BIDIRECTIONAL for such case?

Not sure if it was intended for that case, but it definitively should
do the right thing for swiotlb, and it should also do the right thing
in terms of cache maintainance.

> Maybe we should update 
> documentation a bit to point that DMA_FROM_DEVICE expects the whole 
> buffer to be filled by the device?

Probably. Horia, can you try to use DMA_BIDIRECTIONAL?
