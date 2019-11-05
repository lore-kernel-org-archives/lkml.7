Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBAFC010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A662190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbfKEMfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:24 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59580 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388626AbfKEMfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:35:00 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B321E1A01F8;
        Tue,  5 Nov 2019 13:34:58 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A62541A01E9;
        Tue,  5 Nov 2019 13:34:58 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 70AB3205ED;
        Tue,  5 Nov 2019 13:34:58 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 10/12] staging: dpaa2-ethsw: enable the CTRL_IF based on the FW version
Date:   Tue,  5 Nov 2019 14:34:33 +0200
Message-Id: <1572957275-23383-11-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a features bitmask in the dpaa2-ethsw driver that would be
populated based on the running version of MC firmware. The first and
only feature, at the moment, is the control traffic which is available
only when the DPSW object version is greater than 8.4.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 13 +++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index abe920f8a665..df9d81be242b 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -2111,6 +2111,14 @@ static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 	return err;
 }
 
+void dpaa2_ethsw_set_features(struct ethsw_core *ethsw,
+			      u16 major, u16 minor)
+{
+	if (major >= DPAA2_ETHSW_CTRL_IF_MIN_MAJOR &&
+	    minor >= DPAA2_ETHSW_CTRL_IF_MIN_MINOR)
+		ethsw->features |= DPAA2_ETHSW_CONTROL_TRAFFIC;
+}
+
 static int ethsw_init(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
@@ -2154,6 +2162,11 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 		goto err_close;
 	}
 
+	/* Compose the set of supported features by
+	 * the current firmware image
+	 */
+	dpaa2_ethsw_set_features(ethsw, version_major, version_minor);
+
 	err = dpsw_reset(ethsw->mc_io, 0, ethsw->dpsw_handle);
 	if (err) {
 		dev_err(dev, "dpsw_reset err %d\n", err);
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index 747a4e15d28a..d880a3321e14 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -116,6 +116,13 @@ struct ethsw_port_priv {
 	u16			tx_qdid;
 };
 
+#define DPAA2_ETHSW_CTRL_IF_MIN_MAJOR 8
+#define DPAA2_ETHSW_CTRL_IF_MIN_MINOR 4
+
+enum dpaa2_ethsw_features {
+	DPAA2_ETHSW_CONTROL_TRAFFIC = BIT(0),
+};
+
 /* Switch data */
 struct ethsw_core {
 	struct device			*dev;
@@ -125,6 +132,7 @@ struct ethsw_core {
 	int				dev_id;
 	struct ethsw_port_priv		**ports;
 	struct iommu_domain		*iommu_domain;
+	int				features;
 
 	u8				vlans[VLAN_VID_MASK + 1];
 	bool				learning;
@@ -138,6 +146,9 @@ struct ethsw_core {
 
 static inline bool ethsw_has_ctrl_if(struct ethsw_core *ethsw)
 {
+	if (!ethsw->features & DPAA2_ETHSW_CONTROL_TRAFFIC)
+		return false;
+
 	return !(ethsw->sw_attr.options & DPSW_OPT_CTRL_IF_DIS);
 }
 #endif	/* __ETHSW_H */
-- 
1.9.1

