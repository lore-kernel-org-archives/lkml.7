Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD0CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EEF20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfJ3Pmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:42:43 -0400
Received: from foss.arm.com ([217.140.110.172]:36782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfJ3Pml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:42:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02F474F5;
        Wed, 30 Oct 2019 08:42:41 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 371303F6C4;
        Wed, 30 Oct 2019 08:42:39 -0700 (PDT)
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
Subject: [PATCH 12/12] cpu: Hide cpu_up/down
Date:   Wed, 30 Oct 2019 15:38:37 +0000
Message-Id: <20191030153837.18107-13-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030153837.18107-1-qais.yousef@arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
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
 kernel/cpu.c        | 26 ++++++++++++++++++++++----
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index cc37511de866..96c69c5fbfff 100644
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
index b1c7b788b8e9..6822e676f420 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -83,7 +83,7 @@ extern ssize_t arch_cpu_release(const char *, size_t);
 
 #ifdef CONFIG_SMP
 extern bool cpuhp_tasks_frozen;
-int cpu_up(unsigned int cpu);
+int cpu_subsys_up(struct device *dev);
 void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
@@ -114,7 +114,7 @@ extern void lockdep_assert_cpus_held(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
-int cpu_down(unsigned int cpu);
+int cpu_subsys_down(struct device *dev);
 
 #else /* CONFIG_HOTPLUG_CPU */
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e16695b841de..087c10dbfb99 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1045,11 +1045,20 @@ static int do_cpu_down(unsigned int cpu, enum cpuhp_state target)
 	return err;
 }
 
-int cpu_down(unsigned int cpu)
+static int cpu_down(unsigned int cpu)
 {
 	return do_cpu_down(cpu, CPUHP_OFFLINE);
 }
-EXPORT_SYMBOL(cpu_down);
+
+/*
+ * This function is meant to be used by device core cpu subsystem.
+ *
+ * Other subsystems should use device_offline(get_cpu_device(cpu)) instead.
+ */
+int cpu_subsys_down(struct device *dev)
+{
+	return cpu_down(dev->id);
+}
 
 #else
 #define takedown_cpu		NULL
@@ -1191,11 +1200,20 @@ static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
 	return err;
 }
 
-int cpu_up(unsigned int cpu)
+static int cpu_up(unsigned int cpu)
 {
 	return do_cpu_up(cpu, CPUHP_ONLINE);
 }
-EXPORT_SYMBOL_GPL(cpu_up);
+
+/*
+ * This function is meant to be used by device core cpu subsystem.
+ *
+ * Other subsystems should use device_online(get_cpu_device(cpu)) instead.
+ */
+int cpu_subsys_up(struct device *dev)
+{
+	return cpu_up(dev->id);
+}
 
 int hibernation_bringup_sleep_cpu(unsigned int sleep_cpu)
 {
-- 
2.17.1

