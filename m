Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA463C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4072087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCMNxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:53:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42109 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCMNxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:53:35 -0400
Received: from [123.118.215.37] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1h44K4-0007tR-Nh; Wed, 13 Mar 2019 13:53:33 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, aaron.ma@canonical.com
Subject: [RESEND][PATCH] iommu/amd: Fix NULL dereference bug in match_hid_uid
Date:   Wed, 13 Mar 2019 21:53:24 +0800
Message-Id: <1552485204-11381-1-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a non-NULL check to fix potential NULL pointer dereference
Cleanup code to call function once.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/iommu/amd_iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2a7b78bb98b4..dbda5b86f979 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -140,9 +140,14 @@ static inline int match_hid_uid(struct device *dev,
 				struct acpihid_map_entry *entry)
 {
 	const char *hid, *uid;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 
-	hid = acpi_device_hid(ACPI_COMPANION(dev));
-	uid = acpi_device_uid(ACPI_COMPANION(dev));
+	if (!adev) {
+		return -ENODEV;
+	}
+
+	hid = acpi_device_hid(adev);
+	uid = acpi_device_uid(adev);
 
 	if (!hid || !(*hid))
 		return -ENODEV;
-- 
2.20.1

