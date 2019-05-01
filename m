Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB156C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FB821743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684752;
	bh=ob/5nc5oxIJ301T4Ggi61ILm7rWRoXici9xBAQcMVlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=yGDuu0jowb8gkG3RGtYwcETgmp82CaAvmj3BaxTFNYCRqNcMWdfV7luvTLZWog03u
	 jqe2lxv18RzouHqQpkwXgXDt8jfH7iun8OwpUPfCZtHurb5M6P2zchFl4iCEKsG85C
	 pOsBSNK2yoNhnmIisKQg63EAgoo01yRBbBkpmkl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfEAEZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:25:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36897 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfEAEYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:40 -0400
Received: by mail-io1-f65.google.com with SMTP id a23so14113492iot.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=y67rI0+7LMqluGWWS+Hg6ADNiTmiQ2c0vs6hDyCQNYU=;
        b=Jw1H4068Nf+XggslcFDLtr3MRGaJawSSBjgkUN/hgBojENghcU7b4bvYT1g9+cp9Si
         Lpe+zNBbpQa7CP8odC6yHmJmJ6+4hiMQbHxZCGAeuwqOIUKOhN+raCqLMpqBCLEKZ0J3
         rIIBouMemkDgQjN5cA7QfnWI81tywVv0PrEXMP+Ucf+Qxe8BzXOQUaCdNf+qR+ydEFyn
         hfoMSUmMscva+g7hOKaGWncksXulrh03oaUMTYuDSpOX+sHkX+9Ye+PBpUVOCTf85ZkU
         Xajoz4zBuNGdmmIz2ho3B04SWAHy9AVM7m0o1fxtBRBzb0eNYjoeNVx1dbKdGmRkM+GL
         DQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=y67rI0+7LMqluGWWS+Hg6ADNiTmiQ2c0vs6hDyCQNYU=;
        b=MeW8lsCsqkI7bhH51H6yOdoU/Kab2LuLvPc6RzNKI764h9xYJeMmSfOnIq8FoXAZ3j
         mT/QQDoSt7h4S8dE9xayoBT4TeX7vqLMgDpjlQUi3/XlgpBwS8KM/1AShsKvv8HkUq0w
         W7BwWS9q4pInyCTsA//ffBYPjk+WrPtnAJjXnc8KGZQF1iuaesnaGY+rOn6HZf0aV5AQ
         LibtlIMyN6lyptQ+Z+pvaNM9wXLiFOsgt13Cr1kbx3SNTeDZpCCfrfceNuPoFCN5wSV3
         dcYXL/8h4e86u/QxW8q6IdC/vS+RHw9Gz/2od0N8of+3XZrFAlToNNvwYXaW9alIKksF
         Ke8w==
X-Gm-Message-State: APjAAAWf6HH5BV0f+m/rQ1HAytWPYhGdP3Xp5sHGNNBc/Hgui3rpVz1x
        MKIOwjiqtfQN+L232ISWBt0=
X-Google-Smtp-Source: APXvYqyThSRIjwfuTidUj8WzgaHNWCKSaYfTK0B/4/LIOg8dFXzsqztZMdeTvOUd2y+tCQsC7OcPrQ==
X-Received: by 2002:a6b:6405:: with SMTP id t5mr29898239iog.190.1556684680146;
        Tue, 30 Apr 2019 21:24:40 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:39 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 05/18] x86 topology: Create topology_max_die_per_package()
Date:   Wed,  1 May 2019 00:24:14 -0400
Message-Id: <f29322ff37990b684cf93effff0c9d14c356d607.1556657368.git.len.brown@intel.com>
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

