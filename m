Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EEEC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4130D21744
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S0kaE2za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfHPO4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:56:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34580 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfHPO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:56:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so694100plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zNgTsW/toH/romghD8lLcdPbcwRsNKM6knNktVHRNQ8=;
        b=S0kaE2za0xATgm2WQghaqBcWsnU5pJoTf84SiAygs9rGHfUJdXTr7foafGJWht0hPx
         kadKTHVoWd4ufhpX/8+/O7FxFAO7bz87fgnUB4JpSIXJbvB14hj6u0WcO4e6LGmNGKJV
         eY7ut/Umbmip2ORJwXJLQN2603DiHO3xKSsqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zNgTsW/toH/romghD8lLcdPbcwRsNKM6knNktVHRNQ8=;
        b=kfoSNku2msuuYWy1zA7IFL9KjcWlvJI/m6LWTMAZA9fLr3UadKFc97DKvGBa/DTWly
         E00iMgNEwmu6REnkW5k0cPRv8//mpDvC087Ob9YoV9e97RnK5OPfQYtHun4a+S2URPsi
         zqfzNUS0Tw1Vthk3y/5lZxla6jqonLHTHQBSiee0v9AlWszzH9qTP02o/+CcJ4o93kyr
         eW1vdbGpBizgGE/lahWvZD5pOiUqIElL2UWCitW5a6EMnWQEjlnwpXROEsQ+l8pBV/QA
         0Ytc+OpXDLKYR8PDcSw0nAjqFpZf+B/4UnTcThHO+mtSwFIH1lDL3lV+1YA/Q9WHhXWl
         hOmw==
X-Gm-Message-State: APjAAAWQ9NwkEdxD7aM/s3BaU0j/RKrFs8HLR7q/tMnhBEpg+IaZdvEi
        67IfypsA8sum4PCCGIrL5OFkvA==
X-Google-Smtp-Source: APXvYqzOhs2C1rGqnxFIZX/6Ew+FfLaZuWLtrlj5OzigHhc4Un1LsHxaE/KZ+CN/4TO5zJj41eGxrQ==
X-Received: by 2002:a17:902:1107:: with SMTP id d7mr9560620pla.184.1565967363583;
        Fri, 16 Aug 2019 07:56:03 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z4sm6244583pfg.166.2019.08.16.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:56:03 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
Subject: [PATCH] PM / wakeup: Register wakeup class kobj after device is added
Date:   Fri, 16 Aug 2019 07:56:02 -0700
Message-Id: <20190816145602.231163-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_set_wakeup_enable() function can be called on a device that
hasn't been registered with device_add() yet. This allows the device to
be in a state where wakeup is enabled for it but the device isn't
published to userspace in sysfs yet.

After commit 986845e747af ("PM / wakeup: Show wakeup sources stats in
sysfs"), calling device_set_wakeup_enable() will fail for a device that
hasn't been registered with the driver core via device_add(). This is
because we try to create sysfs entries for the device and associate a
wakeup class kobject with it before the device has been registered.
Let's follow a similar approach that device_set_wakeup_capable() takes
here and register the wakeup class either from
device_set_wakeup_enable() when the device is already registered, or
from dpm_sysfs_add() when the device is being registered with the driver
core via device_add().

Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
Reported-by: Qian Cai <cai@lca.pw>
Cc: Qian Cai <cai@lca.pw>
Cc: Tri Vo <trong@android.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/power/sysfs.c  | 10 +++++++++-
 drivers/base/power/wakeup.c | 10 ++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 1b9c281cbe41..27ee00f50bd7 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeup.h>
 #include <linux/atomic.h>
 #include <linux/jiffies.h>
 #include "power.h"
@@ -661,14 +662,21 @@ int dpm_sysfs_add(struct device *dev)
 		if (rc)
 			goto err_runtime;
 	}
+	if (dev->power.wakeup) {
+		rc = wakeup_source_sysfs_add(dev, dev->power.wakeup);
+		if (rc)
+			goto err_wakeup;
+	}
 	if (dev->power.set_latency_tolerance) {
 		rc = sysfs_merge_group(&dev->kobj,
 				       &pm_qos_latency_tolerance_attr_group);
 		if (rc)
-			goto err_wakeup;
+			goto err_wakeup_source;
 	}
 	return 0;
 
+ err_wakeup_source:
+	wakeup_source_sysfs_remove(dev->power.wakeup);
  err_wakeup:
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
  err_runtime:
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index f7925820b5ca..5817b51d2b15 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -220,10 +220,12 @@ struct wakeup_source *wakeup_source_register(struct device *dev,
 
 	ws = wakeup_source_create(name);
 	if (ws) {
-		ret = wakeup_source_sysfs_add(dev, ws);
-		if (ret) {
-			wakeup_source_free(ws);
-			return NULL;
+		if (!dev || device_is_registered(dev)) {
+			ret = wakeup_source_sysfs_add(dev, ws);
+			if (ret) {
+				wakeup_source_free(ws);
+				return NULL;
+			}
 		}
 		wakeup_source_add(ws);
 	}
-- 
Sent by a computer through tubes

