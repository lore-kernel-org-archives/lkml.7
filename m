Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1EB2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334903;
	bh=70o5BDnU03plRCSx+rUhMvBJ7H5/zLM1AoW/K+pse5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zW7Fk0IjK8TCiwhLYxBXG20BxG9dhcCLcJ/szLGKiFPIvNxZE+qPGNqvozNrkyERJ
	 QaKpnZ9aMkZJVSb1+yVLiN/u19tKWdMUn7sG3aLC+0kW69FHaQ7V6E8gm2tOqTX+w/
	 vleKecHptXWz4xkZ1xrr5qq3Kb2zx8hLosDp+K5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfCKUIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbfCKT5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF866214AF;
        Mon, 11 Mar 2019 19:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334228;
        bh=70o5BDnU03plRCSx+rUhMvBJ7H5/zLM1AoW/K+pse5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ymLsQP3RdhY6ZjmKE0WIzvFr8+2PyC2v0S4DzX+RjRsTunftSVQETnYTCc5c93W+5
         57D8eI5Lz+1QBgQp+/w4/2B6BDwGtgsXVzioYG9HxdaM6UDNriVARWbcvHhfLEt6FF
         8pBj6KIYYNLHrs0/AnjYVJpr1+L6AG0qRyt+O2yk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 06/44] clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
Date:   Mon, 11 Mar 2019 15:56:22 -0400
Message-Id: <20190311195700.138462-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 983a5a43ec254cd5ddf3254db80ca96e8f8bb2a4 ]

Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc") moved some omap4 timers to probe with ti-sysc
interconnect target module. Turns out this broke pwm-omap-dmtimer
where we now try to reparent the clock to itself with the following:

omap_dm_timer_of_set_source: failed to set parent

With ti-sysc, we can now configure the clock sources in the dts
with assigned-clocks and assigned-clock-parents. So we should be able
to remove omap_dm_timer_of_set_source with clean-up patches later on.
But for now, let's just fix it first by checking if parent and fck
are the same and bail out of so.

Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe them with ti-sysc")
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Tested-By: Andreas Kemnade <andreas@kemnade.info>
Tested-By: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-ti-dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4cce6b224b87..3ecf84706640 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -154,6 +154,10 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
 	if (IS_ERR(parent))
 		return -ENODEV;
 
+	/* Bail out if both clocks point to fck */
+	if (clk_is_match(parent, timer->fclk))
+		return 0;
+
 	ret = clk_set_parent(timer->fclk, parent);
 	if (ret < 0)
 		pr_err("%s: failed to set parent\n", __func__);
-- 
2.19.1

