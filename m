Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483A3C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2295F2756A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396143;
	bh=7x9X0MqwwzWfesoWnCO+5JinLuR6ZOlSQF2Kuwvlibw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V2CwN/tnEOKGr754Y9ujAu26wZolPFQj7aJBNJHF6pumRZUczDnVJC6uwQZ5P8vGg
	 KA6hf0nuubMsRK9xAbAYfEkQP2ShIzymhLGuZVpHYfLuz0Rdx5XqrUINGXwXTfazCh
	 oDrZYG6mqH+lIpdtbC/lRttawGFukL5hohlDn4Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfFANXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbfFANXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:23:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D8027358;
        Sat,  1 Jun 2019 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395391;
        bh=7x9X0MqwwzWfesoWnCO+5JinLuR6ZOlSQF2Kuwvlibw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTddXRmjqia918mU73RrkwHYeb5ud6Wz38giCyjlP6zznbLJqwNyPpMTP441UnzMy
         fZhuo53CCxxo1aGs0M+iQuhGP8WQXEhK5rzCgk0y+if4dEcSgjiyAaNLZFBVDsztxT
         hNSI6U0uXJBhonie9GKhCUHtusrdQuqBXVoTEY1g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 032/141] mailbox: stm32-ipcc: check invalid irq
Date:   Sat,  1 Jun 2019 09:20:08 -0400
Message-Id: <20190601132158.25821-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

[ Upstream commit 68a1c8485cf83734d4da9d81cd3b5d2ae7c0339b ]

On failure of_irq_get() returns a negative value or zero, which is
not handled as an error in the existing implementation.
Instead of using this API, use platform_get_irq() that returns
exclusively a negative value on failure.
Also, do not output an error log in case of defer probe error.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/stm32-ipcc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 533b0da5235d4..ca1f993c0de30 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -8,9 +8,9 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
 
@@ -240,9 +240,11 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 
 	/* irq */
 	for (i = 0; i < IPCC_IRQ_NUM; i++) {
-		ipcc->irqs[i] = of_irq_get_byname(dev->of_node, irq_name[i]);
+		ipcc->irqs[i] = platform_get_irq_byname(pdev, irq_name[i]);
 		if (ipcc->irqs[i] < 0) {
-			dev_err(dev, "no IRQ specified %s\n", irq_name[i]);
+			if (ipcc->irqs[i] != -EPROBE_DEFER)
+				dev_err(dev, "no IRQ specified %s\n",
+					irq_name[i]);
 			ret = ipcc->irqs[i];
 			goto err_clk;
 		}
@@ -263,9 +265,10 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 
 	/* wakeup */
 	if (of_property_read_bool(np, "wakeup-source")) {
-		ipcc->wkp = of_irq_get_byname(dev->of_node, "wakeup");
+		ipcc->wkp = platform_get_irq_byname(pdev, "wakeup");
 		if (ipcc->wkp < 0) {
-			dev_err(dev, "could not get wakeup IRQ\n");
+			if (ipcc->wkp != -EPROBE_DEFER)
+				dev_err(dev, "could not get wakeup IRQ\n");
 			ret = ipcc->wkp;
 			goto err_clk;
 		}
-- 
2.20.1

