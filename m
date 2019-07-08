Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C04CC606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485822064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YGLom24z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfGHM6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:58:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbfGHM6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:58:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x68CwBDY1420210
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 8 Jul 2019 05:58:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x68CwBDY1420210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562590692;
        bh=FB9NrRyV07bsPT5oBT0kBs+6BMSUma7tcLgph6Y/eKI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YGLom24z/An3CkY1yZy1oMiIc/L7apGySx+XFTx8zzZFEFJIn0DCN47gOfZOcgVUu
         goyWXDFW0YxhjG7z7TpUzafs5XYM4cwmXt3ItG74UxO68nBHMBIUtrWiv8Rnm6rdvt
         UIAI+ePHl+lsYFQICqfWsNh+HmrqFr0QjAyCoEOT7euy0s9yt+wBdn5db5+seVotqx
         zAPZ6w9Kgdo02V2+oxRy7knxRTeQhaL3nENyah7apff9cPmF/rFjUZm9LHK48b3B/t
         TDYpD/oEl+9V0TOmY/NXR2QB3me15SECbhLw8rPaP4YJfy5PQa2ZNfvwEWXEI6FdIJ
         WdlsLbCn6m+lw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x68CwB1d1420207;
        Mon, 8 Jul 2019 05:58:11 -0700
Date:   Mon, 8 Jul 2019 05:58:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-a12486641cddbe825d0441140c7f43e30096bf70@git.kernel.org>
Cc:     rdunlap@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tglx@linutronix.de, rdunlap@infradead.org
In-Reply-To: <9906a70d-7a4a-03a1-f555-07231570364d@infradead.org>
References: <9906a70d-7a4a-03a1-f555-07231570364d@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] cpu/hotplug: Fix CONFIG_SYSFS=n build errors
Git-Commit-ID: a12486641cddbe825d0441140c7f43e30096bf70
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a12486641cddbe825d0441140c7f43e30096bf70
Gitweb:     https://git.kernel.org/tip/a12486641cddbe825d0441140c7f43e30096bf70
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Wed, 3 Jul 2019 15:27:24 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 8 Jul 2019 14:52:27 +0200

cpu/hotplug: Fix CONFIG_SYSFS=n build errors

