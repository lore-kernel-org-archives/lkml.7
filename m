Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17479C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73A3204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEGJF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:05:57 -0400
Received: from foss.arm.com ([217.140.101.70]:47416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfEGJF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:05:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE3B374;
        Tue,  7 May 2019 02:05:57 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 868BD3F238;
        Tue,  7 May 2019 02:05:55 -0700 (PDT)
Date:   Tue, 7 May 2019 10:05:50 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] arm64/iommu: handle non-remapped addresses in
 ->mmap and ->get_sgtable
Message-ID: <20190507090550.GA16148@fuggles.cambridge.arm.com>
References: <20190430105214.24628-1-hch@lst.de>
 <20190430105214.24628-2-hch@lst.de>
 <20190503113352.GA55449@arrakis.emea.arm.com>
 <20190507063720.GB28147@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507063720.GB28147@lst.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 08:37:20AM +0200, Christoph Hellwig wrote:
> On Fri, May 03, 2019 at 12:33:53PM +0100, Catalin Marinas wrote:
> > On Tue, Apr 30, 2019 at 06:51:50AM -0400, Christoph Hellwig wrote:
> > > DMA allocations that can't sleep may return non-remapped addresses, but
> > > we do not properly handle them in the mmap and get_sgtable methods.
> > > Resolve non-vmalloc addresses using virt_to_page to handle this corner
> > > case.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Given that this is a bug fix mostly separate from the rest of the
> series - do you want to pick it up for 5.2 and maybe add a Cc for
> stable?

Sure thing; I'll probably send it after -rc1 unless we get some other fixes
in during the merge window.

Will
