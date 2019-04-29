Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80B42075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfD2TEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:04:05 -0400
Received: from verein.lst.de ([213.95.11.211]:40600 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfD2TEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:04:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6398268AFE; Mon, 29 Apr 2019 21:03:48 +0200 (CEST)
Date:   Mon, 29 Apr 2019 21:03:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/26] iommu/dma: Refactor iommu_dma_free
Message-ID: <20190429190348.GB5637@lst.de>
References: <20190422175942.18788-1-hch@lst.de> <20190422175942.18788-15-hch@lst.de> <8321a363-f448-3e48-48f6-58d2b44a2900@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8321a363-f448-3e48-48f6-58d2b44a2900@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 02:59:43PM +0100, Robin Murphy wrote:
> Hmm, I do still prefer my original flow with the dma_common_free_remap() 
> call right out of the way at the end rather than being a special case in 
> the middle of all the page-freeing (which is the kind of existing 
> complexity I was trying to eliminate). I guess you've done this to avoid 
> having "if (!dma_release_from_contiguous(...))..." twice like I ended up 
> with, which is fair enough I suppose - once we manage to solve the new 
> dma_{alloc,free}_contiguous() interface that may tip the balance so I can 
> always revisit this then.

Ok, I'll try to accomodate that with a minor rework.
