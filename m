Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71056C2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EEF2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576560221;
	bh=gTBRUZTAj08OEJZUmrm/ewxMPRPrawoPjsr3dDQQ800=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VwttAp/1bZ/SHXDHO3rdRSlQilbamcxdY5gRR+7GaWI0sVOaTqB7xZnKlps3MAxWA
	 T8SLKyDWavW5c1mrGeQF8BwGtMXdoI3eGuW208YE3DoUgCEKh3g4uPz3eoJO9nbVDX
	 o7cU7PYNP55XcQfeZmZl0rm6Xrgi+CyxyQ7pxhn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfLQFXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:23:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfLQFXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 00:23:39 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889B12072B;
        Tue, 17 Dec 2019 05:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576560218;
        bh=gTBRUZTAj08OEJZUmrm/ewxMPRPrawoPjsr3dDQQ800=;
        h=From:To:Cc:Subject:Date:From;
        b=SSPOk5UWGjZTQF6arwuC5jG8hGqYNW46VN3fEW/EXcGphRgBAd8SLL9XMd9oAqlYc
         5Uo82aPrM4+6gfnmxEVTCypMUFrPpQO2lb1/Bg8Sx8DHftePSkav+lA3nXRYLGUSQM
         DUYxQIXqlSuL6dT78rQO6yCxRJfX0bvcZJZmzS50=
Received: by wens.tw (Postfix, from userid 1000)
        id 57AA75FCA8; Tue, 17 Dec 2019 13:23:36 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: rockchip: enable hwmon
Date:   Tue, 17 Dec 2019 13:23:28 +0800
Message-Id: <20191217052328.25633-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

By default of-based thermal driver do not have hwmon entries registered.

Do this explicitly so users can use standard hwmon interfaces and tools
to read the temperature.

This is based on similar changes for bcm2835_thermal in commit
d56c19d07e0b ("thermal: bcm2835: enable hwmon explicitly").

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/thermal/rockchip_thermal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 9ed8085bb792..d53ba7dabf16 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -19,6 +19,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/pinctrl/consumer.h>
 
+#include "thermal_hwmon.h"
+
 /*
  * If the temperature over a period of time High,
  * the resulting TSHUT gave CRU module,let it reset the entire chip,
@@ -1210,7 +1212,11 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 		return error;
 	}
 
-	return 0;
+	/* thermal_zone doesn't enable hwmon as default, enable it here */
+	sensor->tzd->tzp->no_hwmon = false;
+	error = thermal_add_hwmon_sysfs(sensor->tzd);
+
+	return error;
 }
 
 /**
-- 
2.24.0

