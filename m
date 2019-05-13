Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AC6C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5806421473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770409;
	bh=Stfls3awoJsv3T+e9vmINlxw4mUIYk8wea2H9QRFTa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Os6Wpu9W/C+umEXBi9/oKHIh7HSPnhTNfYZC4CdrVT4VO8X2Aztqlkit254bwlL28
	 H+cF7eYsmKwmwHJkjyRgeb8TUFieDEbnIO1BcwVFuNAd/1mkyoa3HNYRszl0RvzEcO
	 Ki7VMPXWvLV+Jlil0HTbyllPlxjw9W8lIlI8n7qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbfEMSAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:00:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36635 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbfEMR7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so7156482pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=Dx804oXotrdBCjDYRi4vm3VGxxsLjZ4ijasSE6Np2js=;
        b=rSMjA06ExLXFsNMJ+GeirSAf4ZzjqPqoxyEEhpC2SI/L8/wmwt3HlmVmW17cy2xyYg
         muRY7Vxf8Nx4qMsD3REKEhGX8JJzQk8T7bfVw5Oddc9hUkd1con3WajQoQNwCNp5ElyF
         41C3aA6mHb7R08pAkfETECtxKzAREb13DWDY3R5sWM8o7g3itHhoX6f/2Fa+tubgmB9a
         pd3k7S0WZEwR2MrmubPza21PsgTH/MIXM7tbMSU63Ff05r3bZD/6fsrRR8Itzgo9we2m
         /J1je1b8YtaQOvmx1FLgdVKQaShKs0yeBMwj5Ut0j8au+n0XXf9kjSx88/6L3wA+M9Gu
         gzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=Dx804oXotrdBCjDYRi4vm3VGxxsLjZ4ijasSE6Np2js=;
        b=GbXXb3iXqjdnxTG5OvHR9r7mFrm8fTz7Tbp9/gozCBNiUOoFTqocRzhPc+xiE2tQjG
         K1WZemn3UALjzKMe/68bvers4US2aUh8d+OFd3GgPo80LPUYJbijE0tGwbj9Bi1C/pn7
         DRbWTPhIYoYl560Zl/aA4ErJWCAqDf040EEiiqL7tf0vPHyjvgHDcAVjBeygmLkrlOFa
         rk1mjdfVEkAyYUklvHRh0Y0Rz0ReocOcZFVWo9ONY3qp4fcGxbUKkQAlozVrRp5WjGES
         JBMF8cfk/NAcofeK4jMggScfbmimvTGPk1x/1bUwYGDESgwToVqnMepp5JCPVTaCjCMi
         vXPQ==
X-Gm-Message-State: APjAAAUkkfC18QQXS0Po2THoxBlGH0TaQlBuKxNYC23H41IBIjXsX6wu
        C8EWtiCLl3Gh53dHg1FUWRML6kKy
X-Google-Smtp-Source: APXvYqyjidUQZ8Guw5Vf4f6GIxYipMCsPlMhad6tUjPSV/DcypBVqH7HzeSmQBwuFEx+qzNO7p74XA==
X-Received: by 2002:aa7:8d98:: with SMTP id i24mr35629970pfr.8.1557770379132;
        Mon, 13 May 2019 10:59:39 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:38 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 16/19] thermal/x86_pkg_temp_thermal: Cosmetic: Rename internal variables to zones from packages
Date:   Mon, 13 May 2019 13:59:00 -0400
Message-Id: <b65494a76be13481dc3a809c75debb2574c34eda.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax update only -- no logical or functional change.

