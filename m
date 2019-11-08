Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48BEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCE921D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfKHPz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:55:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42251 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:55:29 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iT6bd-0003xV-0u; Fri, 08 Nov 2019 15:55:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] reset: npcm: check for NULL return from syscon_regmap_lookup_by_compat
Date:   Fri,  8 Nov 2019 15:55:24 +0000
Message-Id: <20191108155524.170566-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Function syscon_regmap_lookup_by_compat can return a NULL pointer, so
the IS_ERR check on the return is incorrect. Fix this by checking for
IS_ERR_OR_NULL and return -ENODEV if true.  This avoids a null pointer
dereference on gcr_regmap later on.

Addresses-Coverity: ("Dereference null return (stat)")
Fixes: b3f1d036f26d ("reset: npcm: add NPCM reset controller driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/reset/reset-npcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 2ea4d3136e15..9febf8bed2f6 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -161,9 +161,9 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 	of_match_device(dev->driver->of_match_table, dev)->data;
 
 	gcr_regmap = syscon_regmap_lookup_by_compatible(gcr_dt);
-	if (IS_ERR(gcr_regmap)) {
+	if (IS_ERR_OR_NULL(gcr_regmap)) {
 		dev_err(&pdev->dev, "Failed to find %s\n", gcr_dt);
-		return PTR_ERR(gcr_regmap);
+		return -ENODEV;
 	}
 
 	/* checking which USB device is enabled */
-- 
2.20.1

