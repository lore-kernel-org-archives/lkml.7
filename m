Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B5DC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2FB2253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003569;
	bh=kBs+PGhfDJoXp+X0PDY6anu/CdS5IPxlDl/7I/nC9Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eLkQybjgn60REyEudO8qNn5x266UZvyILrKxmke3THP8E2zmOGGAym0RgGIrPDhfE
	 uhvocBJ3MK/B+QzAhv0BzL0XQjWeQnIStvVODfIRBTZWeXPb/n1KHzpG0rwP1DT7Ef
	 PqOPJfmQ5I7BET2WLaFOVsegsZXy06fhrZSOv+V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgABWT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgABWTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:19:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3181D2253D;
        Thu,  2 Jan 2020 22:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003562;
        bh=kBs+PGhfDJoXp+X0PDY6anu/CdS5IPxlDl/7I/nC9Gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJ4zJKISzQXgq/c4ezEoYfIY6MN41Y85gmYSrakBvjbrbpUB1p4ENku4WbMbRAvqh
         XUzPCwijd0VLk8CV8WRFzWR4Un4PVmzvKps1bKK18thcAYVp2f2p0Q4hb6P96HQJr+
         ilPYOJfflNxCDREiW1w0fwONj3CE/xfqqd33X8sc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 006/114] iommu: rockchip: Free domain on .domain_free
Date:   Thu,  2 Jan 2020 23:06:18 +0100
Message-Id: <20200102220029.805232190@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

[ Upstream commit 42bb97b80f2e3bf592e3e99d109b67309aa1b30e ]

IOMMU domain resource life is well-defined, managed
by .domain_alloc and .domain_free.

Therefore, domain-specific resources shouldn't be tied to
the device life, but instead to its domain.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/rockchip-iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ad3e2b97469e..140b287e886c 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -977,13 +977,13 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	if (!dma_dev)
 		return NULL;
 
-	rk_domain = devm_kzalloc(dma_dev, sizeof(*rk_domain), GFP_KERNEL);
+	rk_domain = kzalloc(sizeof(*rk_domain), GFP_KERNEL);
 	if (!rk_domain)
 		return NULL;
 
 	if (type == IOMMU_DOMAIN_DMA &&
 	    iommu_get_dma_cookie(&rk_domain->domain))
-		return NULL;
+		goto err_free_domain;
 
 	/*
 	 * rk32xx iommus use a 2 level pagetable.
@@ -1018,6 +1018,8 @@ err_free_dt:
 err_put_cookie:
 	if (type == IOMMU_DOMAIN_DMA)
 		iommu_put_dma_cookie(&rk_domain->domain);
+err_free_domain:
+	kfree(rk_domain);
 
 	return NULL;
 }
@@ -1046,6 +1048,7 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 
 	if (domain->type == IOMMU_DOMAIN_DMA)
 		iommu_put_dma_cookie(&rk_domain->domain);
+	kfree(rk_domain);
 }
 
 static int rk_iommu_add_device(struct device *dev)
-- 
2.20.1



