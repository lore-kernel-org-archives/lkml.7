Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16488C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D041020693
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100817;
	bh=3dLa8NimBsKucGoDE8GB6eGxCqZMLfx7ATcmD0+iWdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mWcv+Qno60iJkuQT9Ij/jhfBihf6q6phyKhnIHogVxyRbwev44YHFedeewZgD4oY8
	 bflJ+edVkG0DDCSTDJfahKTOwe68AfunCxn51pgouv9Xp32GaHr++U/zB5TNqufIM8
	 fvP4uvX9+tyBBTkEC3jmtGTLr+dZcgYm/Ge/RpR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfFIRUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbfFIQrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:47:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAD7205ED;
        Sun,  9 Jun 2019 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098864;
        bh=3dLa8NimBsKucGoDE8GB6eGxCqZMLfx7ATcmD0+iWdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOmZgAON47Z7H5WW3AUUFt2VzostV4vwT8HiJnwEOjVhZGmylkCUi6rI19z47ots+
         ycOmE3kDQ5qLAiEg29VepsRg5xR+mUDEnm2yJ5MveU5dQ9WbXJZy37Un4mMjZ+WdFw
         ooDb9QMf3sJcAHa9D44cBGyw4gQ6ekn36iOk3RwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Emil Lenngren <emil.lenngren@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH 4.19 17/51] mtd: spinand: macronix: Fix ECC Status Read
Date:   Sun,  9 Jun 2019 18:41:58 +0200
Message-Id: <20190609164128.063229742@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Lenngren <emil.lenngren@gmail.com>

commit f4cb4d7b46f6409382fd981eec9556e1f3c1dc5d upstream.

The datasheet specifies the upper four bits are reserved.
Testing on real hardware shows that these bits can indeed be nonzero.

Signed-off-by: Emil Lenngren <emil.lenngren@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/spi/macronix.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -10,6 +10,7 @@
 #include <linux/mtd/spinand.h>
 
 #define SPINAND_MFR_MACRONIX		0xC2
+#define MACRONIX_ECCSR_MASK		0x0F
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -55,7 +56,12 @@ static int mx35lf1ge4ab_get_eccsr(struct
 					  SPI_MEM_OP_DUMMY(1, 1),
 					  SPI_MEM_OP_DATA_IN(1, eccsr, 1));
 
-	return spi_mem_exec_op(spinand->spimem, &op);
+	int ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	*eccsr &= MACRONIX_ECCSR_MASK;
+	return 0;
 }
 
 static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,


