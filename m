Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE8C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8936B216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178001;
	bh=zEyEMOgcoemTI3vfOW6kHyeiZ4ZPRqlsUC5f/iQkz1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=P3YxTpsFoynX0q3QHGPal99EQX1VDeeEkX4xWtPrNzrKmBlFYK5LFa7O6sDM5neyV
	 cJ+k86RANMHTiIsJ1odkeRjRqo4yKXpgxL+uzw3+HlM/l0kpcgVRu8O4HZq6Bu3DmJ
	 jcsBu0KpgCqGmCafEzpVKTIIaW3f0OVGSAZ+XgWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEFV0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:39 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38402 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEFV0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:36 -0400
Received: by mail-it1-f193.google.com with SMTP id q19so22338419itk.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=aWDs9PCEBA88ORBTKQ0Gcg8/cpkSrRQa+GNVhlLVMRk=;
        b=RYbm3hTaft+on+NUjnAxnPM0LGGvkMGCXuwF8RZEv9qWkcYw6NWywQhdMjuiZlyv1/
         pkyaeNLSyDyXFAHUn6jSYY9xIVcjuFfgMqGofPMLmsz5yMjho4flUsKnRhAg5GQDP50A
         /m6ZpTm7ZcJiAzGReeWTDz3H3M6inmqVQGPHtb26ZL+C42cm+FAyN2Irqq1Om9YCJceJ
         +APBkqXPqOT+CsJDJfulMbqgBxxnUMr8Oyu+nwKAD/eSq44UWPD9QblgKGw2c3UQf5gQ
         9Z9G7lAbL/B6Fy2nyfZrqdvN/UqsbvoVCWwokgxjAecpOiVmIvZxIjSyAUyJrdrOqUgh
         Gpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=aWDs9PCEBA88ORBTKQ0Gcg8/cpkSrRQa+GNVhlLVMRk=;
        b=R0q4mPh6hHMssDnQgQjSU30qRr5O0HflPecGBAyn5HL5hnT2MlY52WQxZd/BPxYs4X
         voRxgfLY8WNQEJb4hjPUytZB1fgFE442juSnRX8GOQq3wBuFF6Rhydh+K2Rt/uwerpv+
         93ElB1SnDSCFz/M9C/34Zeq8idtcmBfkJksDkqJBN7ApPnoELcZ51bsWmzTokbDk9XLn
         VSJcAqzabjHEOrttyv6Iix5GU5plfzS+QZRJyRMVjFcw3HbtY6CWPefmxRRdMOVFyZR2
         C2Y2Gx5iqHyQLwHIs9H3//OodGHioGru7ctEKhdJgEMi1nW5HDMSoJXIABV7WgQweXcV
         f+6g==
X-Gm-Message-State: APjAAAWxjxwnyZ2zfRrVBd4GdlOhzpT2iCVdeSJhCHz1RjqmuEt/+aCN
        bynbxRzWReDTLLXglP5YNAU=
X-Google-Smtp-Source: APXvYqy1VdNGIM4ZjTtaHAi0S6V5BU+xaWmrZVt4EQa5vgy/ZsbXxhFIu38Vqs1dfIcuNkqYPpIR4Q==
X-Received: by 2002:a24:5ec2:: with SMTP id h185mr22551091itb.19.1557177995416;
        Mon, 06 May 2019 14:26:35 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:34 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 08/22] x86 topology: Define topology_logical_die_id()
Date:   Mon,  6 May 2019 17:26:03 -0400
Message-Id: <c836939fb740197cb4fe6f7c025cbd91b08c359d.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Define topology_logical_die_id() ala
existing topology_logical_package_id()

Tested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/include/asm/topology.h  |  5 ++++
 arch/x86/kernel/cpu/common.c     |  1 +
 arch/x86/kernel/smpboot.c        | 45 ++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5f45488b1a9d..def963d0b805 100644
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
index cb28e98a0659..24f96c9771af 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1285,6 +1285,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 		       cpu, apicid, c->initial_apicid);
 	}
 	BUG_ON(topology_update_package_map(c->phys_proc_id, cpu));
+	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
 #else
 	c->logical_proc_id = 0;
 #endif
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 05f9cfdddffd..a114375e14f7 100644
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
@@ -326,6 +347,29 @@ int topology_update_package_map(unsigned int pkg, unsigned int cpu)
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
 
-- 
2.18.0-rc0

