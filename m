Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0428C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806602186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610490;
	bh=FQJgoyTh0UdQvIaotCQkrR/AfZAly8xdJ8Wz/lrLT9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=teS13hczBhU/HJWxA6Du+wlLQAMOS2vZdtvlYl4FigYjju2T5TLHDY8QXNlLxYb3p
	 UGlD3HTtt3SDIHosIZuG/zj+M99kgKgi6/owqiEuuqbZQS42Rgi8gYxmkHPlf7MGvb
	 +HhMW3MOGCzOSeQ9Tey8C5gc8mpTa4p8fCb5wzsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390150AbfDRSB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390536AbfDRSBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:01:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487F6217FA;
        Thu, 18 Apr 2019 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610482;
        bh=FQJgoyTh0UdQvIaotCQkrR/AfZAly8xdJ8Wz/lrLT9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yKmrnPCG4fC0kGvA3fdkV7LiVcngUuDFNI2UESsA6+68tz+r41RVKSkPB1iOVir9X
         ifVhgNyHqGuARlnshXX4bzkhk47uWxA83rZuncp77a4JP2jp4ePNFXFMiAu+CSg+hw
         UxJRFtHyShQgBOSwp1kKjMJirUG72OHc2lYdn8Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/110] kernel: hung_task.c: disable on suspend
Date:   Thu, 18 Apr 2019 19:57:07 +0200
Message-Id: <20190418160445.555719161@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 9eca2371f189..4a9191617076 100644
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
@@ -240,6 +241,28 @@ void reset_hung_task_detector(void)
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
@@ -259,7 +282,8 @@ static int watchdog(void *dummy)
 		interval = min_t(unsigned long, interval, timeout);
 		t = hung_timeout_jiffies(hung_last_checked, interval);
 		if (t <= 0) {
-			if (!atomic_xchg(&reset_hung_task, 0))
+			if (!atomic_xchg(&reset_hung_task, 0) &&
+			    !hung_detector_suspended)
 				check_hung_uninterruptible_tasks(timeout);
 			hung_last_checked = jiffies;
 			continue;
@@ -273,6 +297,10 @@ static int watchdog(void *dummy)
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



