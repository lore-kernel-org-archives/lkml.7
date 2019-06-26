Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A2CC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF252086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfFZHmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:42:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37704 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfFZHmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:42:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 98662200912;
        Wed, 26 Jun 2019 09:42:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 514E6200905;
        Wed, 26 Jun 2019 09:42:16 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 16DEA4030F;
        Wed, 26 Jun 2019 15:42:10 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, abel.vesa@nxp.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] soc: imx8: Add i.MX8MQ UID(unique identifier) support
Date:   Wed, 26 Jun 2019 15:44:14 +0800
Message-Id: <20190626074415.18224-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add i.MX8MQ SoC UID(unique identifier) support, user
can read it from sysfs:

root@imx8mqevk:~# cat /sys/devices/soc0/soc_uid
D56911D6F060954B

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx8.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index f924ae8..c19ef4b 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -16,6 +16,9 @@
 #define IMX8MQ_SW_INFO_B1		0x40
 #define IMX8MQ_SW_MAGIC_B1		0xff0055aa
 
+#define OCOTP_UID_LOW			0x410
+#define OCOTP_UID_HIGH			0x420
+
 /* Same as ANADIG_DIGPROG_IMX7D */
 #define ANADIG_DIGPROG_IMX8MM	0x800
 
@@ -24,6 +27,16 @@ struct imx8_soc_data {
 	u32 (*soc_revision)(void);
 };
 
+static u64 soc_uid;
+
+static ssize_t soc_uid_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%016llX\n", soc_uid);
+}
+
+static DEVICE_ATTR_RO(soc_uid);
+
 static u32 __init imx8mq_soc_revision(void)
 {
 	struct device_node *np;
@@ -42,6 +55,10 @@ static u32 __init imx8mq_soc_revision(void)
 	if (magic == IMX8MQ_SW_MAGIC_B1)
 		rev = REV_B1;
 
+	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
+	soc_uid <<= 32;
+	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+
 	iounmap(ocotp_base);
 
 out:
@@ -140,6 +157,11 @@ static int __init imx8_soc_init(void)
 		goto free_rev;
 	}
 
+	ret = device_create_file(soc_device_to_device(soc_dev),
+				 &dev_attr_soc_uid);
+	if (ret)
+		goto free_rev;
+
 	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
 		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
 
-- 
2.7.4

