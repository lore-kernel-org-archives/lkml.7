Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5284DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344C1214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfKDRyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:54:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38025 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfKDRyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:54:19 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRgYR-0002Zs-Hx; Mon, 04 Nov 2019 18:54:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 344561C0426;
        Mon,  4 Nov 2019 18:54:15 +0100 (CET)
Date:   Mon, 04 Nov 2019 17:54:14 -0000
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-of: Use unique device
 name instead of timer
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016144747.29538-3-geert+renesas@glider.be>
References: <20191016144747.29538-3-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <157289005492.29376.132373533001357963.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4411464d6f8b5e5759637235a6f2b2a85c2be0f1
Gitweb:        https://git.kernel.org/tip/4411464d6f8b5e5759637235a6f2b2a85c2be0f1
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 16 Oct 2019 16:47:45 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 04 Nov 2019 10:38:46 +01:00

clocksource/drivers/timer-of: Use unique device name instead of timer

If a hardware-specific driver does not provide a name, the timer-of core
falls back to device_node.name.  Due to generic DT node naming policies,
that name is almost always "timer", and thus doesn't identify the actual
timer used.

Fix this by using device_node.full_name instead, which includes the unit
addrees.

Example impact on /proc/timer_list:

    -Clock Event Device: timer
    +Clock Event Device: timer@fcfec400

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016144747.29538-3-geert+renesas@glider.be
---
 drivers/clocksource/timer-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 3843942..8c11bd7 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -190,7 +190,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
 	}
 
 	if (!to->clkevt.name)
-		to->clkevt.name = np->name;
+		to->clkevt.name = np->full_name;
 
 	to->np = np;
 
