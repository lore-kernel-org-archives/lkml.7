Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EC1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635CA207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDBXHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:07:44 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:35384 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBXHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:07:43 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 19:07:06 EDT
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id BSQjhVncjldkPBSQkhKtnH; Tue, 02 Apr 2019 17:02:58 -0600
X-Authority-Analysis: v=2.3 cv=Ko4zJleN c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=oexKYjalfGEA:10 a=Q-fNiiVtAAAA:8
 a=36yCCN9P0WLGB_Doag4A:9 a=eEZrvosPlDxPMUrx:21 a=XGxIoc4xYr2_QMSj:21
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id E1D32301014300; Tue,  2 Apr 2019 16:02:56 -0700 (PDT)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] memory: brcmstb: dpfe: introduce DPFE API v3
Date:   Tue,  2 Apr 2019 16:01:03 -0700
Message-Id: <20190402230103.25491-7-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402230103.25491-1-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPOiZcZRnn1PYivGxVnosqW2/egj9cK/XTaa8S20v4AS/9tLwkCJb6vWdAIwvxkh7+zgqbS6RUxEzSsxcEkR9NQMKWXLCk7v7FICzZEo9f6B/4gNKahh
 8+pEsA9KuBKtCscFFq188FggjJcxATUn5BxOyFGemi1e1S3Ttdp7ZjZZipujKqK5F9aRMHflNBxLtYc/quEvfPMXQBSdNdMSLfauR9jtxyxen/n53pOAgjco
 UDEOamQakaKMpPuwoELVAXw+Fe57AH/xSRHpSyoujOCgCNnb/GiFNNQwzbr5O05MtVPOqwla9rfd4FAD075Qdfq+baACgXImPnjrfkp6+PVUJ9aAEwEVa255
 i1RzXK/m4JdOti/vfpQf5MoFnqV9CEK4Lyo46i8kFnlJyQKm7kz/M5hhOGxdnhZlEVKxooryxiv7FdlFLDQ6zMl4f2/OWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Introduce code to handle DPFE API v3. We also change the driver to
default to v3 by default and use API v2 only for select chips.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 114 +++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 43a53246abb3..bc6bf263c859 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -76,7 +76,7 @@
 #define DRAM_MR4_TH_OFFS_MASK	0x3
 #define DRAM_MR4_TUF_MASK	0x1
 
-/* DRAM Vendor Offsets & Masks */
+/* DRAM Vendor Offsets & Masks (API v2) */
 #define DRAM_VENDOR_MR5		0x0
 #define DRAM_VENDOR_MR6		0x4
 #define DRAM_VENDOR_MR7		0x8
@@ -85,6 +85,15 @@
 #define DRAM_VENDOR_MASK	0xff
 #define DRAM_VENDOR_SHIFT	24	/* We need to look at byte 3 */
 
+/* DRAM Information Offsets & Masks (API v3) */
+#define DRAM_DDR_INFO_MR4	0x0
+#define DRAM_DDR_INFO_MR5	0x4
+#define DRAM_DDR_INFO_MR6	0x8
+#define DRAM_DDR_INFO_MR7	0xc
+#define DRAM_DDR_INFO_MR8	0x10
+#define DRAM_DDR_INFO_ERROR	0x14
+#define DRAM_DDR_INFO_MASK	0xff
+
 /* Reset register bits & masks */
 #define DCPU_RESET_SHIFT	0x0
 #define DCPU_RESET_MASK		0x1
