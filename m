Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA55C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D353214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334169;
	bh=k5sfPXxMrxZ6suKAME+79KuKlZnZCw9jAM6Ilq7Vwdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSz10Z97cxH5v1fibm7KRMiJkYsrIc0jd3xx5NXsms4zVjtJPgSNxQ1zSoaDF+LSv
	 PfKtRohFbe55ATgRX/HsSGsAo6FCKVkhfYr08MrBc0paLwsScc4MNy7x1mljOJfGJz
	 xv/NxfXbDV9WHTH/omqwbZdNUuO0hFS4SR9ObKfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfCKT4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbfCKT4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 632882087C;
        Mon, 11 Mar 2019 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334163;
        bh=k5sfPXxMrxZ6suKAME+79KuKlZnZCw9jAM6Ilq7Vwdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqZMErpqLQR7TaHPXXyswQ7cUHxaM3wpZwX6qoTwrKxSEvd3goiP0uX9kd9apBsb6
         HATzoCztbuA+gTK0BsSEBZdFrHgR/Ddst3AsghEXzg8EwwmkCivhOUIhBjr6juKBnY
         Dq+Z9bmqcXLoTuNb8j8GhVKxLb+f+CotMYEq3lXc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 24/52] ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug
Date:   Mon, 11 Mar 2019 15:54:48 -0400
Message-Id: <20190311195516.137772-24-sashal@kernel.org>
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

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 50d6b3cf9403879911e06d69c7ef41e43f8f7b4b ]

If we have a kernel configured for periodic timer interrupts, and we
have cpuidle enabled, then we end up with CPU1 losing timer interupts
after a hotplug.

This can manifest itself in RCU stall warnings, or userspace becoming
unresponsive.

The problem is that the kernel initially wants to use the TWD timer
for interrupts, but the TWD loses context when we enter the C3 cpuidle
state.  Nothing reprograms the TWD after idle.

We have solved this in the past by switching to broadcast timer ticks,
and cpuidle44xx switches to that mode at boot time.  However, there is
nothing to switch from periodic mode local timers after a hotplug
operation.

We call tick_broadcast_enter() in omap_enter_idle_coupled(), which one
would expect would take care of the issue, but internally this only
deals with one-shot local timers - tick_broadcast_enable() on the other
hand only deals with periodic local timers.  So, we need to call both.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[tony@atomide.com: just standardized the subject line]
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index a8b291f00109..dae514c8276a 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -152,6 +152,10 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 	mpuss_can_lose_context = (cx->mpu_state == PWRDM_POWER_RET) &&
 				 (cx->mpu_logic_state == PWRDM_POWER_OFF);
 
+	/* Enter broadcast mode for periodic timers */
+	tick_broadcast_enable();
+
+	/* Enter broadcast mode for one-shot timers */
 	tick_broadcast_enter();
 
 	/*
@@ -218,15 +222,6 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 	return index;
 }
 
-/*
- * For each cpu, setup the broadcast timer because local timers
- * stops for the states above C1.
- */
-static void omap_setup_broadcast_timer(void *arg)
-{
-	tick_broadcast_enable();
-}
-
 static struct cpuidle_driver omap4_idle_driver = {
 	.name				= "omap4_idle",
 	.owner				= THIS_MODULE,
@@ -319,8 +314,5 @@ int __init omap4_idle_init(void)
 	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
-	/* Configure the broadcast timer on each cpu */
-	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
-
 	return cpuidle_register(idle_driver, cpu_online_mask);
 }
-- 
2.19.1

