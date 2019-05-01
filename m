Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CED6C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622AF217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684688;
	bh=zEyEMOgcoemTI3vfOW6kHyeiZ4ZPRqlsUC5f/iQkz1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=jyE5Qa8ccOwA5IbgetTHZpbaATlcZfjY/qqvsg0ipeovRsPRkiAPR29Xdr/hP/qBf
	 h5zPtirGVWxxvi1e5rds9JRy1MjV0XNVGKjFgv2+JU+ASXaXDwaiPTWIupttEfUD0K
	 ICy0M+x8ApnSz0j81YJcTqOgxHwrNxBw2tOkrHiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEAEYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:24:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36901 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEAEYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:44 -0400
Received: by mail-io1-f67.google.com with SMTP id a23so14113561iot.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=aWDs9PCEBA88ORBTKQ0Gcg8/cpkSrRQa+GNVhlLVMRk=;
        b=Ug9gHnyWoVgXhvTmE46tDYEzaa6cRpPEExIw0YBhOkLHjfLwfYZDg283on3GCX3v5s
         UPam6H8AW55/ixZmPYig7uLjVvd+8+bTwEYOrzQ6KnBp9Pkzh7ROF+Bv03GdOAA8JxHO
         Qxq2/N8F2NFp/nG5yxWvqChmY6Ba3weqPpFM5/z7IBiBCybrPqtubwcpFqU5xRu6QFVZ
         ZzEjKbGOTiLBugEnJNKzGaY1qH93tfQJf69Nto4dj4cTdh5jfKeZu439GjXc9pNeGT06
         LE+aggIzTNa0c9I0fCiiL8sKQUxRrCv8mLfxqIY+XnljSVsqzY6pSe88mmg4cGfumK0m
         w/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=aWDs9PCEBA88ORBTKQ0Gcg8/cpkSrRQa+GNVhlLVMRk=;
        b=URi5Te4qvqgHNxkZLoRMYTpi89L8xHz+EDHvT7AeUiTzjmfbSgRYM08XronbTB2pix
         q9gjpT2AtyGK676dcwNcazMf9Dy3DdQhrWvu6bfjy0pFjrbFZOv8I/12pWp37fScrY2t
         Q0UJ/1UKv/ZfVTwovhIM5GTBM2UxyTiWhKkkakv4vf2uH3/AVIDF7k+Xv+ViGK4tV7CS
         ZJHwTrCemDUABHatJtlMuvWSLKqcGBHGwBPc21/BzWQAyZ2LBxaUX0uynN2QC2xs+bpL
         p/68kXrQZU+cJUOMucHvdQ9c0lUG+OC050KBv2cCmhkPu62Fq+HExEcqIC+Rsy4+MRoh
         4rDw==
X-Gm-Message-State: APjAAAVk92cfJjY0hPGQNmVL/P5wj3VP27XOJdodt1ODcnGxEEm3y+DI
        YJ/TOQ7KbzDnaBJJgB+53Co=
X-Google-Smtp-Source: APXvYqwGf+0LgaZ0NClpxojbk9QUHOaMJV8mpk/Qebauv4BR5B+UzZIvJBwPcCVsiGeYNeRQ/tey6w==
X-Received: by 2002:a5d:9d06:: with SMTP id j6mr1985045ioj.85.1556684683747;
        Tue, 30 Apr 2019 21:24:43 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:43 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 08/18] x86 topology: Define topology_logical_die_id()
Date:   Wed,  1 May 2019 00:24:17 -0400
Message-Id: <c836939fb740197cb4fe6f7c025cbd91b08c359d.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
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

