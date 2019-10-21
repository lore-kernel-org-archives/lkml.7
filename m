Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3043DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D24A2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfJUPRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:17:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:37402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727309AbfJUPRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:17:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D454AE39;
        Mon, 21 Oct 2019 15:17:23 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Apply the same IVRS IOAPIC workaround to Acer Aspire A315-41
Date:   Mon, 21 Oct 2019 17:17:21 +0200
Message-Id: <20191021151721.12393-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer Aspire A315-41 requires the very same workaround as the existing
quirk for Dell Latitude 5495.  Add the new entry for that.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1137799
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/iommu/amd_iommu_quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/amd_iommu_quirks.c b/drivers/iommu/amd_iommu_quirks.c
index c235f79b7a20..5120ce4fdce3 100644
--- a/drivers/iommu/amd_iommu_quirks.c
+++ b/drivers/iommu/amd_iommu_quirks.c
@@ -73,6 +73,19 @@ static const struct dmi_system_id ivrs_quirks[] __initconst = {
 		},
 		.driver_data = (void *)&ivrs_ioapic_quirks[DELL_LATITUDE_5495],
 	},
+	{
+		/*
+		 * Acer Aspire A315-41 requires the very same workaround as
+		 * Dell Latitude 5495
+		 */
+		.callback = ivrs_ioapic_quirk_cb,
+		.ident = "Acer Aspire A315-41",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-41"),
+		},
+		.driver_data = (void *)&ivrs_ioapic_quirks[DELL_LATITUDE_5495],
+	},
 	{
 		.callback = ivrs_ioapic_quirk_cb,
 		.ident = "Lenovo ideapad 330S-15ARR",
-- 
2.16.4