In response to the new multi-die/package changes, update variable names
to use the more generic thermal "zone" terminology, instead of "package",
as the zones can refer to either packages or die.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 142 ++++++++++---------
 1 file changed, 72 insertions(+), 70 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 405b3858900a..87e929ffb0cb 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -55,7 +55,7 @@ MODULE_PARM_DESC(notify_delay_ms,
 */
 #define MAX_NUMBER_OF_TRIPS	2
 
-struct pkg_device {
+struct zone_device {
 	int				cpu;
 	bool				work_scheduled;
 	u32				tj_max;
@@ -70,10 +70,10 @@ static struct thermal_zone_params pkg_temp_tz_params = {
 	.no_hwmon	= true,
 };
 
-/* Keep track of how many package pointers we allocated in init() */
-static int max_packages __read_mostly;
-/* Array of package pointers */
-static struct pkg_device **packages;
+/* Keep track of how many zone pointers we allocated in init() */
+static int max_id __read_mostly;
+/* Array of zone pointers */
+static struct zone_device **zones;
 /* Serializes interrupt notification, work and hotplug */
 static DEFINE_SPINLOCK(pkg_temp_lock);
 /* Protects zone operation in the work function against hotplug removal */
@@ -120,12 +120,12 @@ static int pkg_temp_debugfs_init(void)
  *
  * - Other callsites: Must hold pkg_temp_lock
  */
-static struct pkg_device *pkg_temp_thermal_get_dev(unsigned int cpu)
+static struct zone_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 {
-	int pkgid = topology_logical_die_id(cpu);
+	int id = topology_logical_die_id(cpu);
 
-	if (pkgid >= 0 && pkgid < max_packages)
-		return packages[pkgid];
+	if (id >= 0 && id < max_id)
+		return zones[id];
 	return NULL;
 }
 
@@ -150,12 +150,13 @@ static int get_tj_max(int cpu, u32 *tj_max)
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 {
-	struct pkg_device *pkgdev = tzd->devdata;
+	struct zone_device *zonedev = tzd->devdata;
 	u32 eax, edx;
 
-	rdmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_STATUS, &eax, &edx);
+	rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_STATUS,
+			&eax, &edx);
 	if (eax & 0x80000000) {
-		*temp = pkgdev->tj_max - ((eax >> 16) & 0x7f) * 1000;
+		*temp = zonedev->tj_max - ((eax >> 16) & 0x7f) * 1000;
 		pr_debug("sys_get_curr_temp %d\n", *temp);
 		return 0;
 	}
@@ -165,7 +166,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 static int sys_get_trip_temp(struct thermal_zone_device *tzd,
 			     int trip, int *temp)
 {
-	struct pkg_device *pkgdev = tzd->devdata;
+	struct zone_device *zonedev = tzd->devdata;
 	unsigned long thres_reg_value;
 	u32 mask, shift, eax, edx;
 	int ret;
@@ -181,14 +182,14 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzd,
 		shift = THERM_SHIFT_THRESHOLD0;
 	}
 
-	ret = rdmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			   &eax, &edx);
 	if (ret < 0)
 		return ret;
 
 	thres_reg_value = (eax & mask) >> shift;
 	if (thres_reg_value)
-		*temp = pkgdev->tj_max - thres_reg_value * 1000;
+		*temp = zonedev->tj_max - thres_reg_value * 1000;
 	else
 		*temp = 0;
 	pr_debug("sys_get_trip_temp %d\n", *temp);
@@ -199,14 +200,14 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzd,
 static int
 sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
-	struct pkg_device *pkgdev = tzd->devdata;
+	struct zone_device *zonedev = tzd->devdata;
 	u32 l, h, mask, shift, intr;
 	int ret;
 
-	if (trip >= MAX_NUMBER_OF_TRIPS || temp >= pkgdev->tj_max)
+	if (trip >= MAX_NUMBER_OF_TRIPS || temp >= zonedev->tj_max)
 		return -EINVAL;
 
-	ret = rdmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			   &l, &h);
 	if (ret < 0)
 		return ret;
@@ -228,11 +229,12 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 	if (!temp) {
 		l &= ~intr;
 	} else {
-		l |= (pkgdev->tj_max - temp)/1000 << shift;
+		l |= (zonedev->tj_max - temp)/1000 << shift;
 		l |= intr;
 	}
 
-	return wrmsr_on_cpu(pkgdev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	return wrmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			l, h);
 }
 
 static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
