Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF304C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1272175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hquMs0RN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfEWJaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:30:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfEWJaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:30:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9UWIl4042629
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:30:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9UWIl4042629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603833;
        bh=TjS9zQNW6L3cWnv1itpSB4m61vAcsJd8D1v0EGoAKRQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hquMs0RNu/RJk6uV28LrEhFMSl8K7pdEdyV6+0rdz3ubV+K/jXSeBL3JeCNwx/gVB
         Uox2gmBkdXzC6hrpoByReJWdC3yLdQg3NdxilOKDMTkGX2ETpopRySw/8p1Fq0iACV
         CNQ4k7FPPkbjqZ4JvAgkLVTMs0bMBuUwbE+HVLuDSd4rftiQwknu7B3td1IcLDyzwi
         dqSbsIt7TltKkA2veUpGEDwRy3iw8CyveVlkgF/j4Z3PETmMu787u6zzWAeitPPIVu
         WiTa5J+WFrCIgEQlSgIP0ebrclWTME5qC+ih3z3A/sX0sTugjBlsKezWvgywBY2psD
         J7IZV0Z/vAp+Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9UVI94042624;
        Thu, 23 May 2019 02:30:31 -0700
Date:   Thu, 23 May 2019 02:30:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Len Brown <tipbot@zytor.com>
Message-ID: <tip-2e4c54dac7b360c3820399bdf06cde9134a4495b@git.kernel.org>
Cc:     len.brown@intel.com, hpa@zytor.com, Brice.Goglin@inria.fr,
        mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org, Brice.Goglin@inria.fr, mingo@kernel.org,
          hpa@zytor.com, len.brown@intel.com
In-Reply-To: <071c23a298cd27ede6ed0b6460cae190d193364f.1557769318.git.len.brown@intel.com>
References: <071c23a298cd27ede6ed0b6460cae190d193364f.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] topology: Create core_cpus and die_cpus sysfs
 attributes
Git-Commit-ID: 2e4c54dac7b360c3820399bdf06cde9134a4495b
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

Commit-ID:  2e4c54dac7b360c3820399bdf06cde9134a4495b
Gitweb:     https://git.kernel.org/tip/2e4c54dac7b360c3820399bdf06cde9134a4495b
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:56 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:34 +0200

topology: Create core_cpus and die_cpus sysfs attributes

Create CPU topology sysfs attributes: "core_cpus" and "core_cpus_list"

These attributes represent all of the logical CPUs that share the
same core.

These attriutes is synonymous with the existing "thread_siblings" and
"thread_siblings_list" attribute, which will be deprecated.

Create CPU topology sysfs attributes: "die_cpus" and "die_cpus_list".
These attributes represent all of the logical CPUs that share the
same die.

Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/071c23a298cd27ede6ed0b6460cae190d193364f.1557769318.git.len.brown@intel.com

---
 Documentation/cputopology.txt   | 21 +++++++++++++++------
 arch/x86/include/asm/smp.h      |  1 +
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 22 ++++++++++++++++++++++
 arch/x86/xen/smp_pv.c           |  1 +
 drivers/base/topology.c         | 12 ++++++++++++
 include/linux/topology.h        |  3 +++
 7 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 48af5c290e20..b90dafcc8237 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -36,15 +36,15 @@ drawer_id:
 	identifier (rather than the kernel's).	The actual value is
 	architecture and platform dependent.
 
-thread_siblings:
+core_cpus:
 
-	internal kernel map of cpuX's hardware threads within the same
-	core as cpuX.
+	internal kernel map of CPUs within the same core.
+	(deprecated name: "thread_siblings")
 
-thread_siblings_list:
+core_cpus_list:
 
-	human-readable list of cpuX's hardware threads within the same
-	core as cpuX.
+	human-readable list of CPUs within the same core.
+	(deprecated name: "thread_siblings_list");
 
 package_cpus:
 
@@ -56,6 +56,14 @@ package_cpus_list:
 	human-readable list of CPUs sharing the same physical_package_id.
 	(deprecated name: "core_siblings_list")
 
+die_cpus:
+
+	internal kernel map of CPUs within the same die.
+
+die_cpus_list:
+
+	human-readable list of CPUs within the same die.
+
 book_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
@@ -93,6 +101,7 @@ these macros in include/asm-XXX/topology.h::
 	#define topology_drawer_id(cpu)
 	#define topology_sibling_cpumask(cpu)
 	#define topology_core_cpumask(cpu)
+	#define topology_die_cpumask(cpu)
 	#define topology_book_cpumask(cpu)
 	#define topology_drawer_cpumask(cpu)
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index da545df207b2..b673a226ad6c 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -23,6 +23,7 @@ extern unsigned int num_processors;
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
+DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 /* cpus sharing the last level cache: */
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 9de16b4f6023..4b14d2318251 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -111,6 +111,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 #ifdef CONFIG_SMP
+#define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a6e01b6c2709..1a19a5171949 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -91,6 +91,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
+/* representing HT, core, and die siblings of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
+EXPORT_PER_CPU_SYMBOL(cpu_die_map);
+
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
 /* Per CPU bogomips and other parameters */
@@ -509,6 +513,15 @@ static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
+static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	if ((c->phys_proc_id == o->phys_proc_id) &&
+		(c->cpu_die_id == o->cpu_die_id))
+		return true;
+	return false;
+}
+
+
 #if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
