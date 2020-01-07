Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F83C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363E72087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgAGPvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:51:05 -0500
Received: from unsecure-smtp.soverin.net ([94.130.159.241]:34241 "EHLO
        g02sm02.soverin.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727994AbgAGPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:51:04 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2020 10:51:03 EST
Received: from soverin.net by soverin.net
From:   Jack Mitchell <ml@embed.me.uk>
Cc:     ml@embed.me.uk, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: dw_wdt: ping watchdog to reset countdown before start
Date:   Tue,  7 Jan 2020 15:50:53 +0000
Message-Id: <20200107155054.278444-1-ml@embed.me.uk>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at g02sm02
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on an rk3288 SoC when trying to use the watchdog the SoC will
instantly reset. This is due to the watchdog countdown counter being set
to its initial value of 0x0. Reset the watchdog counter before start in
order to correctly start the countdown timer from the right position.

Signed-off-by: Jack Mitchell <ml@embed.me.uk>
---
 drivers/watchdog/dw_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index fef7c61f5555..4a902d015bc2 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -135,6 +135,7 @@ static int dw_wdt_start(struct watchdog_device *wdd)
 	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
 
 	dw_wdt_set_timeout(wdd, wdd->timeout);
+	dw_wdt_ping(&dw_wdt->wdd);
 	dw_wdt_arm_system_reset(dw_wdt);
 
 	return 0;
-- 
2.24.1

