Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF2FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A3B20578
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405114AbfIFNGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:06:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42823 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbfIFNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:06:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6Dwe-0006wv-Lj; Fri, 06 Sep 2019 13:06:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Milo Kim <milo.kim@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: lp8788-ldo: make array en_mask static const, makes object smaller
Date:   Fri,  6 Sep 2019 14:06:32 +0100
Message-Id: <20190906130632.6709-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array en_mask on the stack but instead make it
static const. Makes the object code smaller by 87 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  12967	   3408	      0	  16375	   3ff7	drivers/regulator/lp8788-ldo.o

After:
   text	   data	    bss	    dec	    hex	filename
  12816	   3472	      0	  16288	   3fa0	drivers/regulator/lp8788-ldo.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/lp8788-ldo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index 1b00f3638996..00e9bb92c326 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -464,7 +464,7 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 {
 	struct lp8788 *lp = ldo->lp;
 	enum lp8788_ext_ldo_en_id enable_id;
-	u8 en_mask[] = {
+	static const u8 en_mask[] = {
 		[EN_ALDO1]   = LP8788_EN_SEL_ALDO1_M,
 		[EN_ALDO234] = LP8788_EN_SEL_ALDO234_M,
 		[EN_ALDO5]   = LP8788_EN_SEL_ALDO5_M,
-- 
2.20.1

