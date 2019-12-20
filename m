Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203F5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC662465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vJ9ZNkKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfLTLd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:33:57 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36546 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfLTLd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:33:56 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xBKBW2X0010984;
        Fri, 20 Dec 2019 20:32:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xBKBW2X0010984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576841529;
        bh=FaE1Dy6PORZJLZr2fPoSaDCJ2/3nG0fTHRJYBhAtI20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJ9ZNkKccYowU4XwyMyk1kgJ+wlThcFKimxyMyfxqOs5uY6exrWz0FoCHerjFbbLW
         39Dm0r+sC3zkRT2yGDJLLnwnN6qRFzDNm7NvgGGEv5LoDj3q5WbqsXQdUhQZs2piXI
         HViI9D9pFxujyGfh70LFHdYUvPpKeG9UmtuaxdN9I/HUQsjbKXUYOwds2ig+ef/Ltk
         tW9CzTGmWIJj+8GIsTswmHvcYoSdiYjNiV93VpDUvqljwt7guxUynFuDFzzIdyoeYh
         HONq89bXg5O55aqmuGvaVOVJpuW9z4t35HgkeZBSLOXvcH3r8Z617ZuQUgEr12tZiN
         olIjV5eQNagRw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] mtd: rawnand: denali: remove hard-coded DENALI_DEFAULT_OOB_SKIP_BYTES
Date:   Fri, 20 Dec 2019 20:31:55 +0900
Message-Id: <20191220113155.28177-6-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220113155.28177-1-yamada.masahiro@socionext.com>
References: <20191220113155.28177-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 0d55c668b218 (mtd: rawnand: denali: set SPARE_AREA_SKIP_BYTES
register to 8 if unset") says, there were three solutions discussed:

  [1] Add a DT property to specify the skipped bytes in OOB
  [2] Associate the preferred value with compatible
  [3] Hard-code the default value in the driver

At that time, [3] was chosen because I did not have enough information
about the other platforms than UniPhier.

That commit also says "The preferred value may vary by platform. If so,
please trade up to a different solution." My intention was to replace
[3] with [2], not keep both [2] and [3].

Now that we have switched to [2] for SOCFPGA's SPARE_AREA_SKIP_BYTES=2,
[3] should be removed. This should be OK because denali_pci.c just
gets back to the original behavior.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - New patch

Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index b6c463d02167..fafd0a0aa8e2 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -21,7 +21,6 @@
 #include "denali.h"
 
 #define DENALI_NAND_NAME    "denali-nand"
-#define DENALI_DEFAULT_OOB_SKIP_BYTES	8
 
 /* for Indexed Addressing */
 #define DENALI_INDEXED_CTRL	0x00
@@ -1302,22 +1301,16 @@ int denali_init(struct denali_controller *denali)
 
 	/*
 	 * Set how many bytes should be skipped before writing data in OOB.
-	 * If a non-zero value has already been configured, update it in HW.
-	 * If a non-zero value has already been set (by firmware or something),
-	 * just use it. Otherwise, set the driver's default.
+	 * If a platform requests a non-zero value, set it to the register.
+	 * Otherwise, read the value out, expecting it has already been set up
+	 * by firmware.
 	 */
-	if (denali->oob_skip_bytes) {
+	if (denali->oob_skip_bytes)
 		iowrite32(denali->oob_skip_bytes,
 			  denali->reg + SPARE_AREA_SKIP_BYTES);
-	} else {
-		denali->oob_skip_bytes =
-			ioread32(denali->reg + SPARE_AREA_SKIP_BYTES);
-		if (!denali->oob_skip_bytes) {
-			denali->oob_skip_bytes = DENALI_DEFAULT_OOB_SKIP_BYTES;
-			iowrite32(denali->oob_skip_bytes,
-				  denali->reg + SPARE_AREA_SKIP_BYTES);
-		}
-	}
+	else
+		denali->oob_skip_bytes = ioread32(denali->reg +
+						  SPARE_AREA_SKIP_BYTES);
 
 	iowrite32(0, denali->reg + TRANSFER_SPARE_REG);
 	iowrite32(GENMASK(denali->nbanks - 1, 0), denali->reg + RB_PIN_ENABLED);
-- 
2.17.1

