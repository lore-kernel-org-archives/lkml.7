Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4853C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B382183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909827;
	bh=oQK+PqcDmsh8f+MRbwJf1u0jn/nzMt3sN1hTQ8NT2ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CYJttD7kV9eiDaAj2sWkKPpvTU9WMpaERJfG3rQI8bLZIueT2knruH+hBClicPcXM
	 SdssQZRXX7Zmooer5hpM/xjsWUB1u8axzhhnjqyo1lpXUNEVmzwobGYRgjo/JvUIPs
	 U/MV0ARRLjpCTDM6A5Q9orW2/LEjTPbhZHLCj0rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbfC3BhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731798AbfC3Ba7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 223AF218D8;
        Sat, 30 Mar 2019 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909458;
        bh=oQK+PqcDmsh8f+MRbwJf1u0jn/nzMt3sN1hTQ8NT2ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAnkbpYBrqCQScNHXHyCBq9iRsHNVxNKjRzeX3ov+YRF8zQKhg7xBu0xzupFV9sX0
         8AzUJZa48RTjRrPZ+v+XlMrv1dm4JxcFDuuRuKtcjfPA4Be3a0JdsyQSlzeXnC8e1t
         Jv7JaIdv0KzbjyCfrKN0wK/RKsGBfKyd9OLaqlGA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 17/37] kernel: hung_task.c: disable on suspend
Date:   Fri, 29 Mar 2019 21:30:00 -0400
Message-Id: <20190330013020.379-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit a1c6ca3c6de763459a6e93b644ec6518c890ba1c ]

It is possible to observe hung_task complaints when system goes to
suspend-to-idle state:

 # echo freeze > /sys/power/state

 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.001 seconds) done.
 OOM killer disabled.
 Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
 sd 0:0:0:0: [sda] Synchronizing SCSI cache
 INFO: task bash:1569 blocked for more than 120 seconds.
       Not tainted 4.19.0-rc3_+ #687
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 bash            D    0  1569    604 0x00000000
 Call Trace:
  ? __schedule+0x1fe/0x7e0
  schedule+0x28/0x80
  suspend_devices_and_enter+0x4ac/0x750
  pm_suspend+0x2c0/0x310

Register a PM notifier to disable the detector on suspend and re-enable
back on wakeup.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/hung_task.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index f9aaf4994062..2e4869fa66c9 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -15,6 +15,7 @@
 #include <linux/lockdep.h>
 #include <linux/export.h>
 #include <linux/sysctl.h>
+#include <linux/suspend.h>
 #include <linux/utsname.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
@@ -232,6 +233,28 @@ void reset_hung_task_detector(void)
 }
 EXPORT_SYMBOL_GPL(reset_hung_task_detector);
 
+static bool hung_detector_suspended;
+
+static int hungtask_pm_notify(struct notifier_block *self,
+			      unsigned long action, void *hcpu)
+{
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		hung_detector_suspended = true;
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		hung_detector_suspended = false;
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
 /*
  * kthread which checks for tasks stuck in D state
  */
@@ -246,7 +269,8 @@ static int watchdog(void *dummy)
 		long t = hung_timeout_jiffies(hung_last_checked, timeout);
 
 		if (t <= 0) {
-			if (!atomic_xchg(&reset_hung_task, 0))
+			if (!atomic_xchg(&reset_hung_task, 0) &&
+			    !hung_detector_suspended)
 				check_hung_uninterruptible_tasks(timeout);
 			hung_last_checked = jiffies;
 			continue;
@@ -260,6 +284,10 @@ static int watchdog(void *dummy)
 static int __init hung_task_init(void)
 {
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
+
+	/* Disable hung task detector on suspend */
+	pm_notifier(hungtask_pm_notify, 0);
+
 	watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
 
 	return 0;
-- 
2.19.1

