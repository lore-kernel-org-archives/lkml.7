Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42279C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA6F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QH7dpM/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfDWXjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:39:09 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49848 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfDWXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:39:08 -0400
Received: by mail-pg1-f202.google.com with SMTP id x2so10937560pge.16
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=l4OycizyA4U5EtUwbs2RVj8M0wcMjT611kVIFhqJjMU=;
        b=QH7dpM/SPdEFshWf4Mox3ZzVJQDJ5EjmxAPm9CViy7vNKZKTZSsuzbqVqa+yAUbN5i
         q+NfU8bxXL5B417KaRqB0pSg2VvE55NkQmX1wgUDlhGS4shPCgR+lVtAsf5jsA0Zguii
         1vlGQQNGACiXUg4uFsW7pl+VMNB2OsH7SD7CUR9KU9m4Yxj+NMzDe567aWJsk6ZCP3Lt
         bcikSyzfHb8+P+mGDPk1FtMNMgIrAQyAIW7eQC26t7+phIZ8UInHw/mi23T6M1ZzNsBY
         Yku94h8mTrlbFecKDUjXOF+YzDQ+d0NamOgW9HwVvdRGuMBPlegY3A6xWMbJRF3ER/ci
         pKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=l4OycizyA4U5EtUwbs2RVj8M0wcMjT611kVIFhqJjMU=;
        b=DJB4IdsFL5pZMHKwkg0IVbwYmra4f3nf1f0icIW+ux2xBz6wVGt7JWxEYlhwPlVGLW
         /mtl22iRxLvMlpzJ+vABF80XpDvjc09AyuW1mA11Xg9luF4eheEqAz+lnZm3SHZjFKiD
         riy6mYEUsHDMepQSw99ZYJlFZxhcl41pDOAoIhGUd2um6jriiv34FllLbUK7gDx7p7Qk
         /5rj+ej54rhAGvV7VnuGmm35AtTIHoi/Y23QW4xAEyUefFhiJzxr+0zoCPJOlhWgT+8y
         e8b9xLvP6vLkHp4INaBduqwoy1OT+fPW6X6RCFFGwhssl3AHEMxe/N8Tkha8W8qRNUMG
         eQTA==
X-Gm-Message-State: APjAAAWvPSOmD8f27J6FltbyFedHPzBzc/hxsq4mpbXR4vigMCRbLI4C
        RZQF1nEbRykK02ZQ57jDxtcjI1KIs1hf
X-Google-Smtp-Source: APXvYqyfHcPeX7FpqyI0kp5JyjYb+VFFph0EunyTXyIbwVSLwBz+WWvAWSJgxWAonkxGhy7Gd0QmacvjAU+j
X-Received: by 2002:a63:20f:: with SMTP id 15mr26489675pgc.90.1556062747616;
 Tue, 23 Apr 2019 16:39:07 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:39:04 -0700
Message-Id: <20190423233904.195842-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] drivers/acpi: Turn off power resources while entering S5
From:   Furquan Shaikh <furquan@google.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, dlaurie@google.com, furquan@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot-up, ACPI bus scan enables all power resources so that
respective device drivers can talk to their device. This causes acpi
ref_count for the power resource to be incremented to 1. When system
suspends (S3/S0ix) or hibernates(S4), DPM is responsible for calling
power off on all power resources whose ref_count is 1 i.e. no other
user of this power resource and thus resulting in _OFF routine being
called for it.

However, in case of poweroff, DPM is not involved and so the power
resources are left on when the system is entering S5. This results in
the violation of power down sequencing for certain devices
e.g. touchscreen or digitizer I2C devices. In order to ensure that the
power down sequencing does the right thing, it is necessary for ACPI
to disable all power resources while preparing for S5.

This change updates the function acpi_turn_off_unused_power_resources
to accept a parameter acpi_system_state, This function turns off power
resources according to the targeted system ACPI state:
1. For S0: Unused power resources are turned off i.e. power resources
whose ref_count is already 0.
2. For S5: ref_count is decremented first to undo the increment
performed during ACPI bus scan and then power resources with ref_count
0 are turned off.
3. All other suspend/hibernate states: No action is required since DPM
takes care of turning off power resources.

