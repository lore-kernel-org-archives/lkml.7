Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D13AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F16720740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfKYL2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:28:30 -0500
Received: from foss.arm.com ([217.140.110.172]:49138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbfKYL21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:28:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F7771045;
        Mon, 25 Nov 2019 03:28:26 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7E313F52E;
        Mon, 25 Nov 2019 03:28:24 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eiichi Tsukata <devel@etsukata.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] cpu: Hide cpu_up/down
Date:   Mon, 25 Nov 2019 11:27:54 +0000
Message-Id: <20191125112754.25223-15-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125112754.25223-1-qais.yousef@arm.com>
References: <20191125112754.25223-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a special exported function for the device core to bring a cpu
up/down and hide the real cpu_up/down as they are treated as private
functions. cpu_up/down are lower level API and users outside the cpu
subsystem should use device_online/offline which will take care of extra
housekeeping work like keeping sysfs in sync.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Josh Poimboeuf <jpoimboe@redhat.com>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: Jiri Kosina <jkosina@suse.cz>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Eiichi Tsukata <devel@etsukata.com>
CC: Zhenzhong Duan <zhenzhong.duan@oracle.com>
CC: Ingo Molnar <mingo@kernel.org>
CC: Pavankumar Kondeti <pkondeti@codeaurora.org>
CC: linux-kernel@vger.kernel.org
---
 drivers/base/cpu.c  |  4 ++--
 include/linux/cpu.h |  4 ++--
 kernel/cpu.c        | 32 ++++++++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 6265871a4af2..9a134cd362ee 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -55,7 +55,7 @@ static int cpu_subsys_online(struct device *dev)
 	if (from_nid == NUMA_NO_NODE)
 		return -ENODEV;
 
-	ret = cpu_up(cpuid);
+	ret = cpu_subsys_up(dev);
 	/*
 	 * When hot adding memory to memoryless node and enabling a cpu
 	 * on the node, node number of the cpu may internally change.
@@ -69,7 +69,7 @@ static int cpu_subsys_online(struct device *dev)
 
 static int cpu_subsys_offline(struct device *dev)
 {
-	return cpu_down(dev->id);
+	return cpu_subsys_down(dev);
 }
 
 void unregister_cpu(struct cpu *cpu)
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index b5d9287899d1..bd9c5870c26f 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -88,7 +88,7 @@ extern ssize_t arch_cpu_release(const char *, size_t);
 
 #ifdef CONFIG_SMP
 extern bool cpuhp_tasks_frozen;
-int cpu_up(unsigned int cpu);
+int cpu_subsys_up(struct device *dev);
 void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
@@ -119,7 +119,7 @@ extern void lockdep_assert_cpus_held(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
-int cpu_down(unsigned int cpu);
+int cpu_subsys_down(struct device *dev);
 extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
 
 #else /* CONFIG_HOTPLUG_CPU */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3631184a284f..8b29e0aa95ba 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1052,11 +1052,23 @@ static int do_cpu_down(unsigned int cpu, enum cpuhp_state target)
 	return err;
 }
 
-int cpu_down(unsigned int cpu)
+static int cpu_down(unsigned int cpu)
 {
 	return do_cpu_down(cpu, CPUHP_OFFLINE);
 }
-EXPORT_SYMBOL(cpu_down);
+
+/**
+ * cpu_subsys_down - Bring down a cpu device
+ * @dev: Pointer to the cpu device to offline
+ *
+ * This function is meant to be used by device core cpu subsystem only.
+ *
+ * Other subsystems should use device_offline(get_cpu_device(cpu)) instead.
+ */
+int cpu_subsys_down(struct device *dev)
+{
+	return cpu_down(dev->id);
+}
 
 void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 {
@@ -1215,11 +1227,23 @@ static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
 	return err;
 }
 
-int cpu_up(unsigned int cpu)
+static int cpu_up(unsigned int cpu)
 {
 	return do_cpu_up(cpu, CPUHP_ONLINE);
 }
-EXPORT_SYMBOL_GPL(cpu_up);
+
+/**
+ * cpu_subsys_up - Bring up a cpu device
+ * @dev: Pointer to the cpu device to online
+ *
+ * This function is meant to be used by device core cpu subsystem only.
+ *
+ * Other subsystems should use device_online(get_cpu_device(cpu)) instead.
+ */
+int cpu_subsys_up(struct device *dev)
+{
+	return cpu_up(dev->id);
+}
 
 /**
  * bringup_hibernate_cpu - Bring up the CPU that we hibernated on
-- 
2.17.1

