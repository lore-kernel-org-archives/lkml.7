Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A844C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF40214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="f60oHmXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCLIql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:46:41 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:37386 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfCLIqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:46:40 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x2C8j6Zg004092;
        Tue, 12 Mar 2019 17:45:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x2C8j6Zg004092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552380321;
        bh=/HYOG6Znx3tjMAy9o8VQey5HBdroa+Gr+dhg2Ya6JXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f60oHmXc6d/J1BcGZuZ+ww2rj+8Hnvq1sLh94PruRHLVGt8yaHlZjshFOg8TOyH0e
         na2Ca3Du4Up5H+TCAlUqN/33pYIXGZxuO7iNNfxGDCFco+W8idhtgvIa9r7EmHBlAI
         VU+Z4+8XqsLiyz7F8TyS+etj1lOplPtCUVSLh2cke0Defh1Rc/La9aoqxvQ7tFuUq+
         Eg8i8Pee9+fbk7hSBDCsklumJ2XTkf9YjP49RxYYIum1nmxwFHNhfOAxjxGooghe39
         yKZhWgowpvZLtX6DekWaQbXROoO1OelRVIZAhzrG5OqDSX7YceI7zOwN62Ssvz0SU+
         dbqWARCGnau5w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v3 6/9] mtd: rawnand: denali_pci: rename goto labels
Date:   Tue, 12 Mar 2019 17:44:47 +0900
Message-Id: <1552380290-19951-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
References: <1552380290-19951-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Documentation/process/coding-style.rst says, choose label names
which say what the goto does. The out_<action> label style is already
used in denali_dt.c. Rename likewise for denali_pci.c

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mtd/nand/raw/denali_pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/denali_pci.c
index 48e9ac5..02eb599 100644
--- a/drivers/mtd/nand/raw/denali_pci.c
+++ b/drivers/mtd/nand/raw/denali_pci.c
@@ -84,20 +84,20 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!denali->host) {
 		dev_err(&dev->dev, "Spectra: ioremap_nocache failed!");
 		ret = -ENOMEM;
-		goto failed_remap_reg;
+		goto out_unmap_reg;
 	}
 
 	ret = denali_init(denali);
 	if (ret)
-		goto failed_remap_mem;
+		goto out_unmap_host;
 
 	pci_set_drvdata(dev, denali);
 
 	return 0;
 
-failed_remap_mem:
+out_unmap_host:
 	iounmap(denali->host);
-failed_remap_reg:
+out_unmap_reg:
 	iounmap(denali->reg);
 	return ret;
 }
-- 
2.7.4

