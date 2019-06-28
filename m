Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395FBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE9A2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfF1Der (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:34:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55882 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfF1Der (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:34:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A463200304;
        Fri, 28 Jun 2019 05:34:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 567642002F0;
        Fri, 28 Jun 2019 05:34:40 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 308CE402B3;
        Fri, 28 Jun 2019 11:34:34 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] soc: imx-scu: Add SoC UID(unique identifier) support
Date:   Fri, 28 Jun 2019 11:25:44 +0800
Message-Id: <20190628032544.8317-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add i.MX SCU SoC's UID(unique identifier) support, user
can read it from sysfs:

root@imx8qxpmek:~# cat /sys/devices/soc0/soc_uid
7B64280B57AC1898

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Improve the comment of skipping SCFW API return value check for getting UID.
---
 drivers/soc/imx/soc-imx-scu.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
index 676f612..3eacb54 100644
--- a/drivers/soc/imx/soc-imx-scu.c
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -27,6 +27,40 @@ struct imx_sc_msg_misc_get_soc_id {
 	} data;
 } __packed;
 
+struct imx_sc_msg_misc_get_soc_uid {
+	struct imx_sc_rpc_msg hdr;
+	u32 uid_low;
+	u32 uid_high;
+} __packed;
+
+static ssize_t soc_uid_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct imx_sc_msg_misc_get_soc_uid msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	u64 soc_uid;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_MISC;
+	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
+	hdr->size = 1;
+
+	/*
+	 * SCU FW API always returns an error even the
+	 * function is successfully executed, so skip
+	 * returned value check.
+	 */
+	imx_scu_call_rpc(soc_ipc_handle, &msg, true);
+
+	soc_uid = msg.uid_high;
+	soc_uid <<= 32;
+	soc_uid |= msg.uid_low;
+
+	return sprintf(buf, "%016llX\n", soc_uid);
+}
+
+static DEVICE_ATTR_RO(soc_uid);
+
 static int imx_scu_soc_id(void)
 {
 	struct imx_sc_msg_misc_get_soc_id msg;
@@ -102,6 +136,11 @@ static int imx_scu_soc_probe(struct platform_device *pdev)
 		goto free_revision;
 	}
 
+	ret = device_create_file(soc_device_to_device(soc_dev),
+				 &dev_attr_soc_uid);
+	if (ret)
+		goto free_revision;
+
 	return 0;
 
 free_revision:
-- 
2.7.4

