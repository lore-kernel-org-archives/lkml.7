Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA19C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E295720674
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i8EIHBME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfIBUIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 16:08:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 16:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xqxQuwGBw6IqNxgSm5Uk9jgJRjqBVsfSI8lAUbmGfV4=; b=i8EIHBMEftogkv/Q4l1Z30fTwF
        wSoRIKc1rZ0/PDqW6fA5cgWNwUrkNbIwUO1CtM6Wggse9XoGsH1g+XRgVJ6D4GzYdcx/+zcEpMBXY
        Q1s/XqFVuhhfDcVUYZ2a9zywSk+2W48Ffl/4r5ULvh05/+Jz4QKkn+7Ai2FD4mVsMfg/M8IcS+n0S
        wpeInxH4J2+qaWK7qIldbKIkJZtHp00BMZgo8tjQuhXjFWXpVx53vFvCV8BQEQCjTdqek0DDMzNba
        qMfyUBAcUk+mPjSsnvzcMamBOfxb9B+85XTAQYlp1mFPSrh0448iNMyd4K8TkigLWYnZCAOa2+BSW
        7y+gxiOw==;
Received: from [2001:4bb8:18c:1755:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4scL-0007MQ-5U; Mon, 02 Sep 2019 20:08:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dma-mapping: remove dma_release_declared_memory
Date:   Mon,  2 Sep 2019 22:07:43 +0200
Message-Id: <20190902200746.16185-2-hch@lst.de>
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

This function is entirely unused given that declared memory is
generally provided by platform setup code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API.txt   | 11 -----------
 include/linux/dma-mapping.h |  6 ------
 kernel/dma/coherent.c       | 11 -----------
 3 files changed, 28 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index e47c63bd4887..c0865ca664b8 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -595,17 +595,6 @@ For reasons of efficiency, most platforms choose to track the declared
 region only at the granularity of a page.  For smaller allocations,
 you should use the dma_pool() API.
 
-::
-
-	void
-	dma_release_declared_memory(struct device *dev)
-
-Remove the memory region previously declared from the system.  This
-API performs *no* in-use checking for this region and will return
-unconditionally having removed all the required structures.  It is the
-driver's job to ensure that no parts of this memory region are
-currently in use.
-
 Part III - Debug drivers use of the DMA-API
 -------------------------------------------
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 48ebe8295987..165cd61f1c6e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -753,7 +753,6 @@ static inline int dma_get_cache_alignment(void)
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size);
-void dma_release_declared_memory(struct device *dev);
 #else
 static inline int
 dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
@@ -761,11 +760,6 @@ dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 {
 	return -ENOSYS;
 }
-
-static inline void
-dma_release_declared_memory(struct device *dev)
-{
-}
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 29fd6590dc1e..7271cda86a37 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -124,17 +124,6 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 }
 EXPORT_SYMBOL(dma_declare_coherent_memory);
 
-void dma_release_declared_memory(struct device *dev)
-{
-	struct dma_coherent_mem *mem = dev->dma_mem;
-
-	if (!mem)
-		return;
-	dma_release_coherent_memory(mem);
-	dev->dma_mem = NULL;
-}
-EXPORT_SYMBOL(dma_release_declared_memory);
-
 static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
 		ssize_t size, dma_addr_t *dma_handle)
 {
-- 
2.20.1

