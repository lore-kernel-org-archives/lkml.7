Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4737BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C6020674
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IKK7dOAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfIBUIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 16:08:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBUIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 16:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BVNq47HXj2pt+zogEJG8nkEiH0l4/wH9jA+1tCZXI6w=; b=IKK7dOAUG6pwQ3QFcv9Q2x3ZUH
        zOxu0VV1ODcT6ycsRhGaL+MdqFJ01nNbP+4sqBmq5bM29wdnYvaIABqI6YxK58JfVVNG2KhxBbqQK
        XPkkhiI+gfs7TMrLKbB6Ba7JliUxN20U6GoWVZhqEFfe3+GEJ2zTrkLwNEQDgcemLy63W+bI8zMvF
        bLTvdnpWAYqzHN1ws/GsnN/cPWtw8y0I7E1I/p8LDh73tt7L2WNkvP1gE4BJL0jciVjdmLL1Jsz+j
        UThFdNhTBiUCzaxg6co3+rfiWR4B05AkSdBR0XGwMCeakPNbl4RdnNcNrwM1aqNvdoFw3H2iCKH9j
        Jtw4ezfw==;
Received: from [2001:4bb8:18c:1755:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4scc-0007Od-Gn; Mon, 02 Sep 2019 20:08:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dma-mapping: remove the dma_declare_coherent_memory export
Date:   Mon,  2 Sep 2019 22:07:46 +0200
Message-Id: <20190902200746.16185-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902200746.16185-1-hch@lst.de>
References: <20190902200746.16185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_declare_coherent_memory is something that the platform setup code
(which pretty much means the device tree these days) need to do so that
drivers can use the memory as declared by the platform.  Drivers
themselves have no business calling this function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/coherent.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 7cafe1affdc9..545e3869b0e3 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -122,7 +122,6 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 		dma_release_coherent_memory(mem);
 	return ret;
 }
-EXPORT_SYMBOL(dma_declare_coherent_memory);
 
 static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
 		ssize_t size, dma_addr_t *dma_handle)
-- 
2.20.1

