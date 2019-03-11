Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3346C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13D9217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334151;
	bh=R5OPx04TONxcgD5j44BsYo7XZLnqnY8hKVlQGhnD224=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0N48+UHJSL+ELotdKQ3HZkXeX4G/h8vRVoUM7ymgJ0gnaeGxX1CO9dAHt7N1G7uZ
	 XAjifeTwYuZmhdbWasS+nsXJASRt4Fx9DPeBCgRabft20/a3bmERhSZmpiWCNrazKJ
	 mnon9NKPI6LskTLDfsASYxA/vtRGoW4sjsVrRx58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfCKTzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbfCKTzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:55:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACDB6214AE;
        Mon, 11 Mar 2019 19:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334147;
        bh=R5OPx04TONxcgD5j44BsYo7XZLnqnY8hKVlQGhnD224=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpLt/YKXS204q1EPtYvmlUYhaxq6L1ZgWDGkGt3Zeac1OYWKkfbm68YdBypXp7TER
         1lYumoYz0iLfVYb+ruTlDhDgBXcJmo4zK2MF4d1dWpgvqFniOFmJkyenOfWEo4WImZ
         PppIZ4K6h2M2AmdQ9U4OWLnWW0ff3G9g0cDjq2yQ=
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
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 13/52] ARM: dts: Configure clock parent for pwm vibra
Date:   Mon, 11 Mar 2019 15:54:37 -0400
Message-Id: <20190311195516.137772-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 0840242e887586268f665bf58d5e1a7d6ebf35ed ]

Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc") moved some omap4 timers to probe with ti-sysc
interconnect target module. Turns out this broke pwm-omap-dmtimer
for reparenting of the timer clock.

With ti-sysc, we can now configure the clock sources in the dts with
assigned-clocks and assigned-clock-parents.

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
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 04758a2a87f0..67d77eee9433 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -644,6 +644,17 @@
 	};
 };
 
+/* Configure pwm clock source for timers 8 & 9 */
+&timer8 {
+	assigned-clocks = <&abe_clkctrl OMAP4_TIMER8_CLKCTRL 24>;
+	assigned-clock-parents = <&sys_clkin_ck>;
+};
+
+&timer9 {
+	assigned-clocks = <&l4_per_clkctrl OMAP4_TIMER9_CLKCTRL 24>;
+	assigned-clock-parents = <&sys_clkin_ck>;
+};
+
 /*
  * As uart1 is wired to mdm6600 with rts and cts, we can use the cts pin for
  * uart1 wakeirq.
-- 
2.19.1

