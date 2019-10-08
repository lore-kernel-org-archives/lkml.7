Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C46C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4903D21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570563784;
	bh=0Q9N0eIfUOZeCLFUdyu/TPNy9QnsRIz7q4lrP3NFEOQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=x5uR4sKoOH2AM/K6aFTkMKSvq2Qb9LEIaqaan8s3wVezLf9zMLhxDEXOXBbnp848w
	 4N0TXToabYWIaNFNmpUhCtmdUlxMSdkCLHL9VCauFaPMMd7oS6yO9rTPhw+CF35ZwW
	 38Al8Zhol0sVTTBSkpWYqzthdQdVtOrI62EuF5Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfJHTnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:43:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38956 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfJHTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:43:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so15083381otr.6;
        Tue, 08 Oct 2019 12:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hHpNdmx6ZCCeIfcgfwoHn6k+baku1ya57GjAAC0jCk=;
        b=oVMOrScYCgwZwoLm6suVpoQ48XNuV/hsv27J3e6kOJ58qaqJwGePsPohrR7qid6FwF
         ukTuoyBJuOWT5xW/w0CTncrA6Qu11PcvLRpLm8JGwXInCnlomV5aZ6Smjry8U3uG0SWY
         jPqNIzeEGbTpkZms4tcQXqZiumjmbpFCRIuHfbuFfnEtExrMmVCvmKAzEQVurMr/Q4ue
         RGPBLB9mAaoNr4dmeohU/cBk+CbsjobbnnrTxbK6niZN08aMb23xiclojI6s81XaaosQ
         l4ASVArzGK9ep01LqVdl5xNFKtnj6pExmMH8ECWOB+wINuKH4JzKWgEY893+bQq/0erQ
         AmdQ==
X-Gm-Message-State: APjAAAWgVX4u37p02RlsfDm5CEyzffxU9p1ExbUZ0rUBvrH2kb+C/6qw
        0fkBRxMYqj4nOR0kD1AoozxUCoI=
X-Google-Smtp-Source: APXvYqx0hRy7RDge7tDO8F/mdn/AaiNxsFZGFE5MtHui5GF4agtZ9gjqzUAbj2L8XkP8g+AKBmIBHg==
X-Received: by 2002:a9d:64c8:: with SMTP id n8mr5431476otl.342.1570563781495;
        Tue, 08 Oct 2019 12:43:01 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y16sm5481079otg.7.2019.10.08.12.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:43:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] of: Make of_dma_get_range() work on bus nodes
Date:   Tue,  8 Oct 2019 14:43:00 -0500
Message-Id: <20191008194300.12626-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

Since the "dma-ranges" property is only valid for a node representing a
bus, of_dma_get_range() currently assumes the node passed in is a leaf
representing a device, and starts the walk from its parent. In cases
like PCI host controllers on typical FDT systems, however, where the PCI
endpoints are probed dynamically the initial leaf node represents the
'bus' itself, and this logic means we fail to consider any "dma-ranges"
describing the host bridge itself. Rework the logic such that
of_dma_get_range() also works correctly starting from a bus node
containing "dma-ranges".

While this does mean "dma-ranges" could incorrectly be in a device leaf
node, there isn't really any way in this function to ensure that a leaf
node is or isn't a bus node.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[robh: Allow for the bus child node to still be passed in]
Signed-off-by: Rob Herring <robh@kernel.org>

---
v2:
 - Ensure once we find dma-ranges, every parent has it.
 - Only get the #{size,address}-cells after we find non-empty dma-ranges
 - Add a check on the 'dma-ranges' length
---
 drivers/of/address.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 5ce69d026584..99c1b8058559 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -930,47 +930,39 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	const __be32 *ranges = NULL;
 	int len, naddr, nsize, pna;
 	int ret = 0;
+	bool found_dma_ranges = false;
 	u64 dmaaddr;
 
-	if (!node)
-		return -EINVAL;
-
-	while (1) {
-		struct device_node *parent;
-
-		naddr = of_n_addr_cells(node);
-		nsize = of_n_size_cells(node);
-
-		parent = __of_get_dma_parent(node);
-		of_node_put(node);
-
-		node = parent;
-		if (!node)
-			break;
-
+	while (node) {
 		ranges = of_get_property(node, "dma-ranges", &len);
 
 		/* Ignore empty ranges, they imply no translation required */
 		if (ranges && len > 0)
 			break;
 
-		/*
-		 * At least empty ranges has to be defined for parent node if
-		 * DMA is supported
-		 */
-		if (!ranges)
-			break;
+		/* Once we find 'dma-ranges', then a missing one is an error */
+		if (found_dma_ranges && !ranges) {
+			ret = -ENODEV;
+			goto out;
+		}
+		found_dma_ranges = true;
+
+		node = of_get_next_dma_parent(node);
 	}
 
-	if (!ranges) {
+	if (!node || !ranges) {
 		pr_debug("no dma-ranges found for node(%pOF)\n", np);
 		ret = -ENODEV;
 		goto out;
 	}
 
-	len /= sizeof(u32);
-
+	naddr = of_bus_n_addr_cells(node);
+	nsize = of_bus_n_size_cells(node);
 	pna = of_n_addr_cells(node);
+	if ((len / sizeof(__be32)) % (pna + naddr + nsize)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* dma-ranges format:
 	 * DMA addr	: naddr cells
@@ -978,7 +970,7 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	 * size		: nsize cells
 	 */
 	dmaaddr = of_read_number(ranges, naddr);
-	*paddr = of_translate_dma_address(np, ranges);
+	*paddr = of_translate_dma_address(node, ranges + naddr);
 	if (*paddr == OF_BAD_ADDR) {
 		pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
 		       dmaaddr, np);
-- 
2.20.1

