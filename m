Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B321C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636E92087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfC0MAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:00:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbfC0MAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:00:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32E958831D;
        Wed, 27 Mar 2019 12:00:51 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-253.rdu2.redhat.com [10.10.120.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EBD55DE69;
        Wed, 27 Mar 2019 12:00:50 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH v2] cpu/hotplug: Create SMT sysfs interface for all arches
Date:   Wed, 27 Mar 2019 07:00:29 -0500
Message-Id: <469c2b98055f2c41e75748e06447d592a64080c9.1553635520.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 27 Mar 2019 12:00:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the /sys/devices/system/cpu/smt/* files available on all arches, so
user space has a consistent way to detect whether SMT is enabled.

The 'control' file now shows 'notimplemented' for architectures which
don't yet have CONFIG_HOTPLUG_SMT.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
v2: add "notimplemented" pseudo-state [tglx]

 .../ABI/testing/sysfs-devices-system-cpu      | 10 +--
 include/linux/cpu.h                           |  2 +-
 kernel/cpu.c                                  | 72 +++++++++++--------
 3 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 9605dbd4b5b5..5eea46fefcb2 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -511,10 +511,12 @@ Description:	Control Symetric Multi Threading (SMT)
 		control: Read/write interface to control SMT. Possible
 			 values:
 
-			 "on"		SMT is enabled
-			 "off"		SMT is disabled
-			 "forceoff"	SMT is force disabled. Cannot be changed.
-			 "notsupported" SMT is not supported by the CPU
+			 "on"		  SMT is enabled
+			 "off"		  SMT is disabled
+			 "forceoff"	  SMT is force disabled. Cannot be changed.
+			 "notsupported"   SMT is not supported by the CPU
+			 "notimplemented" SMT runtime toggling is not
+					  implemented for the architecture
 
 			 If control status is "forceoff" or "notsupported" writes
 			 are rejected.
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5041357d0297..296753249343 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -182,7 +182,7 @@ extern enum cpuhp_smt_control cpu_smt_control;
 extern void cpu_smt_disable(bool force);
 extern void cpu_smt_check_topology(void);
 #else
-# define cpu_smt_control		(CPU_SMT_ENABLED)
+# define cpu_smt_control		(CPU_SMT_NOT_SUPPORTED)
 static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f69ba38573c2..b0614263963b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2019,19 +2019,6 @@ static const struct attribute_group cpuhp_cpu_root_attr_group = {
 
 #ifdef CONFIG_HOTPLUG_SMT
 
-static const char *smt_states[] = {
-	[CPU_SMT_ENABLED]		= "on",
-	[CPU_SMT_DISABLED]		= "off",
-	[CPU_SMT_FORCE_DISABLED]	= "forceoff",
-	[CPU_SMT_NOT_SUPPORTED]		= "notsupported",
-};
-
-static ssize_t
-show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", smt_states[cpu_smt_control]);
-}
-
 static void cpuhp_offline_cpu_device(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
@@ -2102,9 +2089,10 @@ static int cpuhp_smt_enable(void)
 	return ret;
 }
 
+
 static ssize_t
-store_smt_control(struct device *dev, struct device_attribute *attr,
-		  const char *buf, size_t count)
+__store_smt_control(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
 {
 	int ctrlval, ret;
 
@@ -2120,9 +2108,6 @@ store_smt_control(struct device *dev, struct device_attribute *attr,
 	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
 		return -EPERM;
 
-	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		return -ENODEV;
-
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
 		return ret;
@@ -2142,14 +2127,49 @@ store_smt_control(struct device *dev, struct device_attribute *attr,
 	unlock_device_hotplug();
 	return ret ? ret : count;
 }
+
+#else /* !CONFIG_HOTPLUG_SMT */
+static ssize_t
+__store_smt_control(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	return 0;
+}
+#endif /* CONFIG_HOTPLUG_SMT */
+
+static const char *smt_states[] = {
+	[CPU_SMT_ENABLED]		= "on",
+	[CPU_SMT_DISABLED]		= "off",
+	[CPU_SMT_FORCE_DISABLED]	= "forceoff",
+	[CPU_SMT_NOT_SUPPORTED]		= "notsupported",
+};
+
+static ssize_t
+show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	const char *state = IS_ENABLED(CONFIG_HOTPLUG_SMT) ?
+				smt_states[cpu_smt_control] :
+				"notimplemented";
+
+	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+}
+
+static ssize_t
+store_smt_control(struct device *dev, struct device_attribute *attr,
+		  const char *buf, size_t count)
+{
+
+	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		return -ENODEV;
+
+	return __store_smt_control(dev, attr, buf, count);
+}
 static DEVICE_ATTR(control, 0644, show_smt_control, store_smt_control);
 
 static ssize_t
 show_smt_active(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	bool active = topology_max_smt_threads() > 1;
-
-	return snprintf(buf, PAGE_SIZE - 2, "%d\n", active);
+	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
 }
 static DEVICE_ATTR(active, 0444, show_smt_active, NULL);
 
@@ -2165,21 +2185,17 @@ static const struct attribute_group cpuhp_smt_attr_group = {
 	NULL
 };
 
-static int __init cpu_smt_state_init(void)
+static int __init cpu_smt_sysfs_init(void)
 {
 	return sysfs_create_group(&cpu_subsys.dev_root->kobj,
 				  &cpuhp_smt_attr_group);
 }
 
-#else
-static inline int cpu_smt_state_init(void) { return 0; }
-#endif
-
 static int __init cpuhp_sysfs_init(void)
 {
 	int cpu, ret;
 
-	ret = cpu_smt_state_init();
+	ret = cpu_smt_sysfs_init();
 	if (ret)
 		return ret;
 
@@ -2200,7 +2216,7 @@ static int __init cpuhp_sysfs_init(void)
 	return 0;
 }
 device_initcall(cpuhp_sysfs_init);
-#endif
+#endif /* CONFIG_SYSFS && CONFIG_HOTPLUG_CPU */
 
 /*
  * cpu_bit_bitmap[] is a special, "compressed" data structure that
-- 
2.17.2

