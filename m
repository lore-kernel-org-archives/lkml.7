Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20001C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AFB22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="le8WcKjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfHUPDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:03:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16630 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfHUPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:03:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5d5d2b0000>; Wed, 21 Aug 2019 08:03:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 08:03:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Aug 2019 08:03:06 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 15:03:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 21 Aug 2019 15:03:06 +0000
Received: from moonraker.nvidia.com (Not Verified[10.2.160.227]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5d5d290000>; Wed, 21 Aug 2019 08:03:06 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 2/2] clocksource/drivers: Do not warn on probe defer
Date:   Wed, 21 Aug 2019 16:02:41 +0100
Message-ID: <20190821150241.31093-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821150241.31093-1-jonathanh@nvidia.com>
References: <20190821150241.31093-1-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566399787; bh=p648Wl6F7y32KHJWtTRFzAGWOiC9pGf46QsYBWxiuxs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=le8WcKjOr/xSHdJAiZvm5Jru3NGWJNQwCDULD2ZPRnDQ0Zx0yMPnk5b6uZA3/V5/k
         u9VN85Z3CFEvS9lyEmcRME3OiY/rkor4HTZHbHh2U2T26Fgxa6z5jr/TgXADQH6S6h
         MfveZ/qcee960QSQ8u6D8e6+mv88r4CPqH+D8D8/XHofy/LeTHZQ78petCAfkODZv/
         rYUJpBbr+aAJ9ygms4zNgs6T85jMV5swpAIIYSD76hhOpbhSNzBsVCzi4FAJ8VQpv5
         ZEHqP/Mre5a3F5gNIsKrn0v//tf9ssAyq3rWbx8t/np2Erb37OOWUOhUik2P+c+e6L
         upgbCw3Mw+bhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred probe is an expected return value on many platforms and so
there's no need to output a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/clocksource/timer-probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index dda1946e84dd..ee9574da53c0 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -29,7 +29,9 @@ void __init timer_probe(void)
 
 		ret = init_func_ret(np);
 		if (ret) {
-			pr_err("Failed to initialize '%pOF': %d\n", np, ret);
+			if (ret != -EPROBE_DEFER)
+				pr_err("Failed to initialize '%pOF': %d\n", np,
+				       ret);
 			continue;
 		}
 
-- 
2.17.1

