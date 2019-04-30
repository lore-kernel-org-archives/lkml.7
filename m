Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D48C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186A121744
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657830;
	bh=+EBia4we2RuwFMQcfNrzmq7S49fUtEvB9LKZSAWlAGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=av+a5tDm9hZOQi3mIuwjY7jqP1keLe/JSSbLc3MQz4JRWRrwxStjUNLullC2/1S/X
	 V6b9TJM6r8xUQFrET6j8QikjPfGKhpcJTD3tn/DBatQlrAILivtTd790zXRhVoC6U1
	 QAlOxXoSKBO5iJPZ+ExJ42/kJaoSqTYOm8YsIEcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfD3U5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:57:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36283 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfD3U4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:24 -0400
Received: by mail-it1-f193.google.com with SMTP id v143so7102227itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=zlHiEJFhKdzlZJ8m9G0YC2sApm0+ISFHS5hAsi9k4Ro=;
        b=ZkWxYPXuOJ+wllutaiOE++hO/G6Mq2mqreKzddxzpfOWClGMO/c7xDjmmVZSTJH3qv
         wHy1mDYa5hAasOCtp7y7Kjl364XGF/VACg/oBRtlrzZRZ/ktLHYD19k86heuKyPQPtsZ
         0NScsj3OpEgaggpRQsu1EfepCzR+rz0AVc1VODEkpKyeXg0DfS36KpdhGcJL+SeVtEgq
         wJSxlqsAT6ncKRLkGm690tP4v6EUnxs/hnTUoJrPeP0ZxRDjT9mqa2JgjaTsk2qe/U9D
         S9kxm+epdTwudsPq7PtPWdXiMjA7sozGo7OK6mexQXMb0nURw6QVBIj880BZNOUvr8Ob
         TTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=zlHiEJFhKdzlZJ8m9G0YC2sApm0+ISFHS5hAsi9k4Ro=;
        b=NscwJBrGr5oVXYwzm6HcntHweBlfAobjyWuE5nfXdbQrE6Ne++wO7M6VNmNaBOrM/S
         G9coM90r3U7/E8I0smmbhRrmHVTPq+8LMosO2nUQBhlvT2RhRQLpyH8wtqPaS1yf+9Pn
         hVQE7WhjzXvud7Kl978dYsAsG9gQEyWOmr+bpIXfbbu5sPrrjUwH+c3VLXLIeywvsaaP
         af73YLL/KG1wlGDE/MeXTJvBodFR1CptWH4DzBbC5Gtgm3GQvcvR7K089ciDJIE7OqTx
         ZvqBGPpZJQJtEERjMhryqf2LeCQNpRnie4fei6cAuUgNbQV6AEwa7B9itm60TmuM0Bc2
         CE+Q==
X-Gm-Message-State: APjAAAUVg7GYsOrdKjEqpJBw4L74JaN4LSvBBNxHhj2TKOE41gSE0y0R
        t4QSDy4AJtfKV7+JSlSBxmvohX7h
X-Google-Smtp-Source: APXvYqxb7zY90Nqkn6v1cH+MW2VXgvWTq7PErHYJ5SbZVF66jaFLdzuqetWRqL4LXOXBkPNV4St70g==
X-Received: by 2002:a24:8c:: with SMTP id 134mr5369229ita.24.1556657783513;
        Tue, 30 Apr 2019 13:56:23 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:22 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 07/14] x86 topology: Define topology_logical_die_id()
Date:   Tue, 30 Apr 2019 16:55:52 -0400
Message-Id: <d9bd5054226a2bb3dc35238d12e9f7f982b8ffac.1553624867.git.len.brown@intel.com>
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

Define topology_logical_die_id() ala
existing topology_logical_package_id()

Tested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/include/asm/topology.h  |  7 +++++
 arch/x86/kernel/cpu/common.c     |  1 +
 arch/x86/kernel/smpboot.c        | 45 ++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f2856fe03715..ee34ff34889d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -119,6 +119,7 @@ struct cpuinfo_x86 {
 	/* Core id: */
 	u16			cpu_core_id;
 	u16			cpu_die_id;
+	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	u32			microcode;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 281be6bbc80d..5728c43f5123 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,6 +106,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
@@ -124,14 +125,20 @@ static inline int topology_max_smt_threads(void)
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
+static inline int topology_phys_to_logical_die(unsigned int die,
+		unsigned int cpu) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline bool topology_smt_supported(void) { return false; }
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
index c70e547b18c2..0e7184e526a4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -100,6 +100,7 @@ EXPORT_PER_CPU_SYMBOL(cpu_info);
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
 static unsigned int logical_packages __read_mostly;
+static unsigned int logical_die __read_mostly;
 
 /* Maximum number of SMT threads on any online core */
 int __read_mostly __max_smt_threads = 1;
@@ -306,6 +307,26 @@ int topology_phys_to_logical_pkg(unsigned int phys_pkg)
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
@@ -330,6 +351,29 @@ int topology_update_package_map(unsigned int pkg, unsigned int cpu)
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
@@ -339,6 +383,7 @@ void __init smp_store_boot_cpu_info(void)
 	*c = boot_cpu_data;
 	c->cpu_index = id;
 	topology_update_package_map(c->phys_proc_id, id);
+	topology_update_die_map(c->cpu_die_id, id);
 	c->initialized = true;
 }
 
-- 
2.18.0-rc0

