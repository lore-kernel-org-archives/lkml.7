Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C6D222EB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfDSSQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:16:35 -0400
Received: from sauhun.de ([88.99.104.3]:50568 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfDSSQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:19 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id CC5D32E35C9;
        Fri, 19 Apr 2019 20:16:17 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/16] watchdog: ziirave_wdt: drop warning after calling watchdog_init_timeout
Date:   Fri, 19 Apr 2019 20:16:01 +0200
Message-Id: <20190419181601.7412-17-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
References: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core will print out details now.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/ziirave_wdt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index d3594aa3a374..43e6b575c32c 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -658,11 +658,7 @@ static int ziirave_wdt_probe(struct i2c_client *client,
 	w_priv->wdd.parent = &client->dev;
 	w_priv->wdd.groups = ziirave_wdt_groups;
 
-	ret = watchdog_init_timeout(&w_priv->wdd, wdt_timeout, &client->dev);
-	if (ret) {
-		dev_info(&client->dev,
-			 "Unable to select timeout value, using default\n");
-	}
+	watchdog_init_timeout(&w_priv->wdd, wdt_timeout, &client->dev);
 
 	/*
 	 * The default value set in the watchdog should be perfectly valid, so
-- 
2.11.0

