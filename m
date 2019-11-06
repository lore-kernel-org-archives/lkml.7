Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157E1C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D749820663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXE20HvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfKFN2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:28:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46666 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbfKFN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:28:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id r18so1431721pgu.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=M2QJIZx29Gwekb8NQRHw9lqWCpHwrUdysxQR0ZEdvxo=;
        b=YXE20HvW35Fp8pQXuwFOC39tRqHrhYYIB0Kk79+k+E6QK0j4qvWRYMcwIXgdk74Xj0
         vxAiAxqDLOc4idYj7jalm+2xF8RpeJzQflNYXKNeN0RZodAmcSkx4m9CXVQkc5dpCTqK
         y64ygp67E832PmLIBKmgWF61yy1LjpbasXdLfG0bj+Ac+C2SdTk1Qa/fMBaRsHUg9Rzd
         LVQE38dNolQKbYx+rZaEhWhyxvYSgrFiyS2KfZUu1U18mswP1e5iO8Yoh04EiDtESruo
         ZfgRnm2ij4RJNsK5kD1oftJDX76h502Lj8g9BGAVW05qiZSts4YKVDcUt4BYNRDM3bm+
         1siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=M2QJIZx29Gwekb8NQRHw9lqWCpHwrUdysxQR0ZEdvxo=;
        b=Jchf5EzwrqdSaLVc0s0iYHa6Ra1HTQpTBu6RJR9f7y2hwjZzgvCGBjFoIeSQwIqA7G
         5TyGvSqTm+fMhqTPagxE2ekx1WrtZD1fuedwIZo47TT4PEb4W1Ch/AtxN5fbM0vUp8PM
         lL95TibNPYlHAp3TbHPz0EB57nRZTSMBr73GmoWWJZ0pf4NAPwezEPT7O5L9fCves1MG
         5Sjb2nCsQE6FsBo5jih2D6CR1ncXhskyU/IvNy31Gfen6cAz7Ve6DW6O7rVMwpZKCn6S
         RWz/9/uxDif8Q3ZpKS23M8eTqfH4aQTpNdsAfi1GzFChEliGKtS9VHDy/XImxs8jBa0i
         v6BA==
X-Gm-Message-State: APjAAAVLKsDxSRceZ2lon9gAVmnh4dERk4Qm8tePoAszuzlkdl+49E3e
        iR7O2GIk8j3SsNxjhrAlhGAMEyYmW7gLrQ==
X-Google-Smtp-Source: APXvYqx39ocvWK4EJjHayELfW7zIYDcufpwnEtY5mR0CiHvyOrP67iXURKLfvVVPd86QyNCrMOUkmQ==
X-Received: by 2002:aa7:9aea:: with SMTP id y10mr3292063pfp.16.1573046927655;
        Wed, 06 Nov 2019 05:28:47 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id w11sm18236846pgp.28.2019.11.06.05.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:28:47 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 03/11] thermal: step_wise: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:19 +0530
Message-Id: <fe3fc4028189d45f8a20da48501e0ea09f2b5236.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace - with : to appease the kernel-doc gods and fix warnings such as
the following when compiled with make W=1:

linux-amit.git/drivers/thermal/step_wise.c:187: warning: Function
parameter or member 'tz' not described in 'step_wise_throttle'
linux-amit.git/drivers/thermal/step_wise.c:187: warning: Function
parameter or member 'trip' not described in 'step_wise_throttle'

linux.git/drivers/thermal/fair_share.c:79: warning: Function parameter
or member 'tz' not described in 'fair_share_throttle'
linux.git/drivers/thermal/fair_share.c:79: warning: Function parameter
or member 'trip' not described in 'fair_share_throttle'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/fair_share.c    | 4 ++--
 drivers/thermal/gov_bang_bang.c | 4 ++--
 drivers/thermal/step_wise.c     | 4 ++--
 drivers/thermal/user_space.c    | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index afd99f668c65d..aaa07180ab482 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -58,8 +58,8 @@ static long get_target_state(struct thermal_zone_device *tz,
 
 /**
  * fair_share_throttle - throttles devices associated with the given zone
- * @tz - thermal_zone_device
- * @trip - trip point index
+ * @tz: thermal_zone_device
+ * @trip: trip point index
  *
  * Throttling Logic: This uses three parameters to calculate the new
  * throttle state of the cooling devices associated with the given zone.
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index b831fc77cf64a..991a1c54296de 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -71,8 +71,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 
 /**
  * bang_bang_control - controls devices associated with the given zone
- * @tz - thermal_zone_device
- * @trip - the trip point
+ * @tz: thermal_zone_device
+ * @trip: the trip point
  *
  * Regulation Logic: a two point regulation, deliver cooling state depending
  * on the previous state shown in this diagram:
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 6e051cbd824ff..2ae7198d3067c 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -174,8 +174,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 
 /**
  * step_wise_throttle - throttles devices associated with the given zone
- * @tz - thermal_zone_device
- * @trip - trip point index
+ * @tz: thermal_zone_device
+ * @trip: trip point index
  *
  * Throttling Logic: This uses the trend of the thermal zone to throttle.
  * If the thermal zone is 'heating up' this throttles all the cooling
diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index 962873fd92425..293cffd9c8adb 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -17,8 +17,8 @@
 
 /**
  * notify_user_space - Notifies user space about thermal events
- * @tz - thermal_zone_device
- * @trip - trip point index
+ * @tz: thermal_zone_device
+ * @trip: trip point index
  *
  * This function notifies the user space through UEvents.
  */
-- 
2.17.1

