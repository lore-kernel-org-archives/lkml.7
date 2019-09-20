Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FAFC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C93120882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437266AbfITGJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:09:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437235AbfITGI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:08:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C9784AF2204CC461C878;
        Fri, 20 Sep 2019 14:08:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:49 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Robert Richter <rric@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 07/32] x86: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:19 +0800
Message-ID: <20190920062544.180997-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Robert Richter <rric@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/x86/kernel/amd_gart_64.c          | 11 ++++---
 arch/x86/kernel/apic/apic.c            | 41 ++++++++++++--------------
 arch/x86/kernel/setup_percpu.c         |  4 +--
 arch/x86/kernel/tboot.c                | 15 +++++-----
 arch/x86/kernel/tsc_sync.c             |  8 ++---
 arch/x86/kernel/umip.c                 |  6 ++--
 arch/x86/mm/kmmio.c                    |  7 ++---
 arch/x86/mm/mmio-mod.c                 |  6 ++--
 arch/x86/mm/numa_emulation.c           |  4 +--
 arch/x86/mm/testmmiotrace.c            |  6 ++--
 arch/x86/oprofile/op_x86_model.h       |  6 ++--
 arch/x86/platform/olpc/olpc-xo15-sci.c |  2 +-
 arch/x86/platform/sfi/sfi.c            |  3 +-
 arch/x86/xen/setup.c                   |  2 +-
 14 files changed, 57 insertions(+), 64 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index a585ea6f686a..53545c9c7cad 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -510,10 +510,9 @@ static __init unsigned long check_iommu_size(unsigned long aper, u64 aper_size)
 	iommu_size -= round_up(a, PMD_PAGE_SIZE) - a;
 
 	if (iommu_size < 64*1024*1024) {
-		pr_warning(
-			"PCI-DMA: Warning: Small IOMMU %luMB."
+		pr_warn("PCI-DMA: Warning: Small IOMMU %luMB."
 			" Consider increasing the AGP aperture in BIOS\n",
-				iommu_size >> 20);
+			iommu_size >> 20);
 	}
 
 	return iommu_size;
@@ -665,7 +664,7 @@ static __init int init_amd_gatt(struct agp_kern_info *info)
 
  nommu:
 	/* Should not happen anymore */
-	pr_warning("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
+	pr_warn("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
 	       "falling back to iommu=soft.\n");
 	return -1;
 }
@@ -730,8 +729,8 @@ int __init gart_iommu_init(void)
 	    !gart_iommu_aperture ||
 	    (no_agp && init_amd_gatt(&info) < 0)) {
 		if (max_pfn > MAX_DMA32_PFN) {
-			pr_warning("More than 4GB of memory but GART IOMMU not available.\n");
-			pr_warning("falling back to iommu=soft.\n");
+			pr_warn("More than 4GB of memory but GART IOMMU not available.\n");
+			pr_warn("falling back to iommu=soft.\n");
 		}
 		return 0;
 	}
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 9e2dd2b296cd..3570864b8329 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -780,8 +780,8 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 
 	res = (((u64)deltapm) *  mult) >> 22;
 	do_div(res, 1000000);
-	pr_warning("APIC calibration not consistent "
-		   "with PM-Timer: %ldms instead of 100ms\n",(long)res);
+	pr_warn("APIC calibration not consistent "
+		"with PM-Timer: %ldms instead of 100ms\n", (long)res);
 
 	/* Correct the lapic counter value */
 	res = (((u64)(*delta)) * pm_100ms);
@@ -977,7 +977,7 @@ static int __init calibrate_APIC_clock(void)
 	 */
 	if (lapic_timer_period < (1000000 / HZ)) {
 		local_irq_enable();
-		pr_warning("APIC frequency too slow, disabling apic timer\n");
+		pr_warn("APIC frequency too slow, disabling apic timer\n");
 		return -1;
 	}
 
@@ -1021,7 +1021,7 @@ static int __init calibrate_APIC_clock(void)
 	local_irq_enable();
 
 	if (levt->features & CLOCK_EVT_FEAT_DUMMY) {
-		pr_warning("APIC timer disabled due to verification failure\n");
+		pr_warn("APIC timer disabled due to verification failure\n");
 		return -1;
 	}
 