@@ -571,6 +584,7 @@ void set_cpu_sibling_map(int cpu)
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
+		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
 		c->booted_cores = 1;
 		return;
 	}
@@ -619,6 +633,9 @@ void set_cpu_sibling_map(int cpu)
 		}
 		if (match_pkg(c, o) && !topology_same_node(c, o))
 			x86_has_numa_in_package = true;
+
+		if ((i == cpu) || (has_mp && match_die(c, o)))
+			link_mask(topology_die_cpumask, cpu, i);
 	}
 
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
@@ -1223,6 +1240,7 @@ static __init void disable_smp(void)
 		physid_set_mask_of_physid(0, &phys_cpu_present_map);
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));
+	cpumask_set_cpu(0, topology_die_cpumask(0));
 }
 
 /*
@@ -1318,6 +1336,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
 	}
 
@@ -1538,6 +1557,8 @@ static void remove_siblinginfo(int cpu)
 			cpu_data(sibling).booted_cores--;
 	}
 
+	for_each_cpu(sibling, topology_die_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_die_cpumask(sibling));
 	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
@@ -1545,6 +1566,7 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
+	cpumask_clear(topology_die_cpumask(cpu));
 	c->cpu_core_id = 0;
 	c->booted_cores = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 590fcf863006..77d81c1a63e9 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -251,6 +251,7 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
 	}
 	set_cpu_sibling_map(0);
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index dc3c19b482f3..4e033d4cc0dc 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -53,10 +53,18 @@ define_siblings_show_func(thread_siblings, sibling_cpumask);
 static DEVICE_ATTR_RO(thread_siblings);
 static DEVICE_ATTR_RO(thread_siblings_list);
 
+define_siblings_show_func(core_cpus, sibling_cpumask);
+static DEVICE_ATTR_RO(core_cpus);
+static DEVICE_ATTR_RO(core_cpus_list);
+
 define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(die_cpus, die_cpumask);
+static DEVICE_ATTR_RO(die_cpus);
+static DEVICE_ATTR_RO(die_cpus_list);
+
 define_siblings_show_func(package_cpus, core_cpumask);
 static DEVICE_ATTR_RO(package_cpus);
 static DEVICE_ATTR_RO(package_cpus_list);
@@ -83,8 +91,12 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_core_id.attr,
 	&dev_attr_thread_siblings.attr,
 	&dev_attr_thread_siblings_list.attr,
+	&dev_attr_core_cpus.attr,
+	&dev_attr_core_cpus_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_die_cpus.attr,
+	&dev_attr_die_cpus_list.attr,
 	&dev_attr_package_cpus.attr,
 	&dev_attr_package_cpus_list.attr,
 #ifdef CONFIG_SCHED_BOOK
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 5cc8595dd0e4..47a3e3c08036 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -196,6 +196,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_core_cpumask
 #define topology_core_cpumask(cpu)		cpumask_of(cpu)
 #endif
+#ifndef topology_die_cpumask
+#define topology_die_cpumask(cpu)		cpumask_of(cpu)
+#endif
 
 #ifdef CONFIG_SCHED_SMT
 static inline const struct cpumask *cpu_smt_mask(int cpu)