@@ -287,26 +289,26 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 {
 	struct thermal_zone_device *tzone = NULL;
 	int cpu = smp_processor_id();
-	struct pkg_device *pkgdev;
+	struct zone_device *zonedev;
 	u64 msr_val, wr_val;
 
 	mutex_lock(&thermal_zone_mutex);
 	spin_lock_irq(&pkg_temp_lock);
 	++pkg_work_cnt;
 
-	pkgdev = pkg_temp_thermal_get_dev(cpu);
-	if (!pkgdev) {
+	zonedev = pkg_temp_thermal_get_dev(cpu);
+	if (!zonedev) {
 		spin_unlock_irq(&pkg_temp_lock);
 		mutex_unlock(&thermal_zone_mutex);
 		return;
 	}
-	pkgdev->work_scheduled = false;
+	zonedev->work_scheduled = false;
 
 	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
 	wr_val = msr_val & ~(THERM_LOG_THRESHOLD0 | THERM_LOG_THRESHOLD1);
 	if (wr_val != msr_val) {
 		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, wr_val);
-		tzone = pkgdev->tzone;
+		tzone = zonedev->tzone;
 	}
 
 	enable_pkg_thres_interrupt();
@@ -332,7 +334,7 @@ static void pkg_thermal_schedule_work(int cpu, struct delayed_work *work)
 static int pkg_thermal_notify(u64 msr_val)
 {
 	int cpu = smp_processor_id();
-	struct pkg_device *pkgdev;
+	struct zone_device *zonedev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&pkg_temp_lock, flags);
@@ -341,10 +343,10 @@ static int pkg_thermal_notify(u64 msr_val)
 	disable_pkg_thres_interrupt();
 
 	/* Work is per package, so scheduling it once is enough. */
-	pkgdev = pkg_temp_thermal_get_dev(cpu);
-	if (pkgdev && !pkgdev->work_scheduled) {
-		pkgdev->work_scheduled = true;
-		pkg_thermal_schedule_work(pkgdev->cpu, &pkgdev->work);
+	zonedev = pkg_temp_thermal_get_dev(cpu);
+	if (zonedev && !zonedev->work_scheduled) {
+		zonedev->work_scheduled = true;
+		pkg_thermal_schedule_work(zonedev->cpu, &zonedev->work);
 	}
 
 	spin_unlock_irqrestore(&pkg_temp_lock, flags);
@@ -353,12 +355,12 @@ static int pkg_thermal_notify(u64 msr_val)
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
-	int pkgid = topology_logical_die_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	u32 tj_max, eax, ebx, ecx, edx;
-	struct pkg_device *pkgdev;
+	struct zone_device *zonedev;
 	int thres_count, err;
 
-	if (pkgid >= max_packages)
+	if (id >= max_id)
 		return -ENOMEM;
 
 	cpuid(6, &eax, &ebx, &ecx, &edx);
@@ -372,51 +374,51 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	if (err)
 		return err;
 
-	pkgdev = kzalloc(sizeof(*pkgdev), GFP_KERNEL);
-	if (!pkgdev)
+	zonedev = kzalloc(sizeof(*zonedev), GFP_KERNEL);
+	if (!zonedev)
 		return -ENOMEM;
 
-	INIT_DELAYED_WORK(&pkgdev->work, pkg_temp_thermal_threshold_work_fn);
-	pkgdev->cpu = cpu;
-	pkgdev->tj_max = tj_max;
-	pkgdev->tzone = thermal_zone_device_register("x86_pkg_temp",
+	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
+	zonedev->cpu = cpu;
+	zonedev->tj_max = tj_max;
+	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
 			thres_count,
 			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
-			pkgdev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
-	if (IS_ERR(pkgdev->tzone)) {
-		err = PTR_ERR(pkgdev->tzone);
-		kfree(pkgdev);
+			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
+	if (IS_ERR(zonedev->tzone)) {
+		err = PTR_ERR(zonedev->tzone);
+		kfree(zonedev);
 		return err;
 	}
 	/* Store MSR value for package thermal interrupt, to restore at exit */
-	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, pkgdev->msr_pkg_therm_low,
-	      pkgdev->msr_pkg_therm_high);
+	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm_low,
+	      zonedev->msr_pkg_therm_high);
 
-	cpumask_set_cpu(cpu, &pkgdev->cpumask);
+	cpumask_set_cpu(cpu, &zonedev->cpumask);
 	spin_lock_irq(&pkg_temp_lock);
-	packages[pkgid] = pkgdev;
+	zones[id] = zonedev;
 	spin_unlock_irq(&pkg_temp_lock);
 	return 0;
 }
 
 static int pkg_thermal_cpu_offline(unsigned int cpu)
 {
-	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
+	struct zone_device *zonedev = pkg_temp_thermal_get_dev(cpu);
 	bool lastcpu, was_target;
 	int target;
 
-	if (!pkgdev)
+	if (!zonedev)
 		return 0;
 
-	target = cpumask_any_but(&pkgdev->cpumask, cpu);
-	cpumask_clear_cpu(cpu, &pkgdev->cpumask);
+	target = cpumask_any_but(&zonedev->cpumask, cpu);
+	cpumask_clear_cpu(cpu, &zonedev->cpumask);
 	lastcpu = target >= nr_cpu_ids;
 	/*
 	 * Remove the sysfs files, if this is the last cpu in the package
 	 * before doing further cleanups.
 	 */
 	if (lastcpu) {
-		struct thermal_zone_device *tzone = pkgdev->tzone;
+		struct thermal_zone_device *tzone = zonedev->tzone;
 
 		/*
 		 * We must protect against a work function calling
@@ -425,7 +427,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 		 * won't try to call.
 		 */
 		mutex_lock(&thermal_zone_mutex);
-		pkgdev->tzone = NULL;
+		zonedev->tzone = NULL;
 		mutex_unlock(&thermal_zone_mutex);
 
 		thermal_zone_device_unregister(tzone);
@@ -439,8 +441,8 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	 * one. When we drop the lock, then the interrupt notify function
 	 * will see the new target.
 	 */
-	was_target = pkgdev->cpu == cpu;
-	pkgdev->cpu = target;
+	was_target = zonedev->cpu == cpu;
+	zonedev->cpu = target;
 
 	/*
 	 * If this is the last CPU in the package remove the package
@@ -449,23 +451,23 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	 * worker will see the package anymore.
 	 */
 	if (lastcpu) {
-		packages[topology_logical_die_id(cpu)] = NULL;
+		zones[topology_logical_die_id(cpu)] = NULL;
 		/* After this point nothing touches the MSR anymore. */
 		wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-		      pkgdev->msr_pkg_therm_low, pkgdev->msr_pkg_therm_high);
+		      zonedev->msr_pkg_therm_low, zonedev->msr_pkg_therm_high);
 	}
 
 	/*
 	 * Check whether there is work scheduled and whether the work is
 	 * targeted at the outgoing CPU.
 	 */
-	if (pkgdev->work_scheduled && was_target) {
+	if (zonedev->work_scheduled && was_target) {
 		/*
 		 * To cancel the work we need to drop the lock, otherwise
 		 * we might deadlock if the work needs to be flushed.
 		 */
 		spin_unlock_irq(&pkg_temp_lock);
-		cancel_delayed_work_sync(&pkgdev->work);
+		cancel_delayed_work_sync(&zonedev->work);
 		spin_lock_irq(&pkg_temp_lock);
 		/*
 		 * If this is not the last cpu in the package and the work
@@ -473,21 +475,21 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 		 * need to reschedule the work, otherwise the interrupt
 		 * stays disabled forever.
 		 */
-		if (!lastcpu && pkgdev->work_scheduled)
-			pkg_thermal_schedule_work(target, &pkgdev->work);
+		if (!lastcpu && zonedev->work_scheduled)
+			pkg_thermal_schedule_work(target, &zonedev->work);
 	}
 
 	spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
 	if (lastcpu)
-		kfree(pkgdev);
+		kfree(zonedev);
 	return 0;
 }
 
 static int pkg_thermal_cpu_online(unsigned int cpu)
 {
-	struct pkg_device *pkgdev = pkg_temp_thermal_get_dev(cpu);
+	struct zone_device *zonedev = pkg_temp_thermal_get_dev(cpu);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
 	/* Paranoia check */
@@ -495,8 +497,8 @@ static int pkg_thermal_cpu_online(unsigned int cpu)
 		return -ENODEV;
 
 	/* If the package exists, nothing to do */
-	if (pkgdev) {
-		cpumask_set_cpu(cpu, &pkgdev->cpumask);
+	if (zonedev) {
+		cpumask_set_cpu(cpu, &zonedev->cpumask);
 		return 0;
 	}
 	return pkg_temp_thermal_device_add(cpu);
@@ -515,10 +517,10 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages() * topology_max_die_per_package();
-	packages = kcalloc(max_packages, sizeof(struct pkg_device *),
+	max_id = topology_max_packages() * topology_max_die_per_package();
+	zones = kcalloc(max_id, sizeof(struct zone_device *),
 			   GFP_KERNEL);
-	if (!packages)
+	if (!zones)
 		return -ENOMEM;
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "thermal/x86_pkg:online",
@@ -537,7 +539,7 @@ static int __init pkg_temp_thermal_init(void)
 	return 0;
 
 err:
-	kfree(packages);
+	kfree(zones);
 	return ret;
 }
 module_init(pkg_temp_thermal_init)
@@ -549,7 +551,7 @@ static void __exit pkg_temp_thermal_exit(void)
 
 	cpuhp_remove_state(pkg_thermal_hp_state);
 	debugfs_remove_recursive(debugfs);
-	kfree(packages);
+	kfree(zones);
 }
 module_exit(pkg_temp_thermal_exit)
 
-- 
2.18.0-rc0

