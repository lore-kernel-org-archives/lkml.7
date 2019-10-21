Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95025CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B3D20679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Zf2TycnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfJUC2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:28:31 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:34634 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfJUC2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:28:31 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x9L2R0jj001059;
        Mon, 21 Oct 2019 11:27:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x9L2R0jj001059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571624821;
        bh=rGwnrypchAXWsBh4eydVJnNqPcxPycvJ1jDHIQCeQ0o=;
        h=From:To:Cc:Subject:Date:From;
        b=Zf2TycnXa0108kxAeWiLD9OPuZMkAuLjw6uVI2yAOpHXf1rdibSWDIv/Dvool7CCK
         67cK30LQB5PydvMv1FC4wotcZRNWHV+awDSDcBb0hFXHk+UeUAtPPFUzlQqZY/iQBC
         2rg8bKR1PIyb5O2teKgsw/jufYS1VVp4QeHsCBT1ij0ltvSGhy/LpS0VYKSG0mHF/2
         3XG+LQUCezSDo+gQK9mHNOu2iDKtVAdB+TlkUtLruDjxHDXjHWv13juuvXqbOVZaKD
         2gExpQQa3k5T0WydTcK8zOYYWqSbdeeG/dfgQcE9yLxdp0TInuH2wDIAAIXIa3yHS1
         qi3XcgxHav1Fg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: denali: remove the old unified controller/chip DT support
Date:   Mon, 21 Oct 2019 11:26:54 +0900
Message-Id: <20191021022654.13886-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d8e8fd0ebf8b ("mtd: rawnand: denali: decouple controller and
NAND chips") supported the new binding for the separate controller/chip
representation, keeping the backward compatibility.

All the device trees in upstream migrated to the new binding.

Remove the support for the old binding.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali_dt.c | 55 +++-----------------------------
 1 file changed, 4 insertions(+), 51 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 5e14836f6bd5..4cce9ae33b8e 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -102,47 +102,6 @@ static int denali_dt_chip_init(struct denali_controller *denali,
 	return denali_chip_init(denali, dchip);
 }
 
-/* Backward compatibility for old platforms */
-static int denali_dt_legacy_chip_init(struct denali_controller *denali)
-{
-	struct denali_chip *dchip;
-	int nsels, i;
-
-	nsels = denali->nbanks;
-
-	dchip = devm_kzalloc(denali->dev, struct_size(dchip, sels, nsels),
-			     GFP_KERNEL);
-	if (!dchip)
-		return -ENOMEM;
-
-	dchip->nsels = nsels;
-
-	for (i = 0; i < nsels; i++)
-		dchip->sels[i].bank = i;
-
-	nand_set_flash_node(&dchip->chip, denali->dev->of_node);
-
-	return denali_chip_init(denali, dchip);
-}
-
-/*
- * Check the DT binding.
- * The new binding expects chip subnodes in the controller node.
- * So, #address-cells = <1>; #size-cells = <0>; are required.
- * Check the #size-cells to distinguish the binding.
- */
-static bool denali_dt_is_legacy_binding(struct device_node *np)
-{
-	u32 cells;
-	int ret;
-
-	ret = of_property_read_u32(np, "#size-cells", &cells);
-	if (ret)
-		return true;
-
-	return cells != 0;
-}
-
 static int denali_dt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -213,17 +172,11 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_disable_clk_ecc;
 
-	if (denali_dt_is_legacy_binding(dev->of_node)) {
-		ret = denali_dt_legacy_chip_init(denali);
-		if (ret)
+	for_each_child_of_node(dev->of_node, np) {
+		ret = denali_dt_chip_init(denali, np);
+		if (ret) {
+			of_node_put(np);
 			goto out_remove_denali;
-	} else {
-		for_each_child_of_node(dev->of_node, np) {
-			ret = denali_dt_chip_init(denali, np);
-			if (ret) {
-				of_node_put(np);
-				goto out_remove_denali;
-			}
 		}
 	}
 
-- 
2.17.1