@@ -1095,8 +1095,8 @@ static void local_apic_timer_interrupt(void)
 	 * spurious.
 	 */
 	if (!evt->event_handler) {
-		pr_warning("Spurious LAPIC timer interrupt on cpu %d\n",
-			   smp_processor_id());
+		pr_warn("Spurious LAPIC timer interrupt on cpu %d\n",
+			smp_processor_id());
 		/* Switch it off */
 		lapic_timer_shutdown(evt);
 		return;
@@ -1809,11 +1809,11 @@ static int __init setup_nox2apic(char *str)
 		int apicid = native_apic_msr_read(APIC_ID);
 
 		if (apicid >= 255) {
-			pr_warning("Apicid: %08x, cannot enforce nox2apic\n",
-				   apicid);
+			pr_warn("Apicid: %08x, cannot enforce nox2apic\n",
+				apicid);
 			return 0;
 		}
-		pr_warning("x2apic already enabled.\n");
+		pr_warn("x2apic already enabled.\n");
 		__x2apic_disable();
 	}
 	setup_clear_cpu_cap(X86_FEATURE_X2APIC);
@@ -1981,7 +1981,7 @@ static int __init apic_verify(void)
 	 */
 	features = cpuid_edx(1);
 	if (!(features & (1 << X86_FEATURE_APIC))) {
-		pr_warning("Could not enable APIC!\n");
+		pr_warn("Could not enable APIC!\n");
 		return -1;
 	}
 	set_cpu_cap(&boot_cpu_data, X86_FEATURE_APIC);
