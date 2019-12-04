Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EF0C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45F620661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKV0DDwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfLDLtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:49:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35258 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfLDLth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:49:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so3285268pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 03:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJkvrnioSQap6ACieU6t8hJuY1ERTNT5B9HRX4oZ5DE=;
        b=VKV0DDwA/UzwDe7ouqeMhP9fYYctO5hgh7o9QMjvs/Ssapc+8aNRHaeQy8TMafGqjE
         cudMP5KNmfp/Q7BbYhqxbjJZxkcUMMqOQGu7Kf6MmaDrHciOOEMD5rkmXq0V0mieKUB7
         vobaaYp/haHhEj3X9s2bQaZXpzqm8Vqdb0VuHW61n+iySzQSdjYC3WKyZYyXXQZO2n9k
         T1nkEc6bPJG8vqSU3cl06ZW4s7RCIKNo5jHDu1g9dAjTJGR+/dyisnsZfyg7boSln5SM
         Ud5OQXKf/T2fYjEdnJK07GWXLt6aFzkNnEVkmAlaWDWgLUXOnhSfY02lenQYZ6nIWGJh
         FLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJkvrnioSQap6ACieU6t8hJuY1ERTNT5B9HRX4oZ5DE=;
        b=smLAtl4MGiAuhp380+gz35CjsgKy0dOnCsQbYuA2mPriU8F5Hu0CR8BHg72vcdyves
         jL9T16HLkwQKPSR2Dh6dM+uaWLAzQJ3kBJ/7RJ2a50fMIueV/3IHSOAGd/TvMoRWla2K
         7UwAXhb4mdVqceONfqjfo9uEBrFkgQ/jUkuRyDYN8E1JJeP9/Y4Ag3HT/cga5nof04s+
         V9sswiVJCAvAC/oWQFbZgcZ7//cJnwEMY5l1F3TSAnrkknKWrFWV3RUE/WAdErdVAYil
         7M1VoknA6/tKBYvLJgA7Syw+/fgSMad1r3cojVUk+gLuCUJ+N/6lGKpMZwi7f0RnP24C
         yaRw==
X-Gm-Message-State: APjAAAVliJulg+cY0uA2wr6QsgNYhaFRgTL9ygZ2F9Mer4628IUDqxl1
        /+hmUhBqR0IxDJDp1qWKpbI=
X-Google-Smtp-Source: APXvYqyLhSz9F0rui+DKkP6V9S1kGOeSHHbTAfuIz1zIxELZAQED8o42WBkM5hvs4Nzg9G/5sbc+3w==
X-Received: by 2002:aa7:8753:: with SMTP id g19mr3132142pfo.40.1575460176532;
        Wed, 04 Dec 2019 03:49:36 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id u26sm7374170pfn.46.2019.12.04.03.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 03:49:35 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] phy: ti-pipe3: make clk operations symmetric in probe and remove
Date:   Wed,  4 Dec 2019 19:47:59 +0800
Message-Id: <20191204114759.3754-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver calls clk_prepare_enable in probe but the corresponding
clk_disable_unprepare() is in ti_pipe3_disable_clocks().
Move clk_disable_unprepare() to remove to make them symmetric.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Modify commit message.
  - Delete the clk_disable_unprepare() in ti_pipe3_disable_clocks().

 drivers/phy/ti/phy-ti-pipe3.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index edd6859afba8..a87946589eb7 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -850,6 +850,12 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 
 static int ti_pipe3_remove(struct platform_device *pdev)
 {
+	struct ti_pipe3 *phy = platform_get_drvdata(pdev);
+
+	if (phy->mode == PIPE3_MODE_SATA) {
+		clk_disable_unprepare(phy->refclk);
+		phy->sata_refclk_enabled = false;
+	}
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
@@ -900,18 +906,8 @@ static void ti_pipe3_disable_clocks(struct ti_pipe3 *phy)
 {
 	if (!IS_ERR(phy->wkupclk))
 		clk_disable_unprepare(phy->wkupclk);
-	if (!IS_ERR(phy->refclk)) {
+	if (!IS_ERR(phy->refclk))
 		clk_disable_unprepare(phy->refclk);
-		/*
-		 * SATA refclk needs an additional disable as we left it
-		 * on in probe to avoid Errata i783
-		 */
-		if (phy->sata_refclk_enabled) {
-			clk_disable_unprepare(phy->refclk);
-			phy->sata_refclk_enabled = false;
-		}
-	}
-
 	if (!IS_ERR(phy->div_clk))
 		clk_disable_unprepare(phy->div_clk);
 }
-- 
2.24.0

