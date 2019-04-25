Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3634C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042ED206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EZX2iUrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfDYO4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:56:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41096 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfDYO4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:56:03 -0400
Received: from zn.tnic (p200300EC2F0E43001D86563D61B131D5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4300:1d86:563d:61b1:31d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DBDB1EC09F1;
        Thu, 25 Apr 2019 16:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556204161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=HlhU7sVeqBudDbuFGfe1q1xxgBNWTsEvOFUEN3Hx9qc=;
        b=EZX2iUrAL1jGoWk4d0wowQq6cHPBzQ1pep1GN1x+P4/QtsOKoApZ/6VJSzc0pbGe/xgP6h
        /0DQZ3KApl/kgaAvLznv18Dx5enAJnLPeGB8QEDxCRkcjmDtlPchX7ngxfsgttZCF9vNOP
        wDsd417heLz1HgucXYYqdMTHup08E+0=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] Revert "EDAC/amd64: Support more than two controllers for chip select handling"
Date:   Thu, 25 Apr 2019 16:55:54 +0200
Message-Id: <20190425145554.5091-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This reverts commit 0a227af521d6df5286550b62f4b591417170b4ea.

Unfortunately, this commit caused wrong detection of chip select sizes
on some F17h client machines:

  --- 00-rc6+     2019-02-14 14:28:03.126622904 +0100
  +++ 01-rc4+     2019-04-14 21:06:16.060614790 +0200
   EDAC amd64: MC: 0:     0MB 1:     0MB
  -EDAC amd64: MC: 2: 16383MB 3: 16383MB
  +EDAC amd64: MC: 2:     0MB 3: 2097151MB
   EDAC amd64: MC: 4:     0MB 5:     0MB
   EDAC amd64: MC: 6:     0MB 7:     0MB
   EDAC MC: UMC1 chip selects:
   EDAC amd64: MC: 0:     0MB 1:     0MB
  -EDAC amd64: MC: 2: 16383MB 3: 16383MB
  +EDAC amd64: MC: 2:     0MB 3: 2097151MB
   EDAC amd64: MC: 4:     0MB 5:     0MB
   EDAC amd64: MC: 6:     0MB 7:     0M

Revert it for now until it has been solved properly.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 113 ++++++++++++++++++--------------------
 drivers/edac/amd64_edac.h |   5 +-
 2 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4c0239aeff2f..e2a99466faaa 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -941,94 +941,89 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
-	} else if (pvt->fam >= 0x17) {
-		int umc;
-
-		for_each_umc(umc) {
-			pvt->csels[umc].b_cnt = 8;
-			pvt->csels[umc].m_cnt = 4;
-		}
-
 	} else {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
 	}
 }
 
-static void read_umc_base_mask(struct amd64_pvt *pvt)
-{
-	int cs, umc;
-
-	for_each_umc(umc) {
-		u32 umc_base_reg = get_umc_base(umc) + UMCCH_BASE_ADDR;
-		u32 umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
-
-		for_each_chip_select(cs, 0, pvt) {
-			u32 *base = &pvt->csels[umc].csbases[cs];
-			u32 *mask = &pvt->csels[umc].csmasks[cs];
-
-			u32 base_reg = umc_base_reg + (cs * 4);
-			u32 mask_reg = umc_mask_reg + ((cs >> 1) * 4);
-
-			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
-				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
-					 umc, cs, *base, base_reg);
-
-			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
-				edac_dbg(0, "    DCSM%d[%d]=0x%08x reg: 0x%x\n",
-					 umc, cs, *mask, mask_reg);
-		}
-	}
-}
-
 /*
  * Function 2 Offset F10_DCSB0; read in the DCS Base and DCS Mask registers
  */
 static void read_dct_base_mask(struct amd64_pvt *pvt)
 {
-	int cs;
+	int base_reg0, base_reg1, mask_reg0, mask_reg1, cs;
 
 	prep_chip_selects(pvt);
 
-	if (pvt->umc)
-		return read_umc_base_mask(pvt);
+	if (pvt->umc) {
+		base_reg0 = get_umc_base(0) + UMCCH_BASE_ADDR;
+		base_reg1 = get_umc_base(1) + UMCCH_BASE_ADDR;
+		mask_reg0 = get_umc_base(0) + UMCCH_ADDR_MASK;
+		mask_reg1 = get_umc_base(1) + UMCCH_ADDR_MASK;
+	} else {
+		base_reg0 = DCSB0;
+		base_reg1 = DCSB1;
+		mask_reg0 = DCSM0;
+		mask_reg1 = DCSM1;
+	}
 
 	for_each_chip_select(cs, 0, pvt) {
-		int reg0   = DCSB0 + (cs * 4);
-		int reg1   = DCSB1 + (cs * 4);
+		int reg0   = base_reg0 + (cs * 4);
+		int reg1   = base_reg1 + (cs * 4);
 		u32 *base0 = &pvt->csels[0].csbases[cs];
 		u32 *base1 = &pvt->csels[1].csbases[cs];
 
-		if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, base0))
-			edac_dbg(0, "  DCSB0[%d]=0x%08x reg: F2x%x\n",
-				 cs, *base0, reg0);
+		if (pvt->umc) {
+			if (!amd_smn_read(pvt->mc_node_id, reg0, base0))
+				edac_dbg(0, "  DCSB0[%d]=0x%08x reg: 0x%x\n",
+					 cs, *base0, reg0);
 
-		if (pvt->fam == 0xf)
-			continue;
+			if (!amd_smn_read(pvt->mc_node_id, reg1, base1))
+				edac_dbg(0, "  DCSB1[%d]=0x%08x reg: 0x%x\n",
+					 cs, *base1, reg1);
+		} else {
+			if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, base0))
+				edac_dbg(0, "  DCSB0[%d]=0x%08x reg: F2x%x\n",
+					 cs, *base0, reg0);
+
+			if (pvt->fam == 0xf)
+				continue;
 
