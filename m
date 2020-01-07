Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D55C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AF9206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="lyFRI24B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgAGWX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:23:26 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34355 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgAGWX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:23:26 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 400AD23E27;
        Tue,  7 Jan 2020 23:23:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578435804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tE4QVR46KKaoNeLKOHECIwkbvBJ+HBwW4P7gMA56dvk=;
        b=lyFRI24BQZ7EQqj7nutS7jJVGnHR/CzRgAkauIvl5c9+Hn4aajMQ5ueaWiSndyczOIxz68
        jmV6rke0EDhEMAQSqh/Zv5Js07X0epKUF4wTL+1UNPujF4wi2GoRCVnpLVBx5UtUzh9LJe
        munAMO3WkZX1MMfWi+H4ec3Ul/BKC3M=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] mtd: spi-nor: fix spi_nor_lock_and_prep() usage
Date:   Tue,  7 Jan 2020 23:23:16 +0100
Message-Id: <20200107222317.3527-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 400AD23E27
X-Spamd-Result: default: False [4.90 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.108];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         FREEMAIL_CC(0.00)[microchip.com,bootlin.com,nod.at,ti.com,gmail.com,walle.cc]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lock_and_prep() and unlock_and_unprep() are asymmetrical. The second
argument should be the same and represents the operation. This was
correct before commit 8cc7f33aadc8 ("mtd: spi-nor: factor out
replace-able flash_{lock,unlock}").

Fixes: 8cc7f33aadc8 ("mtd: spi-nor: factor out replace-able flash_{lock,unlock}")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b381bc0f825e..5cc4c0b331b3 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2047,7 +2047,7 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 
 	ret = nor->params.locking_ops->lock(nor, ofs, len);
 
-	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK);
+	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
 	return ret;
 }
 
@@ -2062,7 +2062,7 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 
 	ret = nor->params.locking_ops->unlock(nor, ofs, len);
 
-	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
+	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK);
 	return ret;
 }
 
-- 
2.20.1

