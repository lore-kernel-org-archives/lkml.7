Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CCEC072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AB8214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfE0KpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:45:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44511 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0KpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:45:21 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 294efc5ec800b2d8; Mon, 27 May 2019 12:45:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] PM: sleep: Add kerneldoc comments to some functions
Date:   Mon, 27 May 2019 12:45:18 +0200
Message-ID: <36259828.LPqo0PWuvG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add kerneldoc comments to pm_suspend_via_firmware(),
pm_resume_via_firmware() and pm_suspend_via_s2idle() to explain
what they do.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
  Put more information into the pm_suspend_via_firmware() kerneldoc comment.

---
 include/linux/suspend.h |   31 +++++++++++++++++++++++++++++++
 kernel/power/suspend.c  |    6 ++++++
 2 files changed, 37 insertions(+)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -227,11 +227,42 @@ static inline void pm_set_resume_via_fir
 	pm_suspend_global_flags |= PM_SUSPEND_FLAG_FW_RESUME;
 }
 
+/**
+ * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
+ *
+ * To be called during system-wide power management transitions to sleep states
+ * or during the subsequent system-wide transitions back to the working state.
+ *
+ * Return 'true' if the platform firmware is going to be invoked at the end of
+ * the system-wide power management transition (to a sleep state) in progress in
+ * order to complete it, or if the platform firmware has been invoked in order
+ * to complete the last (or preceding) transition of the system to a sleep
+ * state.
+ *
+ * This matters if the caller needs or wants to carry out some special actions
+ * depending on whether or not control will be passed to the platform firmware
+ * subsequently (for example, the device may need to be reset before letting the
+ * platform firmware manipulate it, which is not necessary when the platform
+ * firmware is not going to be invoked) or when such special actions may have
+ * been carried out during the preceding transition of the system to a sleep
+ * state (as they may need to be taken into account).
+ */
 static inline bool pm_suspend_via_firmware(void)
 {
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_SUSPEND);
 }
 
+/**
+ * pm_resume_via_firmware - Check if platform firmware has woken up the system.
+ *
+ * To be called during system-wide power management transitions from sleep
+ * states.
+ *
+ * Return 'true' if the platform firmware has passed control to the kernel at
+ * the beginning of the system-wide power management transition in progress, so
+ * the event that woke up the system from sleep has been handled by the platform
+ * firmware.
+ */
 static inline bool pm_resume_via_firmware(void)
 {
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_RESUME);
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -62,6 +62,12 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_w
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+/**
+ * pm_suspend_via_s2idle - Check if suspend-to-idle is the default suspend.
+ *
+ * Return 'true' if suspend-to-idle has been selected as the default system
+ * suspend method.
+ */
 bool pm_suspend_via_s2idle(void)
 {
 	return mem_sleep_current == PM_SUSPEND_TO_IDLE;



