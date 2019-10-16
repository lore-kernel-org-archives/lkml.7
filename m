Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D3BFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3402168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tx1xZc+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406361AbfJPQk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:40:26 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42475 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389155AbfJPQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:40:25 -0400
Received: by mail-qk1-f202.google.com with SMTP id b143so24343148qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=KmHAeCmiFOkBGaykqemUU3bu3MBT3SFq3fZo9SBLQA0=;
        b=tx1xZc+0ttcNVyH6dgx0gO8wsgU0mihhPb+RiRKk+HcpECEXVmWlY8ozvaLkS0c50k
         Ywlq/bCBFMCPCSHKDA3Z6Y64vl8kk+svg+xx2YbIoTMUOOCat0suCVcNT5sXBIm8XwaF
         HMHDlRDKFfqAY/4KYZorMk9ujRtgRT51qri49NfKncCMyk0qoZwZHw2lG6ixBpFh4229
         ntO0JrbnM9BZLlJo2W0Mt3yzCkWcTJDcF7JBRyG6IVOVOQN+CieokpQikeA+vCV4mDfI
         THn6AsxJVslMxe+YSBK42QP4GY37vFyKPhH7U5rfE41zqzo70nu9aOd1M7KBi0DPcsR/
         Arkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=KmHAeCmiFOkBGaykqemUU3bu3MBT3SFq3fZo9SBLQA0=;
        b=rjdDuIDbXYJC1KIMhROcMEl0JXyOS+/OEAcGuqQms/5Ml6v+8ffxB9iJHCNlodSIbH
         W48LoUUzRMz8I7VX2xu1+RAwMGYMvv3TNP1xAXtRCQ2WkMw4EPqwF4nLYS8vFHaY4uTx
         lg43eeUQEp5VeVd3CEooQw5CGbi3+KVmc0j8H4TtIhso1WjAa3IirIxUtpJmtQkKpTAA
         L07VIB7Gs+fBU8X8WufnxDubwAb4MiWY1pdo3fbbkc/Yf3by/yfSB9Iiu0udGU+k3sLL
         NiUb+TDARlx6IO2W5OU2c+znQxChyRj4VH6dAuUfui5eyf2xvaBngQLCDYmSVaYt5OW1
         dKTg==
X-Gm-Message-State: APjAAAUeO0d86u1gDrezuIhbgtVtFv6eWk9aOkYnQNw86e9yUhxmWiwc
        X8rPLT2XQE3QjreqIR0cYOgSfMs=
X-Google-Smtp-Source: APXvYqwGTx11wWIRQ2TebiUDv/eQwz/FhNoBpywwJ2gXee0Ud1aGImugAy/hl95BaQVi8snymnd9ldk=
X-Received: by 2002:ad4:4448:: with SMTP id l8mr20707050qvt.102.1571244023109;
 Wed, 16 Oct 2019 09:40:23 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:40:07 -0700
Message-Id: <20191016164014.146868-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH] thermal: update header and documentation
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit commit f991de53a8ab ("thermal: make device_register's type
argument const") changed APIs, but only when CONFIG_THERMAL enabled case.

This patch is partial from https://lkml.org/lkml/2019/5/14/631 which
tries to address the same concern,

Signed-off-by: Wei Wang <wvw@google.com>
---
 Documentation/driver-api/thermal/sysfs-api.rst | 4 ++--
 include/linux/thermal.h                        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index fab2c9b36d08..0ef337417922 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -39,7 +39,7 @@ temperature) and throttle appropriate devices.
     ::
 
 	struct thermal_zone_device
-	*thermal_zone_device_register(char *type,
+	*thermal_zone_device_register(const char *type,
 				      int trips, int mask, void *devdata,
 				      struct thermal_zone_device_ops *ops,
 				      const struct thermal_zone_params *tzp,
@@ -221,7 +221,7 @@ temperature) and throttle appropriate devices.
     ::
 
 	struct thermal_cooling_device
-	*thermal_cooling_device_register(char *name,
+	*thermal_cooling_device_register(const char *name,
 			void *devdata, struct thermal_cooling_device_ops *)
 
     This interface function adds a new thermal cooling device (fan/processor/...)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45659c75920..ee235a29294e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -501,12 +501,12 @@ static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 static inline void thermal_zone_set_trips(struct thermal_zone_device *tz)
 { }
 static inline struct thermal_cooling_device *
-thermal_cooling_device_register(char *type, void *devdata,
+thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-	char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
+thermal_of_cooling_device_register(struct device_node *np, const char *type,
+	void *devdata, const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
-- 
2.23.0.700.g56cf767bdb-goog

