Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FF7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E772195D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255898;
	bh=7VieeIoHCGgo+vw6Zaam26iIruZvmZVmE+n5jqxPOOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JkRbXum5N0PEKAUVxx+Fk6kI9DcLqm8vdO9FX698ufi320KWVvafbKJTgWl/QphFE
	 CJsFlFfF6w73HHwbM2mRhiBtr9gesK6U1e6aToEZP+yDGA1/xKuMr4If3QjrPURCxr
	 lzNOxFge6xF+eJTO5A+jQi2NHxzTtVe/f9v6KZDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbfCVL6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387779AbfCVL6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC7521939;
        Fri, 22 Mar 2019 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255891;
        bh=7VieeIoHCGgo+vw6Zaam26iIruZvmZVmE+n5jqxPOOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uBJqwTPOQ0+MEpYVYhap9N9tyDiM0Xqo9cXzbhlecqJks4HhGyCszZRqGJheyux38
         fhWAPKOxuAfYWXlRIpw+vbaTSFi1Qz+0qAwDhZCLKqMkHRulTj3pkrJTc42EQFMt/Y
         6PXFpG2QqBKBzo+Ot5zlluWuzGNTxcMad2CaK9aI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/280] clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
Date:   Fri, 22 Mar 2019 12:13:01 +0100
Message-Id: <20190322111307.876230024@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



