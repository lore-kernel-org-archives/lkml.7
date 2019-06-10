Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E68DC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA5220820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NHJP3aYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbfFJRMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:12:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58034 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388341AbfFJRMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:12:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5AHCQUD110035;
        Mon, 10 Jun 2019 12:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560186746;
        bh=Ew1K6dc7XJ3Lz8pVJ6FwwRkOUCloXwI4ODLhOfwKs2A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NHJP3aYQ5nFeClYJ+sqWP4MdxtcIfaH7GesHywLvY6k7YAh1v0O80jXr+NlmoGmo2
         JhpvOw4f5Uk3hAVUMpt9s8bgdgo1NSTyRWyhh6nTdrbVkEocaCHbZh36ozSUIXZLPG
         PNlZl1J3aoexuCJAMSvQ4ECvh/lvlR7wGJ9ZEeHw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5AHCPxK011206
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jun 2019 12:12:25 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 10
 Jun 2019 12:12:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 10 Jun 2019 12:12:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5AHCOJR051660;
        Mon, 10 Jun 2019 12:12:25 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Russell King <rmk@arm.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 11/20] gpio: gpio-omap: simplify bank->level_mask
Date:   Mon, 10 Jun 2019 20:10:54 +0300
Message-ID: <20190610171103.30903-12-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610171103.30903-1-grygorii.strashko@ti.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

bank->level_mask is merely the bitwise or of the level detection
context which we have already read in this function.  Rather than
repeating additional reads, compute it from the values already
read.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8fdac6e4a929..369ce46e2b09 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -325,6 +325,9 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 	bank->context.fallingdetect =
 			readl_relaxed(bank->base + bank->regs->fallingdetect);
 
+	bank->level_mask = bank->context.leveldetect0 |
+			   bank->context.leveldetect1;
+
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
 		omap_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
 		bank->context.wake_en =
@@ -344,10 +347,6 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 		else
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
 	}
-
-	bank->level_mask =
-		readl_relaxed(bank->base + bank->regs->leveldetect0) |
-		readl_relaxed(bank->base + bank->regs->leveldetect1);
 }
 
 #ifdef CONFIG_ARCH_OMAP1
-- 
2.17.1

