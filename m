Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF45C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CF421783
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657808;
	bh=3LbK+bucRHCFgTn9epY2HjMqT5//5v7ZdNBfKR7E+gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=zlyXu8xL6vcesh09DA1mkjevaIBJR9qKdGNGA2ym/t7MsWRytAaSleumkiio8c1jY
	 jD87xrYBmkoZMlnLxhOftSg6JmTOhGr7aO1ChjzgUbT5mCT7nQESMrH3lk9R+6uTKt
	 qgqs72ft+QhtVUXvyBGkpxhQJTnnJD43bbWFvxcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfD3U4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:56:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43337 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfD3U4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:33 -0400
Received: by mail-io1-f68.google.com with SMTP id v9so13431691iol.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=mYmIhRnm97J2GMRymnzJcfVYOfv5/Pvcxh//QU152qg=;
        b=GgxgUoZjApNAjPTpsEFHKCLQVfFkeX9y6w95BiEu5TGtqRirBG3zboxljlxKu9LBB0
         TagYM4m4ajnvXcpYhMkEIovOX5aaQf93iRWrkabyN6XRZn/k4CZ2narnK3WtGGC1YqbM
         6Fkio8DZc32MgaHKUH1ZakfZ9dz3j+4dwqhXJfdFCT7BEODMXeCOAeHNXDS6oszJw0yE
         2cPlRWCmP0wo7R87MLAiB51SKCbRzwfncPZ2q3/niORnRZGKexdG1szsU9wB4c0oYMlF
         M3mL0BQTb13FYtiTJjB29GXCkU/iveKUh3YYcJsxXjppVUwS7pmH+Q4R9NyR1kDDHUkC
         QZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=mYmIhRnm97J2GMRymnzJcfVYOfv5/Pvcxh//QU152qg=;
        b=AUdbcY+ofGGZzTiABbOlCSqHsgO9JN0ushwGJBHWOqw6CS2ihZPhppv5gAuGawwGWL
         nfmafFmeJI2hepz1QVxtqhygq1hZF6iS2feVgyHtvaZLTuSmd9ZylX8GtCeXhWG8Yml7
         aiPAJwcso2QZgzQ3tnwlTejdxqVsQD5jqQdXoy9xoJ1e9uu+DMqf4cFHjMgO6YWdOMPD
         eW/OUSlDJ20Jl7RFKnlgK+bAo7gii3X6IgEWzooYaoHLzdHMRqX2TAbGGt4hPDC5Lg70
         pys+iKXIKFMzR/72lRg6Kyf9yPCZ/+FO2n97Wavbkfj5SR7m39XjCVfgRae2yE7yYjLI
         xtIQ==
X-Gm-Message-State: APjAAAW75gVco/T8Te67BPccF7oR6vFeCk1ro+eCnt8fIFBLcBPr2rO3
        WEQPse3MsebP27NhgZ+Sc2SBG2TF
X-Google-Smtp-Source: APXvYqwOCZEqaTmoPQL8P+mc4PToLUGyNyiwnTUoXpE2Q/HjVm/JV5NJ+IZagiWm8u3QBzWiLtyieQ==
X-Received: by 2002:a6b:630b:: with SMTP id p11mr6340394iog.168.1556657792180;
        Tue, 30 Apr 2019 13:56:32 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:31 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 14/14] topology: Create core_threads sysfs attribute
Date:   Tue, 30 Apr 2019 16:55:59 -0400
Message-Id: <647375066a62024df24b8c6a7fa70796ac82f63d.1553624867.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
References: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Create CPU topology sysfs attributes:
"core_threads" and "core_threads_list"

These attributes represent all of the logical CPU threads that share the
same core.

