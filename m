Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58DDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E082070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfH2Fde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:33:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:11120 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfH2Fde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:33:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 22:33:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="182238593"
Received: from otc-nc-03.jf.intel.com ([10.54.39.145])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2019 22:33:32 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/microcode: Add an option to reload microcode even if revision is unchanged
Date:   Wed, 28 Aug 2019 22:33:22 -0700
Message-Id: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During microcode development, its often required to test different versions
of microcode. Intel microcode loader enforces loading only if the revision is
greater than what is currently loaded on the cpu. Overriding this behavior
allows us to reuse the same revision during development cycles.
This facilty also allows us to share debug microcode with development
partners for getting feedback before microcode release.

Microcode developers should have other ways to check which
of their internal version is actually loaded. For e.g. checking a
temporary MSR for instance. In order to reload the same microcode do as
shown below.

 # echo 2 > /sys/devices/system/cpu/microcode/reload

 as root.


I tested this on top of the parallel ucode load patch

https://lore.kernel.org/r/1566506627-16536-2-git-send-email-mihai.carabas@oracle.com/

v2: [Mihai] Address comments from Boris
	- Support for AMD
	- add taint flag
	- removed global force_ucode_load and parameterized it.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Mihai Carabas <mihai.carabas@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jon Grimm <Jon.Grimm@amd.com>
Cc: kanth.ghatraju@oracle.com
Cc: konrad.wilk@oracle.com
Cc: patrick.colp@oracle.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 Documentation/x86/microcode.rst       |  7 ++++
 arch/x86/include/asm/microcode.h      |  4 +--
 arch/x86/kernel/cpu/microcode/amd.c   | 19 ++++++-----
 arch/x86/kernel/cpu/microcode/core.c  | 31 ++++++++++++------
 arch/x86/kernel/cpu/microcode/intel.c | 61 ++++++++++++++++++++++++++---------
 5 files changed, 88 insertions(+), 34 deletions(-)

diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index a320d37..ad804eb 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -110,6 +110,13 @@ The loading mechanism looks for microcode blobs in
 /lib/firmware/{intel-ucode,amd-ucode}. The default distro installation
 packages already put them there.
 
+The microcode will not be updated if the existing revision is newer or the
+same. In order to force a reload you can run the following command::
+
+  # echo 2 > /sys/devices/system/cpu/microcode/reload
+
+as root.
+
 Builtin microcode
 =================
 
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 2b7cc53..f5bc849 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -36,7 +36,7 @@ struct microcode_ops {
 				const void __user *buf, size_t size);
 
 	enum ucode_state (*request_microcode_fw) (int cpu, struct device *,
-						  bool refresh_fw);
+						  bool refresh_fw, bool force_ucode_load);
 
 	void (*microcode_fini_cpu) (int cpu);
 
@@ -46,7 +46,7 @@ struct microcode_ops {
 	 * are being called.
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
-	enum ucode_state (*apply_microcode) (int cpu);
+	enum ucode_state (*apply_microcode) (int cpu, bool force_ucode_load);
 	int (*collect_cpu_info) (int cpu, struct cpu_signature *csig);
 };
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 4ddadf6..1d6e4e2 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -539,7 +539,8 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
 }
 
 static enum ucode_state
-load_microcode_amd(bool save, u8 family, const u8 *data, size_t size);
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size,
+		   bool force_ucode_load);
 
 int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 {
@@ -557,7 +558,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	if (!desc.mc)
 		return -EINVAL;
 
-	ret = load_microcode_amd(true, x86_family(cpuid_1_eax), desc.data, desc.size);
+	ret = load_microcode_amd(true, x86_family(cpuid_1_eax), desc.data, desc.size, false);
 	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
@@ -666,7 +667,7 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	return 0;
 }
 
-static enum ucode_state apply_microcode_amd(int cpu)
+static enum ucode_state apply_microcode_amd(int cpu, bool force_ucode_load)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_amd *mc_amd;
@@ -689,7 +690,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (rev >= mc_amd->hdr.patch_id && !force_ucode_load) {
 		ret = UCODE_OK;
 		goto out;
 	}
@@ -835,7 +836,8 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 }
 
 static enum ucode_state