@@ -2408,9 +2408,8 @@ int generic_processor_info(int apicid, int version)
 	    disabled_cpu_apicid == apicid) {
 		int thiscpu = num_processors + disabled_cpus;
 
-		pr_warning("APIC: Disabling requested cpu."
-			   " Processor %d/0x%x ignored.\n",
-			   thiscpu, apicid);
+		pr_warn("APIC: Disabling requested cpu."
+			" Processor %d/0x%x ignored.\n", thiscpu, apicid);
 
 		disabled_cpus++;
 		return -ENODEV;
@@ -2424,8 +2423,7 @@ int generic_processor_info(int apicid, int version)
 	    apicid != boot_cpu_physical_apicid) {
 		int thiscpu = max + disabled_cpus - 1;
 
-		pr_warning(
-			"APIC: NR_CPUS/possible_cpus limit of %i almost"
+		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i almost"
 			" reached. Keeping one slot for boot cpu."
 			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
 
@@ -2436,9 +2434,8 @@ int generic_processor_info(int apicid, int version)
 	if (num_processors >= nr_cpu_ids) {
 		int thiscpu = max + disabled_cpus;
 
-		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
-			   "reached. Processor %d/0x%x ignored.\n",
-			   max, thiscpu, apicid);
+		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
+			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
 
 		disabled_cpus++;
 		return -EINVAL;
@@ -2468,13 +2465,13 @@ int generic_processor_info(int apicid, int version)
 	 * Validate version
 	 */
 	if (version == 0x0) {
-		pr_warning("BIOS bug: APIC version is 0 for CPU %d/0x%x, fixing up to 0x10\n",
-			   cpu, apicid);
+		pr_warn("BIOS bug: APIC version is 0 for CPU %d/0x%x, fixing up to 0x10\n",
+			cpu, apicid);
 		version = 0x10;
 	}
 
 	if (version != boot_cpu_apic_version) {
-		pr_warning("BIOS bug: APIC version mismatch, boot CPU: %x, CPU %d: version %x\n",
+		pr_warn("BIOS bug: APIC version mismatch, boot CPU: %x, CPU %d: version %x\n",
 			boot_cpu_apic_version, cpu, version);
 	}
 
@@ -2843,7 +2840,7 @@ static int __init apic_set_verbosity(char *arg)
 		apic_verbosity = APIC_VERBOSE;
 #ifdef CONFIG_X86_64
 	else {
-		pr_warning("APIC Verbosity level %s not recognised"
+		pr_warn("APIC Verbosity level %s not recognised"
 			" use apic=verbose or apic=debug\n", arg);
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 86663874ef04..e6d7894ad127 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -207,8 +207,8 @@ void __init setup_per_cpu_areas(void)
 					    pcpu_cpu_distance,
 					    pcpu_fc_alloc, pcpu_fc_free);
 		if (rc < 0)
-			pr_warning("%s allocator failed (%d), falling back to page size\n",
-				   pcpu_fc_names[pcpu_chosen_fc], rc);
+			pr_warn("%s allocator failed (%d), falling back to page size\n",
+				pcpu_fc_names[pcpu_chosen_fc], rc);
 	}
 	if (rc < 0)
 		rc = pcpu_page_first_chunk(PERCPU_FIRST_CHUNK_RESERVE,
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index a49fe1dcb47e..4c61f0713832 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -57,7 +57,7 @@ void __init tboot_probe(void)
 	 */
 	if (!e820__mapped_any(boot_params.tboot_addr,
 			     boot_params.tboot_addr, E820_TYPE_RESERVED)) {
-		pr_warning("non-0 tboot_addr but it is not of type E820_TYPE_RESERVED\n");
+		pr_warn("non-0 tboot_addr but it is not of type E820_TYPE_RESERVED\n");
 		return;
 	}
 
@@ -65,13 +65,12 @@ void __init tboot_probe(void)
 	set_fixmap(FIX_TBOOT_BASE, boot_params.tboot_addr);
 	tboot = (struct tboot *)fix_to_virt(FIX_TBOOT_BASE);
 	if (memcmp(&tboot_uuid, &tboot->uuid, sizeof(tboot->uuid))) {
-		pr_warning("tboot at 0x%llx is invalid\n",
-			   boot_params.tboot_addr);
+		pr_warn("tboot at 0x%llx is invalid\n", boot_params.tboot_addr);
 		tboot = NULL;
 		return;
 	}
 	if (tboot->version < 5) {
-		pr_warning("tboot version is invalid: %u\n", tboot->version);
+		pr_warn("tboot version is invalid: %u\n", tboot->version);
 		tboot = NULL;
 		return;
 	}
@@ -289,7 +288,7 @@ static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
 
 	if (sleep_state >= ACPI_S_STATE_COUNT ||
 	    acpi_shutdown_map[sleep_state] == -1) {
-		pr_warning("unsupported sleep state 0x%x\n", sleep_state);
+		pr_warn("unsupported sleep state 0x%x\n", sleep_state);
 		return -1;
 	}
 
@@ -302,7 +301,7 @@ static int tboot_extended_sleep(u8 sleep_state, u32 val_a, u32 val_b)
 	if (!tboot_enabled())
 		return 0;
 
-	pr_warning("tboot is not able to suspend on platforms with reduced hardware sleep (ACPIv5)");
+	pr_warn("tboot is not able to suspend on platforms with reduced hardware sleep (ACPIv5)");
 	return -ENODEV;
 }
 
@@ -320,7 +319,7 @@ static int tboot_wait_for_aps(int num_aps)
 	}
 
 	if (timeout)
-		pr_warning("tboot wait for APs timeout\n");
+		pr_warn("tboot wait for APs timeout\n");
 
 	return !(atomic_read((atomic_t *)&tboot->num_in_wfs) == num_aps);
 }
@@ -516,7 +515,7 @@ int tboot_force_iommu(void)
 		return 1;
 
 	if (no_iommu || swiotlb || dmar_disabled)
-		pr_warning("Forcing Intel-IOMMU to enabled\n");
+		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
 	dmar_disabled = 0;
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index ec534f978867..b8acf639abd1 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -364,12 +364,12 @@ void check_tsc_sync_source(int cpu)
 		/* Force it to 0 if random warps brought us here */
 		atomic_set(&test_runs, 0);
 
-		pr_warning("TSC synchronization [CPU#%d -> CPU#%d]:\n",
+		pr_warn("TSC synchronization [CPU#%d -> CPU#%d]:\n",
 			smp_processor_id(), cpu);
-		pr_warning("Measured %Ld cycles TSC warp between CPUs, "
-			   "turning off TSC clock.\n", max_warp);
+		pr_warn("Measured %Ld cycles TSC warp between CPUs, "
+			"turning off TSC clock.\n", max_warp);
 		if (random_warps)
-			pr_warning("TSC warped randomly between CPUs\n");
+			pr_warn("TSC warped randomly between CPUs\n");
 		mark_tsc_unstable("check_tsc_sync_source failed");
 	}
 
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 548fefed71ee..b4a304893189 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -91,7 +91,7 @@ const char * const umip_insns[5] = {
 
 #define umip_pr_err(regs, fmt, ...) \
 	umip_printk(regs, KERN_ERR, fmt, ##__VA_ARGS__)
-#define umip_pr_warning(regs, fmt, ...) \
+#define umip_pr_warn(regs, fmt, ...) \
 	umip_printk(regs, KERN_WARNING, fmt,  ##__VA_ARGS__)
 
 /**
@@ -380,14 +380,14 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	if (umip_inst < 0)
 		return false;
 
-	umip_pr_warning(regs, "%s instruction cannot be used by applications.\n",
+	umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
 			umip_insns[umip_inst]);
 
 	/* Do not emulate (spoof) SLDT or STR. */
 	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
 		return false;
 
-	umip_pr_warning(regs, "For now, expensive software emulation returns the result.\n");
+	umip_pr_warn(regs, "For now, expensive software emulation returns the result.\n");
 
 	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
 			      user_64bit_mode(regs)))
diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index 79eb55ce69a9..49d7814b59a9 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -193,8 +193,8 @@ static int arm_kmmio_fault_page(struct kmmio_fault_page *f)
 	int ret;
 	WARN_ONCE(f->armed, KERN_ERR pr_fmt("kmmio page already armed.\n"));
 	if (f->armed) {
-		pr_warning("double-arm: addr 0x%08lx, ref %d, old %d\n",
-			   f->addr, f->count, !!f->old_presence);
+		pr_warn("double-arm: addr 0x%08lx, ref %d, old %d\n",
+			f->addr, f->count, !!f->old_presence);
 	}
 	ret = clear_page_presence(f, true);
 	WARN_ONCE(ret < 0, KERN_ERR pr_fmt("arming at 0x%08lx failed.\n"),
@@ -341,8 +341,7 @@ static int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
 		 * something external causing them (f.e. using a debugger while
 		 * mmio tracing enabled), or erroneous behaviour
 		 */
-		pr_warning("unexpected debug trap on CPU %d.\n",
-			   smp_processor_id());
+		pr_warn("unexpected debug trap on CPU %d.\n", smp_processor_id());
 		goto out;
 	}
 
diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index b8ef8557d4b3..673de6063345 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -394,7 +394,7 @@ static void enter_uniprocessor(void)
 	}
 out:
 	if (num_online_cpus() > 1)
-		pr_warning("multiple CPUs still online, may miss events.\n");
+		pr_warn("multiple CPUs still online, may miss events.\n");
 }
 
 static void leave_uniprocessor(void)
