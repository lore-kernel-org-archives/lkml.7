Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B9C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C1924249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ld8GY3Ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfLEHUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:20:23 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:39295 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLEHUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:20:21 -0500
Received: by mail-yw1-f73.google.com with SMTP id l12so1740260ywk.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 23:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=ts1yBosTiHCFk+FM0gulija97H50ynj8MItVpiYvleQ=;
        b=ld8GY3TacvMwKqP04HpCI65PJfosSibr/XBnqjhUGqK8lCLovwEHCSicuYg0080tyP
         dfZbzuPfYYv3pcb1iC+/CjCG+fUQxrimPBy9fyQjgXTDZs1PPcwNfw3HCWbiFE7wRUKk
         UXIsBTWrF8A4dbgQooSvDgo/pV1rNrkqUuGILp+GFV2cUEVt5BpP6dJJCCd1gu0Gz93w
         5mBfZHtVfBwJN9vRkQ1DcqJdelveL3SzXxVZcPfFgUTSzGwNBav4M86qMp+cHgOwnQrg
         7tm3S/98VeIjDpYfSS1hAII/y8JDlNG2vNIvj/6oUTS8FiojrKMPKnf640QM1RQNpCR3
         +hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=ts1yBosTiHCFk+FM0gulija97H50ynj8MItVpiYvleQ=;
        b=uZQFfCrYv568xhySxrKnEXIq9tDUeWGLbEEu09hjlPgGQSAJ9dvgj1ElX7KIGP8OWj
         oDRwQ1bg2mAlVjBLPTokk+VGEKXfGu9bkBTOmZzRQ6zdscLrKVki3XXVcq3TjcTue/Vo
         l/hE6b+zi8ff3bwpHxhbwRdEawQ85cLddUj3lxiL3Zh35GPAXLufnXjyjF5KZLbz8sNh
         d8Ur63lfrV5kShKVtQ59smLK4w57GnLZvYrH3SG/suNM5Hn+XZjOeZLJNRFgkMxa67xL
         +Qn3XildBsw+jyIVG9AXe2U09aQBMBxDxjJAGWS6/GwNEZv9w6JseYffqvKo+TsRC2eu
         NqCg==
X-Gm-Message-State: APjAAAVyNV4+PkL033xSp4nB031VW8VDOPSZKb0uo2s7S9hLusPAG64g
        bC7v2FLG3JdpSGvuGDcTzJBiM44=
X-Google-Smtp-Source: APXvYqwPLL22lSTzNWHq5MEuCpLUubSt5RY0lxSgL1kQNEi44mvvHms6QnuzTkyPX1MHD1unKh/9ObE=
X-Received: by 2002:a0d:d911:: with SMTP id b17mr5123945ywe.269.1575530419968;
 Wed, 04 Dec 2019 23:20:19 -0800 (PST)
Date:   Wed,  4 Dec 2019 23:19:53 -0800
In-Reply-To: <20191205071953.121511-1-wvw@google.com>
Message-Id: <20191205071953.121511-4-wvw@google.com>
Mime-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v3 3/3] thermal: create softlink by name for thermal_zone and cooling_device
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paths thermal_zone%d and cooling_device%d are not intuitive and the
numbers are subject to change due to device tree change. This usually
leads to tree traversal in userspace code.
The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
cooling_device respectively.

Signed-off-by: Wei Wang <wvw@google.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9db7f72e70f8..7872bd527f3f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -22,6 +22,7 @@
 #include <net/netlink.h>
 #include <net/genetlink.h>
 #include <linux/suspend.h>
+#include <linux/kobject.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/thermal.h>
@@ -46,6 +47,8 @@ static DEFINE_MUTEX(poweroff_lock);
 
 static atomic_t in_suspend;
 static bool power_off_triggered;
+static struct kobject *cdev_link_kobj;
+static struct kobject *tz_link_kobj;
 
 static struct thermal_governor *def_governor;
 
@@ -999,9 +1002,15 @@ __thermal_cooling_device_register(struct device_node *np,
 		return ERR_PTR(result);
 	}
 
-	/* Add 'this' new cdev to the global cdev list */
+	/* Add 'this' new cdev to the global cdev list and create link*/
 	mutex_lock(&thermal_list_lock);
 	list_add(&cdev->node, &thermal_cdev_list);
+	if (!cdev_link_kobj)
+		cdev_link_kobj = kobject_create_and_add("cdev-by-name",
+						cdev->device.kobj.parent);
+	if (!cdev_link_kobj || sysfs_create_link(cdev_link_kobj,
+						&cdev->device.kobj, cdev->type))
+		dev_err(&cdev->device, "Failed to create cdev-by-name link\n");
 	mutex_unlock(&thermal_list_lock);
 
 	/* Update binding information for 'this' new cdev */
@@ -1167,6 +1176,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 			}
 		}
 	}
+	if (cdev_link_kobj)
+		sysfs_remove_link(cdev_link_kobj, cdev->type);
 
 	mutex_unlock(&thermal_list_lock);
 
@@ -1354,6 +1365,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 
 	mutex_lock(&thermal_list_lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
+	if (!tz_link_kobj)
+		tz_link_kobj = kobject_create_and_add("tz-by-name",
+						tz->device.kobj.parent);
+	if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
+						&tz->device.kobj, tz->type))
+		dev_err(&tz->device, "Failed to create tz-by-name link\n");
 	mutex_unlock(&thermal_list_lock);
 
 	/* Bind cooling devices for this zone */
@@ -1425,6 +1442,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 			}
 		}
 	}
+	if (tz_link_kobj)
+		sysfs_remove_link(tz_link_kobj, tz->type);
 
 	mutex_unlock(&thermal_list_lock);
 
-- 
2.24.0.393.g34dc348eaf-goog

