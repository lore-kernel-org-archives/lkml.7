Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF02C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E322820825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SmjV52WJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfDOGdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:33:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pNf9pfvgLdccEDVgSHx2Yxh5Htmh35hVEg69OaFdf8k=; b=SmjV52WJpL/Qv7ymPr/M5ytTu
        Y28R9e7uC2IxTOfzDQv6azgmlL16zED6ZddBalcYpYFWirlqtRZyECYYLLuUfNliGqxpowruzoJzv
        y7JQmqP6k08iCHrZhMSe5/jqXmtZ7DIh44lKS1W33wicmljUEPyfxguv5cYbTwYnW3UF3xMn+6mlT
        bbj46TEuL22Q5eIg8QpC0zccRCdNwqxLlD0PUSLYooj6ejcNv2UwXU1Bb68Y4JrwCweGRqfC2YTLG
        JqiwBNBd8LT+6nMdRmAxe6t6LyZyB9bTPopWyRhuqxCte/nKyLQT5Ghji5j7g3hG81IkpBX9UVOny
        EJg6AbwSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFvBf-0002x4-LD; Mon, 15 Apr 2019 06:33:51 +0000
Date:   Sun, 14 Apr 2019 23:33:51 -0700
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
Subject: Re: [PATCH 5/9] iommu/amd: Implement .flush_np_cache
Message-ID: <20190415063351.GD1377@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
 <20190411184741.27540-6-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411184741.27540-6-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void amd_iommu_flush_np_cache(struct iommu_domain *domain,
> +		unsigned long iova, size_t size)
> +{
> +	struct protection_domain *dom = to_pdomain(domain);
> +
> +	if (unlikely(amd_iommu_np_cache)) {

Is this case really so unlikely that it needs a static branch prediction
hint?
