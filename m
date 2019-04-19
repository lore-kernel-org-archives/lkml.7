Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E059BC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD9D222E9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfDSSQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:16:18 -0400
Received: from sauhun.de ([88.99.104.3]:50518 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfDSSQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:12 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id E39C92E3578;
        Fri, 19 Apr 2019 20:16:09 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/16] watchdog: add error messages when initializing timeout fails
Date:   Fri, 19 Apr 2019 20:15:47 +0200
Message-Id: <20190419181601.7412-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
References: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
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
 drivers/watchdog/watchdog_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 21e53cc49977..62be9e52a4de 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -115,6 +115,8 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 int watchdog_init_timeout(struct watchdog_device *wdd,
 				unsigned int timeout_parm, struct device *dev)
 {
+	const char *dev_str = wdd->parent ? dev_name(wdd->parent) :
+			      (const char *)wdd->info->identity;
 	unsigned int t = 0;
 	int ret = 0;
 
@@ -126,6 +128,8 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 			wdd->timeout = timeout_parm;
 			return 0;
 		}
+		pr_err("%s: driver supplied timeout (%u) out of range\n",
+			dev_str, timeout_parm);
 		ret = -EINVAL;
 	}
 
@@ -136,9 +140,14 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 			wdd->timeout = t;
 			return 0;
 		}
+		pr_err("%s: DT supplied timeout (%u) out of range\n", dev_str, t);
 		ret = -EINVAL;
 	}
 
+	if (ret < 0 && wdd->timeout)
+		pr_warn("%s: falling back to default timeout (%u)\n", dev_str,
+			wdd->timeout);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
-- 
2.11.0

