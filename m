Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEE6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC537205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEGGhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:37:40 -0400
Received: from verein.lst.de ([213.95.11.211]:57709 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfEGGhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:37:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 21A4A67358; Tue,  7 May 2019 08:37:21 +0200 (CEST)
Date:   Tue, 7 May 2019 08:37:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] arm64/iommu: handle non-remapped addresses in
 ->mmap and ->get_sgtable
Message-ID: <20190507063720.GB28147@lst.de>
References: <20190430105214.24628-1-hch@lst.de> <20190430105214.24628-2-hch@lst.de> <20190503113352.GA55449@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503113352.GA55449@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 12:33:53PM +0100, Catalin Marinas wrote:
> On Tue, Apr 30, 2019 at 06:51:50AM -0400, Christoph Hellwig wrote:
> > DMA allocations that can't sleep may return non-remapped addresses, but
> > we do not properly handle them in the mmap and get_sgtable methods.
> > Resolve non-vmalloc addresses using virt_to_page to handle this corner
> > case.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Given that this is a bug fix mostly separate from the rest of the
series - do you want to pick it up for 5.2 and maybe add a Cc for
stable?
