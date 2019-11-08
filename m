Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6092C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E066215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214987;
	bh=61Zi68SLTQlqqIhEFxVkIGJTkP0MJg3PyoENUJb2L+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ecnrlMcL1p7h2/MNOqTPXhAbXEmldRpRAd0kmlzYCzVwi26IMJK5jAhVBjzwixbtS
	 b4szqfcueUPKh/BY32kiePorQXG9cKSqZgcVhtw207qo9lD4yWWM+XQvKCHEzRXCDA
	 LRGGpJeVQkdxUauNRVws/vBht8qunTCgqbv2TAm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbfKHLj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:39:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388119AbfKHLjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:39:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3835B20869;
        Fri,  8 Nov 2019 11:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213192;
        bh=61Zi68SLTQlqqIhEFxVkIGJTkP0MJg3PyoENUJb2L+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2tfOBhxT2hyA4UARK+KCZEHDBktX3PIdgQiD0FeGwgpdO4gS0h/w/qAeuTgDvPJp
         +NY0nv9IYErSGw+0btcq4pQNwtIfrgKdM7QOEvs5Y+X2RnsCZTie90Vr24Nq4pI9ls
         VcvBJbFuDl4iQlKs14o3yEbjZJu+LP3CRXcPjuwk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 081/205] mtd: rawnand: fsl_ifc: check result of SRAM initialization
Date:   Fri,  8 Nov 2019 06:35:48 -0500
Message-Id: <20191108113752.12502-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kurt Kanzenbach <kurt@linutronix.de>

[ Upstream commit 434655af6a187129d8114640443b27d2cecfb979 ]

The SRAM initialization might fail. If that happens further NAND operations
won't be successful. Therefore, the chip init routine should fail if the SRAM
initialization didn't work.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/fsl_ifc_nand.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 24f59d0066afd..e4f5792dc5893 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -761,7 +761,7 @@ static const struct nand_controller_ops fsl_ifc_controller_ops = {
 	.attach_chip = fsl_ifc_attach_chip,
 };
 
-static void fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
+static int fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
 {
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_runtime __iomem *ifc_runtime = ctrl->rregs;
@@ -805,12 +805,16 @@ static void fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
 	wait_event_timeout(ctrl->nand_wait, ctrl->nand_stat,
 			   msecs_to_jiffies(IFC_TIMEOUT_MSECS));
 
-	if (ctrl->nand_stat != IFC_NAND_EVTER_STAT_OPC)
+	if (ctrl->nand_stat != IFC_NAND_EVTER_STAT_OPC) {
 		pr_err("fsl-ifc: Failed to Initialise SRAM\n");
+		return -ETIMEDOUT;
+	}
 
 	/* Restore CSOR and CSOR_ext */
 	ifc_out32(csor, &ifc_global->csor_cs[cs].csor);
 	ifc_out32(csor_ext, &ifc_global->csor_cs[cs].csor_ext);
+
+	return 0;
 }
 
 static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
@@ -914,8 +918,13 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 		chip->ecc.algo = NAND_ECC_HAMMING;
 	}
 
-	if (ctrl->version >= FSL_IFC_VERSION_1_1_0)
-		fsl_ifc_sram_init(priv);
+	if (ctrl->version >= FSL_IFC_VERSION_1_1_0) {
+		int ret;
+
+		ret = fsl_ifc_sram_init(priv);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * As IFC version 2.0.0 has 16KB of internal SRAM as compared to older
-- 
2.20.1

