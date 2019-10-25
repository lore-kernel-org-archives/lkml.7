Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15470CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E986D20867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405781AbfJYG7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:59:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37694 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbfJYG7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:59:35 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 51A0E2008F3;
        Fri, 25 Oct 2019 08:59:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A94B200438;
        Fri, 25 Oct 2019 08:59:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 432B2402BC;
        Fri, 25 Oct 2019 14:59:21 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, daniel.baluta@nxp.com, aisheng.dong@nxp.com,
        abel.vesa@nxp.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] soc: imx8: Using existing serial_number instead of UID
Date:   Fri, 25 Oct 2019 14:56:22 +0800
Message-Id: <1571986583-21138-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
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
 drivers/soc/imx/soc-imx8.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index b9831576..fcbf745 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -29,14 +29,6 @@ struct imx8_soc_data {
 
 static u64 soc_uid;
 
-static ssize_t soc_uid_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%016llX\n", soc_uid);
-}
-
-static DEVICE_ATTR_RO(soc_uid);
-
 static u32 __init imx8mq_soc_revision(void)
 {
 	struct device_node *np;
@@ -174,22 +166,25 @@ static int __init imx8_soc_init(void)
 		goto free_soc;
 	}
 
+	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	if (!soc_dev_attr->serial_number) {
+		ret = -ENOMEM;
+		goto free_rev;
+	}
+
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
 		ret = PTR_ERR(soc_dev);
-		goto free_rev;
+		goto free_serial_number;
 	}
 
-	ret = device_create_file(soc_device_to_device(soc_dev),
-				 &dev_attr_soc_uid);
-	if (ret)
-		goto free_rev;
-
 	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
 		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
 
 	return 0;
 
+free_serial_number:
+	kfree(soc_dev_attr->serial_number);
 free_rev:
 	if (strcmp(soc_dev_attr->revision, "unknown"))
 		kfree(soc_dev_attr->revision);
-- 
2.7.4

