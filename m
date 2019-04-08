Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F27C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30F821473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfDHPtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:49:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50600 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbfDHPtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:49:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB2131688;
        Mon,  8 Apr 2019 08:49:40 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A81D3F557;
        Mon,  8 Apr 2019 08:49:38 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 2/7] watchdog/sbsa: Use arch_timer_read_counter instead of arch_counter_get_cntvct
Date:   Mon,  8 Apr 2019 16:49:02 +0100
Message-Id: <20190408154907.223536-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408154907.223536-1-marc.zyngier@arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only arch_timer_read_counter will guarantee that workarounds are
applied. So let's use this one instead of arch_counter_get_cntvct.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/watchdog/sbsa_gwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index e8bd9887c566..e221e47396ab 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -161,7 +161,7 @@ static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
 		timeleft += readl(gwdt->control_base + SBSA_GWDT_WOR);
 
 	timeleft += lo_hi_readq(gwdt->control_base + SBSA_GWDT_WCV) -
-		    arch_counter_get_cntvct();
+		    arch_timer_read_counter();
 
 	do_div(timeleft, gwdt->clk);
 
-- 
2.20.1

