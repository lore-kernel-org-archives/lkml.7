Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939CBC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663D920674
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eR12wCXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfIBUIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 16:08:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBUIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 16:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LdVrxkL37VTklHgUT3hBqRPwtefR2ZTRSxffxyS1bNQ=; b=eR12wCXrzskT5yKF1EtGfMTIMC
        vZO29ISsn2SsgNgCKOVf61BsrSaQD1/XVR6ffJvy77NmG9RyMaLCYU673eUuzIxBnDM7iPvPkgDek
        V1Jh6CGzMVA880f+FelEGBscMWDTL5BLMmEEtdykAixCnjvEosgvRe9ElmCO23oBab9pvPtm3aPbn
        nKMXn6TP57hSjzkFNg9HndaaQsZAd4xVPO9Hj/1jWHlJAGOFCVD+1XFqgNA6qKn5dyZZacAtfNtBD
        fMLLoRFGC6/uJ6zUcYJVvn9NnFqsm8B07tqEQHsf/O8ZNQrrmJUbHDA6Nc0MU4WzWbJy2nPqkqT95
        JzuhOtgw==;
Received: from [2001:4bb8:18c:1755:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4scQ-0007Mi-SU; Mon, 02 Sep 2019 20:08:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dma-mapping: remove the dma_mmap_from_dev_coherent export
Date:   Mon,  2 Sep 2019 22:07:44 +0200
Message-Id: <20190902200746.16185-3-hch@lst.de>
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

dma_mmap_from_dev_coherent is only used by dma_map_ops instances,
none of which is modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/coherent.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 7271cda86a37..7cafe1affdc9 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -277,7 +277,6 @@ int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 
 	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
 }
-EXPORT_SYMBOL(dma_mmap_from_dev_coherent);
 
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
 				   size_t size, int *ret)
-- 
2.20.1

