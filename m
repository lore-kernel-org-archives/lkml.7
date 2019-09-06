Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23517C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0794A2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393855AbfIFOB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:01:28 -0400
Received: from verein.lst.de ([213.95.11.211]:57552 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732131AbfIFOB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:01:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C476768B05; Fri,  6 Sep 2019 16:01:23 +0200 (CEST)
Date:   Fri, 6 Sep 2019 16:01:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        gross@suse.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] swiotlb-xen: simplify cache maintainance
Message-ID: <20190906140123.GA9894@lst.de>
References: <20190905113408.3104-1-hch@lst.de> <20190905113408.3104-10-hch@lst.de> <e4f9b393-2631-57cd-f42f-3581e75ab9a3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4f9b393-2631-57cd-f42f-3581e75ab9a3@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 09:52:12AM -0400, Boris Ostrovsky wrote:
> We need nop definitions of these two for x86.
> 
> Everything builds now but that's probably because the calls are under
> 'if (!dev_is_dma_coherent(dev))' which is always false so compiler
> optimized is out. I don't think we should rely on that.

That is how a lot of the kernel works.  Provide protypes only for code
that is semantically compiled, but can't ever be called due to
IS_ENABLED() checks.  It took me a while to get used to it, but it
actually is pretty nice as the linker does the work for you to check
that it really is never called.  Much better than say a BUILD_BUG_ON().