@@ -418,8 +418,8 @@ static void leave_uniprocessor(void)
 static void enter_uniprocessor(void)
 {
 	if (num_online_cpus() > 1)
-		pr_warning("multiple CPUs are online, may miss events. "
-			   "Suggest booting with maxcpus=1 kernel argument.\n");
+		pr_warn("multiple CPUs are online, may miss events. "
+			"Suggest booting with maxcpus=1 kernel argument.\n");
 }
 
 static void leave_uniprocessor(void)
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index abffa0be80da..7f1d2034df1e 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -438,7 +438,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 		goto no_emu;
 
 	if (numa_cleanup_meminfo(&ei) < 0) {
-		pr_warning("NUMA: Warning: constructed meminfo invalid, disabling emulation\n");
+		pr_warn("NUMA: Warning: constructed meminfo invalid, disabling emulation\n");
 		goto no_emu;
 	}
 
@@ -449,7 +449,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 		phys = memblock_find_in_range(0, PFN_PHYS(max_pfn_mapped),
 					      phys_size, PAGE_SIZE);
 		if (!phys) {
-			pr_warning("NUMA: Warning: can't allocate copy of distance table, disabling emulation\n");
+			pr_warn("NUMA: Warning: can't allocate copy of distance table, disabling emulation\n");
 			goto no_emu;
 		}
 		memblock_reserve(phys, phys_size);
diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index 0881e1ff1e58..afd828a57c33 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -122,9 +122,9 @@ static int __init init(void)
 		return -ENXIO;
 	}
 
-	pr_warning("WARNING: mapping %lu kB @ 0x%08lx in PCI address space, "
-		   "and writing 16 kB of rubbish in there.\n",
-		   size >> 10, mmio_address);
+	pr_warn("WARNING: mapping %lu kB @ 0x%08lx in PCI address space, "
+		"and writing 16 kB of rubbish in there.\n",
+		size >> 10, mmio_address);
 	do_test(size);
 	do_test_bulk_ioremapping();
 	pr_info("All done.\n");
diff --git a/arch/x86/oprofile/op_x86_model.h b/arch/x86/oprofile/op_x86_model.h
index 71e8a67337e2..276cf79b5d24 100644
--- a/arch/x86/oprofile/op_x86_model.h
+++ b/arch/x86/oprofile/op_x86_model.h
@@ -67,13 +67,13 @@ static inline void op_x86_warn_in_use(int counter)
 	 * cannot be monitored by any other counter, contact your
 	 * hardware or BIOS vendor.
 	 */
-	pr_warning("oprofile: counter #%d on cpu #%d may already be used\n",
-		   counter, smp_processor_id());
+	pr_warn("oprofile: counter #%d on cpu #%d may already be used\n",
+		counter, smp_processor_id());
 }
 
 static inline void op_x86_warn_reserved(int counter)
 {
-	pr_warning("oprofile: counter #%d is already reserved\n", counter);
+	pr_warn("oprofile: counter #%d is already reserved\n", counter);
 }
 
 extern u64 op_x86_get_ctrl(struct op_x86_model_spec const *model,
diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 6d193bb36021..089413cd944e 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -39,7 +39,7 @@ static int set_lid_wake_behavior(bool wake_on_close)
 
 	status = acpi_execute_simple_method(NULL, "\\_SB.PCI0.LID.LIDW", wake_on_close);
 	if (ACPI_FAILURE(status)) {
-		pr_warning(PFX "failed to set lid behavior\n");
+		pr_warn(PFX "failed to set lid behavior\n");
 		return 1;
 	}
 
diff --git a/arch/x86/platform/sfi/sfi.c b/arch/x86/platform/sfi/sfi.c
index bf6016f8db4e..6259563760f9 100644
--- a/arch/x86/platform/sfi/sfi.c
+++ b/arch/x86/platform/sfi/sfi.c
@@ -26,8 +26,7 @@ static unsigned long sfi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 static void __init mp_sfi_register_lapic(u8 id)
 {
 	if (MAX_LOCAL_APIC - id <= 0) {
-		pr_warning("Processor #%d invalid (max %d)\n",
-			id, MAX_LOCAL_APIC);
+		pr_warn("Processor #%d invalid (max %d)\n", id, MAX_LOCAL_APIC);
 		return;
 	}
 
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 548d1e0a5ba1..33b0e20df7fc 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -412,7 +412,7 @@ static unsigned long __init xen_set_identity_and_remap_chunk(
 
 		remap_range_size = xen_find_pfn_range(&remap_pfn);
 		if (!remap_range_size) {
-			pr_warning("Unable to find available pfn range, not remapping identity pages\n");
+			pr_warn("Unable to find available pfn range, not remapping identity pages\n");
 			xen_set_identity_and_release_chunk(cur_pfn,
 						cur_pfn + left, nr_pages);
 			break;
-- 
2.20.1

