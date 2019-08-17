Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0157C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD5D2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfHQGuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:50:17 -0400
Received: from verein.lst.de ([213.95.11.211]:60648 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfHQGuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:50:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70BE768B05; Sat, 17 Aug 2019 08:50:12 +0200 (CEST)
Date:   Sat, 17 Aug 2019 08:50:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Xen-devel] [PATCH 07/11] swiotlb-xen: provide a single
 page-coherent.h header
Message-ID: <20190817065011.GA18599@lst.de>
References: <20190816130013.31154-1-hch@lst.de> <20190816130013.31154-8-hch@lst.de> <9a3261c6-5d92-cf6b-1ae8-3a8e8b5ef0d4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3261c6-5d92-cf6b-1ae8-3a8e8b5ef0d4@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:40:43PM +0100, Julien Grall wrote:
> I am not sure I agree with this rename. The implementation of the helpers 
> are very Arm specific as this is assuming Dom0 is 1:1 mapped.
>
> This was necessary due to the lack of IOMMU on Arm platforms back then.
> But this is now a pain to get rid of it on newer platform...

So if you look at the final version of the header after the whole
series, what assumes a 1:1 mapping?  It all just is

	if (pfn_valid())
		local cache sync;
	else
		call into the arch code;

are you concerned that the local cache sync might have to be split
up more for a non-1:1 map in that case?  We could just move
the xen_dma_* routines into the arch instead of __xen_dma, but it
really helps to have a common interface header.
