Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9FC2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfKTO0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:26:22 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:41410 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfKTO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:26:20 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id UESJ2100w5USYZQ06ESJDP; Wed, 20 Nov 2019 15:26:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXQvy-0001ua-PW; Wed, 20 Nov 2019 15:26:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXQvy-0007bb-Ob; Wed, 20 Nov 2019 15:26:18 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] reset: Align logic and flow in managed helpers
Date:   Wed, 20 Nov 2019 15:26:14 +0100
Message-Id: <20191120142614.29180-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120142614.29180-1-geert+renesas@glider.be>
References: <20191120142614.29180-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__devm_reset_control_get() and devm_reset_control_array_get() are very
similar, but they do not look similar, due to inverted logic.
Make them more similar, following the "bail out early" paradigm.

Adjust the logic and flow in devm_reset_controller_register() to match
the two other functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/reset/core.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 4ea62aa00260f82c..763f1353d386519b 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -150,13 +150,14 @@ int devm_reset_controller_register(struct device *dev,
 		return -ENOMEM;
 
 	ret = reset_controller_register(rcdev);
-	if (!ret) {
-		*rcdevp = rcdev;
-		devres_add(dev, rcdevp);
-	} else {
+	if (ret) {
 		devres_free(rcdevp);
+		return ret;
 	}
 
+	*rcdevp = rcdev;
+	devres_add(dev, rcdevp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(devm_reset_controller_register);
@@ -787,13 +788,14 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	rstc = __reset_control_get(dev, id, index, shared, optional, acquired);
-	if (rstc && !IS_ERR(rstc)) {
-		*ptr = rstc;
-		devres_add(dev, ptr);
-	} else {
+	if (!rstc || IS_ERR(rstc)) {
 		devres_free(ptr);
+		return rstc;
 	}
 
+	*ptr = rstc;
+	devres_add(dev, ptr);
+
 	return rstc;
 }
 EXPORT_SYMBOL_GPL(__devm_reset_control_get);
@@ -919,22 +921,21 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
 struct reset_control *
 devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
 {
-	struct reset_control **devres;
-	struct reset_control *rstc;
+	struct reset_control **ptr, *rstc;
 
-	devres = devres_alloc(devm_reset_control_release, sizeof(*devres),
-			      GFP_KERNEL);
-	if (!devres)
+	ptr = devres_alloc(devm_reset_control_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
 	rstc = of_reset_control_array_get(dev->of_node, shared, optional, true);
 	if (!rstc || IS_ERR(rstc)) {
-		devres_free(devres);
+		devres_free(ptr);
 		return rstc;
 	}
 
-	*devres = rstc;
-	devres_add(dev, devres);
+	*ptr = rstc;
+	devres_add(dev, ptr);
 
 	return rstc;
 }
-- 
2.17.1

