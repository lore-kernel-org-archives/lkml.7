Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809C4C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D138208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770431;
	bh=/ztHUK6mdLEo9+gJkbhr4Ha759+XvpyfUbixVqDquS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=nUjpR6c+rTPURe4lDd/Pae///EAJsb+Tmvx7dOo7xrbIAW1+x5/Sa23nLYhHUzrVh
	 GwODxw+l1QNtS0Ng8KbRr5C8L3FtSOMkjNANKbxUtrPzdPIvm2r4qyw4KJU/IT/3b6
	 +ELsUGItdJh1Q/uAAXrUAdamwW7N4WB4KQLy8uzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfEMR71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40834 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbfEMR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so6847556plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=9hwo5m2Xx1oKDMkvf5tOo/8gQUnZwUKCASRqX2THc6M=;
        b=H7rDmfP80GgPW8QHcJ0TmSkIl9IZYmSWhXb/ShU82EbPcyIYYYkhS2WRuvaGPRDY9P
         8M9r36NFKVbkb6O4R+f3hJCZCHD9vEmXIKPtJ955nPDZ9Lrkhe+r7l8/QRV1B2mr09i1
         pSI8m0esHx9VnjImsUEYLMsfoiXYR6uaMTTCHMF6b8xmEJcdFZFy4SVh2BDuyC39wIM2
         I1oRGXeX8JNMu2zKHie4W8eFAO9z3BPAneE6BB+qgYQYyE0mY/G2UlxlSe0Ecv4sx+Bw
         OMvBDc/JjmE6FHrdFY/oYtUweqgJdFVJCDvg1D8ib0N1H0Kdyg4trlwmQIUGxFtdfRnl
         tF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=9hwo5m2Xx1oKDMkvf5tOo/8gQUnZwUKCASRqX2THc6M=;
        b=cTcx9eSt2Fml8mAoq3v8meix5TUHva/d7s2pxEGipTVSSozdnGIK5Wr1ot09329Zkz
         5xkmF3HQjFDBn+wxnPveNAp2fTpNtjk4aoXdb0HzhYPu8nu1TrDZYGWBllmprhG8saq8
         OpRkKXAn2jMsyDR51NwSy4qjq6sntLap0FdOENX4nPTQR3OxfgVcqlFVIdFtQcOw1RDp
         PT9Gt6Da+385UQkS8S0iolPWJ6KHtgaKg9oX58rXp46rDHrFG0P2jHcxXJtR3GjX/Qui
         Ioxx81gw/sJ+8WlkGeqoL+XnfYWKY0h7NCdLhqG5I7JO/KM/Kw86B7i0THmWZIbq2iw6
         BoFg==
X-Gm-Message-State: APjAAAWzo6/VkqrpC1a+/1yemtoMlx0T69Wm9Ha/M/oqtcl9MUt/BFAs
        JQ7jlCliLENgVX7V454zDGhNhy+d
X-Google-Smtp-Source: APXvYqwd01FI397+M52CvJ3ABc9I4RcGzO0hxgN2EquwC06KNR6g2DIKpmN4u/5UylzbgXOgqoWpZw==
X-Received: by 2002:a17:902:2847:: with SMTP id e65mr32716179plb.319.1557770362274;
        Mon, 13 May 2019 10:59:22 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:21 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 05/19] x86 topology: Define topology_logical_die_id()
Date:   Mon, 13 May 2019 13:58:49 -0400
Message-Id: <2f3526e25ae14fbeff26fb26e877d159df8946d9.1557769318.git.len.brown@intel.com>
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
index 87d42c0c6ccc..603ce3fe578d 100644
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
index 8739bdfe9bdf..48de7f069ac7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1277,6 +1277,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
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

