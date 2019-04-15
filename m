Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05716C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C703420825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uoz1Da3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfDOGbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:31:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOGbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sBvvwLAlcvN1BhPYhrP92KdhFk9vL6RzAU/eyQJbtN8=; b=Uoz1Da3E3lLPQy37LZAVYDF9N0
        FSXo09rFri3MFfGg+C+zaoIiTI7eN36RlIbtThL04wK/u2kQpS2xzfhXM+Ud+O4Ct+mE1sfx7ZTFg
        YmGh5xTERnLVji2ukeZzbEtA7gINkw/hCLv2fzR/mRn8/McAi6nVF8zCRY5is1+KWsEqW5VdpA8qJ
        1neN7XXNcoXfY+iGVJGDg0QR7gaRMbyt930ySxIkwJ6IO7xW1qOMsPn451/zLxJrBCFQj+TpZS2Vi
        Mv7oUB3ugC3VMfWlUJo8zpi1b7fWnvWe9VqLpJBcJK5xUt6D1uRNlNOdta55hpw7VtYEaJ4OCfOJb
        xVDQp4Hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFv8t-0001xP-1u; Mon, 15 Apr 2019 06:30:59 +0000
Date:   Sun, 14 Apr 2019 23:30:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Murphy <tmurphy@arista.com>
Cc:     iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will.deacon@arm.com>,
        David Brown <david.brown@linaro.org>,
        linux-samsung-soc@vger.kernel.org, dima@arista.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        murphyt7@tcd.ie, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/9] iommu/dma-iommu: Add iommu_map_atomic
Message-ID: <20190415063058.GA1377@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
 <20190411184741.27540-2-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411184741.27540-2-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 07:47:30PM +0100, Tom Murphy via iommu wrote:
> The iommu ops .map function (or the iommu_map function which calls it)
> was always supposed to be sleepable (according to Joerg's comment in
> this thread: https://lore.kernel.org/patchwork/patch/977520/ ) and so
> should probably have had a "might_sleep()" since it was written. However
> currently the dma-iommu api can call iommu_map in an atomic context,
> which it shouldn't do. This doesn't cause any problems because any iommu
> driver which uses the dma-iommu api uses gfp_atomic in it's iommu_ops
> .map function. But doing this wastes the memory allocators atomic pools.
> 
> Add a new function iommu_map_atomic, use it in the dma-iommu api and add
> “might_sleep()” to the iommu_map function.
> 
> After this change all drivers which use the dma-iommu api need to
> implement the new iommu ops .map_atomic function. For the moment just
> reuse the driver's iommus ops .map function for .map_atomic.

Instead of duplicating the callchain shouldn't we just pass down a flag
to indicate if the context can sleep or not?  Especially as all the
existing arm drivers already implement the atomic behavior, which is
a majority of struct iommu_ops based iommu drivers.
