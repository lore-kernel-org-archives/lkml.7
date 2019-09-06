Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA316C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A38321835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404745AbfIFMtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:49:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42302 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404473AbfIFMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:49:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6DgO-0005cj-Gt; Fri, 06 Sep 2019 12:49:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: xgene: make array serdes_reg static const, makes object smaller
Date:   Fri,  6 Sep 2019 13:49:44 +0100
Message-Id: <20190906124944.1574-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array serdes_reg on the stack but instead make it
static const. Makes the object code smaller by 228 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  23875	   6232	     64	  30171	   75db	drivers/phy/phy-xgene.o

After:
   text	   data	    bss	    dec	    hex	filename
  23551	   6328	     64	  29943	   74f7	drivers/phy/phy-xgene.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/phy/phy-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-xgene.c b/drivers/phy/phy-xgene.c
index 3c9189473407..7a33ec12f71b 100644
--- a/drivers/phy/phy-xgene.c
+++ b/drivers/phy/phy-xgene.c
@@ -1342,7 +1342,7 @@ static int xgene_phy_hw_initialize(struct xgene_phy_ctx *ctx,
 static void xgene_phy_force_lat_summer_cal(struct xgene_phy_ctx *ctx, int lane)
 {
 	int i;
-	struct {
+	static const struct {
 		u32 reg;
 		u32 val;
 	} serdes_reg[] = {
-- 
2.20.1

