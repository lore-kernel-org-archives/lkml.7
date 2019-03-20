Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C495FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A019217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FNXKglhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfCTBXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:23:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58805 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfCTBXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553044990; x=1584580990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=clP6NMFQMwOD3n54p6gFwQhrqNU04Jf2cfalAdxHECo=;
  b=FNXKglhqgRdNXSexvL3keXxNagprjIk88z0i5QAfUYM26jy3beKR8BC9
   zaId9n38+h/yLg8mqaUr4DO34386W85fF6792CQiJJhun+pqKlUnQatyh
   +pA6n8e6UpGPAG1voG1A8MovDjSAa1wRoDC2u/v+OkJ6USV51B0LwkLUG
   jCwhbIM+5UIW0og62rp1igaEFqCYQNcKkhXvRGn8FKZ/7hAbUysdpG7Cx
   lNUG/Ts4sKho0fpotS2YNz1ShjRPeEIPdUz6+IuDg63VMKeCe0u38iupU
   953OLAbXFnSFVe3nk3NxRBI8I2QXwgLmfmzb8BHDpRxraeKV/QrvfwDOP
   g==;
X-IronPort-AV: E=Sophos;i="5.58,498,1544457600"; 
   d="scan'208";a="209334031"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 09:22:59 +0800
IronPort-SDR: JVj/9vlWesC8weJiktfwCdn6/HfKUCC3+7eoFYIAvkut0mn/nj3A4KU9DyuDkRotQFzZD0+j4H
 pWzT4M8LZYJBxAX0YJkPGHTDsK1YtwMrc8v532Kr4AVXmVBAswsvW4DRe6muLl/Rb0gQa7KMG1
 W/R0V4UGbKKruxUT/grmX2y66BzIzLMxTwlF4rKCNHRxiUYNNr49RAocFsTnTy3GcyUioX8QKf
 HfHyOcmTvyHKbRZasc8mFzx5z60cWTiYWiI+01UKLjS1nKqnPJ4c4/NpiaVbdD6/fo+CgMu9oV
 +dEhofYF5SLFuP70R+zIrJqE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Mar 2019 18:02:38 -0700
IronPort-SDR: Mm5ffHnMXLnxzR1GUSYNkrtLoY2+7RghWhnwm3rbWmIpX08gxIVYkBbEC5fVJZJ9NDkJDK9Xin
 FhOTRoW7BlLxIMunZBjIBu0QNT6ma2EmmYIAWko25FHzceSMVH1ysTi8VHGeFo2mgdzRuljAhH
 dOsnYATokewlBOXrwwg8owTuQL28346eGYMJ+BUgEbg/nTNxtoRwgt7vyulnZowRtjtbpyGTNi
 MvpVbRYG7k13jQD+ietuBwFSjIxgDdPJnghQFwFrRBYaoSfnU+/UN0v72cNq7CPhPB3ppX79iI
 ISc=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2019 18:22:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [RFT/RFC PATCH v2 3/4] arm: Use common cpu_topology
Date:   Tue, 19 Mar 2019 18:22:50 -0700
Message-Id: <20190320012251.2728-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320012251.2728-1-atish.patra@wdc.com>
References: <20190320012251.2728-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ARM32 and ARM64 uses different data structures to
represent their cpu toplogies. Since, we are moving the ARM64
topology to common code to be used by other architectures, we
can reuse that for ARM32 as well.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/arm/include/asm/topology.h | 22 +---------------------
 arch/arm/kernel/topology.c      | 10 +++++-----
 include/linux/arch_topology.h   | 10 +++++++++-
 3 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 2a786f54..52f99ec8 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -5,26 +5,6 @@
 #ifdef CONFIG_ARM_CPU_TOPOLOGY
 
 #include <linux/cpumask.h>
-
-struct cputopo_arm {
-	int thread_id;
-	int core_id;
-	int socket_id;
-	cpumask_t thread_sibling;
-	cpumask_t core_sibling;
-};
-
-extern struct cputopo_arm cpu_topology[NR_CPUS];
-
-#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
-#define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
-#define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
-#define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
-
-void init_cpu_topology(void);
-void store_cpu_topology(unsigned int cpuid);
-const struct cpumask *cpu_coregroup_mask(int cpu);
-
 #include <linux/arch_topology.h>
 
 /* Replace task scheduler's default frequency-invariant accounting */
@@ -38,7 +18,7 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #else
 
-static inline void init_cpu_topology(void) { }
+static inline void init_cpu_topology(void) {}
 static inline void store_cpu_topology(unsigned int cpuid) { }
 
 #endif
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 60e375ce..0ddb24c7 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -180,7 +180,7 @@ static inline void update_cpu_capacity(unsigned int cpuid) {}
  /*
  * cpu topology table
  */
-struct cputopo_arm cpu_topology[NR_CPUS];
+struct cpu_topology cpu_topology[NR_CPUS];
 EXPORT_SYMBOL_GPL(cpu_topology);
 
 const struct cpumask *cpu_coregroup_mask(int cpu)
@@ -197,9 +197,9 @@ const struct cpumask *cpu_corepower_mask(int cpu)
 	return &cpu_topology[cpu].thread_sibling;
 }
 
-static void update_siblings_masks(unsigned int cpuid)
+void update_siblings_masks(unsigned int cpuid)
 {
-	struct cputopo_arm *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
+	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
 	int cpu;
 
 	/* update core and thread sibling masks */
@@ -230,7 +230,7 @@ static void update_siblings_masks(unsigned int cpuid)
  */
 void store_cpu_topology(unsigned int cpuid)
 {
-	struct cputopo_arm *cpuid_topo = &cpu_topology[cpuid];
+	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
 	unsigned int mpidr;
 
 	/* If the cpu topology has been already set, just return */
@@ -302,7 +302,7 @@ void __init init_cpu_topology(void)
 
 	/* init core mask and capacity */
 	for_each_possible_cpu(cpu) {
-		struct cputopo_arm *cpu_topo = &(cpu_topology[cpu]);
+		struct cpu_topology *cpu_topo = &(cpu_topology[cpu]);
 
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id =  -1;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index d4e76e0a..7c850611 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -36,17 +36,25 @@ unsigned long topology_get_freq_scale(int cpu)
 struct cpu_topology {
 	int thread_id;
 	int core_id;
+#ifdef CONFIG_ARM_CPU_TOPOLOGY
+	int socket_id;
+#else
 	int package_id;
 	int llc_id;
+	cpumask_t llc_sibling;
+#endif
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
-	cpumask_t llc_sibling;
 };
 
 #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
 extern struct cpu_topology cpu_topology[NR_CPUS];
 
+#ifdef CONFIG_ARM_CPU_TOPOLOGY
+#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
+#else
 #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
+#endif
 #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
-- 
2.21.0