Following link errors happen when building a almost-allmodconfig but
CONFIG_SYSFS is not set/enabled:

 ld: arch/x86/power/cpu.o: in function `hibernate_resume_nonboot_cpu_disable':
 cpu.c:(.text+0x9f4): undefined reference to `cpuhp_smt_enable'
 ld: arch/x86/power/hibernate.o: in function `arch_resume_nosmt':
 hibernate.c:(.text+0x7f7): undefined reference to `cpuhp_smt_enable'
 ld: hibernate.c:(.text+0x809): undefined reference to `cpuhp_smt_disable'

The missing functions should not be inside #if CONFIG_SYSFS/#endif. Moving
them around and adjusting the #ifdeffery makes also the non-SYSFS stub for
__store_smt_control() obsolete.

No functional change.

Fixes: 98f8cdce1db5 ("cpu/hotplug: Add sysfs state interface")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/9906a70d-7a4a-03a1-f555-07231570364d@infradead.org
---
 kernel/cpu.c | 242 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 118 insertions(+), 124 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index ef1c565edc5d..1eec77e7950e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -376,7 +376,7 @@ static void lockdep_release_cpus_lock(void)
 {
 }
 
-#endif	/* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_HOTPLUG_CPU */
 
 /*
  * Architectures that need SMT-specific errata handling during SMT hotplug
@@ -1892,6 +1892,123 @@ void __cpuhp_remove_state(enum cpuhp_state state, bool invoke)
 }
 EXPORT_SYMBOL(__cpuhp_remove_state);
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+static void cpuhp_offline_cpu_device(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	dev->offline = true;
+	/* Tell user space about the state change */
+	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
+}
+
+static void cpuhp_online_cpu_device(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	dev->offline = false;
+	/* Tell user space about the state change */
+	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+}
+
+int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
+{
+	int cpu, ret = 0;
+
+	cpu_maps_update_begin();
+	for_each_online_cpu(cpu) {
+		if (topology_is_primary_thread(cpu))
+			continue;
+		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
+		if (ret)
+			break;
+		/*
+		 * As this needs to hold the cpu maps lock it's impossible
+		 * to call device_offline() because that ends up calling
+		 * cpu_down() which takes cpu maps lock. cpu maps lock
+		 * needs to be held as this might race against in kernel
+		 * abusers of the hotplug machinery (thermal management).
+		 *
+		 * So nothing would update device:offline state. That would
+		 * leave the sysfs entry stale and prevent onlining after
+		 * smt control has been changed to 'off' again. This is
+		 * called under the sysfs hotplug lock, so it is properly
+		 * serialized against the regular offline usage.
+		 */
+		cpuhp_offline_cpu_device(cpu);
+	}
+	if (!ret)
+		cpu_smt_control = ctrlval;
+	cpu_maps_update_done();
+	return ret;
+}
+
+int cpuhp_smt_enable(void)
+{
+	int cpu, ret = 0;
+
+	cpu_maps_update_begin();
+	cpu_smt_control = CPU_SMT_ENABLED;
+	for_each_present_cpu(cpu) {
+		/* Skip online CPUs and CPUs on offline nodes */
+		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
+			continue;
+		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
+		if (ret)
+			break;
+		/* See comment in cpuhp_smt_disable() */
+		cpuhp_online_cpu_device(cpu);
+	}
+	cpu_maps_update_done();
+	return ret;
+}
+
+#if defined(CONFIG_HOTPLUG_SMT) && defined(CONFIG_SYSFS)
+static ssize_t
+__store_smt_control(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	int ctrlval, ret;
+
+	if (sysfs_streq(buf, "on"))
+		ctrlval = CPU_SMT_ENABLED;
+	else if (sysfs_streq(buf, "off"))
+		ctrlval = CPU_SMT_DISABLED;
+	else if (sysfs_streq(buf, "forceoff"))
+		ctrlval = CPU_SMT_FORCE_DISABLED;
+	else
+		return -EINVAL;
+
+	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
+		return -EPERM;
+
+	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		return -ENODEV;
+
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		return ret;
+
+	if (ctrlval != cpu_smt_control) {
+		switch (ctrlval) {
+		case CPU_SMT_ENABLED:
+			ret = cpuhp_smt_enable();
+			break;
+		case CPU_SMT_DISABLED:
+		case CPU_SMT_FORCE_DISABLED:
+			ret = cpuhp_smt_disable(ctrlval);
+			break;
+		}
+	}
+
+	unlock_device_hotplug();
+	return ret ? ret : count;
+}
+#endif /* CONFIG_HOTPLUG_SMT && CONFIG_SYSFS */
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
 #if defined(CONFIG_SYSFS) && defined(CONFIG_HOTPLUG_CPU)
 static ssize_t show_cpuhp_state(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -2044,129 +2161,6 @@ static const struct attribute_group cpuhp_cpu_root_attr_group = {
 	NULL
 };
 
-#ifdef CONFIG_HOTPLUG_SMT
-
-static void cpuhp_offline_cpu_device(unsigned int cpu)
-{
-	struct device *dev = get_cpu_device(cpu);
-
-	dev->offline = true;
-	/* Tell user space about the state change */
-	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
-}
-
-static void cpuhp_online_cpu_device(unsigned int cpu)
-{
-	struct device *dev = get_cpu_device(cpu);
-
-	dev->offline = false;
-	/* Tell user space about the state change */
-	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
-}
-
-int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
-{
-	int cpu, ret = 0;
-
-	cpu_maps_update_begin();
-	for_each_online_cpu(cpu) {
-		if (topology_is_primary_thread(cpu))
-			continue;
-		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
-		if (ret)
-			break;
-		/*
-		 * As this needs to hold the cpu maps lock it's impossible
-		 * to call device_offline() because that ends up calling
-		 * cpu_down() which takes cpu maps lock. cpu maps lock
-		 * needs to be held as this might race against in kernel
-		 * abusers of the hotplug machinery (thermal management).
-		 *
-		 * So nothing would update device:offline state. That would
-		 * leave the sysfs entry stale and prevent onlining after
-		 * smt control has been changed to 'off' again. This is
-		 * called under the sysfs hotplug lock, so it is properly
-		 * serialized against the regular offline usage.
-		 */
-		cpuhp_offline_cpu_device(cpu);
-	}
-	if (!ret)
-		cpu_smt_control = ctrlval;
-	cpu_maps_update_done();
-	return ret;
-}
-
-int cpuhp_smt_enable(void)
-{
-	int cpu, ret = 0;
-
-	cpu_maps_update_begin();
-	cpu_smt_control = CPU_SMT_ENABLED;
-	for_each_present_cpu(cpu) {
-		/* Skip online CPUs and CPUs on offline nodes */
-		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
-			continue;
-		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
-		if (ret)
-			break;
-		/* See comment in cpuhp_smt_disable() */
-		cpuhp_online_cpu_device(cpu);
-	}
-	cpu_maps_update_done();
-	return ret;
-}
-
-
-static ssize_t
-__store_smt_control(struct device *dev, struct device_attribute *attr,
-		    const char *buf, size_t count)
-{
-	int ctrlval, ret;
-
-	if (sysfs_streq(buf, "on"))
-		ctrlval = CPU_SMT_ENABLED;
-	else if (sysfs_streq(buf, "off"))
-		ctrlval = CPU_SMT_DISABLED;
-	else if (sysfs_streq(buf, "forceoff"))
-		ctrlval = CPU_SMT_FORCE_DISABLED;
-	else
-		return -EINVAL;
-
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
-		return -EPERM;
-
-	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
-		return -ENODEV;
-
-	ret = lock_device_hotplug_sysfs();
-	if (ret)
-		return ret;
-
-	if (ctrlval != cpu_smt_control) {
-		switch (ctrlval) {
-		case CPU_SMT_ENABLED:
-			ret = cpuhp_smt_enable();
-			break;
-		case CPU_SMT_DISABLED:
-		case CPU_SMT_FORCE_DISABLED:
-			ret = cpuhp_smt_disable(ctrlval);
-			break;
-		}
-	}
-
-	unlock_device_hotplug();
-	return ret ? ret : count;
-}
-
-#else /* !CONFIG_HOTPLUG_SMT */
-static ssize_t
-__store_smt_control(struct device *dev, struct device_attribute *attr,
-		    const char *buf, size_t count)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_HOTPLUG_SMT */
-
 static const char *smt_states[] = {
 	[CPU_SMT_ENABLED]		= "on",
 	[CPU_SMT_DISABLED]		= "off",
