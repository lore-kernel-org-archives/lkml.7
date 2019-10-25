Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E60CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A844B21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405830AbfJYG7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:59:37 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56786 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405710AbfJYG7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:59:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 82D751A0409;
        Fri, 25 Oct 2019 08:59:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3797E1A0221;
        Fri, 25 Oct 2019 08:59:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 720F5402DA;
        Fri, 25 Oct 2019 14:59:22 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, daniel.baluta@nxp.com, aisheng.dong@nxp.com,
        abel.vesa@nxp.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] soc: imx-scu: Using existing serial_number instead of UID
Date:   Fri, 25 Oct 2019 14:56:23 +0800
Message-Id: <1571986583-21138-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571986583-21138-1-git-send-email-Anson.Huang@nxp.com>
References: <1571986583-21138-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soc_device_attribute structure already contains a serial_number
attribute to show SoC's unique ID, just use it to show SoC's unique
ID instead of creating a new file called soc_uid.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx-scu.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
index c68882e..fb70b8a 100644
--- a/drivers/soc/imx/soc-imx-scu.c
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -33,12 +33,10 @@ struct imx_sc_msg_misc_get_soc_uid {
 	u32 uid_high;
 } __packed;
 
-static ssize_t soc_uid_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+static int imx_scu_soc_uid(u64 *soc_uid)
 {
 	struct imx_sc_msg_misc_get_soc_uid msg;
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	u64 soc_uid;
 	int ret;
 
 	hdr->ver = IMX_SC_RPC_VERSION;
@@ -52,15 +50,13 @@ static ssize_t soc_uid_show(struct device *dev,
 		return ret;
 	}
 
-	soc_uid = msg.uid_high;
-	soc_uid <<= 32;
-	soc_uid |= msg.uid_low;
+	*soc_uid = msg.uid_high;
+	*soc_uid <<= 32;
+	*soc_uid |= msg.uid_low;
 
-	return sprintf(buf, "%016llX\n", soc_uid);
+	return 0;
 }
 
-static DEVICE_ATTR_RO(soc_uid);
-
 static int imx_scu_soc_id(void)
 {
 	struct imx_sc_msg_misc_get_soc_id msg;
@@ -89,6 +85,7 @@ static int imx_scu_soc_probe(struct platform_device *pdev)
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	int id, ret;
+	u64 uid = 0;
 	u32 val;
 
 	ret = imx_scu_get_handle(&soc_ipc_handle);
@@ -112,6 +109,10 @@ static int imx_scu_soc_probe(struct platform_device *pdev)
 	if (id < 0)
 		return -EINVAL;
 
+	ret = imx_scu_soc_uid(&uid);
+	if (ret < 0)
+		return -EINVAL;
+
 	/* format soc_id value passed from SCU firmware */
 	val = id & 0x1f;
 	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "0x%x", val);
@@ -130,19 +131,22 @@ static int imx_scu_soc_probe(struct platform_device *pdev)
 		goto free_soc_id;
 	}
 
+	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", uid);
+	if (!soc_dev_attr->serial_number) {
+		ret = -ENOMEM;
+		goto free_revision;
+	}
+
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
 		ret = PTR_ERR(soc_dev);
-		goto free_revision;
+		goto free_serial_number;
 	}
 
-	ret = device_create_file(soc_device_to_device(soc_dev),
-				 &dev_attr_soc_uid);
-	if (ret)
-		goto free_revision;
-
 	return 0;
 
+free_serial_number:
+	kfree(soc_dev_attr->serial_number);
 free_revision:
 	kfree(soc_dev_attr->revision);
 free_soc_id:
-- 
2.7.4

