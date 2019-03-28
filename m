Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00148C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC88A21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfC1KAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:00:40 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:50819 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1KAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:00:40 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x2S9wlJQ052359;
        Thu, 28 Mar 2019 17:58:54 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmal.com, paul.burton@mips.com, stefan@agner.ch,
        christophe.kerello@st.com, liang.yang@amlogic.com,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
        richard@nod.at, miquel.raynal@bootlin.com
Cc:     juliensu@mxic.com.tw, zhengxunli@mxic.com.tw,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH 7/7] mtd: rawnand: Add Macronix NAND block protection driver
Date:   Thu, 28 Mar 2019 18:18:38 +0800
Message-Id: <1553768318-23149-8-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x2S9wlJQ052359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for Macronix NAND block protection function.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/mxic_nand.c     |  3 +++
 drivers/mtd/nand/raw/nand_macronix.c | 47 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mxic-mx25f0a.h     |  3 +++
 3 files changed, 53 insertions(+)

diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_nand.c
index 03886b2..9307ca2 100644
--- a/drivers/mtd/nand/raw/mxic_nand.c
+++ b/drivers/mtd/nand/raw/mxic_nand.c
@@ -262,6 +262,9 @@ static int mx25f0a_nand_probe(struct platform_device *pdev)
 	if (err)
 		goto fail;
 
+	mtd->_lock = mxic_nand_lock;
+	mtd->_unlock = mxic_nand_unlock;
+
 	err = mtd_device_register(mtd, NULL, 0);
 	if (err)
 		goto fail;
diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index a19caa4..db63350 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -21,8 +21,12 @@
 #define MACRONIX_RANDOMIZER_BIT BIT(1)
 #define MACRONIX_READ_RETRY_MODE 5
 
+#define ONFI_FEATURE_ADDR_MXIC_PROTECTION 0xA0
 #define ONFI_FEATURE_ADDR_MXIC_RANDOMIZER 0xB0
 
+#define MXIC_BLOCK_PROTECTION_ALL_LOCK 0x38
+#define MXIC_BLOCK_PROTECTION_ALL_UNLOCK 0x0
+
 struct nand_onfi_vendor_macronix {
 	u8 reserved[1];
 	u8 reliability_func;
@@ -146,6 +150,13 @@ static void macronix_nand_onfi_init(struct nand_chip *chip)
 		struct nand_onfi_vendor_macronix *mxic =
 				(void *)p->onfi->vendor;
 
+		if (p->supports_set_get_features) {
+			set_bit(ONFI_FEATURE_ADDR_MXIC_PROTECTION,
+				p->get_feature_list);
+			set_bit(ONFI_FEATURE_ADDR_MXIC_PROTECTION,
+				p->set_feature_list);
+		}
+
 		if (mxic->reliability_func & MACRONIX_READ_RETRY_BIT) {
 			chip->read_retries = MACRONIX_READ_RETRY_MODE + 1;
 			chip->setup_read_retry =
@@ -241,3 +252,39 @@ static int macronix_nand_init(struct nand_chip *chip)
 const struct nand_manufacturer_ops macronix_nand_manuf_ops = {
 	.init = macronix_nand_init,
 };
+
+int mxic_nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = {0};
+	int ret;
+
+	feature[0] = MXIC_BLOCK_PROTECTION_ALL_LOCK;
+	nand_select_target(chip, 0);
+	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
+				feature);
+	nand_deselect_target(chip);
+	if (ret)
+		pr_err("Lock MXIC NAND all blocks failed, err:%d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mxic_nand_lock);
+
+int mxic_nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = {0};
+	int ret;
+
+	feature[0] = MXIC_BLOCK_PROTECTION_ALL_UNLOCK;
+	nand_select_target(chip, 0);
+	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
+				feature);
+	nand_deselect_target(chip);
+	if (ret)
+		pr_err("Unlock MXIC NAND all blocks failed, err:%d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mxic_nand_unlock);
diff --git a/include/linux/mfd/mxic-mx25f0a.h b/include/linux/mfd/mxic-mx25f0a.h
index 5a8cfc7..cfce992 100644
--- a/include/linux/mfd/mxic-mx25f0a.h
+++ b/include/linux/mfd/mxic-mx25f0a.h
@@ -170,4 +170,7 @@ struct mx25f0a_mfd {
 	void __iomem *dirmap;
 };
 
+int mxic_nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
+int mxic_nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
+
 #endif // __MFD_MXIC_MX25F0A_H
-- 
1.9.1

