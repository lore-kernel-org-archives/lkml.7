Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E1C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D2B2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbfKEMfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:01 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41884 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388532AbfKEMe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:34:58 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BA58D200500;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ABD7C2004F1;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 765A4205ED;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 03/12] staging: dpaa2-ethsw: setup RX path rings
Date:   Tue,  5 Nov 2019 14:34:26 +0200
Message-Id: <1572957275-23383-4-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Rx path, when a pull-dequeue operation is performed on a
software portal, available frame descriptors are put in a ring - a DMA
memory storage - for further usage. Create the needed rings for both
frame queues used on the control interface.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 37 +++++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h |  6 ++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 4ed335af2cc8..7b68eb22a951 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1459,6 +1459,33 @@ static void ethsw_free_dpbp(struct ethsw_core *ethsw)
 	fsl_mc_object_free(ethsw->dpbp_dev);
 }
 
+static int ethsw_alloc_rings(struct ethsw_core *ethsw)
+{
+	int i;
+
+	for (i = 0; i < ETHSW_RX_NUM_FQS; i++) {
+		ethsw->fq[i].store =
+			dpaa2_io_store_create(DPAA2_ETHSW_STORE_SIZE,
+					      ethsw->dev);
+		if (!ethsw->fq[i].store) {
+			dev_err(ethsw->dev, "dpaa2_io_store_create failed\n");
+			while (--i >= 0)
+				dpaa2_io_store_destroy(ethsw->fq[i].store);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static void ethsw_destroy_rings(struct ethsw_core *ethsw)
+{
+	int i;
+
+	for (i = 0; i < ETHSW_RX_NUM_FQS; i++)
+		dpaa2_io_store_destroy(ethsw->fq[i].store);
+}
+
 static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 {
 	int err;
@@ -1473,7 +1500,16 @@ static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 	if (err)
 		return err;
 
+	err = ethsw_alloc_rings(ethsw);
+	if (err)
+		goto err_free_dpbp;
+
 	return 0;
+
+err_free_dpbp:
+	ethsw_free_dpbp(ethsw);
+
+	return err;
 }
 
 static int ethsw_init(struct fsl_mc_device *sw_dev)
@@ -1651,6 +1687,7 @@ static void ethsw_takedown(struct fsl_mc_device *sw_dev)
 
 static void ethsw_ctrl_if_teardown(struct ethsw_core *ethsw)
 {
+	ethsw_destroy_rings(ethsw);
 	ethsw_free_dpbp(ethsw);
 }
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index c3cfd08c21c7..a1ca30c615d5 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -19,6 +19,8 @@
 #include <linux/if_bridge.h>
 #include <linux/fsl/mc.h>
 
+#include <soc/fsl/dpaa2-io.h>
+
 #include "dpsw.h"
 
 /* Number of IRQs supported */
@@ -48,6 +50,9 @@
 #define DPAA2_ETHSW_RX_BUF_SIZE \
 	(DPAA2_ETHSW_RX_BUF_RAW_SIZE - DPAA2_ETHSW_RX_BUF_TAILROOM)
 
+/* Dequeue store size */
+#define DPAA2_ETHSW_STORE_SIZE		16
+
 extern const struct ethtool_ops ethsw_port_ethtool_ops;
 
 struct ethsw_core;
@@ -55,6 +60,7 @@
 struct ethsw_fq {
 	struct ethsw_core *ethsw;
 	enum dpsw_queue_type type;
+	struct dpaa2_io_store *store;
 	u32 fqid;
 };
 
-- 
1.9.1

