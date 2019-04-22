Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E0BC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FA820643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963520;
	bh=IAPikkAGx80dK1h5T9epE5Abk7jyy3k1wkTycyh9lBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C6GT+ZuS9GUdGl4bxuSgA0jCT3mgJ83LPVSe5Wd5YjF8c3p3lyXCiDv6Bx2IOM3MT
	 yCJ7fm7XgBk9NCiID8zQGYXr/XH/ylf2SRGttuKyzWNGJhn+NI+JhIXd+lp9pR6vWa
	 3K/tPStT8lk3iBPMuPutZHnKvG/sFscp0ND5dfoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfDVUFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729664AbfDVTpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3DD21902;
        Mon, 22 Apr 2019 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962307;
        bh=IAPikkAGx80dK1h5T9epE5Abk7jyy3k1wkTycyh9lBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjfhBAP9sWOr6bN6PcptyyaUHBWT6h3bhLSS6rxdJtiYCSAbJ2Rxa9zNe17yXiSrq
         PCwqA3SohJKWYv9HcCX/49nJF4DgD160stQee8UQwyUzaVUbSkLuEOT66W0Tz0Wi4q
         /fFlN4hZm6FCwr1dyyQoF8SsuxNQ51FI9861pTZM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.0 94/98] iommu/amd: Reserve exclusion range in iova-domain
Date:   Mon, 22 Apr 2019 15:42:01 -0400
Message-Id: <20190422194205.10404-94-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 8aafaaf2212192012f5bae305bb31cdf7681d777 ]

If a device has an exclusion range specified in the IVRS
table, this region needs to be reserved in the iova-domain
of that device. This hasn't happened until now and can cause
data corruption on data transfered with these devices.

Treat exclusion ranges as reserved regions in the iommu-core
to fix the problem.

Fixes: be2a022c0dd0 ('x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c       | 9 ++++++---
 drivers/iommu/amd_iommu_init.c  | 7 ++++---
 drivers/iommu/amd_iommu_types.h | 2 ++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e628ef23418f..55b3e4b9d5dc 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3166,21 +3166,24 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
+		int type, prot = 0;
 		size_t length;
-		int prot = 0;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
 
+		type   = IOMMU_RESV_DIRECT;
 		length = entry->address_end - entry->address_start;
 		if (entry->prot & IOMMU_PROT_IR)
 			prot |= IOMMU_READ;
 		if (entry->prot & IOMMU_PROT_IW)
 			prot |= IOMMU_WRITE;
+		if (entry->prot & IOMMU_UNITY_MAP_FLAG_EXCL_RANGE)
+			/* Exclusion range */
+			type = IOMMU_RESV_RESERVED;
 
 		region = iommu_alloc_resv_region(entry->address_start,
-						 length, prot,
-						 IOMMU_RESV_DIRECT);
+						 length, prot, type);
 		if (!region) {
 			pr_err("Out of memory allocating dm-regions for %s\n",
 				dev_name(dev));
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 66123b911ec8..84fa5b22371e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2013,6 +2013,9 @@ static int __init init_unity_map_range(struct ivmd_header *m)
 	if (e == NULL)
 		return -ENOMEM;
 
+	if (m->flags & IVMD_FLAG_EXCL_RANGE)
+		init_exclusion_range(m);
+
 	switch (m->type) {
 	default:
 		kfree(e);
@@ -2059,9 +2062,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
-		if (m->flags & IVMD_FLAG_EXCL_RANGE)
-			init_exclusion_range(m);
-		else if (m->flags & IVMD_FLAG_UNITY_MAP)
+		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
 			init_unity_map_range(m);
 
 		p += m->length;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index eae0741f72dc..87965e4d9647 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -374,6 +374,8 @@
 #define IOMMU_PROT_IR 0x01
 #define IOMMU_PROT_IW 0x02
 
+#define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
+
 /* IOMMU capabilities */
 #define IOMMU_CAP_IOTLB   24
 #define IOMMU_CAP_NPCACHE 26
-- 
2.19.1

