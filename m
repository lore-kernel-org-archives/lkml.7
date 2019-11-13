Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9E3C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F79206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfKMRPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:15:18 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51161 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbfKMRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:15:16 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 06872E0011;
        Wed, 13 Nov 2019 17:15:12 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 2/4] mtd: Add get_mtd_device_by_node() helper
Date:   Wed, 13 Nov 2019 18:15:03 +0100
Message-Id: <20191113171505.26128-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113171505.26128-1-miquel.raynal@bootlin.com>
References: <20191113171505.26128-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernhard Frauendienst <kernel@nospam.obeliks.de>

Add an helper to retrieve a MTD device by its OF node. Since drivers can
assign arbitrary names to MTD devices in the absence of a 'label' DT
property, there is no other reliable way to retrieve a MTD device for a
given OF node.

Signed-off-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
[<miquel.raynal@bootlin.com>: light internals rework]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/mtdcore.c   | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 76b4264936ff..5a94a2c0a6de 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -985,6 +985,44 @@ struct mtd_info *get_mtd_device_nm(const char *name)
 }
 EXPORT_SYMBOL_GPL(get_mtd_device_nm);
 
+/**
+ *	get_mtd_device_by_node - obtain a validated handle for an MTD device
+ *	by of_node
+ *	@of_node: OF node of MTD device to open
+ *
+ *	This function returns an MTD device structure in case of success,
+ *	an error code otherwise.
+ */
+struct mtd_info *get_mtd_device_by_node(const struct device_node *of_node)
+{
+	struct mtd_info *mtd;
+	bool found = false;
+	int ret;
+
+	mutex_lock(&mtd_table_mutex);
+
+	mtd_for_each_device(mtd) {
+		if (of_node == mtd->dev.of_node) {
+			found = true;
+			break;
+		}
+	}
+
+	if (found)
+		ret = __get_mtd_device(mtd);
+
+	mutex_unlock(&mtd_table_mutex);
+
+	if (!found)
+		return ERR_PTR(-ENODEV);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return mtd;
+}
+EXPORT_SYMBOL_GPL(get_mtd_device_by_node);
+
 void put_mtd_device(struct mtd_info *mtd)
 {
 	mutex_lock(&mtd_table_mutex);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 677768b21a1d..0f25c476a1a3 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -573,6 +573,8 @@ extern struct mtd_info *get_mtd_device(struct mtd_info *mtd, int num);
 extern int __get_mtd_device(struct mtd_info *mtd);
 extern void __put_mtd_device(struct mtd_info *mtd);
 extern struct mtd_info *get_mtd_device_nm(const char *name);
+extern struct mtd_info *get_mtd_device_by_node(
+		const struct device_node *of_node);
 extern void put_mtd_device(struct mtd_info *mtd);
 
 
-- 
2.20.1

