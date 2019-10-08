Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89FDC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A2821835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570564364;
	bh=NxfSURK4m/zpe3s/DMmkIEjB5/N5cHvHZT57B/cvWjM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mtrotTvzSSlfFuxGKMJ3H4btObjRTU5uMsUUqueGohQwTlokKhY18PhDuJVWo2X6E
	 AcgxNS540nsJbC/7xi/sH+q+Nk7NOYC+ztuG6ZvtgHcO/v8+UQ5IIUfSI+aeOgBTcH
	 paL+3Xva+455Jw2eUPTQdgskbAocFXau7XpWLPXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfJHTwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:52:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38824 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbfJHTwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:52:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id m16so15911073oic.5;
        Tue, 08 Oct 2019 12:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DpOnxNX3I7+J8dRMWaO+FigaTKEbqHibu1OQL1peJY=;
        b=j3dlhm6KW0cOiXV+bPkyVeSoivS7X9TmeginrfWtccgidsF4kfE+sZDGiILG0t/zWQ
         6sqxqCIj7X0EWpf8lNVfCCnI9eeY/zndFwdu4GlBEDlVjOtfWJbtAT4AFT2iahixJ9eh
         MgmXw6S/MLvAgx0pOR5FffpPBk0n7k+xJDZyp/nUlCvajN3rnJ2w3J+ofn1S51pDSqmd
         n8ThYvaEhQRV4OXkx5KSPG7CircFMr+FCYUO5hZtHGQrweIgPUgn+NDidL5BseEde/xh
         tNRdQMPKhkol4vu+aZVFjZXck2++a2fiVDyA+EXz+WVFxppGInvjHIwvTyVOK1fStWs4
         rDKA==
X-Gm-Message-State: APjAAAWDIqRAlUq2jgfwlEbUl131YN/ucDas7xCe7PJzIIc0+j/0eneY
        hVOP8ublQLwggNRUeBBm6sdYmbI=
X-Google-Smtp-Source: APXvYqx3UCdVEhyicSwZJeq8Uk0rPo4W8xc+pe7UghGarV6P5NA3FcZJ4CC9ipmykIi72BrvPCmPhg==
X-Received: by 2002:aca:b342:: with SMTP id c63mr5424396oif.91.1570564361631;
        Tue, 08 Oct 2019 12:52:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z10sm6151032ote.54.2019.10.08.12.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:52:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2] of: Make of_dma_get_range() work on bus nodes
Date:   Tue,  8 Oct 2019 14:52:39 -0500
Message-Id: <20191008195239.12852-1-robh@kernel.org>
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
Resending, hit send too quickly.

v2:
 - Ensure once we find dma-ranges, every parent has it.
 - Only get the #{size,address}-cells after we find non-empty dma-ranges
 - Add a check on the 'dma-ranges' length

This is all that remains of the dma-ranges series. I've applied the rest 
of the series prep and fixes. I dropped "of: Ratify of_dma_configure() 
interface" as the assertions that the node pointer being the parent only 
when struct device doesn't have a DT node pointer is not always 
true.

I didn't include any tested-bys as this has changed a bit. A git branch 
is here[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dma-masks-v2

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

