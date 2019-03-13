Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E86AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DD72146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfCMQgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:36:22 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:42669 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:36:19 -0400
Received: from localhost (alyon-652-1-66-9.w109-213.abo.wanadoo.fr [109.213.209.9])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 9191620000E;
        Wed, 13 Mar 2019 16:36:12 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Christian Neubert <christian.neubert.86@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for cpu clocks
Date:   Wed, 13 Mar 2019 17:35:58 +0100
Message-Id: <20190313163558.6705-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock parenting was not setup properly when DVFS was enabled. It was
expected that the same clock source was used with and without DVFS which
was not the case.

This patch fixes this issue, allowing to make the cpufreq support work
when the CPU clocks source are not the default ones.

Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
Cc: <stable@vger.kernel.org>
Reported-by: Christian Neubert <christian.neubert.86@gmail.com>
Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 1f1cff428d78..26ed3c18a239 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -671,6 +671,17 @@ static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
 		map = syscon_regmap_lookup_by_compatible(
 				"marvell,armada-3700-nb-pm");
 		pmcpu_clk->nb_pm_base = map;
+
+		/*
+		 * Use the same parent when DVFS is enabled that the
+		 * default parent received at boot time. When this
+		 * function is called, DVFS is not enabled yet, so we
+		 * get the default parent and we can set the parent
+		 * for DVFS.
+		 */
+		if (clk_pm_cpu_set_parent(muxrate_hw,
+					  clk_pm_cpu_get_parent(muxrate_hw)))
+			dev_warn(dev, "Failed to setup default parent clock for DVFS\n");
 	}
 
 	*hw = clk_hw_register_composite(dev, data->name, data->parent_names,
-- 
2.20.1