-		if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, base1))
-			edac_dbg(0, "  DCSB1[%d]=0x%08x reg: F2x%x\n",
-				 cs, *base1, (pvt->fam == 0x10) ? reg1
-							: reg0);
+			if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, base1))
+				edac_dbg(0, "  DCSB1[%d]=0x%08x reg: F2x%x\n",
+					 cs, *base1, (pvt->fam == 0x10) ? reg1
+								: reg0);
+		}
 	}
 
 	for_each_chip_select_mask(cs, 0, pvt) {
-		int reg0   = DCSM0 + (cs * 4);
-		int reg1   = DCSM1 + (cs * 4);
+		int reg0   = mask_reg0 + (cs * 4);
+		int reg1   = mask_reg1 + (cs * 4);
 		u32 *mask0 = &pvt->csels[0].csmasks[cs];
 		u32 *mask1 = &pvt->csels[1].csmasks[cs];
 
-		if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, mask0))
-			edac_dbg(0, "    DCSM0[%d]=0x%08x reg: F2x%x\n",
-				 cs, *mask0, reg0);
+		if (pvt->umc) {
+			if (!amd_smn_read(pvt->mc_node_id, reg0, mask0))
+				edac_dbg(0, "    DCSM0[%d]=0x%08x reg: 0x%x\n",
+					 cs, *mask0, reg0);
 
-		if (pvt->fam == 0xf)
-			continue;
+			if (!amd_smn_read(pvt->mc_node_id, reg1, mask1))
+				edac_dbg(0, "    DCSM1[%d]=0x%08x reg: 0x%x\n",
+					 cs, *mask1, reg1);
+		} else {
+			if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, mask0))
+				edac_dbg(0, "    DCSM0[%d]=0x%08x reg: F2x%x\n",
+					 cs, *mask0, reg0);
 
-		if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, mask1))
-			edac_dbg(0, "    DCSM1[%d]=0x%08x reg: F2x%x\n",
-				 cs, *mask1, (pvt->fam == 0x10) ? reg1
-							: reg0);
+			if (pvt->fam == 0xf)
+				continue;
+
+			if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, mask1))
+				edac_dbg(0, "    DCSM1[%d]=0x%08x reg: F2x%x\n",
+					 cs, *mask1, (pvt->fam == 0x10) ? reg1
+								: reg0);
+		}
 	}
 }
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4dce6a2ac75f..8f66472f7adc 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -96,7 +96,6 @@
 /* Hardware limit on ChipSelect rows per MC and processors per system */
 #define NUM_CHIPSELECTS			8
 #define DRAM_RANGES			8
-#define NUM_CONTROLLERS			8
 
 #define ON true
 #define OFF false
@@ -352,8 +351,8 @@ struct amd64_pvt {
 	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
 	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
 
-	/* one for each DCT/UMC */
-	struct chip_select csels[NUM_CONTROLLERS];
+	/* one for each DCT */
+	struct chip_select csels[2];
 
 	/* DRAM base and limit pairs F1x[78,70,68,60,58,50,48,40] */
 	struct dram_range ranges[DRAM_RANGES];
-- 
2.21.0

