Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8752C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B8F2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfHSNXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:23:01 -0400
Received: from 8bytes.org ([81.169.241.247]:50292 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfHSNXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:23:00 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DDBDB1C7; Mon, 19 Aug 2019 15:22:58 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 01/11] iommu: Remember when default domain type was set on kernel command line
Date:   Mon, 19 Aug 2019 15:22:46 +0200
Message-Id: <20190819132256.14436-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819132256.14436-1-joro@8bytes.org>
References: <20190819132256.14436-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Introduce an extensible concept to remember when certain
configuration settings for the IOMMU code have been set on
the kernel command line.

This will be used later to prevent overwriting these
settings with other defaults.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c674d80c37f..3361ca5ef769 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
 static bool iommu_dma_strict __read_mostly = true;
+static u32 iommu_cmd_line __read_mostly;
 
 struct iommu_group {
 	struct kobject kobj;
@@ -68,6 +69,18 @@ static const char * const iommu_group_resv_type_string[] = {
 	[IOMMU_RESV_SW_MSI]			= "msi",
 };
 
+#define IOMMU_CMD_LINE_DMA_API		BIT(0)
+
+static void iommu_set_cmd_line_dma_api(void)
+{
+	iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
+}
+
+static bool __maybe_unused iommu_cmd_line_dma_api(void)
+{
+	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
+}
+
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
 	__ATTR(_name, _mode, _show, _store)
@@ -165,6 +178,8 @@ static int __init iommu_set_def_domain_type(char *str)
 	if (ret)
 		return ret;
 
+	iommu_set_cmd_line_dma_api();
+
 	iommu_def_domain_type = pt ? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
 	return 0;
 }
-- 
2.16.4

