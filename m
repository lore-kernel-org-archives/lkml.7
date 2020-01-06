Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8CFC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C81B20731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgAFUhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:37:04 -0500
Received: from muru.com ([72.249.23.125]:50330 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgAFUhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:37:04 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4790C80AA;
        Mon,  6 Jan 2020 20:37:44 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clocksource: timer-ti-dm: Fix regression
Date:   Mon,  6 Jan 2020 12:37:00 -0800
Message-Id: <20200106203700.21009-1-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean-up commit 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to
platform_get_irq") caused a regression where we now try to access
uninitialized data for timer:

drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may be used
uninitialized in this function [-Wmaybe-uninitialized]

On boot we now get:

Unable to handle kernel NULL pointer dereference at virtual address
00000004
...
(omap_dm_timer_probe) from [<c061ac7c>] (platform_drv_probe+0x48/0x98)
(platform_drv_probe) from [<c0618c04>] (really_probe+0x1dc/0x348)
(really_probe) from [<c0618ef4>] (driver_probe_device+0x5c/0x160)

Let's fix the issue by moving platform_get_irq to happen after timer has
been allocated.

Fixes: 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to platform_get_irq")
Cc: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

I did not notice simlar issue with other patches in the series, but
please do double check Yangtao.

---
 drivers/clocksource/timer-ti-dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -795,14 +795,14 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	timer->irq = platform_get_irq(pdev, 0);
-	if (timer->irq < 0)
-		return timer->irq;
-
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
 		return  -ENOMEM;
 
+	timer->irq = platform_get_irq(pdev, 0);
+	if (timer->irq < 0)
+		return timer->irq;
+
 	timer->fclk = ERR_PTR(-ENODEV);
 	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
-- 
2.24.1
