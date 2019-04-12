Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CEAC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922CF20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkd5xlmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDLOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:43:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9k4nQZPif7ndSOFrX9noMGAIl+nulGOO2bXKPiEFONo=; b=dkd5xlmUVRxboDcz0a4HtGo8Y
        AzX6Nakz0CeqqRH/AX7LWET5GmWMLLbDD0U+WN15tayfLIHdw0a2KYYI/uUM142XMLOI5UQwLvgP8
        IUa/FfABeGFiWywp+XOLaaWGhd6tVkGthtc6X8dgedn2MDOke3eORdCIrbnCWhbJuVufEBZkk/mts
        NnLHIfR9db3oCCGBSAdiaOqgnHXV0yvXVQL7tYC/FJu8SCh52q+ulOepvQT87mZldZ4XANjHo639M
        mU5Y6CKSG4fmXOzoz3LsWbmAEJv1Vm4AWF/fkblURLt7mPk4sQtTzWhuDagWatkyBL3X2WTo0exOP
        XSLYaiMZQ==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hExOw-0001xe-S8; Fri, 12 Apr 2019 14:43:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     robdclark@gmail.com
Cc:     iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] qcom_iommu: fix a config symbol typo
Date:   Fri, 12 Apr 2019 16:43:11 +0200
Message-Id: <20190412144311.12949-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm/arm64 symbol for big endian builds is CONFIG_CPU_BIG_ENDIAN,
not CONFIG_BIG_ENDIAN.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/qcom_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 8cdd3f059513..69f58b633f9d 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -280,7 +280,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE |
 			SCTLR_M | SCTLR_S1_ASIDPNE | SCTLR_CFCFG;
 
-		if (IS_ENABLED(CONFIG_BIG_ENDIAN))
+		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 			reg |= SCTLR_E;
 
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, reg);
-- 
2.20.1

