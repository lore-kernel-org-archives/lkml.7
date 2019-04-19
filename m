Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D63C282E5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F16C222E9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfDSSQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:16:17 -0400
Received: from sauhun.de ([88.99.104.3]:50504 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfDSSQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:12 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id 57B9B2E3571;
        Fri, 19 Apr 2019 20:16:09 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/16] watchdog: refactor watchdog_init_timeout
Date:   Fri, 19 Apr 2019 20:15:46 +0200
Message-Id: <20190419181601.7412-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
References: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is not easy to read and has a problem: -EINVAL is returned
when the module parameter is invalid but the DT parameter is OK.

Refactor the code to have the same pattern of checks for the module
parameter and DT. Further ones can be easily added in the future if the
need arises. The above mentioned problem is fixed, too.

Some documentation is added to describe the different handlings of '0'
for the module parameter and the DT property.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/watchdog_core.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index eb8fa25f8eb2..21e53cc49977 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -105,9 +105,12 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
  * timeout module parameter (if it is valid value) or the timeout-sec property
  * (only if it is a valid value and the timeout_parm is out of bounds).
  * If none of them are valid then we keep the old value (which should normally
- * be the default timeout value).
+ * be the default timeout value). Note that for the module parameter, '0' means
+ * 'use default' while it is an invalid value for the timeout-sec property.
+ * It should simply be dropped if you want to use the default value then.
  *
- * A zero is returned on success and -EINVAL for failure.
+ * A zero is returned on success or -EINVAL if all provided values are out of
+ * bounds.
  */
 int watchdog_init_timeout(struct watchdog_device *wdd,
 				unsigned int timeout_parm, struct device *dev)
@@ -117,22 +120,24 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 
 	watchdog_check_min_max_timeout(wdd);
 
-	/* try to get the timeout module parameter first */
-	if (!watchdog_timeout_invalid(wdd, timeout_parm) && timeout_parm) {
-		wdd->timeout = timeout_parm;
-		return ret;
-	}
-	if (timeout_parm)
+	/* check the driver supplied value (likely a module parameter) first */
+	if (timeout_parm) {
+		if (!watchdog_timeout_invalid(wdd, timeout_parm)) {
+			wdd->timeout = timeout_parm;
+			return 0;
+		}
 		ret = -EINVAL;
+	}
 
 	/* try to get the timeout_sec property */
-	if (dev == NULL || dev->of_node == NULL)
-		return ret;
-	of_property_read_u32(dev->of_node, "timeout-sec", &t);
-	if (!watchdog_timeout_invalid(wdd, t) && t)
-		wdd->timeout = t;
-	else
+	if (dev && dev->of_node &&
+	    of_property_read_u32(dev->of_node, "timeout-sec", &t) == 0) {
+		if (t && !watchdog_timeout_invalid(wdd, t)) {
+			wdd->timeout = t;
+			return 0;
+		}
 		ret = -EINVAL;
+	}
 
 	return ret;
 }
-- 
2.11.0

