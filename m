Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2482C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4C721881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="h9R2LslY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfICQqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:46:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfICQqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:46:40 -0400
Received: from zn.tnic (p200300EC2F0CBF00D12B638A55CBD0AB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:bf00:d12b:638a:55cb:d0ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6633D1EC0A6C;
        Tue,  3 Sep 2019 18:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567529194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PC72vzEs5y5hIPGjNcj3CgUHQP65WrqBlKtpqNomqFo=;
        b=h9R2LslYsdrkRs7HZn4xLAs9wbE8MaR9OUoIwmPdof9/NbbBfOBR3+vQ14/TQ4yhDidbge
        +05I0v3M1uR8UozTndAH7Hx5cZHaBIIen3LOhl0LX+htf7beYlh9ZBpk7R9bIsZ+mmwBe0
        b12klZSJ23UfHmLrcseYt+SW1FQKvKA=
Date:   Tue, 3 Sep 2019 18:46:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190903164630.GF11641@zn.tnic>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com>
 <20190829060942.GA1312@zn.tnic>
 <20190829130213.GA23510@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190829130213.GA23510@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 06:02:14AM -0700, Raj, Ashok wrote:
> > As I've said before, I don't like the churn in this version and how it
> > turns out. I'll have a look at how to do this cleanly when I get some
> > free cycles.

Ok, here's an untested rough version. It is doing a couple of things in
one go, including cleanups, which I'll eventually separate out but it
should suffice for now to show the intent: namely, reload the microcode
revision which late loading has loaded already in the past. See, pls, if
that suffices for your microcoders' needs.

Thx.

---
diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index a320d37982ed..4b2b9c350cea 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -110,6 +110,17 @@ The loading mechanism looks for microcode blobs in
 /lib/firmware/{intel-ucode,amd-ucode}. The default distro installation
 packages already put them there.
 
+Normally, microcode will be updated only if the current revision's
+number is smaller than the new one.
+
+Reload of the current revision can be done by doing::
+
+  # echo 2 > /sys/devices/system/cpu/microcode/reload
+
+as root. This is meant to have a quicker turnaround when testing
+microcode patches and will taint the kernel so do not use it if you
+don't know what you're doing.
+
 Builtin microcode
 =================
 
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 2b7cc5397f80..3e53ce875e55 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -35,19 +35,24 @@ struct microcode_ops {
 	enum ucode_state (*request_microcode_user) (int cpu,
 				const void __user *buf, size_t size);
 
-	enum ucode_state (*request_microcode_fw) (int cpu, struct device *,
+	enum ucode_state (*request_microcode_fw)(int cpu, struct device *dev,
 						  bool refresh_fw);
 
-	void (*microcode_fini_cpu) (int cpu);
+	void (*microcode_fini_cpu)(int cpu);
 
 	/*
 	 * The generic 'microcode_core' part guarantees that
-	 * the callbacks below run on a target cpu when they
+	 * the callbacks below run on a target CPU when they
 	 * are being called.
-	 * See also the "Synchronization" section in microcode_core.c.
+	 * See also the "Synchronization" section in microcode/core.c.
 	 */
-	enum ucode_state (*apply_microcode) (int cpu);
+	enum ucode_state (*apply_microcode)(unsigned int cpu);
 	int (*collect_cpu_info) (int cpu, struct cpu_signature *csig);
+
+	/*
+	 * Attempt to reapply microcode without any checking whatsoever.
+	 */
+	enum ucode_state (*apply_microcode_nocheck)(unsigned int cpu);
 };
 
 struct ucode_cpu_info {
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a0e52bd00ecc..e9e2bd9e5d4d 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -666,7 +666,7 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	return 0;
 }
 
-static enum ucode_state apply_microcode_amd(int cpu)
+static enum ucode_state apply_microcode_amd(unsigned int cpu)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_amd *mc_amd;
@@ -675,7 +675,8 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	enum ucode_state ret;
 	u32 rev, dummy;
 
-	BUG_ON(raw_smp_processor_id() != cpu);
+	if (WARN_ON(raw_smp_processor_id() != cpu))
+		return UCODE_ERROR;
 
 	uci = ucode_cpu_info + cpu;
 
@@ -716,6 +717,28 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	return ret;
 }
 
+static enum ucode_state apply_microcode_nocheck_amd(unsigned int cpu)
+{
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	struct microcode_amd *mc;
+
+	if (WARN_ON(raw_smp_processor_id() != cpu))
+		return UCODE_ERROR;
+
+	if (!uci->mc)
+		return UCODE_NFOUND;
+
+	mc = uci->mc;
+
+	if (__apply_microcode_amd(mc)) {
+		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
+			cpu, mc->hdr.patch_id);
+		return UCODE_ERROR;
+	}
+
+	return UCODE_OK;
+}
+
 static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 {
 	u32 equiv_tbl_len;
@@ -933,11 +956,12 @@ static void microcode_fini_cpu_amd(int cpu)
 }
 
 static struct microcode_ops microcode_amd_ops = {
-	.request_microcode_user           = request_microcode_user,
-	.request_microcode_fw             = request_microcode_amd,
-	.collect_cpu_info                 = collect_cpu_info_amd,
-	.apply_microcode                  = apply_microcode_amd,
-	.microcode_fini_cpu               = microcode_fini_cpu_amd,
+	.request_microcode_user		= request_microcode_user,
+	.request_microcode_fw		= request_microcode_amd,
+	.collect_cpu_info		= collect_cpu_info_amd,
+	.apply_microcode		= apply_microcode_amd,
+	.apply_microcode_nocheck	= apply_microcode_nocheck_amd,
+	.microcode_fini_cpu		= microcode_fini_cpu_amd,
 };
 
 struct microcode_ops * __init init_amd_microcode(void)
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7019d4b2df0c..345deaf55119 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -42,6 +42,8 @@
 
 #define DRIVER_VERSION	"2.2"
 
