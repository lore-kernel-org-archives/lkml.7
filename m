Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36185C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121B921841
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 12:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfEKMlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 08:41:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35172 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEKMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 08:41:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hPRJo-0008Us-2r; Sat, 11 May 2019 12:41:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: remove redundant assignment to variable npages
Date:   Sat, 11 May 2019 13:41:35 +0100
Message-Id: <20190511124135.3635-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable npages is being initialized however this is never read and
later it is being reassigned to a new value. The initialization is
redundant and hence can be removed.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 09c9e45f7fa2..c0b5b9298e8e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2609,7 +2609,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	unsigned long startaddr;
-	int npages = 2;
+	int npages;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
-- 
2.20.1

