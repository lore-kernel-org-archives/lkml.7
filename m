Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B27CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E645D2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfJaPvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:51:50 -0400
Received: from foss.arm.com ([217.140.110.172]:50884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaPvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:51:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2CF41F1;
        Thu, 31 Oct 2019 08:51:49 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFB3B3F71E;
        Thu, 31 Oct 2019 08:51:47 -0700 (PDT)
Date:   Thu, 31 Oct 2019 15:51:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Qian Cai <cai@lca.pw>, f.fainelli@gmail.com, mbrugger@suse.com,
        marc.zyngier@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        Robin Murphy <Robin.Murphy@arm.com>, phill@raspberrypi.org,
        will@kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
Message-ID: <20191031155145.GF39590@arrakis.emea.arm.com>
References: <6703f8dab4a21fe4e1049f8f224502e1733bf72c.camel@suse.de>
 <A1A8EEF0-2273-4338-B4D8-D9B1328484B4@lca.pw>
 <9208de061fe2b9ee7b74206b3cd52cc116e43ac0.camel@suse.de>
 <AA6D37F1-A1B3-4EC4-8620-007095168BC7@lca.pw>
 <1956a2c8f4911b2a7e2ba3c53506c0f06efb93f8.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1956a2c8f4911b2a7e2ba3c53506c0f06efb93f8.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry, I've been away last week and only now caught up with emails)

On Tue, Oct 22, 2019 at 01:23:32PM +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2019-10-21 at 16:36 -0400, Qian Cai wrote:
> > I managed to get more information here,
> > 
> > [    0.000000] cma: dma_contiguous_reserve(limit c0000000)
> > [    0.000000] cma: dma_contiguous_reserve: reserving 64 MiB for global area
> > [    0.000000] cma: cma_declare_contiguous(size 0x0000000004000000, base
> > 0x0000000000000000, limit 0x00000000c0000000 alignment 0x0000000000000000)
> > [    0.000000] cma: Failed to reserve 512 MiB
> > 
> > Full dmesg:
> > 
> > https://cailca.github.io/files/dmesg.txt
> 
> OK I got it, reproduced it too.
> 
> Here are the relevant logs:
> 
> 	[    0.000000]   DMA      [mem 0x00000000802f0000-0x00000000bfffffff]
> 	[    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
> 	[    0.000000]   Normal   [mem 0x0000000100000000-0x00000097fcffffff]
> 
> As you can see ZONE_DMA spans from 0x00000000802f0000-0x00000000bfffffff which
> is slightly smaller than 1GB.
> 
> 	[    0.000000] crashkernel reserved: 0x000000009fe00000 - 0x00000000bfe00000 (512 MB)
> 
> Here crashkernel reserved 512M in ZONE_DMA.
> 
> 	[    0.000000] cma: Failed to reserve 512 MiB
> 
> CMA tried to allocate 512M in ZONE_DMA which fails as there is no enough space.
> Makes sense.
> 
> A fix could be moving crashkernel reservations after CMA and then if unable to
> fit in ZONE_DMA try ZONE_DMA32 before bailing out. Maybe it's a little over the
> top, yet although most devices will be fine with ZONE_DMA32, the RPi4 needs
> crashkernel to be reserved in ZONE_DMA.

Does RPi4 need CMA in ZONE_DMA? If not, I'd rather reserve the CMA from
ZONE_DMA32.

Even if you moved the crash kernel, someone else might complain that
they had 2GB of CMA and it no longer works.


-- 
Catalin
