Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2BEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DFD20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ag3h7z/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfDPSYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y6uxTTe3gNAo9vdISLF79GTkR1M5Ma468lycBIpZCKY=; b=ag3h7z/QEpiCaSN4dgDyHcx5bK
        HN4ph3+LqnI/EMyseJgdaOlG68550achlPV/qTFeGH0+ZOgu4XeP4OuISxguUctrC0Kwz2NkR4s0x
        XH6enB01rKeIq1lDV9aGerst5bn4nQtJrPVhRqOus7lnAOfLGqgqG3mCbLFRyJlQLpYsInpGs6Nkc
        VQflg9V/zO3MdDTJfQTf/wPcIbeKQi1BdEuDDu2+GQO3Fg9who3RgD6cPVRnXnZu5tghz3e7fbol0
        Q6I9TalEZOZrATD6O1c6ibjtr79MJxYNd5CLOu+JGKMNV0uqrP1PSqsb3VEK3LAfaDahwuqUCYa/1
        YRy8AOjA==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSki-00075i-5N; Tue, 16 Apr 2019 18:24:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] sparc/iommu: use !PageHighMem to check if a page has a kernel mapping
Date:   Tue, 16 Apr 2019 20:23:39 +0200
Message-Id: <20190416182347.18441-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
References: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This deobsfucates the check a bit, and prepares for future changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index e8d5d73ca40d..dcdadac03fdf 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -273,7 +273,8 @@ static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
 		 * XXX Is this a good assumption?
 		 * XXX What if someone else unmaps it here and races us?
 		 */
-		if ((page = (unsigned long) page_address(sg_page(sg))) != 0) {
+		if (!PageHighMem(sg_page(sg))) {
+			page = (unsigned long)page_address(sg_page(sg));
 			for (i = 0; i < n; i++) {
 				if (page != oldpage) {	/* Already flushed? */
 					flush_page_for_dma(page);
-- 
2.20.1

