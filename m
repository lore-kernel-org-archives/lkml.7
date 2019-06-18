Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65329C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333EB206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfFRJl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:41:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57626 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbfFRJl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:41:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4BFD72003B7;
        Tue, 18 Jun 2019 11:41:55 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2936C200269;
        Tue, 18 Jun 2019 11:41:51 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BEF8A402A0;
        Tue, 18 Jun 2019 17:41:45 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND V2] soc: imx8: Use existing of_root directly
Date:   Tue, 18 Jun 2019 17:43:38 +0800
Message-Id: <20190618094338.11183-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
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
index ef2406f..34ab993 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -94,7 +94,6 @@ static int __init imx8_soc_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
-	struct device_node *root;
 	const struct of_device_id *id;
 	u32 soc_rev = 0;
 	const struct imx8_soc_data *data;
@@ -106,12 +105,11 @@ static int __init imx8_soc_init(void)
 
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
@@ -136,8 +134,6 @@ static int __init imx8_soc_init(void)
 		goto free_rev;
 	}
 
-	of_node_put(root);
-
 	return 0;
 
 free_rev:
@@ -145,7 +141,6 @@ static int __init imx8_soc_init(void)
 		kfree(soc_dev_attr->revision);
 free_soc:
 	kfree(soc_dev_attr);
-	of_node_put(root);
 	return ret;
 }
 device_initcall(imx8_soc_init);
-- 
2.7.4

