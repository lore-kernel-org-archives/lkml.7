Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2DAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286CA21902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfDXNzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:55:44 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:34212 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbfDXNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:55:24 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 4DvM2000Q3XaVaC06DvMpc; Wed, 24 Apr 2019 15:55:22 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hJIMr-000888-O4; Wed, 24 Apr 2019 15:55:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hJIMr-0006Ye-Me; Wed, 24 Apr 2019 15:55:21 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 4/6] iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific features
Date:   Wed, 24 Apr 2019 15:55:16 +0200
Message-Id: <20190424135518.25150-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424135518.25150-1-geert+renesas@glider.be>
References: <20190424135518.25150-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum number of micro-TLBs per IPMMU instance is not fixed, but
depends on the SoC type.  Hence move it from struct ipmmu_vmsa_device to
struct ipmmu_features, and set up the correct value for both R-Car Gen2
and Gen3 SoCs.

Note that currently no code uses this value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v3:
  - Add Reviewed-by,

v2:
  - Add Reviewed-by.
---
 drivers/iommu/ipmmu-vmsa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 87acf86f295fac0d..3fa57627b1e35562 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -42,6 +42,7 @@ struct ipmmu_features {
 	bool use_ns_alias_offset;
 	bool has_cache_leaf_nodes;
 	unsigned int number_of_contexts;
+	unsigned int num_utlbs;
 	bool setup_imbuscr;
 	bool twobit_imttbcr_sl0;
 	bool reserved_context;
@@ -53,7 +54,6 @@ struct ipmmu_vmsa_device {
 	struct iommu_device iommu;
 	struct ipmmu_vmsa_device *root;
 	const struct ipmmu_features *features;
-	unsigned int num_utlbs;
 	unsigned int num_ctx;
 	spinlock_t lock;			/* Protects ctx and domains[] */
 	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
@@ -972,6 +972,7 @@ static const struct ipmmu_features ipmmu_features_default = {
 	.use_ns_alias_offset = true,
 	.has_cache_leaf_nodes = false,
 	.number_of_contexts = 1, /* software only tested with one context */
+	.num_utlbs = 32,
 	.setup_imbuscr = true,
 	.twobit_imttbcr_sl0 = false,
 	.reserved_context = false,
@@ -981,6 +982,7 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
 	.use_ns_alias_offset = false,
 	.has_cache_leaf_nodes = true,
 	.number_of_contexts = 8,
+	.num_utlbs = 48,
 	.setup_imbuscr = false,
 	.twobit_imttbcr_sl0 = true,
 	.reserved_context = true,
@@ -1033,7 +1035,6 @@ static int ipmmu_probe(struct platform_device *pdev)
 	}
 
 	mmu->dev = &pdev->dev;
-	mmu->num_utlbs = 48;
 	spin_lock_init(&mmu->lock);
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 	mmu->features = of_device_get_match_data(&pdev->dev);
-- 
2.17.1

