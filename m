Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0932CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82B621734
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552894467;
	bh=0AuMBXaXxM/YSa+Udyni2GlrNuX68I0E9NFk4r0XgfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uq8QnFSBtIQP6g4YE7Jykv/RlAym4o04B/JDTuCg8Z+6SuhEPVWt3Bhvcx91dT+vg
	 qnULZG9tdbUily8fXedzpuW+moarzQ9cQXqJPKhVzp2gtbbHYY/nO/Z+pz4fvPJtAP
	 AtaB9Ln+2/ha6EuMhk+YBUt2WzvMKH8TmeuBFUqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCRHeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:34:18 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:40896 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfCRHeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:34:14 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 06C315FD9F; Mon, 18 Mar 2019 15:34:12 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] nvmem: sunxi_sid: Dynamically allocate nvmem_config structure
Date:   Mon, 18 Mar 2019 15:33:51 +0800
Message-Id: <20190318073354.12151-4-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318073354.12151-1-wens@kernel.org>
References: <20190318073354.12151-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The sunxi_sid driver currently uses a statically allocated nvmem_config
structure that is updated at probe time. This is sub-optimal as it
limits the driver to one instance, and also takes up space even if the
device is not present.

Modify the driver to allocate the nvmem_config structure at probe time,
plugging in the desired parameters along the way.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/nvmem/sunxi_sid.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 15fbfab62595..75c1f48cb3d0 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -35,13 +35,6 @@
 #define SUN8I_SID_OP_LOCK	(0xAC << 8)
 #define SUN8I_SID_READ		BIT(1)
 
-static struct nvmem_config econfig = {
-	.name = "sunxi-sid",
-	.read_only = true,
-	.stride = 4,
-	.word_size = 1,
-};
-
 struct sunxi_sid_cfg {
 	u32	value_offset;
 	u32	size;
@@ -150,6 +143,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	struct nvmem_config *nvmem_cfg;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
 	int size;
@@ -172,14 +166,23 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 
 	size = cfg->size;
 
-	econfig.size = size;
-	econfig.dev = dev;
+	nvmem_cfg = devm_kzalloc(dev, sizeof(*nvmem_cfg), GFP_KERNEL);
+	if (!nvmem_cfg)
+		return -ENOMEM;
+
+	nvmem_cfg->dev = dev;
+	nvmem_cfg->name = "sunxi-sid";
+	nvmem_cfg->read_only = true;
+	nvmem_cfg->size = cfg->size;
+	nvmem_cfg->word_size = 1;
+	nvmem_cfg->stride = 4;
+	nvmem_cfg->priv = sid;
 	if (cfg->need_register_readout)
-		econfig.reg_read = sun8i_sid_read_by_reg;
+		nvmem_cfg->reg_read = sun8i_sid_read_by_reg;
 	else
-		econfig.reg_read = sunxi_sid_read;
-	econfig.priv = sid;
-	nvmem = devm_nvmem_register(dev, &econfig);
+		nvmem_cfg->reg_read = sunxi_sid_read;
+
+	nvmem = devm_nvmem_register(dev, nvmem_cfg);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
@@ -187,8 +190,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	if (!randomness)
 		return -ENOMEM;
 
-	econfig.reg_read(sid, 0, randomness, size);
-
+	nvmem_cfg->reg_read(sid, 0, randomness, size);
 	add_device_randomness(randomness, size);
 	kfree(randomness);
 
-- 
2.20.1

