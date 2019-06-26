Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F8AC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A77A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfFZHm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:42:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38676 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfFZHmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:42:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A5131A099E;
        Wed, 26 Jun 2019 09:42:23 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D78F81A0997;
        Wed, 26 Jun 2019 09:42:17 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 21A93402FB;
        Wed, 26 Jun 2019 15:42:11 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, abel.vesa@nxp.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] soc: imx8: Add i.MX8MM UID(unique identifier) support
Date:   Wed, 26 Jun 2019 15:44:15 +0800
Message-Id: <20190626074415.18224-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626074415.18224-1-Anson.Huang@nxp.com>
References: <20190626074415.18224-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add i.MX8MM SoC UID(unique identifier) support, user
can read it from sysfs:

root@imx8mmevk:~# cat /sys/devices/soc0/soc_uid
B365FA0A5C85D6EE

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx8.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index c19ef4b..b9831576 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -66,6 +66,26 @@ static u32 __init imx8mq_soc_revision(void)
 	return rev;
 }
 
+static void __init imx8mm_soc_uid(void)
+{
+	void __iomem *ocotp_base;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
+	if (!np)
+		return;
+
+	ocotp_base = of_iomap(np, 0);
+	WARN_ON(!ocotp_base);
+
+	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
+	soc_uid <<= 32;
+	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+
+	iounmap(ocotp_base);
+	of_node_put(np);
+}
+
 static u32 __init imx8mm_soc_revision(void)
 {
 	struct device_node *np;
@@ -83,6 +103,9 @@ static u32 __init imx8mm_soc_revision(void)
 
 	iounmap(anatop_base);
 	of_node_put(np);
+
+	imx8mm_soc_uid();
+
 	return rev;
 }
 
-- 
2.7.4

