Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E62AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0310207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDBXKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:10:48 -0400
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:44654 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:10:48 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 19:10:47 EDT
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id BSQPhhrxvGusjBSQQhTVvB; Tue, 02 Apr 2019 17:02:39 -0600
X-Authority-Analysis: v=2.3 cv=fOdHIqSe c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=oexKYjalfGEA:10 a=Q-fNiiVtAAAA:8
 a=IA7aKqN18JfRTjCajgUA:9 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id 819F33010142F9; Tue,  2 Apr 2019 16:02:37 -0700 (PDT)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] memory: brcmstb: dpfe: prepare support for multiple API versions
Date:   Tue,  2 Apr 2019 16:01:01 -0700
Message-Id: <20190402230103.25491-5-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402230103.25491-1-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPu/6dCio4euRdjkWCoFdmjIYLxgses2eSHgdkJTgJ1jtZvUW3e7PHl5qYKt5NUxSItGEsR5MpJer9c+wNhw1wwgquzFaI+9BPTpnntkmqHB0jyWAZZ6
 tnnqWiCjLPZnsLCyLT1rrdnfHGOoL7SyWH4wAdltrPJox0TfuIGIKnMEKO/s9GgKKifeknMHCTchiirmou8t6mvVAJBLxcWiMKBF3sglERea4QxfMowidv2T
 9Rx4nAW4Dq1otRry/o5ngcXxI6l6GuycyjcXLAFlhuLBLsAHcIqilQyJDjJooZfAnDwQw0CFnyR9puwi4kjX3kwb1ym1nGkOaOZhoTw3Zsuo20jENM6M9z2x
 bnkq/6uEkRFOV/G0uA7mXgU0Zig59WsqoIVRu6lGnzGKiIxSVxZElufuT/3ehp8et8QOxXNs3cPV5cPqHT7qWY0DpMaNoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Extend the driver, so it can handle different API versions for
interacting with the DCPU. This is in preparation for the upcoming API
v3.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 87 ++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 28 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index f8d05a8266c3..9ad5ea08c134 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -35,10 +35,10 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #define DRVNAME			"brcmstb-dpfe"
-#define FIRMWARE_NAME		"dpfe.bin"
 
 /* DCPU register offsets */
 #define REG_DCPU_RESET		0x0
@@ -164,12 +164,20 @@ struct init_data {
 	bool is_big_endian;
 };
 
+/* API version and corresponding commands */
+struct dpfe_api {
+	int version;
+	const char *fw_name;
+	u32 command[DPFE_CMD_MAX][MSG_FIELD_MAX];
+};
+
 /* Things we need for as long as we are active. */
 struct private_data {
 	void __iomem *regs;
 	void __iomem *dmem;
 	void __iomem *imem;
 	struct device *dev;
+	const struct dpfe_api *dpfe_api;
 	struct mutex lock;
 };
 
@@ -178,29 +186,33 @@ static const char *error_text[] = {
 	"Incorrect checksum", "Malformed command", "Timed out",
 };
 
-/* List of supported firmware commands */
-static const u32 dpfe_commands[DPFE_CMD_MAX][MSG_FIELD_MAX] = {
-	[DPFE_CMD_GET_INFO] = {
-		[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
-		[MSG_COMMAND] = 1,
-		[MSG_ARG_COUNT] = 1,
-		[MSG_ARG0] = 1,
-		[MSG_CHKSUM] = 4,
-	},
-	[DPFE_CMD_GET_REFRESH] = {
-		[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
-		[MSG_COMMAND] = 2,
-		[MSG_ARG_COUNT] = 1,
-		[MSG_ARG0] = 1,
-		[MSG_CHKSUM] = 5,
-	},
-	[DPFE_CMD_GET_VENDOR] = {
-		[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
-		[MSG_COMMAND] = 2,
-		[MSG_ARG_COUNT] = 1,
-		[MSG_ARG0] = 2,
-		[MSG_CHKSUM] = 6,
-	},
+/* API v2 firmware commands */
+static const struct dpfe_api dpfe_api_v2 = {
+	.version = 2,
+	.fw_name = "dpfe.bin",
+	.command = {
+		[DPFE_CMD_GET_INFO] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 1,
+			[MSG_ARG_COUNT] = 1,
+			[MSG_ARG0] = 1,
+			[MSG_CHKSUM] = 4,
+		},
+		[DPFE_CMD_GET_REFRESH] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 2,
+			[MSG_ARG_COUNT] = 1,
+			[MSG_ARG0] = 1,
+			[MSG_CHKSUM] = 5,
+		},
+		[DPFE_CMD_GET_VENDOR] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 2,
+			[MSG_ARG_COUNT] = 1,
+			[MSG_ARG0] = 2,
+			[MSG_CHKSUM] = 6,
+		},
+	}
 };
 
 static bool is_dcpu_enabled(void __iomem *regs)
@@ -293,7 +305,7 @@ static void __iomem *get_msg_ptr(struct private_data *priv, u32 response,
 static int __send_command(struct private_data *priv, unsigned int cmd,
 			  u32 result[])
 {
-	const u32 *msg = dpfe_commands[cmd];
+	const u32 *msg = priv->dpfe_api->command[cmd];
 	void __iomem *regs = priv->regs;
 	unsigned int i, chksum;
 	int ret = 0;
@@ -492,7 +504,15 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 			return 0;
 	}
 
-	ret = request_firmware(&fw, FIRMWARE_NAME, dev);
+	/*
+	 * If the firmware filename is NULL it means the boot firmware has to
+	 * download the DCPU firmware for us. If that didn't work, we have to
+	 * bail, since downloading it ourselves wouldn't work either.
+	 */
+	if (!priv->dpfe_api->fw_name)
+		return -ENODEV;
+
+	ret = request_firmware(&fw, priv->dpfe_api->fw_name, dev);
 	/* request_firmware() prints its own error messages. */
 	if (ret)
 		return ret;
@@ -714,6 +734,16 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
+	priv->dpfe_api = of_device_get_match_data(dev);
+	if (unlikely(!priv->dpfe_api)) {
+		/*
+		 * It should be impossible to end up here, but to be safe we
+		 * check anyway.
+		 */
+		dev_err(dev, "Couldn't determine API\n");
+		return -ENOENT;
+	}
+
 	ret = brcmstb_dpfe_download_firmware(pdev, &init);
 	if (ret) {
 		dev_err(dev, "Couldn't download firmware -- %d\n", ret);
@@ -722,7 +752,8 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 
 	ret = sysfs_create_groups(&pdev->dev.kobj, dpfe_groups);
 	if (!ret)
-		dev_info(dev, "registered.\n");
+		dev_info(dev, "registered with API v%d.\n",
+			 priv->dpfe_api->version);
 
 	return ret;
 }
@@ -735,7 +766,7 @@ static int brcmstb_dpfe_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id brcmstb_dpfe_of_match[] = {
-	{ .compatible = "brcm,dpfe-cpu", },
+	{ .compatible = "brcm,dpfe-cpu", .data = &dpfe_api_v2 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, brcmstb_dpfe_of_match);
-- 
2.17.1

