Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08267C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF78724249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPDrfjkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfLEHUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:20:19 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:50340 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLEHUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:20:18 -0500
Received: by mail-pj1-f73.google.com with SMTP id e5so1294456pjr.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 23:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=qBYn7QdHGw5o3k1E2n1vfLHpyF0EPaNXN0K06zsIrec=;
        b=MPDrfjkC69dMj7OwfVpcDWa35vX63WFFcF9bDeEqDQIO/t1SpaUuRCVjhVjkELnrYu
         weZDos57yuDVRe28v9nOoqlDiSN4BwHaWe0+hwcNuZAuI3cIV0zelHny9EsGAkXn2sMy
         stuxH5G1Uhx8Q/D5VT13+9HHNG75aTgyUGIol1QaK9pOFZTXJiknWIL1IG1UD5LzE8Em
         nWTqzOR7Z0zJSP96STyBEE80xAI6Av0r3xzE9NAlAGmoliKyXDwlxQBEwgppix/aErnF
         cPGxngNl1rtP2CnyVImKDs6/7t9Nmr+g25K89QH5zC9f/s5yRzwtAE19ZhLvEqb2r3o1
         u9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=qBYn7QdHGw5o3k1E2n1vfLHpyF0EPaNXN0K06zsIrec=;
        b=kG85pJCHlbHBAtIt4NdiIYJqZgtxBkUMJp0hNnsz3Qpv297c2fDBREp8DpWTKpPwuH
         NFGe4HuWK3LyfQABJy8VGaUr9aSd4WiRU8LLU+PHrnIjFwQEnUsI1FJB9YmBu1IuvaqC
         BjhRZGZolv5N8p+eIxpM35ttukxUOytTSkS6R0zHoiKU0fwrEu+vsi/lr+b4gmpqouQt
         1CDRX5z87oxSi+SHoR/Tg4mqPVR78ZXznLQn8cQm+VzagZoRVt5lBwAap5HBxFWlHkNS
         bAFf3o1xyXWV4L/uXPLigmsKs2sVsbX+DN5gLEdD9LbzK1uMnYUjV1vA7uMDQZON93p5
         eSpg==
X-Gm-Message-State: APjAAAW6lna2whWmELH1vKQp7U4DMdZwMbnP1ti1ylzRuT7anSJqNWrK
        rDA7o5gOfDaFMJQAOexcaYvhQRo=
X-Google-Smtp-Source: APXvYqz6tTORReFVhHF553LdfWiOo3N0A8DvfOUKqFSsJ3E9ouDfjpwwcLx1ASORtEVYLnBr/OOq9pc=
X-Received: by 2002:a63:d351:: with SMTP id u17mr7718158pgi.84.1575530417211;
 Wed, 04 Dec 2019 23:20:17 -0800 (PST)
Date:   Wed,  4 Dec 2019 23:19:52 -0800
In-Reply-To: <20191205071953.121511-1-wvw@google.com>
Message-Id: <20191205071953.121511-3-wvw@google.com>
Mime-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v3 2/3] thermal: improve error message in thermal zone registration
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow up with commit 67eed44b8a8a ("thermal: Add some error messages")
to clean up checkpatch warning on line length and also add more message
for developers.

Signed-off-by: Wei Wang <wvw@google.com>
---
 drivers/thermal/thermal_core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 974e2d91c30b..9db7f72e70f8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1255,29 +1255,33 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	int count;
 	struct thermal_governor *governor;
 
-	if (!type || strlen(type) == 0) {
+	if (!type || !type[0]) {
 		pr_err("Error: No thermal zone type defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
-		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
-		       type, THERMAL_NAME_LENGTH);
+	if (strlen(type) >= THERMAL_NAME_LENGTH) {
+		pr_err("Error: Thermal zone name over %d chars: %s\n",
+			THERMAL_NAME_LENGTH, type);
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
-		pr_err("Error: Incorrect number of thermal trips\n");
+		pr_err("Error: Incorrect number of thermal trips: %s\n", type);
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (!ops) {
-		pr_err("Error: Thermal zone device ops not defined\n");
+		pr_err("Error: Thermal zone device ops not defined: %s\n",
+			type);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
+	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp)) {
+		pr_err("Error: Thermal zone device missing callback: %s\n",
+			type);
 		return ERR_PTR(-EINVAL);
+	}
 
 	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
 	if (!tz)
-- 
2.24.0.393.g34dc348eaf-goog

