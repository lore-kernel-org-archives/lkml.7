Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827A5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6442220882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392857AbfITPjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:39:16 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34933 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391054AbfITPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:39:16 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AE20FFF811;
        Fri, 20 Sep 2019 15:39:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] clk: at91: avoid sleeping early
Date:   Fri, 20 Sep 2019 17:39:06 +0200
Message-Id: <20190920153906.20887-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not allowed to sleep to early in the boot process and this may lead
to kernel issues if the bootloader didn't prepare the slow clock and main
clock.

This results in the following error and dump stack on the AriettaG25:
   bad: scheduling from the idle thread!

Ensure it is possible to sleep, else simply have a delay.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Note that this was already discussed a while ago and Arnd said this approach was
reasonable:
  https://lore.kernel.org/lkml/6120818.MyeJZ74hYa@wuerfel/

 drivers/clk/at91/clk-main.c |  5 ++++-
 drivers/clk/at91/sckc.c     | 20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index f607ee702c83..ccd48e7a3d74 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -293,7 +293,10 @@ static int clk_main_probe_frequency(struct regmap *regmap)
 		regmap_read(regmap, AT91_CKGR_MCFR, &mcfr);
 		if (mcfr & AT91_PMC_MAINRDY)
 			return 0;
-		usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT);
+		if (system_state < SYSTEM_RUNNING)
+			udelay(MAINF_LOOP_MIN_WAIT);
+		else
+			usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT);
 	} while (time_before(prep_time, timeout));
 
 	return -ETIMEDOUT;
diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 9bfe9a28294a..fac0ca56d42d 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -76,7 +76,10 @@ static int clk_slow_osc_prepare(struct clk_hw *hw)
 
 	writel(tmp | osc->bits->cr_osc32en, sckcr);
 
-	usleep_range(osc->startup_usec, osc->startup_usec + 1);
+	if (system_state < SYSTEM_RUNNING)
+		udelay(osc->startup_usec);
+	else
+		usleep_range(osc->startup_usec, osc->startup_usec + 1);
 
 	return 0;
 }
@@ -187,7 +190,10 @@ static int clk_slow_rc_osc_prepare(struct clk_hw *hw)
 
 	writel(readl(sckcr) | osc->bits->cr_rcen, sckcr);
 
-	usleep_range(osc->startup_usec, osc->startup_usec + 1);
+	if (system_state < SYSTEM_RUNNING)
+		udelay(osc->startup_usec);
+	else
+		usleep_range(osc->startup_usec, osc->startup_usec + 1);
 
 	return 0;
 }
@@ -288,7 +294,10 @@ static int clk_sam9x5_slow_set_parent(struct clk_hw *hw, u8 index)
 
 	writel(tmp, sckcr);
 
-	usleep_range(SLOWCK_SW_TIME_USEC, SLOWCK_SW_TIME_USEC + 1);
+	if (system_state < SYSTEM_RUNNING)
+		udelay(SLOWCK_SW_TIME_USEC);
+	else
+		usleep_range(SLOWCK_SW_TIME_USEC, SLOWCK_SW_TIME_USEC + 1);
 
 	return 0;
 }
@@ -533,7 +542,10 @@ static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 		return 0;
 	}
 
-	usleep_range(osc->startup_usec, osc->startup_usec + 1);
+	if (system_state < SYSTEM_RUNNING)
+		udelay(osc->startup_usec);
+	else
+		usleep_range(osc->startup_usec, osc->startup_usec + 1);
 	osc->prepared = true;
 
 	return 0;
-- 
2.21.0