@@ -121,7 +130,7 @@ enum dpfe_msg_fields {
 	MSG_ARG_COUNT,
 	MSG_ARG0,
 	MSG_CHKSUM,
-	MSG_FIELD_MAX /* Last entry */
+	MSG_FIELD_MAX	= 16 /* Max number of arguments */
 };
 
 enum dpfe_commands {
@@ -196,6 +205,7 @@ static ssize_t show_refresh(struct device *, struct device_attribute *, char *);
 static ssize_t store_refresh(struct device *, struct device_attribute *,
 			  const char *, size_t);
 static ssize_t show_vendor(struct device *, struct device_attribute *, char *);
+static ssize_t show_dram(struct device *, struct device_attribute *, char *);
 
 /*
  * Declare our attributes early, so they can be referenced in the API data
@@ -205,6 +215,7 @@ static ssize_t show_vendor(struct device *, struct device_attribute *, char *);
 static DEVICE_ATTR(dpfe_info, 0444, show_info, NULL);
 static DEVICE_ATTR(dpfe_refresh, 0644, show_refresh, store_refresh);
 static DEVICE_ATTR(dpfe_vendor, 0444, show_vendor, NULL);
+static DEVICE_ATTR(dpfe_dram, 0444, show_dram, NULL);
 
 /* API v2 sysfs attributes */
 static struct attribute *dpfe_v2_attrs[] = {
@@ -215,6 +226,14 @@ static struct attribute *dpfe_v2_attrs[] = {
 };
 ATTRIBUTE_GROUPS(dpfe_v2);
 
+/* API v3 sysfs attributes */
+static struct attribute *dpfe_v3_attrs[] = {
+	&dev_attr_dpfe_info.attr,
+	&dev_attr_dpfe_dram.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(dpfe_v3);
+
 /* API v2 firmware commands */
 static const struct dpfe_api dpfe_api_v2 = {
 	.version = 2,
@@ -245,6 +264,34 @@ static const struct dpfe_api dpfe_api_v2 = {
 	}
 };
 
+/* API v3 firmware commands */
+static const struct dpfe_api dpfe_api_v3 = {
+	.version = 3,
+	.fw_name = NULL, /* We expect the firmware to have been downloaded! */
+	.sysfs_attrs = dpfe_v3_groups,
+	.command = {
+		[DPFE_CMD_GET_INFO] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 0x0101,
+			[MSG_ARG_COUNT] = 1,
+			[MSG_ARG0] = 1,
+			[MSG_CHKSUM] = 0x104,
+		},
+		[DPFE_CMD_GET_REFRESH] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 0x0202,
+			[MSG_ARG_COUNT] = 0,
+			/*
+			 * This is a bit ugly. Without arguments, the checksum
+			 * follows right after the argument count and not at
+			 * offset MSG_CHKSUM.
+			 */
+			[MSG_ARG0] = 0x203,
+		},
+		/* There's no GET_VENDOR command in API v3. */
+	},
+};
+
 static bool is_dcpu_enabled(void __iomem *regs)
 {
 	u32 val;
@@ -286,13 +333,13 @@ static void __enable_dcpu(void __iomem *regs)
 	writel_relaxed(val, regs + REG_DCPU_RESET);
 }
 
-static unsigned int get_msg_chksum(const u32 msg[])
+static unsigned int get_msg_chksum(const u32 msg[], unsigned int max)
 {
 	unsigned int sum = 0;
 	unsigned int i;
 
 	/* Don't include the last field in the checksum. */
-	for (i = 0; i < MSG_FIELD_MAX - 1; i++)
+	for (i = 0; i < max; i++)
 		sum += msg[i];
 
 	return sum;
@@ -305,6 +352,11 @@ static void __iomem *get_msg_ptr(struct private_data *priv, u32 response,
 	unsigned int offset;
 	void __iomem *ptr = NULL;
 
+	/* There is no need to use this function for API v3 or later. */
+	if (unlikely(priv->dpfe_api->version >= 3)) {
+		return NULL;
+	}
+
 	msg_type = (response >> DRAM_MSG_TYPE_OFFSET) & DRAM_MSG_TYPE_MASK;
 	offset = (response >> DRAM_MSG_ADDR_OFFSET) & DRAM_MSG_ADDR_MASK;
 
@@ -332,12 +384,25 @@ static void __iomem *get_msg_ptr(struct private_data *priv, u32 response,
 	return ptr;
 }
 
+static void __finalize_command(struct private_data *priv)
+{
+	unsigned int release_mbox;
+
+	/*
+	 * It depends on the API version which MBOX register we have to write to
+	 * to signal we are done.
+	 */
+	release_mbox = (priv->dpfe_api->version < 3)
+			? REG_TO_HOST_MBOX : REG_TO_DCPU_MBOX;
+	writel_relaxed(0, priv->regs + release_mbox);
+}
+
 static int __send_command(struct private_data *priv, unsigned int cmd,
 			  u32 result[])
 {
 	const u32 *msg = priv->dpfe_api->command[cmd];
 	void __iomem *regs = priv->regs;
-	unsigned int i, chksum;
+	unsigned int i, chksum, chksum_idx;
 	int ret = 0;
 	u32 resp;
 
@@ -381,10 +446,11 @@ static int __send_command(struct private_data *priv, unsigned int cmd,
 		/* Read response data */
 		for (i = 0; i < MSG_FIELD_MAX; i++)
 			result[i] = readl_relaxed(regs + DCPU_MSG_RAM(i));
+		chksum_idx = result[MSG_ARG_COUNT] + MSG_ARG_COUNT + 1;
 	}
 
 	/* Tell DCPU we are done */
-	writel_relaxed(0, regs + REG_TO_HOST_MBOX);
+	__finalize_command(priv);
 
 	mutex_unlock(&priv->lock);
 
@@ -392,8 +458,8 @@ static int __send_command(struct private_data *priv, unsigned int cmd,
 		return ret;
 
 	/* Verify response */
-	chksum = get_msg_chksum(result);
-	if (chksum != result[MSG_CHKSUM])
+	chksum = get_msg_chksum(result, chksum_idx);
+	if (chksum != result[chksum_idx])
 		resp = DCPU_RET_ERR_CHKSUM;
 
 	if (resp != DCPU_RET_SUCCESS) {
@@ -710,6 +776,30 @@ static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%#x %#x %#x %#x %#x\n", mr5, mr6, mr7, mr8, err);
 }
 
+static ssize_t show_dram(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
+{
+	u32 response[MSG_FIELD_MAX];
+	struct private_data *priv;
+	ssize_t ret;
+	u32 mr4, mr5, mr6, mr7, mr8, err;
+
+	priv = dev_get_drvdata(dev);
+	ret = generic_show(DPFE_CMD_GET_REFRESH, response, priv, buf);
+	if (ret)
+		return ret;
+
+	mr4 = response[MSG_ARG0 + 0] & DRAM_INFO_MR4_MASK;
+	mr5 = response[MSG_ARG0 + 1] & DRAM_DDR_INFO_MASK;
+	mr6 = response[MSG_ARG0 + 2] & DRAM_DDR_INFO_MASK;
+	mr7 = response[MSG_ARG0 + 3] & DRAM_DDR_INFO_MASK;
+	mr8 = response[MSG_ARG0 + 4] & DRAM_DDR_INFO_MASK;
+	err = response[MSG_ARG0 + 5] & DRAM_DDR_INFO_MASK;
+
+	return sprintf(buf, "%#x %#x %#x %#x %#x %#x\n", mr4, mr5, mr6, mr7,
+			mr8, err);
+}
+
 static int brcmstb_dpfe_resume(struct platform_device *pdev)
 {
 	struct init_data init;
@@ -787,7 +877,13 @@ static int brcmstb_dpfe_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id brcmstb_dpfe_of_match[] = {
-	{ .compatible = "brcm,dpfe-cpu", .data = &dpfe_api_v2 },
+	/* Use legacy API v2 for a select number of chips */
+	{ .compatible = "brcm,bcm7268-dpfe-cpu", .data = &dpfe_api_v2 },
+	{ .compatible = "brcm,bcm7271-dpfe-cpu", .data = &dpfe_api_v2 },
+	{ .compatible = "brcm,bcm7278-dpfe-cpu", .data = &dpfe_api_v2 },
+	{ .compatible = "brcm,bcm7211-dpfe-cpu", .data = &dpfe_api_v2 },
+	/* API v3 is the default going forward */
+	{ .compatible = "brcm,dpfe-cpu", .data = &dpfe_api_v3 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, brcmstb_dpfe_of_match);
-- 
2.17.1