-load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size,
+		   bool force_ucode_load)
 {
 	struct ucode_patch *p;
 	enum ucode_state ret;
@@ -853,7 +855,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 	if (!p) {
 		return ret;
 	} else {
-		if (boot_cpu_data.microcode >= p->patch_id)
+		if (boot_cpu_data.microcode >= p->patch_id && !force_ucode_load)
 			return ret;
 
 		ret = UCODE_NEW;
@@ -886,7 +888,8 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
  * These might be larger than 2K.
  */
 static enum ucode_state request_microcode_amd(int cpu, struct device *device,
-					      bool refresh_fw)
+					      bool refresh_fw,
+					      bool force_ucode_load)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -910,7 +913,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	if (!verify_container(fw->data, fw->size, false))
 		goto fw_release;
 
-	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
+	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size, force_ucode_load);
 
  fw_release:
 	release_firmware(fw);
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7019d4b..c4181b7 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -376,7 +376,7 @@ static void apply_microcode_local(void *arg)
 {
 	enum ucode_state *err = arg;
 
-	*err = microcode_ops->apply_microcode(smp_processor_id());
+	*err = microcode_ops->apply_microcode(smp_processor_id(), false);
 }
 
 static int apply_microcode_on_target(int cpu)
@@ -550,6 +550,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
  */
 static int __reload_late(void *info)
 {
+	bool force_ucode_load = (bool) info;
 	int cpu = smp_processor_id();
 	enum ucode_state err;
 	int ret = 0;
@@ -569,7 +570,7 @@ static int __reload_late(void *info)
 	 * below.
 	 */
 	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
-		apply_microcode_local(&err);
+		err = microcode_ops->apply_microcode(smp_processor_id(), force_ucode_load);
 	else
 		goto wait_for_siblings;
 
@@ -600,14 +601,14 @@ static int __reload_late(void *info)
  * Reload microcode late on all CPUs. Wait for a sec until they
  * all gather together.
  */
-static int microcode_reload_late(void)
+static int microcode_reload_late(bool force_ucode_load)
 {
 	int ret;
 
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
-	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+	ret = stop_machine_cpuslocked(__reload_late, (void *)force_ucode_load, cpu_online_mask);
 	if (ret > 0)
 		microcode_check();
 
@@ -622,6 +623,7 @@ static ssize_t reload_store(struct device *dev,
 {
 	enum ucode_state tmp_ret = UCODE_OK;
 	int bsp = boot_cpu_data.cpu_index;
+	bool force_ucode_load = false;
 	unsigned long val;
 	ssize_t ret = 0;
 
@@ -629,10 +631,21 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (val != 1)
+	if (!val || val > 2)
 		return size;
 
-	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
+	/*
+	 * Check if the value is 2 to permit reloading microcode even if the revision
+	 * is unchanged. This is typically used during development of microcode and
+	 * changing rev is a pain. Also this is why we also added here a
+	 * TAINT_CPU_OUT_OF_SPEC taint.
+	 */
+	if (val == 2) {
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+		force_ucode_load = true;
+	}
+
+	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true, force_ucode_load);
 	if (tmp_ret != UCODE_NEW)
 		return size;
 
@@ -643,7 +656,7 @@ static ssize_t reload_store(struct device *dev,
 		goto put;
 
 	mutex_lock(&microcode_mutex);
-	ret = microcode_reload_late();
+	ret = microcode_reload_late(force_ucode_load);
 	mutex_unlock(&microcode_mutex);
 
 put:
@@ -717,7 +730,7 @@ static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
 	if (system_state != SYSTEM_RUNNING)
 		return UCODE_NFOUND;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw);
+	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw, false);
 	if (ustate == UCODE_NEW) {
 		pr_debug("CPU%d updated upon init\n", cpu);
 		apply_microcode_on_target(cpu);
@@ -786,7 +799,7 @@ static void mc_bp_resume(void)
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
 	if (uci->valid && uci->mc)
-		microcode_ops->apply_microcode(cpu);
+		microcode_ops->apply_microcode(cpu, false);
 	else if (!uci->mc)
 		reload_early_microcode();
 }
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6a99535..631b5a4 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -90,11 +90,13 @@ static int find_matching_signature(void *mc, unsigned int csig, int cpf)
 /*
  * Returns 1 if update has been found, 0 otherwise.
  */
-static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
+static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev,
+			    bool force_ucode_load)
 {
 	struct microcode_header_intel *mc_hdr = mc;
 
-	if (mc_hdr->rev <= new_rev)
+	if ((mc_hdr->rev < new_rev) || (mc_hdr->rev == new_rev &&
+					!force_ucode_load))
 		return 0;
 
 	return find_matching_signature(mc, csig, cpf);
@@ -359,7 +361,8 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 			if (!has_newer_microcode(data,
 						 uci->cpu_sig.sig,
 						 uci->cpu_sig.pf,
-						 uci->cpu_sig.rev))
+						 uci->cpu_sig.rev,
+						 false))
 				goto next;
 
 		} else {
@@ -368,7 +371,8 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 			if (!has_newer_microcode(data,
 						 phdr->sig,
 						 phdr->pf,
-						 phdr->rev))
+						 phdr->rev,
+						 false))
 				goto next;
 		}
 
