Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B94C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287D12183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfC2OBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:01:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60148 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfC2OAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:00:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 041062002E9;
        Fri, 29 Mar 2019 15:00:22 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EB71F200270;
        Fri, 29 Mar 2019 15:00:21 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.74.120])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 37BBE20606;
        Fri, 29 Mar 2019 15:00:21 +0100 (CET)
From:   laurentiu.tudor@nxp.com
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com
Cc:     davem@davemloft.net, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 07/13] fsl/fman: backup and restore ICID registers
Date:   Fri, 29 Mar 2019 16:00:08 +0200
Message-Id: <20190329140014.8126-8-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

During probing, FMAN is reset thus losing all its register
settings. Backup port ICID registers before reset and restore
them after, similarly to how it's done on powerpc / PAMU based
platforms.
This also has the side effect of disabling the old code path
(liodn backup/restore handling) that obviously make no sense
in the context of SMMU on ARMs.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 35 +++++++++++++++++++++-
 drivers/net/ethernet/freescale/fman/fman.h |  4 +++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index e80fedb27cee..ae833e215b74 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -629,6 +629,7 @@ static void set_port_order_restoration(struct fman_fpm_regs __iomem *fpm_rg,
 	iowrite32be(tmp, &fpm_rg->fmfp_prc);
 }
 
+#ifdef CONFIG_PPC
 static void set_port_liodn(struct fman *fman, u8 port_id,
 			   u32 liodn_base, u32 liodn_ofst)
 {
@@ -646,6 +647,27 @@ static void set_port_liodn(struct fman *fman, u8 port_id,
 	iowrite32be(tmp, &fman->dma_regs->fmdmplr[port_id / 2]);
 	iowrite32be(liodn_ofst, &fman->bmi_regs->fmbm_spliodn[port_id - 1]);
 }
+#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+static void save_restore_port_icids(struct fman *fman, bool save)
+{
+	int port_idxes[] = {
+		0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc,
+		0xd, 0xe, 0xf, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
+		0x10, 0x11, 0x30, 0x31
+	};
+	int idx, i;
+
+	for (i = 0; i < ARRAY_SIZE(port_idxes); i++) {
+		idx = port_idxes[i];
+		if (save)
+			fman->sp_icids[idx] =
+				ioread32be(&fman->bmi_regs->fmbm_spliodn[idx]);
+		else
+			iowrite32be(fman->sp_icids[idx],
+				    &fman->bmi_regs->fmbm_spliodn[idx]);
+	}
+}
+#endif
 
 static void enable_rams_ecc(struct fman_fpm_regs __iomem *fpm_rg)
 {
@@ -1914,7 +1936,10 @@ static int fman_reset(struct fman *fman)
 static int fman_init(struct fman *fman)
 {
 	struct fman_cfg *cfg = NULL;
-	int err = 0, i, count;
+	int err = 0, count;
+#ifdef CONFIG_PPC
+	int i;
+#endif
 
 	if (is_init_done(fman->cfg))
 		return -EINVAL;
@@ -1934,6 +1959,7 @@ static int fman_init(struct fman *fman)
 	memset_io((void __iomem *)(fman->base_addr + CGP_OFFSET), 0,
 		  fman->state->fm_port_num_of_cg);
 
+#ifdef CONFIG_PPC
 	/* Save LIODN info before FMan reset
 	 * Skipping non-existent port 0 (i = 1)
 	 */
@@ -1953,6 +1979,9 @@ static int fman_init(struct fman *fman)
 		}
 		fman->liodn_base[i] = liodn_base;
 	}
+#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+	save_restore_port_icids(fman, true);
+#endif
 
 	err = fman_reset(fman);
 	if (err)
@@ -2181,8 +2210,12 @@ int fman_set_port_params(struct fman *fman,
 	if (err)
 		goto return_err;
 
+#ifdef CONFIG_PPC
 	set_port_liodn(fman, port_id, fman->liodn_base[port_id],
 		       fman->liodn_offset[port_id]);
+#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+	save_restore_port_icids(fman, false);
+#endif
 
 	if (fman->state->rev_info.major < 6)
 		set_port_order_restoration(fman->fpm_regs, port_id);
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 935c317fa696..19f20fa58053 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -346,8 +346,12 @@ struct fman {
 	unsigned long fifo_offset;
 	size_t fifo_size;
 
+#ifdef CONFIG_PPC
 	u32 liodn_base[64];
 	u32 liodn_offset[64];
+#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+	u32 sp_icids[64];
+#endif
 
 	struct fman_dts_params dts_params;
 };
-- 
2.17.1

