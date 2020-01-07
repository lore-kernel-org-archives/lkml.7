Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29697C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA90206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Bj4iEpxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgAGWX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:23:27 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:37555 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGWX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:23:26 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B6FBF23E29;
        Tue,  7 Jan 2020 23:23:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578435804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycC4l96HeCSX2Wgr4BM6xzAWC3OL6kgNnAF7SFpEJxI=;
        b=Bj4iEpxiffWzIm18jzTYuSKjpQYic1qaWT4ZnYIMM0Gau4xn8wCSzOEhW+puQza17FqiDI
        r/u/sbOYgjmX6cWNOH4nEez0f+uTK6pr0NsWNIFe7vS3QfteBHMtRZrByVyZ13Cno6x3D6
        VjKlplRBoOoDEQKENZO56y9+zBFijiE=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] mtd: spi-nor: fix locking argument in spi_nor_is_locked()
Date:   Tue,  7 Jan 2020 23:23:17 +0100
Message-Id: <20200107222317.3527-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107222317.3527-1-michael@walle.cc>
References: <20200107222317.3527-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: B6FBF23E29
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
         NEURAL_HAM(-0.00)[-0.120];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         FREEMAIL_CC(0.00)[microchip.com,bootlin.com,nod.at,ti.com,gmail.com,walle.cc]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second argument represents the operation which takes the lock. Add a
new SPI_NOR_OPS_IS_LOCKED and use it.

Fixes: 5bf0e69b67a5 ("mtd: spi-nor: add mtd_is_locked() support")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 ++--
 include/linux/mtd/spi-nor.h   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5cc4c0b331b3..d422aead9f36 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2071,13 +2071,13 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
 
-	ret = spi_nor_lock_and_prep(nor, SPI_NOR_OPS_UNLOCK);
+	ret = spi_nor_lock_and_prep(nor, SPI_NOR_OPS_IS_LOCKED);
 	if (ret)
 		return ret;
 
 	ret = nor->params.locking_ops->is_locked(nor, ofs, len);
 
-	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
+	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_IS_LOCKED);
 	return ret;
 }
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b661fd948a25..a8fcb1d70510 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -235,6 +235,7 @@ enum spi_nor_ops {
 	SPI_NOR_OPS_ERASE,
 	SPI_NOR_OPS_LOCK,
 	SPI_NOR_OPS_UNLOCK,
+	SPI_NOR_OPS_IS_LOCKED,
 };
 
 enum spi_nor_option_flags {
-- 
2.20.1