This change should not affect the wake capable devices since:
1. If wake capable devices are enabled before this call, their
refcount should be greater than 1. Thus, they won't be turned off.
2. If wake capable devices are not enabled yet when this call is made,
they would eventually get turned on by call to
acpi_enable_wakeup_devices.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/acpi/power.c | 47 ++++++++++++++++++++++++++++++++++++++------
 drivers/acpi/sleep.c |  5 ++++-
 drivers/acpi/sleep.h |  2 +-
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 665e93ca0b40f..945db762861a3 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -889,10 +889,42 @@ void acpi_resume_power_resources(void)
 
 	mutex_unlock(&power_resource_list_lock);
 }
+#endif
 
-void acpi_turn_off_unused_power_resources(void)
+/**
+ * acpi_turn_off_power_resources: This function is used to turn off power
+ * resources in provided ACPI system state.
+ *
+ * Behavior differs based on the target system state:
+ * ACPI_STATE_S0: Turn off unused power resources i.e. turn off power resources
+ *                with ref_count zero.
+ * ACPI_STATE_S5: Decrement ref_count first and turn off power resources with
+ *                ref_count zero. This is done to ensure that the ref_count
+ *                incremented during ACPI bus scan is undone and any power
+ *                resources that are not required during S5 are turned off.
+ * ACPI_STATE_Sx: No action required. DPM is responsible for turning off power
+ *                resources while suspending/hibernating.
+ */
+void acpi_turn_off_power_resources(int acpi_system_state)
 {
 	struct acpi_power_resource *resource;
+	int decrement;
+
+	if (acpi_system_state == ACPI_STATE_S0) {
+		/*
+		 * In case of ACPI_STATE_S0, turn off only unused power
+		 * resources. So, no need to decrement ref_count.
+		 */
+		decrement = 0;
+	} else if (acpi_system_state == ACPI_STATE_S5) {
+		/*
+		 * In case of ACPI_STATE_S5, ref_count needs to be decremented
+		 * first before checking if it is okay to power off the
+		 * resource.
+		 */
+		decrement = 1;
+	} else
+		return;
 
 	mutex_lock(&power_resource_list_lock);
 
@@ -907,10 +939,14 @@ void acpi_turn_off_unused_power_resources(void)
 			continue;
 		}
 
-		if (state == ACPI_POWER_RESOURCE_STATE_ON
-		    && !resource->ref_count) {
-			dev_info(&resource->device.dev, "Turning OFF\n");
-			__acpi_power_off(resource);
+		if (state == ACPI_POWER_RESOURCE_STATE_ON) {
+			if (resource->ref_count)
+				resource->ref_count -= decrement;
+
+			if (!resource->ref_count) {
+				dev_info(&resource->device.dev, "Turning OFF\n");
+				__acpi_power_off(resource);
+			}
 		}
 
 		mutex_unlock(&resource->resource_lock);
@@ -918,4 +954,3 @@ void acpi_turn_off_unused_power_resources(void)
 
 	mutex_unlock(&power_resource_list_lock);
 }
-#endif
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 403c4ff153498..fb6b3ca0eeb91 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -75,6 +75,9 @@ static int acpi_sleep_prepare(u32 acpi_state)
 	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
 		acpi_state);
 	acpi_enable_wakeup_devices(acpi_state);
+
+	acpi_turn_off_power_resources(acpi_state);
+
 	acpi_enter_sleep_state_prep(acpi_state);
 	return 0;
 }
@@ -524,7 +527,7 @@ static void acpi_pm_start(u32 acpi_state)
  */
 static void acpi_pm_end(void)
 {
-	acpi_turn_off_unused_power_resources();
+	acpi_turn_off_power_resources(ACPI_STATE_S0);
 	acpi_scan_lock_release();
 	/*
 	 * This is necessary in case acpi_pm_finish() is not called during a
diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index 41675d24a9bc0..a495c91e2bf3b 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -7,7 +7,7 @@ extern struct list_head acpi_wakeup_device_list;
 extern struct mutex acpi_device_lock;
 
 extern void acpi_resume_power_resources(void);
-extern void acpi_turn_off_unused_power_resources(void);
+extern void acpi_turn_off_power_resources(int acpi_system_state);
 
 static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
 {
-- 
2.21.0.593.g511ec345e18-goog

