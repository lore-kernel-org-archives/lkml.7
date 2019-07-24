Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6A5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB5221852
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfGXRzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:55:54 -0400
Received: from verein.lst.de ([213.95.11.211]:53005 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGXRzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:55:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4813E68B20; Wed, 24 Jul 2019 19:55:51 +0200 (CEST)
Date:   Wed, 24 Jul 2019 19:55:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] arm: use swiotlb for bounce buffer on LPAE configs
Message-ID: <20190724175551.GA13073@lst.de>
References: <20190709142011.24984-1-hch@lst.de> <20190709142011.24984-3-hch@lst.de> <a447eae1bb46fe753f7a62fb8932e680b79b1635.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a447eae1bb46fe753f7a62fb8932e680b79b1635.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 07:23:50PM +0200, Nicolas Saenz Julienne wrote:
> Out of curiosity, what is the reason stopping us from using dma-direct/swiotlb
> instead of arm_dma_ops altogether?

Nothing fundamental.  We just need to do a very careful piecemeal
migration as the arm code handles a ot of interesting corner case and
we need to ensure we don't break that.  I have various WIP patches
for the easier bits and we can work from there.
