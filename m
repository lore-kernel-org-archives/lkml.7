Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DD2C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CD6208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770414;
	bh=BM2V6SsTExi0C/jS7YOSTWCa1MJ2mR4PwnixpplEmKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Kjiod2OYlEcvwbydwmJ5+UiCg0i//H8wELnPP0Ozak8oydSkdePb+dCvNOJnMi2Xm
	 uaO9L556NKayojHlDMON9Rc1E3My+JHS98pIWFcnIz1IH38vhG/wB24qlzM1QZ+cGN
	 bfnrcIFYuEvJkiP9FG92O76S56IlpKyVt104XIiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfEMR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32857 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732098AbfEMR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so7167948pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=Tk8oFsZYK508IMdB/PwI2Vz+nsRcojCmLWVhoutJ8Jc=;
        b=tk5BIIqUAuxpjV97CPV/40lu9RaM9r3YtF5dd+4O7DoJ7LpfqSr5Avgj3kbqBdXjdm
         u7FWoWjs3iTn/oBeQ5D00VawIavwpJry9L4/mEiNMb31QXd23TzXZFaPsx3cNxFyv716
         RDkSGxx/LxZ5O9paO5w669Du6iAuZRjJt9hsLFrWgAVq3JgLXyRiqa6gsBYgeNc41uvo
         3kdlmoNWNZ6kMJTpZ+nvrvOQxLSDT/KFQuQ4oSnyTx/CJzEt3X5MyWgINlDOu51iRUZ7
         pZ2JOD6h35oaR2OlR+ApIZ20r25JDu/Z0HhBixoP9y+afH/ooI2EXPV4aVLN8Cg/+W3U
         vkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=Tk8oFsZYK508IMdB/PwI2Vz+nsRcojCmLWVhoutJ8Jc=;
        b=RVsK4WhHLSJOXUvwHzUE7i6xsO3N4sCJILL/yN5q6ApOhIHdaqC/v12Z28ZJgzY0Wy
         2noW/cdf266G4ekhr0j2a2q5LtSIrhQebRriHXMBNIhYdmeSVf3QyNCOOtELFLVZtHD3
         YRu+9E3yo9JhqHZ1y6OttaFEVfk7BAZ5wvJ7WtoWN4HEHJo+6p0y118OO01yqU7Vp1x3
         Ib795tZ88w3Rt/U7SnzwJ6TN30Wd18BMiU9r57N8+T9+jQTVnqzryGuGrP6Wyniw96pk
         jPFRTsteom8OLkSNCTlLGC0Vz0CQFIboho8g3wYPWO6cGIkOiEbjCAK4TWUiuvKriHj/
         RckA==
X-Gm-Message-State: APjAAAV/eMM8xsjZ6zpPaHUYaAWFLcJFeDRjheDDHqh6Nl+vMyqb0kBv
        VvUtRN6W/T4YOmFUKjpsGe9prspq
X-Google-Smtp-Source: APXvYqxCB8PGJbHMkKyYCCH7eWkKSsejgFcHDKBoqjkV7T/Nb8mm6skt4wd4b/VVlcpBoZ0oy/3Wuw==
X-Received: by 2002:a62:582:: with SMTP id 124mr35369349pff.209.1557770372949;
        Mon, 13 May 2019 10:59:32 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:32 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 12/19] topology: Create core_cpus and die_cpus sysfs attributes
Date:   Mon, 13 May 2019 13:58:56 -0400
Message-Id: <071c23a298cd27ede6ed0b6460cae190d193364f.1557769318.git.len.brown@intel.com>
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

Create CPU topology sysfs attributes: "core_cpus" and "core_cpus_list"

These attributes represent all of the logical CPUs that share the
same core.

These attriutes is synonymous with the existing "thread_siblings" and
"thread_siblings_list" attribute, which will be deprecated.

Create CPU topology sysfs attributes: "die_cpus" and "die_cpus_list".
These attributes represent all of the logical CPUs that share the
same die.

Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
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
-- 
2.18.0-rc0

