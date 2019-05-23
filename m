Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE04C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8BB20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RsTPvam+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfEWJZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:25:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40009 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfEWJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:25:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9PWAk4041701
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:25:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9PWAk4041701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603533;
        bh=gDSxH/dOq0Mo4yZFGZo8eh1TvZhxTNPkbYNuqMD9JcI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=RsTPvam+DNBAJToQmfZNS+5s2Nk0IBUn2avkFkddXiwktRBykQ0DcQu2illaJn6VY
         FBrRJsuqLJzy/wo6Gtt/D5tEFkYyJM9YyX7Nk0Gpnqxu4QxEvnOIqbFixGp8d/0vXN
         m9yS7g0VMTEX/K3mBO+ESG9RIrNvKd2OQ0gFBZx84BBtiUw9eRvijJVe+9h+k6zNKK
         lM0ZHEDaJen7FDh6fqTjAChVbw832MGQaeQF0Ver4adPT866WF/O8QhCnpwW6aweEf
         eN9OFx23SxHIeFJsqyFUYq07tMwGRF7zYoN9fltVoC9pQDYp6gxJJj2VMypaE8esJO
         reC1fPlya3lpw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9PWCW4041698;
        Thu, 23 May 2019 02:25:32 -0700
Date:   Thu, 23 May 2019 02:25:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Len Brown <tipbot@zytor.com>
Message-ID: <tip-212bf4fdb7f9eeeb99afd97ebad677d43e7b55ac@git.kernel.org>
Cc:     mingo@kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, len.brown@intel.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          rui.zhang@intel.com, tglx@linutronix.de, peterz@infradead.org,
          hpa@zytor.com, len.brown@intel.com
In-Reply-To: <2f3526e25ae14fbeff26fb26e877d159df8946d9.1557769318.git.len.brown@intel.com>
References: <2f3526e25ae14fbeff26fb26e877d159df8946d9.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] x86/topology: Define topology_logical_die_id()
Git-Commit-ID: 212bf4fdb7f9eeeb99afd97ebad677d43e7b55ac
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

Commit-ID:  212bf4fdb7f9eeeb99afd97ebad677d43e7b55ac
Gitweb:     https://git.kernel.org/tip/212bf4fdb7f9eeeb99afd97ebad677d43e7b55ac
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:49 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:32 +0200

x86/topology: Define topology_logical_die_id()

Define topology_logical_die_id() ala existing topology_logical_package_id()

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/2f3526e25ae14fbeff26fb26e877d159df8946d9.1557769318.git.len.brown@intel.com

---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/include/asm/topology.h  |  5 +++++
 arch/x86/kernel/cpu/common.c     |  1 +
 arch/x86/kernel/smpboot.c        | 45 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 7c17343946dd..6aba36bde57f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -118,6 +118,7 @@ struct cpuinfo_x86 {
 	/* Core id: */
 	u16			cpu_core_id;
 	u16			cpu_die_id;
+	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	u32			microcode;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 3777dbe9c0ff..9de16b4f6023 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,6 +106,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
@@ -131,13 +132,17 @@ static inline int topology_max_smt_threads(void)
 }
 
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
+int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
+int topology_phys_to_logical_die(unsigned int die, unsigned int cpu);
 bool topology_is_primary_thread(unsigned int cpu);
 bool topology_smt_supported(void);
 #else
 #define topology_max_packages()			(1)
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
+static inline int
+topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_phys_to_logical_die(unsigned int die,
 		unsigned int cpu) { return 0; }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d7f55ad2dfb1..8cdca1223b0f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1298,6 +1298,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 		       cpu, apicid, c->initial_apicid);
 	}
 	BUG_ON(topology_update_package_map(c->phys_proc_id, cpu));
+	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
 #else
 	c->logical_proc_id = 0;
 #endif
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 40ffe23249c0..a6e01b6c2709 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,6 +101,7 @@ EXPORT_PER_CPU_SYMBOL(cpu_info);
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
 static unsigned int logical_packages __read_mostly;
+static unsigned int logical_die __read_mostly;
 
 /* Maximum number of SMT threads on any online core */
 int __read_mostly __max_smt_threads = 1;
@@ -302,6 +303,26 @@ int topology_phys_to_logical_pkg(unsigned int phys_pkg)
 	return -1;
 }
 EXPORT_SYMBOL(topology_phys_to_logical_pkg);
+/**
+ * topology_phys_to_logical_die - Map a physical die id to logical
+ *
+ * Returns logical die id or -1 if not found
+ */
+int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
+{
+	int cpu;
+	int proc_id = cpu_data(cur_cpu).phys_proc_id;
+
+	for_each_possible_cpu(cpu) {
+		struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+		if (c->initialized && c->cpu_die_id == die_id &&
+		    c->phys_proc_id == proc_id)
+			return c->logical_die_id;
+	}
+	return -1;
+}
+EXPORT_SYMBOL(topology_phys_to_logical_die);
 
 /**
  * topology_update_package_map - Update the physical to logical package map
@@ -326,6 +347,29 @@ found:
 	cpu_data(cpu).logical_proc_id = new;
 	return 0;
 }
+/**
+ * topology_update_die_map - Update the physical to logical die map
+ * @die:	The die id as retrieved via CPUID
+ * @cpu:	The cpu for which this is updated
+ */
+int topology_update_die_map(unsigned int die, unsigned int cpu)
+{
+	int new;
+
+	/* Already available somewhere? */
+	new = topology_phys_to_logical_die(die, cpu);
+	if (new >= 0)
+		goto found;
+
+	new = logical_die++;
+	if (new != die) {
+		pr_info("CPU %u Converting physical %u to logical die %u\n",
+			cpu, die, new);
+	}
+found:
+	cpu_data(cpu).logical_die_id = new;
+	return 0;
+}
 
 void __init smp_store_boot_cpu_info(void)
 {
@@ -335,6 +379,7 @@ void __init smp_store_boot_cpu_info(void)
 	*c = boot_cpu_data;
 	c->cpu_index = id;
 	topology_update_package_map(c->phys_proc_id, id);
+	topology_update_die_map(c->cpu_die_id, id);
 	c->initialized = true;
 }
 
