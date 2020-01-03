Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE5C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D089821734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tfxrTNAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgACQ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:26:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39001 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgACQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:26:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so42939128wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 08:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89mFA8e7Xc7aCGnee/vBVuK6j5IjAiZj3SvE/aRAZkU=;
        b=tfxrTNAlbO1a4huM8IDy6tBKcl5I9hIGs22EGye9w5UqqHWTreoNTQ8QYcvb7YXmnN
         35WIII5O06Ed79JL1L2aWb4w4vlKdqPa68lhyM/kYS76+BuF0TNXQ3JdF6VKtsRVcIxt
         namNuW/NRTfnECEKBlixtu8EePuaeEnnCl+L1sqFgUij9RjLaFDsjrGZMqb0/B5JH6p1
         AwiiURZ7VLU5sgapnHFWxQ1B2ucVV3FT9uJwtXplth4sy+9CkpmwaKmoyLNSHWcsxFij
         MIDfBHJ+jR49lz5qMC9uZDHOTy31/xy7TXDvyNMEwMvBHQrgYoKqOPdIi02WnBU2luMd
         KTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89mFA8e7Xc7aCGnee/vBVuK6j5IjAiZj3SvE/aRAZkU=;
        b=lceTpkAwOd0B7G5T5M9GNpy/ycjDAv//yvOWt3JAXzXsLr2z9+B3nyH+vcGiwIh38t
         7DPY1ch2tHKN6Loq5pOxd5riiXe2e+H72R2glA46KWRCKy6tEiw9JQ4H/QUZoffgovtd
         3feuak07lAfvhoZl8aUydbAGphJf9L/33hfiI7jyqT/+YzcZE6SGY+xlKhG9buSoDJQ3
         Z62CRZNToOToPTVFdrUc6KFsXA/rI38EspdLsi7R2wX0LdF9/mMr1+83tw+7m/Kmbpoj
         p8Nxwlg68C6WxiYrik/SlfRG322fRijmgpHSIMLzW++JbuB1IfHUqmPCvCszwRDEUStf
         lYPQ==
X-Gm-Message-State: APjAAAVbFb6eyA/+9sn3jI7QnLhuDRq/JkMBQldl+Kxd9kfeT8o/ly3y
        DeYQ++DxSolA4kRFbG94h8dPCg==
X-Google-Smtp-Source: APXvYqwPg2MhuwqZ0oIndjKJulvZt5tg9dwauR6SSxBiZJ9j/GpPtJP4TrTegUABwWAZ4oYoiSU4Og==
X-Received: by 2002:adf:e591:: with SMTP id l17mr82260400wrm.139.1578068796095;
        Fri, 03 Jan 2020 08:26:36 -0800 (PST)
Received: from radium.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x14sm12564234wmj.42.2020.01.03.08.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 08:26:35 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] iommu/mediatek: add support for MT8167
Date:   Fri,  3 Jan 2020 17:26:32 +0100
Message-Id: <20200103162632.109553-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.25.0.rc0
In-Reply-To: <20200103162632.109553-1-fparent@baylibre.com>
References: <20200103162632.109553-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the IOMMU on MT8167

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 11 ++++++++++-
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6fc1f5ecf91e..5fc6178a82dc 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -569,7 +569,8 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (data->plat_data->m4u_plat == M4U_MT8173 ||
+	    data->plat_data->m4u_plat == M4U_MT8167)
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
@@ -782,6 +783,13 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
 };
 
+static const struct mtk_iommu_plat_data mt8167_data = {
+	.m4u_plat     = M4U_MT8167,
+	.has_4gb_mode = true,
+	.reset_axi    = true,
+	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
+};
+
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
@@ -798,6 +806,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
+	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{}
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index ea949a324e33..cb8fd5970cd4 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -30,6 +30,7 @@ struct mtk_iommu_suspend_reg {
 enum mtk_iommu_plat {
 	M4U_MT2701,
 	M4U_MT2712,
+	M4U_MT8167,
 	M4U_MT8173,
 	M4U_MT8183,
 };
-- 
2.25.0.rc0

