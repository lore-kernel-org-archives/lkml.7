Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C828C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B57A2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255955;
	bh=eAglDH3zbOiz0VrCJXk3IOo8oPEmogPYhzJ55yuMeOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UD5FDorDi9FFKQLbp/iuwlWGWruyf0tAZzTgnnXpdEZpMT+Inm/WGd8refVdS64Vh
	 9Rtq/5gngwFewaCZyUjJ1Qb0+OWrXGokg7tqtUvYbyA3NhWC766cQXxty/EAfu7N6m
	 byEn9bv4VA3ai2II/MqPkks595BUrD0bNl8uwAxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfCVL7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387910AbfCVL7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3322192C;
        Fri, 22 Mar 2019 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255944;
        bh=eAglDH3zbOiz0VrCJXk3IOo8oPEmogPYhzJ55yuMeOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2qcGlFn8un6f8E9VA4oHRCFgJ+0NYEiDH4w5By5JFmsNfhD3waEvgFWotBVju9eI
         +nsLXRDthknF5VZpEehScE6CC50ZbHRQbvE5Z11t81e+DVgSAdLeT8QeRQdR4Rv1S1
         pwCKlbzezN7JGZ4H5GkVxqbkiilOV4+EsgjmvRW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/280] ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug
Date:   Fri, 22 Mar 2019 12:13:17 +0100
Message-Id: <20190322111308.798456997@linuxfoundation.org>
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
@@ -218,15 +222,6 @@ fail:
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