These attriutes is synonymous with the existing "thread_siblings" and
"thread_siblings_list" attribute, which will be deprecated.

Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
---
 Documentation/cputopology.txt   | 19 +++++++++++++++----
 arch/x86/include/asm/smp.h      |  1 +
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 22 ++++++++++++++++++++++
 arch/x86/xen/smp_pv.c           |  1 +
 drivers/base/topology.c         | 12 ++++++++++++
 include/linux/topology.h        |  3 +++
 7 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index a500e25476f4..77b65583081e 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -36,15 +36,15 @@ drawer_id:
 	identifier (rather than the kernel's).	The actual value is
 	architecture and platform dependent.
 
-thread_siblings:
+core_threads:
 
 	internal kernel map of cpuX's hardware threads within the same
-	core as cpuX.
+	core as cpuX. (deprecated name: "thread_siblings")
 
-thread_siblings_list:
+core_threads_list:
 
 	human-readable list of cpuX's hardware threads within the same
-	core as cpuX.
+	core as cpuX. (deprecated name: "thread_siblings_list");
 
 package_threads:
 
@@ -56,6 +56,16 @@ package_threads_list:
 	human-readable list of cpuX's hardware threads within the same
 	physical_package_id. (deprecated name: "core_siblings_list")
 
+die_threads:
+
+	internal kernel map of cpuX's hardware threads within the same
+	die_id.
+
+die_threads_list:
+
+	human-readable list of cpuX's hardware threads within the same
+	die_id.
+
 book_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
@@ -93,6 +103,7 @@ these macros in include/asm-XXX/topology.h::
 	#define topology_drawer_id(cpu)
 	#define topology_sibling_cpumask(cpu)
 	#define topology_core_cpumask(cpu)
+	#define topology_die_cpumask(cpu)
 	#define topology_book_cpumask(cpu)
 	#define topology_drawer_cpumask(cpu)
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 2e95b6c1bca3..39266d193597 100644
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
index 5728c43f5123..9be47300665c 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -111,6 +111,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 #ifdef CONFIG_SMP
+#define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0e7184e526a4..b5c516422231 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -90,6 +90,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
+/* representing HT, core, and die siblings of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
+EXPORT_PER_CPU_SYMBOL(cpu_die_map);
+
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
 /* Per CPU bogomips and other parameters */
@@ -513,6 +517,15 @@ static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
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
@@ -575,6 +588,7 @@ void set_cpu_sibling_map(int cpu)
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
+		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
 		c->booted_cores = 1;
 		return;
 	}
@@ -623,6 +637,9 @@ void set_cpu_sibling_map(int cpu)
 		}
 		if (match_pkg(c, o) && !topology_same_node(c, o))
 			x86_has_numa_in_package = true;
+
+		if ((i == cpu) || (has_mp && match_die(c, o)))
+			link_mask(topology_die_cpumask, cpu, i);
 	}
 
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
@@ -1218,6 +1235,7 @@ static __init void disable_smp(void)
 		physid_set_mask_of_physid(0, &phys_cpu_present_map);
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));
+	cpumask_set_cpu(0, topology_die_cpumask(0));
 }
 
 /*
@@ -1313,6 +1331,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
 	}
 
@@ -1533,6 +1552,8 @@ static void remove_siblinginfo(int cpu)
 			cpu_data(sibling).booted_cores--;
 	}
 
+	for_each_cpu(sibling, topology_die_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_die_cpumask(sibling));
 	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
@@ -1540,6 +1561,7 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
+	cpumask_clear(topology_die_cpumask(cpu));
 	c->cpu_core_id = 0;
 	c->booted_cores = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 145506f9fdbe..ac13b0be8448 100644
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
index 5f4405a08c6e..b6d1fec9b6a3 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -53,10 +53,18 @@ define_siblings_show_func(thread_siblings, sibling_cpumask);
 static DEVICE_ATTR_RO(thread_siblings);
 static DEVICE_ATTR_RO(thread_siblings_list);
 
+define_siblings_show_func(core_threads, sibling_cpumask);
+static DEVICE_ATTR_RO(core_threads);
+static DEVICE_ATTR_RO(core_threads_list);
+
 define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(die_threads, die_cpumask);
+static DEVICE_ATTR_RO(die_threads);
+static DEVICE_ATTR_RO(die_threads_list);
+
 define_siblings_show_func(package_threads, core_cpumask);
 static DEVICE_ATTR_RO(package_threads);
 static DEVICE_ATTR_RO(package_threads_list);
@@ -83,8 +91,12 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_core_id.attr,
 	&dev_attr_thread_siblings.attr,
 	&dev_attr_thread_siblings_list.attr,
+	&dev_attr_core_threads.attr,
+	&dev_attr_core_threads_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_die_threads.attr,
+	&dev_attr_die_threads_list.attr,
 	&dev_attr_package_threads.attr,
 	&dev_attr_package_threads_list.attr,
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

