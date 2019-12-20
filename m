Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C30C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065872465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="M98RO5g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLTLeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:34:03 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36601 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfLTLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:33:58 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xBKBW2Wv010984;
        Fri, 20 Dec 2019 20:32:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xBKBW2Wv010984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576841526;
        bh=v9133Ufzc3+ic87B/K3hcV7PpJe8R3xx9bGS9VeHmEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M98RO5g7Dl+IAFl7CBY+mE2aAH6WsodGaRO14yB70GRQtJ/zXz5KxVoKOYBEwkVqD
         nvBZtrCP3vhs0Y+rqnXwygAFssqIuSPG5RA+th90akWkzXELLHOgpWbOJq6K4lPqmU
         DlG33DyVywWfSGPVGK2KL20+W0S1Po59s1hjfK0ux31s9VACxK60mKHCQD/TykjcPp
         hiHE44ptkLTt95kgcWQg5Ga6nB3OhwdmrHehB/FadonjX97MTSKx7S9pcUBuuej2ge
         OvxWrWQtlM4tv0vTZZL1tbkrP/EcwxIdqITIN0czJgAvnLTDGN1bzW7q/8wD0KFCoT
         GzswpdCvKwEaA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] mtd: rawnand: denali_dt: Add support for configuring SPARE_AREA_SKIP_BYTES
Date:   Fri, 20 Dec 2019 20:31:52 +0900
Message-Id: <20191220113155.28177-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220113155.28177-1-yamada.masahiro@socionext.com>
References: <20191220113155.28177-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

The SPARE_AREA_SKIP_BYTES register is reset when the controller reset
signal is toggled. Yet, this register must be configured to match the
content of the NAND OOB area. The current default value is always set
to 8 and is programmed into the hardware in case the hardware was not
programmed before (e.g. in a bootloader) with a different value. This
however does not work when the block is reset properly by Linux.

On Altera SoCFPGA CycloneV, ArriaV and Arria10, which are the SoCFPGA
platforms which support booting from NAND, the SPARE_AREA_SKIP_BYTES
value must be set to 2. On Socionext Uniphier, the value is 8. This
patch adds support for preconfiguring the default value and handles
the special SoCFPGA case by setting the default to 2 on all SoCFPGA
platforms, while retaining the original behavior and default value of
8 on all the other platforms.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
To: linux-mtd@lists.infradead.org
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  [Masahiro]
   - Rebase and give my Acked-by

Changes in v2:
  - V2: Move denali->oob_skip_bytes = data->oob_skip_bytes; right after
    of_device_get_match_data()

 drivers/mtd/nand/raw/denali.c    | 13 ++++++++++---
 drivers/mtd/nand/raw/denali_dt.c |  5 +++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 3102ddbd8abd..b6c463d02167 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1302,14 +1302,21 @@ int denali_init(struct denali_controller *denali)
 
 	/*
 	 * Set how many bytes should be skipped before writing data in OOB.
+	 * If a non-zero value has already been configured, update it in HW.
 	 * If a non-zero value has already been set (by firmware or something),
 	 * just use it. Otherwise, set the driver's default.
 	 */
-	denali->oob_skip_bytes = ioread32(denali->reg + SPARE_AREA_SKIP_BYTES);
-	if (!denali->oob_skip_bytes) {
-		denali->oob_skip_bytes = DENALI_DEFAULT_OOB_SKIP_BYTES;
+	if (denali->oob_skip_bytes) {
 		iowrite32(denali->oob_skip_bytes,
 			  denali->reg + SPARE_AREA_SKIP_BYTES);
+	} else {
+		denali->oob_skip_bytes =
+			ioread32(denali->reg + SPARE_AREA_SKIP_BYTES);
+		if (!denali->oob_skip_bytes) {
+			denali->oob_skip_bytes = DENALI_DEFAULT_OOB_SKIP_BYTES;
+			iowrite32(denali->oob_skip_bytes,
+				  denali->reg + SPARE_AREA_SKIP_BYTES);
+		}
 	}
 
 	iowrite32(0, denali->reg + TRANSFER_SPARE_REG);
diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 276187939689..699255fb2dd8 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -27,6 +27,7 @@ struct denali_dt {
 struct denali_dt_data {
 	unsigned int revision;
 	unsigned int caps;
+	unsigned int oob_skip_bytes;
 	const struct nand_ecc_caps *ecc_caps;
 };
 
@@ -34,6 +35,7 @@ NAND_ECC_CAPS_SINGLE(denali_socfpga_ecc_caps, denali_calc_ecc_bytes,
 		     512, 8, 15);
 static const struct denali_dt_data denali_socfpga_data = {
 	.caps = DENALI_CAP_HW_ECC_FIXUP,
+	.oob_skip_bytes = 2,
 	.ecc_caps = &denali_socfpga_ecc_caps,
 };
 
@@ -42,6 +44,7 @@ NAND_ECC_CAPS_SINGLE(denali_uniphier_v5a_ecc_caps, denali_calc_ecc_bytes,
 static const struct denali_dt_data denali_uniphier_v5a_data = {
 	.caps = DENALI_CAP_HW_ECC_FIXUP |
 		DENALI_CAP_DMA_64BIT,
+	.oob_skip_bytes = 8,
 	.ecc_caps = &denali_uniphier_v5a_ecc_caps,
 };
 
@@ -51,6 +54,7 @@ static const struct denali_dt_data denali_uniphier_v5b_data = {
 	.revision = 0x0501,
 	.caps = DENALI_CAP_HW_ECC_FIXUP |
 		DENALI_CAP_DMA_64BIT,
+	.oob_skip_bytes = 8,
 	.ecc_caps = &denali_uniphier_v5b_ecc_caps,
 };
 
@@ -123,6 +127,7 @@ static int denali_dt_probe(struct platform_device *pdev)
 
 	denali->revision = data->revision;
 	denali->caps = data->caps;
+	denali->oob_skip_bytes = data->oob_skip_bytes;
 	denali->ecc_caps = data->ecc_caps;
 
 	denali->dev = dev;
-- 
2.17.1

