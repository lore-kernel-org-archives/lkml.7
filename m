Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229FFC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E797420706
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 09:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKXJnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 04:43:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48719 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfKXJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 04:43:03 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iYoPy-0003sy-Ux; Sun, 24 Nov 2019 09:42:59 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] iommu/amd: Disable IOMMU on Stoney Ridge systems
Date:   Sun, 24 Nov 2019 17:42:53 +0800
Message-Id: <20191124094253.3433-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Serious screen flickering when Stoney Ridge outputs to a 4K monitor.

According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
the same here to avoid screen flickering on 4K monitor.

Cc: Alex Deucher <alexander.deucher@amd.com>
Bug: https://gitlab.freedesktop.org/drm/amd/issues/961
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/iommu/amd_iommu_init.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 568c52317757..e05f1b269be6 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2516,6 +2516,7 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	acpi_status status;
 	int i, remap_cache_sz, ret = 0;
+	u32 pci_id;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -2603,6 +2604,13 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	/* Get the host bridge VID/PID and disable IOMMU if it's Stoney Ridge */
+	pci_id = read_pci_config(0, 0, 0, 0);
+	if ((pci_id & 0xffff) == 0x1022 && (pci_id >> 16) == 0x1576) {
+		pr_info("Disable IOMMU on Stoney Ridge\n");
+		amd_iommu_disabled = true;
+	}
+
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
@@ -2711,7 +2719,7 @@ static int __init state_next(void)
 		ret = early_amd_iommu_init();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		if (init_state == IOMMU_ACPI_FINISHED && amd_iommu_disabled) {
-			pr_info("AMD IOMMU disabled on kernel command-line\n");
+			pr_info("AMD IOMMU disabled\n");
 			init_state = IOMMU_CMDLINE_DISABLED;
 			ret = -EINVAL;
 		}
-- 
2.17.1

