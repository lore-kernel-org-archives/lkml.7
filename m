Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6E4C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D7F222F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qA6B8TEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfGVF5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:57:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46254 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfGVF5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:57:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so39511398edr.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 22:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=kwPXLWN6H/COBfq884oPFZycA/+QGtJcjDeTrXDDWXs=;
        b=qA6B8TEQd3lxAieBE5VShYd/sB2OekDZ7Wip64ey/4vmgfB2ZuTx5Ap++zZxQw2Bn2
         VnNdRK4E+Zl2U/nHs8h5fpJY7tlpaTP18X0yd/07GmFPqNW+JVuJJMDFcP9HspjEyNvc
         RpRpCL5sBViuPKHNPlChq6q5JBX3bpP9rqMaI0ypkwS4Pd1EtwU1CpAziFbkdwUG4LUK
         0EiMpQhWAJAqEWrjvSa+awIR5dWOr+cdHvzSNaaCy66Kpj1ZXhq2lIcORgD8Ym8d+rZZ
         6KPPC5qtiHV/EVhfWHBHAbfw6Mak4n6ZPBpI33URJsy2odYg4TlMSalo3jTmFMpORmwi
         CCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=kwPXLWN6H/COBfq884oPFZycA/+QGtJcjDeTrXDDWXs=;
        b=NE49jyCALVgOIX/vgK9DITyoJmRsVDEypJ2yHxbnJ7aWJLPxZLzsBF9gUswrIpO+i5
         7JUdLP+8FF3KgApHUIgF1KwHDRUiKMOQJY8+c2a2i2n898IETaNsJqoyLRVP9femAmNd
         ojdOZRK2W4uVG1G43jiVaoogiYQMgt4tz6HHcb6kCD9WToOsh97f2BvMse/jgI7GW5dJ
         o0Pa9KgQpuvg+bj69ka3/zS5oaci+FfRmIe9IvIO/dk9I/ftJQqrgFWFmIBwjO1HzE+o
         YNc8JA9SZESMuoUQBMjjgPzApvmkwuS/efTPuuOjAqY789n3GAccy8d/pQp3o4hsyZom
         Wq5w==
X-Gm-Message-State: APjAAAWAP98jG1MMfrqUZJZUqc8JYuzua14vTtLaJQLFBNw+hdcEifQi
        ZzwQSKh9xViy0Oy7OJBYp5g=
X-Google-Smtp-Source: APXvYqwCtu9XPj5RwCf+z9IbEvNwKl31zZN+U2AKja8o8344MGFPPgPlXldvB082TO9Ayxm07z1GJQ==
X-Received: by 2002:a17:906:4bcb:: with SMTP id x11mr51998939ejv.1.1563775029720;
        Sun, 21 Jul 2019 22:57:09 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id a6sm10351725eds.19.2019.07.21.22.57.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 22:57:09 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [PATCH 5/8] mtd: spinand: micron: prepare for generalizing driver
Date:   Mon, 22 Jul 2019 07:56:18 +0200
Message-Id: <20190722055621.23526-6-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722055621.23526-1-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Generalize OOB layout structure and function names.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 7d7b1f7fcf71..95bc5264ebc1 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -34,38 +34,38 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-static int mt29f2g01abagd_ooblayout_ecc(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
+static int micron_ooblayout_ecc(struct mtd_info *mtd, int section,
+				struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
 
-	region->offset = 64;
-	region->length = 64;
+	region->offset = mtd->oobsize / 2;
+	region->length = mtd->oobsize / 2;
 
 	return 0;
 }
 
-static int mt29f2g01abagd_ooblayout_free(struct mtd_info *mtd, int section,
-					 struct mtd_oob_region *region)
+static int micron_ooblayout_free(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *region)
 {
 	if (section)
 		return -ERANGE;
 
 	/* Reserve 2 bytes for the BBM. */
 	region->offset = 2;
-	region->length = 62;
+	region->length = (mtd->oobsize / 2) - 2;
 
 	return 0;
 }
 
-static const struct mtd_ooblayout_ops mt29f2g01abagd_ooblayout = {
-	.ecc = mt29f2g01abagd_ooblayout_ecc,
-	.free = mt29f2g01abagd_ooblayout_free,
+static const struct mtd_ooblayout_ops micron_ooblayout_ops = {
+	.ecc = micron_ooblayout_ecc,
+	.free = micron_ooblayout_free,
 };
 
-static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
-					 u8 status)
+static int micron_ecc_get_status(struct spinand_device *spinand,
+				 u8 status)
 {
 	switch (status & MICRON_STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -98,8 +98,8 @@ static const struct spinand_info micron_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
-				     mt29f2g01abagd_ecc_get_status)),
+		     SPINAND_ECCINFO(&micron_ooblayout_ops,
+				     micron_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