+typedef void (*apply_fn_t)(void *arg);
+
 static struct microcode_ops	*microcode_ops;
 static bool dis_ucode_ldr = true;
 
@@ -379,6 +381,13 @@ static void apply_microcode_local(void *arg)
 	*err = microcode_ops->apply_microcode(smp_processor_id());
 }
 
+static void apply_microcode_nocheck(void *arg)
+{
+	enum ucode_state *err = arg;
+
+	*err = microcode_ops->apply_microcode_nocheck(smp_processor_id());
+}
+
 static int apply_microcode_on_target(int cpu)
 {
 	enum ucode_state err;
@@ -550,6 +559,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
  */
 static int __reload_late(void *info)
 {
+	apply_fn_t ap_func = (apply_fn_t)(info);
 	int cpu = smp_processor_id();
 	enum ucode_state err;
 	int ret = 0;
@@ -569,7 +579,7 @@ static int __reload_late(void *info)
 	 * below.
 	 */
 	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
-		apply_microcode_local(&err);
+		ap_func(&err);
 	else
 		goto wait_for_siblings;
 
@@ -591,7 +601,7 @@ static int __reload_late(void *info)
 	 * revision.
 	 */
 	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
-		apply_microcode_local(&err);
+		ap_func(&err);
 
 	return ret;
 }
@@ -600,14 +610,14 @@ static int __reload_late(void *info)
  * Reload microcode late on all CPUs. Wait for a sec until they
  * all gather together.
  */
-static int microcode_reload_late(void)
+static int microcode_reload_late(apply_fn_t apply_func)
 {
 	int ret;
 
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
-	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+	ret = stop_machine_cpuslocked(__reload_late, apply_func, cpu_online_mask);
 	if (ret > 0)
 		microcode_check();
 
@@ -629,8 +639,12 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (val != 1)
+	if (val == 2) {
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+		return microcode_reload_late(apply_microcode_nocheck);
+	} else if (val != 1) {
 		return size;
+	}
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
 	if (tmp_ret != UCODE_NEW)
@@ -643,7 +657,7 @@ static ssize_t reload_store(struct device *dev,
 		goto put;
 
 	mutex_lock(&microcode_mutex);
-	ret = microcode_reload_late();
+	ret = microcode_reload_late(apply_microcode_local);
 	mutex_unlock(&microcode_mutex);
 
 put:
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6a99535d7f37..4cc438833f3f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -787,7 +787,7 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 	return 0;
 }
 
-static enum ucode_state apply_microcode_intel(int cpu)
+static enum ucode_state apply_microcode_intel(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -859,6 +859,31 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	return ret;
 }
 
+static enum ucode_state apply_microcode_nocheck_intel(unsigned int cpu)
+{
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	struct microcode_intel *mc;
+
+	if (WARN_ON(raw_smp_processor_id() != cpu))
+		return UCODE_ERROR;
+
+	if (!uci->mc)
+		return UCODE_NFOUND;
+
+	mc = uci->mc;
+
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
+	/* write microcode via MSR 0x79 */
+	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
+
+	return UCODE_OK;
+}
+
 static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -1014,10 +1039,11 @@ request_microcode_user(int cpu, const void __user *buf, size_t size)
 }
 
 static struct microcode_ops microcode_intel_ops = {
-	.request_microcode_user		  = request_microcode_user,
-	.request_microcode_fw             = request_microcode_fw,
-	.collect_cpu_info                 = collect_cpu_info,
-	.apply_microcode                  = apply_microcode_intel,
+	.request_microcode_user		= request_microcode_user,
+	.request_microcode_fw		= request_microcode_fw,
+	.collect_cpu_info		= collect_cpu_info,
+	.apply_microcode		= apply_microcode_intel,
+	.apply_microcode_nocheck	= apply_microcode_nocheck_intel,
 };
 
 static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
