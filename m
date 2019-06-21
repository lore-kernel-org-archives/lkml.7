Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8790C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995002084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFUCCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 22:02:50 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:46878 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfFUCCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 22:02:50 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id BC35129B2E; Thu, 20 Jun 2019 22:02:48 -0400 (EDT)
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <3e1e24a326b8b623b1a8b66a905ac6494ef74a07.1561081886.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] rtc: Don't state that the RTC holds UTC in case it doesn't
Date:   Fri, 21 Jun 2019 11:51:26 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some machines store local time in the Real Time Clock. The hard-coded
"UTC" string is wrong on those machines so just omit that string.
Update the log parser so it doesn't require the string "UTC".

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/rtc/hctosys.c             | 2 +-
 tools/power/pm-graph/bootgraph.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
index ff2092a0d38c..2270eca23203 100644
--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -58,7 +58,7 @@ static int __init rtc_hctosys(void)
 
 	err = do_settimeofday64(&tv64);
 
-	dev_info(rtc->dev.parent, "setting system clock to %ptR UTC (%lld)\n",
+	dev_info(rtc->dev.parent, "setting system clock to %ptR (%lld)\n",
 		 &tm, (long long)tv64.tv_sec);
 
 err_read:
diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
index 6dae57041537..5a045d1cb879 100755
--- a/tools/power/pm-graph/bootgraph.py
+++ b/tools/power/pm-graph/bootgraph.py
@@ -333,7 +333,7 @@ def parseKernelLog():
 			if(not sysvals.stamp['kernel']):
 				sysvals.stamp['kernel'] = sysvals.kernelVersion(msg)
 			continue
-		m = re.match('.* setting system clock to (?P<t>.*) UTC.*', msg)
+		m = re.match('.* setting system clock to (?P<t>.*) (?:UTC )?\(.*', msg)
 		if(m):
 			bt = datetime.strptime(m.group('t'), '%Y-%m-%d %H:%M:%S')
 			bt = bt - timedelta(seconds=int(ktime))
-- 
2.21.0

