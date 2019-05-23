Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C43C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE0A20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JRBFZ1sB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfEWJXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:23:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60947 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfEWJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:23:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9NJvM4039623
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:23:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9NJvM4039623
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603399;
        bh=Yl/n558itPzqtGfLOzc2St/VFW5ipWNb7KMyIjz/Mng=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JRBFZ1sBmH+j+gWAndWWzA6M0HZ9uXz9EsZ8YUM37Z5YNPihblLmt3+loMY33SsND
         XnT01nMut+tL+8F937kxEYcDS8T1xkFnSDs73oHDDFx6Vkus8f/CrexmCgIhwdsmqf
         2Ff+wdqOIx+u/nTXCmm3dLHRS8EuFUR5pkWf03W0pCn7xoH6l47vcRelJNCah8bMJt
         3VKYLMBsLVer8tt6knbKmIQH5t8LzWezilzwScrk9Y56xSfw2M4IWnpcso1W8mh94N
         KSWQfaQLOd4kwqYobfdpz6fmUUb9l3OqS/OKtmTARi+eo66OGI5G6D+bjSfH6m35RL
         ya7swvxj/VmYg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9NI444039620;
        Thu, 23 May 2019 02:23:18 -0700
Date:   Thu, 23 May 2019 02:23:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Len Brown <tipbot@zytor.com>
Message-ID: <tip-14d96d6c06b5d8116b8d52c9c5530f5528ef1e61@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, len.brown@intel.com
Reply-To: linux-kernel@vger.kernel.org, len.brown@intel.com,
          tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          hpa@zytor.com
In-Reply-To: <e6eaf384571ae52ac7d0ca41510b7fb7d2fda0e4.1557769318.git.len.brown@intel.com>
References: <e6eaf384571ae52ac7d0ca41510b7fb7d2fda0e4.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] x86/topology: Create
 topology_max_die_per_package()
Git-Commit-ID: 14d96d6c06b5d8116b8d52c9c5530f5528ef1e61
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

Commit-ID:  14d96d6c06b5d8116b8d52c9c5530f5528ef1e61
Gitweb:     https://git.kernel.org/tip/14d96d6c06b5d8116b8d52c9c5530f5528ef1e61
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:46 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:30 +0200

x86/topology: Create topology_max_die_per_package()

topology_max_packages() is available to size resources to cover all
packages in the system.

But now multi-die/package systems are coming up, and some resources are
per-die.

Create topology_max_die_per_package(), for detecting multi-die/package
systems, and sizing any per-die resources.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/e6eaf384571ae52ac7d0ca41510b7fb7d2fda0e4.1557769318.git.len.brown@intel.com

---
 arch/x86/include/asm/processor.h |  1 -
 arch/x86/include/asm/topology.h  | 10 ++++++++++
 arch/x86/kernel/cpu/topology.c   |  5 ++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index ef0a44fccaec..7c17343946dd 100644
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
