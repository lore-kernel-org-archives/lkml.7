Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C4CC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651222598B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KRm8qX1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfEaQcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:32:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=71MT+BROvQCbPstDEU/GSeEYIz2R3vLcby0U7n4LLfY=; b=KRm8qX1ifVr9clKQgPQOzBCIX
        5tOQM22B22476qAO11z49POuV0WFuttFD147Sio3LcgfdkcNHLGLpRuCTgkvxXbCamh15MJCX7TwT
        pIRxuAEyJgKmVL2vlhOwM+Z93AtSS3/MhVMwIaZlFhMcfOsn7GOgd1/wSuA+wWLTY752BsJLEZ+Bu
        lkcXe/xe4BlysB2zjEEaMWjWuLlS1imej7I2WEaFy2y/woAEHj/8ViFu141ug5u8ey9ElaYvX1Rst
        1oMgg0dyoHRukxYhLQlc1GeatYALHXRpBZDxVWuIfhb3B/llNOQfd8lw662bBJBIDZgnUOr/bJRBS
        FV/pugisw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWkSD-0003l4-C7; Fri, 31 May 2019 16:32:29 +0000
Date:   Fri, 31 May 2019 09:32:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     laurentiu.tudor@nxp.com
Cc:     netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, Joakim.Tjernlund@infinera.com,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/6] dpaa_eth: fix iova handling for contiguous frames
Message-ID: <20190531163229.GA8708@infradead.org>
References: <20190530141951.6704-1-laurentiu.tudor@nxp.com>
 <20190530141951.6704-6-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530141951.6704-6-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 05:19:50PM +0300, laurentiu.tudor@nxp.com wrote:
> +static phys_addr_t dpaa_iova_to_phys(const struct dpaa_priv *priv,
> +				     dma_addr_t addr)
> +{
> +	return priv->domain ? iommu_iova_to_phys(priv->domain, addr) : addr;
> +}

Again, a driver using the iommu API must not call iommu_* APIs.

This chane is not acceptable.
