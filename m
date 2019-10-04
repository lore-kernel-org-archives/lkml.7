Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E308C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C21222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201669;
	bh=/KV5I5DAghrskNH9QDWgNaeNLl+MrlIiwz5apfW4Vrg=;
	h=From:To:Subject:Date:List-ID:From;
	b=XLwkqMqHeztKvw4ndRT0U53GjBMClTMFLQKPDFn4WqxdZ3+Kl1o6WsNStqfv0gDDr
	 Fuf1GV8LZ1+cygJ/EM3B7sJzpnDp974rdTPc5O24Pj3wdndDocd3D74E0QkhM1eovS
	 pSF8pj/wxmj9TVcwHXzldFrt0pPAB+jq1fgKonWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbfJDPHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:07:46 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB92207FF;
        Fri,  4 Oct 2019 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201666;
        bh=/KV5I5DAghrskNH9QDWgNaeNLl+MrlIiwz5apfW4Vrg=;
        h=From:To:Subject:Date:From;
        b=OGWg8NtvNyerybT+VfuS22mipc6Oq+DcD1Z8b/NRsfgNtU+fi5fFNWhlzLyLr4abK
         zcEUcMR0ODI6gine4L3mMTJiPnQlvO9Tb7aumA5IrUBoDCICHdx7W3waD0UV0sTKr6
         I44zsBDOCS3Ya+4oGQmhNliofFEwAkYvvR2GW4sY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 1/3] power: supply: ab8500: Cleanup probe in reverse order
Date:   Fri,  4 Oct 2019 17:07:36 +0200
Message-Id: <20191004150738.6542-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is logical to cleanup in probe's error path in reverse order to
previous actions.  It also makes easier to add additional goto labels
within this error path.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not marking as cc-stable as this was not reproduced and not tested.
---
 drivers/power/supply/ab8500_btemp.c | 4 ++--
 drivers/power/supply/ab8500_fg.c    | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 8fe81259bfd9..a167938e32f2 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -1104,13 +1104,13 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	return ret;
 
 free_irq:
-	power_supply_unregister(di->btemp_psy);
-
 	/* We also have to free all successfully registered irqs */
 	for (i = i - 1; i >= 0; i--) {
 		irq = platform_get_irq_byname(pdev, ab8500_btemp_irq[i].name);
 		free_irq(irq, di);
 	}
+
+	power_supply_unregister(di->btemp_psy);
 free_btemp_wq:
 	destroy_workqueue(di->btemp_wq);
 	return ret;
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 6fc4bc30644c..36bbb8ea05da 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3212,15 +3212,15 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	return ret;
 
 free_irq:
-	power_supply_unregister(di->fg_psy);
-
 	/* We also have to free all registered irqs */
+	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
+	free_irq(irq, di);
 	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq_th); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
 		free_irq(irq, di);
 	}
-	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
-	free_irq(irq, di);
+
+	power_supply_unregister(di->fg_psy);
 free_inst_curr_wq:
 	destroy_workqueue(di->fg_wq);
 	return ret;
-- 
2.17.1

