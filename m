Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602632070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G6/afem4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfH0Vee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:34:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43286 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfH0Ved (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:34:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so221096pfn.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u65eb0LbsmDf9WYugEfQU8yhjh8dm7ShzCXJ4XW2CQI=;
        b=G6/afem4UJIkoFMAMGDejRwkyYnDcQ7TVw/wZM/cC2IEZSlykHjbIvpE8YwuG7zpMl
         jFmuSoN6tCXSVL7gbDUU9wPCx8yQYvZ8HSaqIwX4BXXGjjpnKkteNBdDRH++XZQIhVaT
         T0ETXQ0kUr2bHOD5fk+T76YhRxqS8uqbBz+Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u65eb0LbsmDf9WYugEfQU8yhjh8dm7ShzCXJ4XW2CQI=;
        b=ZZttaH2Te4eGCOTmxPQrtEp5R5p3f8cAO7iY2vQwZOEWp7+rnWFyf0UBo6Kj91x6BM
         tQNxc3VLKPecQ7lCO7ewY4UEPU2xzAIKunl0Z5T1Ujwo5lsZU2fPPYOHc+8QDGGRnOqA
         iCLljk/y3s4D5jEo+5Qlub43B1k1Xg1zLab9QeXstqo+TA7fPtJG98hUHKaskXLlkQwi
         Wld3wfnIPm4YfsAKuCO1MSe5S74A8s/q4PCiAgUDUvtCez0unB+N/2qHChWPTdbrVdqB
         rQ4h0pXL7nONYRYeab9ulufi7fHqljynZRWdVj0j1PzZ/94E8hhSZQDLylnMvNTtMt1R
         30gw==
X-Gm-Message-State: APjAAAXv0bRH5NkwIBX4FpIsKDCwhOFadUjebGFdUASDQZ/7xQCnitzn
        qpzWo/G4YMc+cvZmW43ZIcC/Yg==
X-Google-Smtp-Source: APXvYqyYqruKpbhiqJj9BCo2c+zisJmr/XMd4UKehOqW0B8LSz01bN9xHsOQ9LvOS194GCZof1LdMg==
X-Received: by 2002:a62:2ac4:: with SMTP id q187mr688721pfq.242.1566941673245;
        Tue, 27 Aug 2019 14:34:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 203sm290124pfu.30.2019.08.27.14.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 14:34:32 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] Input - i8042: Enable wakeup on a stable struct device
Date:   Tue, 27 Aug 2019 14:34:31 -0700
Message-Id: <20190827213431.35882-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't know when the device will be added with device_add() in
serio_add_port() because serio_add_port() is called from a workqueue
that this driver schedules by calling serio_register_port(). The best we
can know is that the device will definitely not have been added yet when
the start callback is called on the serio device.

While it hasn't been shown to be a problem, proactively move the wakeup
enabling calls to the start hook so that we don't race with the
workqueue calling device_add(). This will avoid racy situations where
code tries to add wakeup sysfs attributes for this device from
dpm_sysfs_add() but the path in device_set_wakeup_capable() has already
done so.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/input/serio/i8042.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index e4352741c467..f32780ce22cc 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -432,6 +432,19 @@ static int i8042_start(struct serio *serio)
 {
 	struct i8042_port *port = serio->port_data;
 
+	device_set_wakeup_capable(&serio->dev, true);
+
+	/*
+	 * On platforms using suspend-to-idle, allow the keyboard to
+	 * wake up the system from sleep by enabling keyboard wakeups
+	 * by default.  This is consistent with keyboard wakeup
+	 * behavior on many platforms using suspend-to-RAM (ACPI S3)
+	 * by default.
+	 */
+	if (pm_suspend_via_s2idle() &&
+	    serio == i8042_ports[I8042_KBD_PORT_NO].serio)
+		device_set_wakeup_enable(&serio->dev, true);
+
 	spin_lock_irq(&i8042_lock);
 	port->exists = true;
 	spin_unlock_irq(&i8042_lock);
@@ -1397,17 +1410,6 @@ static void __init i8042_register_ports(void)
 			(unsigned long) I8042_COMMAND_REG,
 			i8042_ports[i].irq);
 		serio_register_port(serio);
-		device_set_wakeup_capable(&serio->dev, true);
-
-		/*
-		 * On platforms using suspend-to-idle, allow the keyboard to
-		 * wake up the system from sleep by enabling keyboard wakeups
-		 * by default.  This is consistent with keyboard wakeup
-		 * behavior on many platforms using suspend-to-RAM (ACPI S3)
-		 * by default.
-		 */
-		if (pm_suspend_via_s2idle() && i == I8042_KBD_PORT_NO)
-			device_set_wakeup_enable(&serio->dev, true);
 	}
 }
 
-- 
Sent by a computer through tubes

