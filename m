Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A39BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5972173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfC1KAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:00:45 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:50837 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfC1KAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:00:42 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x2S9wlJP052359;
        Thu, 28 Mar 2019 17:58:53 +0800 (GMT-8)
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
Subject: [PATCH 6/7] mtd: rawnand: Add Macronix NAND read retry and randomizer support
Date:   Thu, 28 Mar 2019 18:18:37 +0800
Message-Id: <1553768318-23149-7-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x2S9wlJP052359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for Macronix NAND read retry and randomizer.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_macronix.c | 169 +++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 47d8cda..a19caa4 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -17,6 +17,174 @@
 
 #include "internals.h"
 
+#define MACRONIX_READ_RETRY_BIT BIT(0)
+#define MACRONIX_RANDOMIZER_BIT BIT(1)
+#define MACRONIX_READ_RETRY_MODE 5
+
+#define ONFI_FEATURE_ADDR_MXIC_RANDOMIZER 0xB0
+
+struct nand_onfi_vendor_macronix {
+	u8 reserved[1];
+	u8 reliability_func;
+} __packed;
+
+struct nand_chip *mxic_sysfs;
+
+static int macronix_nand_setup_read_retry(struct nand_chip *chip, int mode)
+{
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = {0};
+	int ret;
+
+	if (mode > MACRONIX_READ_RETRY_MODE)
+		mode = MACRONIX_READ_RETRY_MODE;
+
+	feature[0] = mode;
+	ret =  nand_set_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);
+	if (ret)
+		pr_err("failed to enter read retry moded:%d\n", mode);
+
+	if (mode == 0)
+		ret =  nand_get_features(chip, ONFI_FEATURE_ADDR_READ_RETRY,
+					 feature);
+		if (ret)
+			pr_err("failed to exits read retry moded:%d\n", mode);
+
+	return ret;
+}
+
+static ssize_t mxic_nand_rand_type_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct nand_chip *chip = mxic_sysfs;
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = {0};
+	int ret;
+
+	nand_select_target(chip, 0);
+	ret = nand_get_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
+				feature);
+	nand_deselect_target(chip);
+	if (ret)
+		pr_err("failed to check mxic nand device randomizer\n");
+
+	return sprintf(buf, "MXIC NAND device randomizer %s(0x%x)\n",
+		       feature[0] & MACRONIX_RANDOMIZER_BIT ?
+		       "enable" : "disable", feature[0]);
+}
+
+static ssize_t mxic_nand_rand_type_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct nand_chip *chip = mxic_sysfs;
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = {0};
+	unsigned int rand_layout;
+	int ret;
+
+	nand_select_target(chip, 0);
+	ret = nand_get_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
+				feature);
+	nand_deselect_target(chip);
+
+	if (feature[0]) {
+		pr_err("Randomizer is enabled 0x%x\n", feature[0]);
+		goto err_out;
+	}
+
+	ret = kstrtouint(buf, 0, &rand_layout);
+	if (ret)
+		goto err_out;
+
+	if (rand_layout > 7) {
+		pr_err("Error parameter value:0x%x\n", rand_layout);
+		goto err_out;
+	}
+
+	feature[0] = rand_layout & 0x07;
+	nand_select_target(chip, 0);
+	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
+				feature);
+	nand_deselect_target(chip);
+	if (ret) {
+		pr_err("device randomizer set feature failed\n");
+		goto err_out;
+	}
+
+	feature[0] = 0x0;
+	nand_select_target(chip, 0);
+	ret = nand_prog_page_op(chip, 0, 0, feature, 1);
+	nand_deselect_target(chip);
+	if (ret) {
+		pr_err("Prog device randomizer failed\n");
+		goto err_out;
+	}
+
+	feature[0] = 0x0;
+	nand_select_target(chip, 0);
+	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
+				feature);
+	nand_deselect_target(chip);
+	if (ret)
+		pr_err("failed to exits prog device randomizer\n");
+
+err_out:
+	return count;
+}
+
+static const struct kobj_attribute sysfs_mxic_nand =
+	__ATTR(nand_random, S_IRUGO | S_IWUSR,
+	       mxic_nand_rand_type_show,
+	       mxic_nand_rand_type_store);
+
+static void macronix_nand_onfi_init(struct nand_chip *chip)
+{
+	struct nand_parameters *p = &chip->parameters;
+	struct kobject *kobj;
+	int ret;
+
+	mxic_sysfs = chip;
+	if (p->onfi) {
+		struct nand_onfi_vendor_macronix *mxic =
+				(void *)p->onfi->vendor;
+
+		if (mxic->reliability_func & MACRONIX_READ_RETRY_BIT) {
+			chip->read_retries = MACRONIX_READ_RETRY_MODE + 1;
+			chip->setup_read_retry =
+				 macronix_nand_setup_read_retry;
+			if (p->supports_set_get_features) {
+				set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
+					p->set_feature_list);
+				set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
+					p->get_feature_list);
+			}
+		}
+
+		if (mxic->reliability_func & MACRONIX_RANDOMIZER_BIT) {
+			if (p->supports_set_get_features) {
+				set_bit(ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
+					p->set_feature_list);
+				set_bit(ONFI_FEATURE_ADDR_MXIC_RANDOMIZER,
+					p->get_feature_list);
+				/*
+				 * create syfs-fs for MXIC NAND device
+				 * randomizer status check & enable
+				 * operations.
+				 */
+				kobj = kobject_create_and_add("mxic_rand_nand",
+							      NULL);
+				if (!kobj)
+					return;
+
+				ret = sysfs_create_file(kobj,
+							&sysfs_mxic_nand.attr);
+				if (ret) {
+					pr_err("Err: mxic_rand_nand sysfs");
+					kobject_put(kobj);
+				}
+			}
+		}
+	}
+}
+
 /*
  * Macronix AC series does not support using SET/GET_FEATURES to change
  * the timings unlike what is declared in the parameter page. Unflag
@@ -65,6 +233,7 @@ static int macronix_nand_init(struct nand_chip *chip)
 		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
 
 	macronix_nand_fix_broken_get_timings(chip);
+	macronix_nand_onfi_init(chip);
 
 	return 0;
 }
-- 
1.9.1

