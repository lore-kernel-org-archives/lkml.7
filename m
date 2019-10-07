Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD65C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E47F2133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nkMQ8X9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfJGHQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:16:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43643 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJGHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:16:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id i32so327004pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzfC8RVq1jP1kr40tiN+8WHn9COGwplqh2mQFPqwcC8=;
        b=nkMQ8X9CAoT8fwvh8c2BskmgfPKD8hl3HO2ivNlWnmNsG22vLvXE4w7M6RHR0vJfq4
         l1RI2y6w9uDbcRSFqoli/p50exF0Zidpx6tLxBRqAEOnllb4hf2meGdHc4hE74MeuyLT
         S6OTOePKh8HFHqJSRN736bofzO7OGadxfB06E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzfC8RVq1jP1kr40tiN+8WHn9COGwplqh2mQFPqwcC8=;
        b=KXqzoEdubai/qM1/+zu2rC60o6Ok5RCodVZLs/8KCXq3zt3vLPSxWPEo8uWc9UkfF7
         jE8NkaXi3EC2Yh1nAWg8U8Ho5uGKzGT3LWUWp3a1tfZ/y7q7ehCFXTB6nVbflnr6P5+V
         NAlpsssHZdnmA7tKW3jFpbn8sa6hJU3AgJvn5e36R1lJZOhGugQenIhiF+awXJMuITTz
         TZHtgIQLLk7pUgU34TI3U15S8uJ5v/oifFjkMuTvC0mM00M4HKeV2FqxVyrXJzFFU0CN
         qbpnIfyEuYYIXws01S80oNJNdCWvMQlhyg/WYPZa792urNpzF8owPMXNj8a/ElIm5aGK
         /qvw==
X-Gm-Message-State: APjAAAUWopNS32L3zZdAiPRY3FhlIvxA37xSa43q6FPSSlrA+a9Zbwln
        KygG4+LxxUdn6otbdR/ocwGz9RoRaL8=
X-Google-Smtp-Source: APXvYqwiP0yuYdJ+4gkcqPLdLjqZtNFDPJkZPqAzA+L0Ij6yff4yxpEiwaN/m998Kt1N7CdwNV74Ow==
X-Received: by 2002:a17:90a:256c:: with SMTP id j99mr31552845pje.125.1570432576781;
        Mon, 07 Oct 2019 00:16:16 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id d10sm15020616pfh.8.2019.10.07.00.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 00:16:15 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Guenter Roeck <linux@roeck-us.net>,
        Hung-Te Lin <hungte@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>, dgreid@chromium.org,
        tzungbi@chromium.org
Subject: [PATCH] firmware: vpd: Add an interface to read VPD value
Date:   Mon,  7 Oct 2019 15:16:10 +0800
Message-Id: <20191007071610.65714-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an interface for other driver to query VPD value.
This will be used for ASoC machine driver to query calibration
data stored in VPD for smart amplifier speaker resistor
calibration.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 drivers/firmware/google/vpd.c              | 16 ++++++++++++++++
 include/linux/firmware/google/google_vpd.h | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/linux/firmware/google/google_vpd.h

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index db0812263d46..71e9d2da63be 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -65,6 +65,22 @@ static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
 				       info->bin_attr.size);
 }
 
+int vpd_attribute_read_value(bool ro, const char *key,
+			     char **value, u32 value_len)
+{
+	struct vpd_attrib_info *info;
+	struct vpd_section *sec = ro ? &ro_vpd : &rw_vpd;
+
+	list_for_each_entry(info, &sec->attribs, list) {
+		if (strcmp(info->key, key) == 0) {
+			*value = kstrndup(info->value, value_len, GFP_KERNEL);
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(vpd_attribute_read_value);
+
 /*
  * vpd_section_check_key_name()
  *
diff --git a/include/linux/firmware/google/google_vpd.h b/include/linux/firmware/google/google_vpd.h
new file mode 100644
index 000000000000..6f1160f28af8
--- /dev/null
+++ b/include/linux/firmware/google/google_vpd.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Google VPD interface.
+ *
+ * Copyright 2019 Google Inc.
+ */
+
+/* Interface for reading VPD value on Chrome platform. */
+
+#ifndef __GOOGLE_VPD_H
+#define __GOOGLE_VPD_H
+
+#include <linux/types.h>
+
+int vpd_attribute_read_value(bool ro, const char *key,
+			     char **value, u32 value_len);
+
+#endif  /* __GOOGLE_VPD_H */
-- 
2.23.0.581.g78d2f28ef7-goog