@@ -721,7 +725,7 @@ void load_ucode_intel_ap(void)
 	}
 }
 
-static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
+static struct microcode_intel *find_patch(struct ucode_cpu_info *uci, bool force_ucode_load)
 {
 	struct microcode_header_intel *phdr;
 	struct ucode_patch *iter, *tmp;
@@ -730,7 +734,8 @@ static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
 
 		phdr = (struct microcode_header_intel *)iter->data;
 
-		if (phdr->rev <= uci->cpu_sig.rev)
+		if ((phdr->rev < uci->cpu_sig.rev) ||
+			(phdr->rev == uci->cpu_sig.rev && !force_ucode_load))
 			continue;
 
 		if (!find_matching_signature(phdr,
@@ -750,7 +755,7 @@ void reload_ucode_intel(void)
 
 	collect_cpu_info_early(&uci);
 
-	p = find_patch(&uci);
+	p = find_patch(&uci, false);
 	if (!p)
 		return;
 
@@ -787,7 +792,7 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 	return 0;
 }
 
-static enum ucode_state apply_microcode_intel(int cpu)
+static enum ucode_state apply_microcode_intel(int cpu, bool force_ucode_load)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -802,7 +807,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_ERROR;
 
 	/* Look for a newer patch in our cache: */
-	mc = find_patch(uci);
+	mc = find_patch(uci, force_ucode_load);
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -815,11 +820,35 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	 * already.
 	 */
 	rev = intel_get_microcode_revision();
-	if (rev >= mc->hdr.rev) {
+	if (rev > mc->hdr.rev) {
 		ret = UCODE_OK;
 		goto out;
 	}
 
+	if (rev == mc->hdr.rev) {
+		/*
+		 * If this isn't the first cpu in the core, just skip
+		 * the actual update since all thread siblings share
+		 * the same microcode resource. We simply update the per-cpu
+		 * revision value that is used in display via /proc/cpuinfo.
+		 */
+		if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu) {
+			ret = UCODE_OK;
+			goto out;
+		} else {
+			/*
+			 * If this is the first cpu in the core, but user
+			 * wanted to force-load the microcode again, then
+			 * go through the real update on the first cpu in every
+			 * core
+			 */
+			if (!force_ucode_load) {
+				ret = UCODE_OK;
+				goto out;
+			}
+		}
+	}
+
 	/*
 	 * Writeback and invalidate caches before updating microcode to avoid
 	 * internal issues depending on what the microcode is updating.
@@ -859,7 +888,8 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
+static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter,
+					    bool force_ucode_load)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
@@ -907,7 +937,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 
 		csig = uci->cpu_sig.sig;
 		cpf = uci->cpu_sig.pf;
-		if (has_newer_microcode(mc, csig, cpf, new_rev)) {
+		if (has_newer_microcode(mc, csig, cpf, new_rev, force_ucode_load)) {
 			vfree(new_mc);
 			new_rev = mc_header.rev;
 			new_mc  = mc;
@@ -967,7 +997,8 @@ static bool is_blacklisted(unsigned int cpu)
 }
 
 static enum ucode_state request_microcode_fw(int cpu, struct device *device,
-					     bool refresh_fw)
+					     bool refresh_fw,
+					     bool force_ucode_load)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	const struct firmware *firmware;
@@ -990,7 +1021,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
 	iov_iter_kvec(&iter, WRITE, &kvec, 1, firmware->size);
-	ret = generic_load_microcode(cpu, &iter);
+	ret = generic_load_microcode(cpu, &iter, force_ucode_load);
 
 	release_firmware(firmware);
 
@@ -1010,7 +1041,7 @@ request_microcode_user(int cpu, const void __user *buf, size_t size)
 	iov.iov_len = size;
 	iov_iter_init(&iter, WRITE, &iov, 1, size);
 
-	return generic_load_microcode(cpu, &iter);
+	return generic_load_microcode(cpu, &iter, false);
 }
 
 static struct microcode_ops microcode_intel_ops = {
-- 
2.7.4

