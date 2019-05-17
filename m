Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23765C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E808520879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfEQK4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:56:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42786 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfEQK4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:56:05 -0400
Received: from 79.184.255.148.ipv4.supernova.orange.pl (79.184.255.148) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id b11b04b4fbd0f617; Fri, 17 May 2019 12:56:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] PM: sleep: Add kerneldoc comments to some functions
Date:   Fri, 17 May 2019 12:56:01 +0200
Message-ID: <11319987.O9o76ZdvQC@kreacher>
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
 include/linux/suspend.h |   20 ++++++++++++++++++++
 kernel/power/suspend.c  |    6 ++++++
 2 files changed, 26 insertions(+)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -227,11 +227,31 @@ static inline void pm_set_resume_via_fir
 	pm_suspend_global_flags |= PM_SUSPEND_FLAG_FW_RESUME;
 }
 
+/**
+ * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
+ *
+ * To be called during system-wide power management transitions to sleep states.
+ *
+ * Return 'true' if the platform firmware is going to be invoked at the end of
+ * the system-wide power management transition in progress in order to complete
+ * it.
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



