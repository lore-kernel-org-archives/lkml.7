Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CF8C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D21120896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436555AbfFLDek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 23:34:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52554 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404730AbfFLDei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:34:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B62A31A0C2E;
        Wed, 12 Jun 2019 05:34:36 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 35E181A00CD;
        Wed, 12 Jun 2019 05:34:32 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 57791402DD;
        Wed, 12 Jun 2019 11:34:26 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] soc: imx8: Use existing of_root directly
Date:   Wed, 12 Jun 2019 11:36:20 +0800
Message-Id: <20190612033620.3556-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612033620.3556-1-Anson.Huang@nxp.com>
References: <20190612033620.3556-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

There is common of_root for reference, no need to find it
from DT again, use of_root directly to make driver simple.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx8.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index 86b925a..a632083 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -100,7 +100,6 @@ static int __init imx8_soc_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
-	struct device_node *root;
 	const struct of_device_id *id;
 	u32 soc_rev = 0;
 	const struct imx8_soc_data *data;
@@ -112,12 +111,11 @@ static int __init imx8_soc_init(void)
 
 	soc_dev_attr->family = "Freescale i.MX";
 
-	root = of_find_node_by_path("/");
-	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
 	if (ret)
 		goto free_soc;
 
-	id = of_match_node(imx8_soc_match, root);
+	id = of_match_node(imx8_soc_match, of_root);
 	if (!id) {
 		ret = -ENODEV;
 		goto free_soc;
@@ -145,8 +143,6 @@ static int __init imx8_soc_init(void)
 		goto free_rev;
 	}
 
-	of_node_put(root);
-
 	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
 		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
 
@@ -156,7 +152,6 @@ static int __init imx8_soc_init(void)
 	kfree(soc_dev_attr->revision);
 free_soc:
 	kfree(soc_dev_attr);
-	of_node_put(root);
 	return ret;
 }
 device_initcall(imx8_soc_init);
-- 
2.7.4

