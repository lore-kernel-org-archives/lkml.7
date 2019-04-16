Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E3EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F907206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfDPK0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:26:48 -0400
Received: from sauhun.de ([88.99.104.3]:48636 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfDPKZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:25:26 -0400
Received: from localhost (p54B332D3.dip0.t-ipconnect.de [84.179.50.211])
        by pokefinder.org (Postfix) with ESMTPSA id 2C90B2E354E;
        Tue, 16 Apr 2019 12:25:24 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/16] watchdog: add error messages when initializing timeout fails
Date:   Tue, 16 Apr 2019 12:25:01 +0200
Message-Id: <20190416102515.12269-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This not only removes boilerplate code from watchdog drivers, it can
also be more specific which of the supplied value actually fails. Also,
the loglevel becomes now consistent across drivers.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/watchdog_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 21e53cc49977..cd3ca6b366ef 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -126,6 +126,8 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 			wdd->timeout = timeout_parm;
 			return 0;
 		}
+		dev_err(dev, "driver supplied timeout (%u) out of range\n",
+			timeout_parm);
 		ret = -EINVAL;
 	}
 
@@ -136,9 +138,13 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 			wdd->timeout = t;
 			return 0;
 		}
+		dev_err(dev, "DT supplied timeout (%u) out of range\n", t);
 		ret = -EINVAL;
 	}
 
+	if (ret < 0 && wdd->timeout)
+		dev_warn(dev, "falling back to default timeout (%u)\n", wdd->timeout);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
-- 
2.11.0

