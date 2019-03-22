Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B58C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425D3218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258925;
	bh=e60w68A2cqVaZOQmFxd/9OUk2hFyV5gbOMjNrOZOSss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3cJ2Ec46lLLCtcX1pxuLZ1pAJqJzIjhX/OxJMd7SiyLIkbYtqSYSQzgNy4CWMQNP
	 gFXkc/2QSFMuGTdudsdK5lOU9q+IpB2qXhhaQVWqFQtgNtkxduoEcAQ1LTNnI1U4lR
	 kITQd+XXzlE2KCK+7KCKUL2m+Qv4BYuxdkS6gg3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfCVMsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387467AbfCVL5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C08FC2192B;
        Fri, 22 Mar 2019 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255851;
        bh=e60w68A2cqVaZOQmFxd/9OUk2hFyV5gbOMjNrOZOSss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fussj2nCj9JmtPsTfUqBLMiMX01m9tGdtfmAOuChYJMaAIpoulcbdAoJjQWvw83hH
         dNBXO8QpafFNdez450R/iaxH806Kh+tWdtHXorsAlI0KHBUgo9x6Rr6k6n65RHnQmO
         a3YnKGpcCjC+uguYu5N3HrldA/XOPC4OZcDztUQg=
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
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/280] ARM: dts: Configure clock parent for pwm vibra
Date:   Fri, 22 Mar 2019 12:13:07 +0100
Message-Id: <20190322111308.231367149@linuxfoundation.org>
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



