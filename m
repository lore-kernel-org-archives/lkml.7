Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A21C31E4B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D422053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="o0tcrE69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfFMRO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:14:59 -0400
Received: from smtp.aristanetworks.com ([52.0.43.43]:48988 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfFLVwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:52:33 -0400
Received: from smtp.aristanetworks.com (localhost [127.0.0.1])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 4416C30DD5A8;
        Wed, 12 Jun 2019 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1560376352;
        bh=0YAEwRV8pxaKDZriNp5u14v56Dsy6P+WWcBl+ItO2zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=o0tcrE69nlTRCy8oBfpiQeJnWgJI43UMXL1JcrYTR2TXwxuLOjTUIkPuuv7MXRqf3
         YDdo4KeSF7MlOXZXb7AcDS73JCOrcTPDsNRD4rK+wv47rTdNi/Dc4KogK0ScKquYPV
         Ayw16OMjHVDyyC60fkrTALrVED6wYi0cwq1M46w3MRBQiHsWK1VL5/PNAqeW/k71J+
         4XnRx4EtiNG+hmSo4aT7WSqrihEBBWcbcaJ+WnRm/tK4ynARFh/fm+IltVeyrfW6d2
         B0MazUx5XKO6Am0eX+nacKTrwXnAepR4LkQz0xllOJX0zJAdCpdDjGtbXR9W0xEe3g
         5b148ONyu7h9A==
Received: from chmeee (unknown [10.80.4.152])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 2AD1730DD5A5;
        Wed, 12 Jun 2019 14:52:32 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
        (envelope-from <kevmitch@chmeee>)
        id 1hbBAV-0003KF-JQ; Wed, 12 Jun 2019 14:52:31 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH 1/3] iommu/amd: make iommu_disable safer
Date:   Wed, 12 Jun 2019 14:52:03 -0700
Message-Id: <20190612215203.12711-2-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612215203.12711-1-kevmitch@arista.com>
References: <20190612215203.12711-1-kevmitch@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it safe to call iommu_disable during early init error conditions
before mmio_base is set, but after the struct amd_iommu has been added
to the amd_iommu_list. For example, this happens if firmware fails to
fill in mmio_phys in the ACPI table leading to a NULL pointer
dereference in iommu_feature_disable.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/iommu/amd_iommu_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index f773792d77fd..3798d7303c99 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -424,6 +424,9 @@ static void iommu_enable(struct amd_iommu *iommu)
 
 static void iommu_disable(struct amd_iommu *iommu)
 {
+	if (!iommu->mmio_base)
+		return;
+
 	/* Disable command buffer */
 	iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
 
-- 
2.20.1

