Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F4C32754
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079F8217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfHFFXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:23:30 -0400
Received: from verein.lst.de ([213.95.11.211]:53115 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731625AbfHFFX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:23:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A815768B05; Tue,  6 Aug 2019 07:23:25 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:23:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH] dma-direct: don't truncate dma_required_mask to bus
 addressing capabilities
Message-ID: <20190806052325.GB13409@lst.de>
References: <20190805155153.11021-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805155153.11021-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 05:51:53PM +0200, Lucas Stach wrote:
> The dma required_mask needs to reflect the actual addressing capabilities
> needed to handle the whole system RAM. When truncated down to the bus
> addressing capabilities dma_addressing_limited() will incorrectly signal
> no limitations for devices which are restricted by the bus_dma_mask.
> 
> Fixes: b4ebe6063204 (dma-direct: implement complete bus_dma_mask handling)
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Yeah, this looks sensible.  Atish, can you check if this helps on the
HiFive board as well?
