Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E003BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FC52064A
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cyRZJ1yR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfHAVdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:33:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46225 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHAVdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:33:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so15857369pgk.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWmARDo48Z8Dv81pG22MrnEPvg/7991SYFzMS48qKnE=;
        b=cyRZJ1yRaVu6PJnIyZ0m2XF/aeI4KSucQmlgOYSbGhPKcG5yUcoM8+RdJ8DbmCDMnc
         RkHD86VRMuw7CevSp88Ee4Ezex7hFoeV3tSzVJFbBo0dyrpIsh0i+pZZIPAhDK8CzAxX
         UpJhLcrmpqLJsBs7zYMLqfQrw6B4tik6LogGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWmARDo48Z8Dv81pG22MrnEPvg/7991SYFzMS48qKnE=;
        b=m7mQmCrONL2xy05L/Z8nf71xuNLXffmHRx/jMpkFN9qB/p2jlWCfrMx0YmKKJUoHZt
         WOC0joiz4ANoGCg//0TkGNB5GCjDF4NBnKoj7RS4BYNL9xpBLdIeJq6LSAXW4Lq7L0zt
         lQ5zMpL9a2pizUw27J0xhxprKbL29JOBjLCES7wDzIBBsocFZjIDvbGZ2lffCPrgWKfY
         HXarwVHn+f2aiRCIwFKmnvV4St6YJ9K+Apg2LuzL6suEvgnMPlKxARkJv/R7ty+8KUZg
         1pAh3cV7W36T7YD9PEM8LVGJ8JK1IhMXPFe/V8mphVnoPR3CTHgP9fUGk8Jzr4qYmxpw
         gNfg==
X-Gm-Message-State: APjAAAVRbyHyZV4KJS8VEU2xeoO0jQjQS66sl4kzJwJw44HtF0poQLG4
        rFqxf3TzWZxr4AdQtkF3+cKuRw==
X-Google-Smtp-Source: APXvYqwYyiNdtpaoJsKsetkRz6ay7LYTZwzMZKhXzzcDkAft5BnXgQ6QvVK/JsDun15uuAKQ3FIRiw==
X-Received: by 2002:a63:5945:: with SMTP id j5mr120457107pgm.452.1564695212134;
        Thu, 01 Aug 2019 14:33:32 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v138sm83854994pfc.15.2019.08.01.14.33.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:33:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] power: supply: Init device wakeup after device_add()
Date:   Thu,  1 Aug 2019 14:33:30 -0700
Message-Id: <20190801213330.81079-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may want to use the device pointer in device_init_wakeup() with
functions that expect the device to already be added with device_add().
For example, if we were to link the device initializing wakeup to
something in sysfs such as a class for wakeups we'll run into an error.
It looks like this code was written with the assumption that the device
would be added before initializing wakeup due to the order of operations
in power_supply_unregister().

Let's change the order of operations so we don't run into problems here.

Fixes: 948dcf966228 ("power_supply: Prevent suspend until power supply events are processed")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>                                                                                                                      
Cc: Tri Vo <trong@android.com>                                                                                                                                             
Cc: Kalesh Singh <kaleshsingh@google.com>      
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

See this thread[1] for more information on how this will be necessary.

[1] https://lkml.kernel.org/r/20190731215514.212215-1-trong@android.com


 drivers/power/supply/power_supply_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 82e84801264c..5c36c430ce8b 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1051,14 +1051,14 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
-	rc = device_init_wakeup(dev, ws);
-	if (rc)
-		goto wakeup_init_failed;
-
 	rc = device_add(dev);
 	if (rc)
 		goto device_add_failed;
 
+	rc = device_init_wakeup(dev, ws);
+	if (rc)
+		goto wakeup_init_failed;
+
 	rc = psy_register_thermal(psy);
 	if (rc)
 		goto register_thermal_failed;
@@ -1101,8 +1101,8 @@ __power_supply_register(struct device *parent,
 	psy_unregister_thermal(psy);
 register_thermal_failed:
 	device_del(dev);
-device_add_failed:
 wakeup_init_failed:
+device_add_failed:
 check_supplies_failed:
 dev_set_name_failed:
 	put_device(dev);
-- 
Sent by a computer through tubes

