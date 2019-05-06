Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA73C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097CE2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178092;
	bh=ob/5nc5oxIJ301T4Ggi61ILm7rWRoXici9xBAQcMVlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=zn7iIza0xxUgyOs/mCYT/7ub2BADZJ1+yrYQh02YkLlYkUO2yQhhGPIvMLW3v6oxg
	 4vpxR1Hdijbm7bum1GTf4YQ4qjUlSFZ+l7ZcLLEnVsJCyVoF5IcSL30fsSJK29hyiB
	 ELvAZdke3qWa3wJCUw5dlvAhUiFlNQThjRcXd//c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfEFV0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34394 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEFV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:32 -0400
Received: by mail-io1-f66.google.com with SMTP id g84so4445161ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=y67rI0+7LMqluGWWS+Hg6ADNiTmiQ2c0vs6hDyCQNYU=;
        b=BVYMz7yvsX4yyMElSlMUMB0dOBE80pJr0n+6BMf5kJmKYsWLm0kYJqzBmeZkV4oOJI
         annzTaY/R9o9e//8xyWnDR1He/Xu8RkwQ5E/qEIuJpU8CgMSdGBc2XbqvzjlD5h83lEb
         xNxQ67cFUZxuXW2i+kIiHbIfO/1LxPMXnSCY2LPi31Rm2c6tjmkx9ac9vqEYMH9ML+mk
         /eXzPf3Un+0adEc5WH5BE3c4ISY6Wa6YxcinHPbSpgMYSn43aOcwYRceHD5FEIPXLS61
         XHfcLzFkBm+msx93FdaceFU0aq0E3mtXaErXgiIYYdkznrE/hoF4PEIZb8yuV5oXe7Nd
         6AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=y67rI0+7LMqluGWWS+Hg6ADNiTmiQ2c0vs6hDyCQNYU=;
        b=B12wf32IZsE049+rQfoGOhtjkQx6l6s/hr5YW34KPoVe9jePDa/DAoKGi2GOBHruEi
         00LJqczBvFx8DWTKsD6/7GvFI1lmIBACEP/sVyRInRoXHyetuVcEj0az9G5+JR5iJQJW
         UW82lBq082dHKoaM4dNgaH3BqTCaIoxcnEqIYeqsRTYm76sB5WqunQ90+XVl3D4BAlmb
         go4rWtokS4UYQSFJ8GAIr0hChM+DGsgE9MDky0ged0onlKDwDViHrVAoNu9ChcSS6QYs
         cIdEZh4wH7j66p0oQhO7VWAAW9TzQg6fxjwrjL5zCSZFy267GMPvJ37hdrusO5JCTxZ7
         OPSw==
X-Gm-Message-State: APjAAAVWdBm8SSBwMbKOPzh+Vmf8K/SR+xn6z0HhH1E4ccJazKXF6nwi
        otIErAkYw6VOhC3CmVuycPB4AMMe
X-Google-Smtp-Source: APXvYqyXByXgZCU/FpNOtP2WPqk/lBVnLWrtZ3F4DYGDGCov0qf9+Q1+7/RVGMF4+0PX12xXNMr63Q==
X-Received: by 2002:a5d:9a0f:: with SMTP id s15mr14363216iol.211.1557177991418;
        Mon, 06 May 2019 14:26:31 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:30 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 05/22] x86 topology: Create topology_max_die_per_package()
Date:   Mon,  6 May 2019 17:26:00 -0400
Message-Id: <f29322ff37990b684cf93effff0c9d14c356d607.1557177585.git.len.brown@intel.com>
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

topology_max_packages() is available to size resources to
cover all packages in the system.

But now we have multi-die/package systems, and some
resources are per-die.

Create topology_max_die_per_package(), for detecting
multi-die/package systems, and sizing any per-die resources.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/processor.h |  1 -
 arch/x86/include/asm/topology.h  | 10 ++++++++++
 arch/x86/kernel/cpu/topology.c   |  5 ++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2507edc30cc2..5f45488b1a9d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -106,7 +106,6 @@ struct cpuinfo_x86 {
 	unsigned long		loops_per_jiffy;
 	/* cpuid returned max cores value: */
 	u16			x86_max_cores;
-	u16			x86_max_dies;
 	u16			apicid;
 	u16			initial_apicid;
 	u16			x86_clflush_size;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 453cf38a1c33..e0232f7042c3 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -115,6 +115,13 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern unsigned int __max_logical_packages;
 #define topology_max_packages()			(__max_logical_packages)
 
+extern unsigned int __max_die_per_package;
+
+static inline int topology_max_die_per_package(void)
+{
+	return __max_die_per_package;
+}
+
 extern int __max_smt_threads;
 
 static inline int topology_max_smt_threads(void)
@@ -131,6 +138,9 @@ bool topology_smt_supported(void);
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
+static inline int topology_phys_to_logical_die(unsigned int die,
+		unsigned int cpu) { return 0; }
+static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline bool topology_smt_supported(void) { return false; }
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 4d17e699657d..ee48c3fc8a65 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -26,6 +26,9 @@
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
 #ifdef CONFIG_SMP
+unsigned int __max_die_per_package __read_mostly = 1;
+EXPORT_SYMBOL(__max_die_per_package);
+
 /*
  * Check if given CPUID extended toplogy "leaf" is implemented
  */
@@ -146,7 +149,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
 
 	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
-	c->x86_max_dies = (die_level_siblings / core_level_siblings);
+	__max_die_per_package = (die_level_siblings / core_level_siblings);
 #endif
 	return 0;
 }
-- 
2.18.0-rc0

