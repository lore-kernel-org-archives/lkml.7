Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE41C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7ED21774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfK1KZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:25:44 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:38743 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfK1KZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:25:43 -0500
Received: from localhost (lfbn-1-1480-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1D174240014;
        Thu, 28 Nov 2019 10:25:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] clk: at91: fix possible deadlock
Date:   Thu, 28 Nov 2019 11:25:31 +0100
Message-Id: <20191128102531.817549-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep warns about a possible circular locking dependency because using
syscon_node_to_regmap() will make the created regmap get and enable the
first clock it can parse from the device tree. This clock is not needed to
access the registers and should not be enabled at that time.

Use the recently introduced device_node_to_regmap to solve that as it looks
up the regmap in the same list but doesn't care about the clocks.

Reported-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/at91sam9260.c | 2 +-
 drivers/clk/at91/at91sam9rl.c  | 2 +-
 drivers/clk/at91/at91sam9x5.c  | 2 +-
 drivers/clk/at91/pmc.c         | 2 +-
 drivers/clk/at91/sama5d2.c     | 2 +-
 drivers/clk/at91/sama5d4.c     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 0aabe49aed09..a9d4234758d7 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -348,7 +348,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 0ac34cdaa106..77fe83a73bf4 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -83,7 +83,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 0855f3a80cc7..086cf0b4955c 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -146,7 +146,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 0b03cfae3a9d..b71515acdec1 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -275,7 +275,7 @@ static int __init pmc_register_ops(void)
 
 	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
 
-	pmcreg = syscon_node_to_regmap(np);
+	pmcreg = device_node_to_regmap(np);
 	if (IS_ERR(pmcreg))
 		return PTR_ERR(pmcreg);
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 0de1108737db..ff7e3f727082 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -162,7 +162,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 25b156d4e645..a6dee4a3b6e4 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -136,7 +136,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		return;
 	mainxtal_name = of_clk_get_parent_name(np, i);
 
-	regmap = syscon_node_to_regmap(np);
+	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
 
-- 
2.23.0

