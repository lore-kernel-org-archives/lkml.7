Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C9C3A59F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 11:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5812E21773
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 11:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfHRLgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 07:36:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44607 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRLgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 07:36:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzJUS-0003f3-6u; Sun, 18 Aug 2019 13:36:52 +0200
Date:   Sun, 18 Aug 2019 11:34:54 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.3-rc5
References: <156612809428.21323.17038181425044292813.tglx@nanos.tec.linutronix.de>
Message-ID: <156612809428.21323.8140671080028731011.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  a90118c445cc: x86/boot: Save fields explicitly, zero out everything else

A set of fixes for x86:

 - Fix the inconsistent error handling in the umwait init code

 - Rework the boot param zeroing so gcc9 stops complaining about out of
   bound memset. The resulting source code is actually more sane to read
   than the smart solution we had

 - Maintainers update so Tony gets involved when Intel models are added

 - Some more fallthrough fixes

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/apic/32: Fix yet another implicit fallthrough warning

Fenghua Yu (1):
      x86/umwait: Fix error handling in umwait_init()

John Hubbard (1):
      x86/boot: Save fields explicitly, zero out everything else

Thomas Gleixner (1):
      x86/fpu/math-emu: Address fallthrough warnings

Tony Luck (1):
      MAINTAINERS, x86/CPU: Tony Luck will maintain asm/intel-family.h


 MAINTAINERS                            |  7 ++++
 arch/x86/include/asm/bootparam_utils.h | 63 ++++++++++++++++++++++++++--------
 arch/x86/kernel/apic/probe_32.c        |  3 +-
 arch/x86/kernel/cpu/umwait.c           | 39 ++++++++++++++++++++-
 arch/x86/math-emu/errors.c             |  5 +--
 arch/x86/math-emu/fpu_trig.c           |  2 +-
 6 files changed, 99 insertions(+), 20 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e81e60bd7c26..f3a78403b47f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8064,6 +8064,13 @@ T:	git git://git.code.sf.net/p/intel-sas/isci
 S:	Supported
 F:	drivers/scsi/isci/
 
+INTEL CPU family model numbers
+M:	Tony Luck <tony.luck@intel.com>
+M:	x86@kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	arch/x86/include/asm/intel-family.h
+
 INTEL DRM DRIVERS (excluding Poulsbo, Moorestown and derivative chipsets)
 M:	Jani Nikula <jani.nikula@linux.intel.com>
 M:	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 101eb944f13c..f5e90a849bca 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -18,6 +18,20 @@
  * Note: efi_info is commonly left uninitialized, but that field has a
  * private magic, so it is better to leave it unchanged.
  */
+
+#define sizeof_mbr(type, member) ({ sizeof(((type *)0)->member); })
+
+#define BOOT_PARAM_PRESERVE(struct_member)				\
+	{								\
+		.start = offsetof(struct boot_params, struct_member),	\
+		.len   = sizeof_mbr(struct boot_params, struct_member),	\
+	}
+
+struct boot_params_to_save {
+	unsigned int start;
+	unsigned int len;
+};
+
 static void sanitize_boot_params(struct boot_params *boot_params)
 {
 	/* 
@@ -35,21 +49,40 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	 * problems again.
 	 */
 	if (boot_params->sentinel) {
-		/* fields in boot_params are left uninitialized, clear them */
-		boot_params->acpi_rsdp_addr = 0;
-		memset(&boot_params->ext_ramdisk_image, 0,
-		       (char *)&boot_params->efi_info -
-			(char *)&boot_params->ext_ramdisk_image);
-		memset(&boot_params->kbd_status, 0,
-		       (char *)&boot_params->hdr -
-		       (char *)&boot_params->kbd_status);
-		memset(&boot_params->_pad7[0], 0,
-		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
-			(char *)&boot_params->_pad7[0]);
-		memset(&boot_params->_pad8[0], 0,
-		       (char *)&boot_params->eddbuf[0] -
-			(char *)&boot_params->_pad8[0]);
-		memset(&boot_params->_pad9[0], 0, sizeof(boot_params->_pad9));
+		static struct boot_params scratch;
+		char *bp_base = (char *)boot_params;
+		char *save_base = (char *)&scratch;
+		int i;
+
+		const struct boot_params_to_save to_save[] = {
+			BOOT_PARAM_PRESERVE(screen_info),
+			BOOT_PARAM_PRESERVE(apm_bios_info),
+			BOOT_PARAM_PRESERVE(tboot_addr),
+			BOOT_PARAM_PRESERVE(ist_info),
+			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
+			BOOT_PARAM_PRESERVE(hd0_info),
+			BOOT_PARAM_PRESERVE(hd1_info),
+			BOOT_PARAM_PRESERVE(sys_desc_table),
+			BOOT_PARAM_PRESERVE(olpc_ofw_header),
+			BOOT_PARAM_PRESERVE(efi_info),
+			BOOT_PARAM_PRESERVE(alt_mem_k),
+			BOOT_PARAM_PRESERVE(scratch),
+			BOOT_PARAM_PRESERVE(e820_entries),
+			BOOT_PARAM_PRESERVE(eddbuf_entries),
+			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
+			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
+			BOOT_PARAM_PRESERVE(e820_table),
+			BOOT_PARAM_PRESERVE(eddbuf),
+		};
+
+		memset(&scratch, 0, sizeof(scratch));
+
+		for (i = 0; i < ARRAY_SIZE(to_save); i++) {
+			memcpy(save_base + to_save[i].start,
+			       bp_base + to_save[i].start, to_save[i].len);
+		}
+
+		memcpy(boot_params, save_base, sizeof(*boot_params));
 	}
 }
 
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 1492799b8f43..ee2d91e382f1 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -184,7 +184,8 @@ void __init default_setup_apic_routing(void)
 				def_to_bigsmp = 0;
 				break;
 			}
-			/* If P4 and above fall through */
+			/* P4 and above */
+			/* fall through */
 		case X86_VENDOR_HYGON:
 		case X86_VENDOR_AMD:
 			def_to_bigsmp = 1;
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 6a204e7336c1..32b4dc9030aa 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -17,6 +17,12 @@
  */
 static u32 umwait_control_cached = UMWAIT_CTRL_VAL(100000, UMWAIT_C02_ENABLE);
 
+/*
+ * Cache the original IA32_UMWAIT_CONTROL MSR value which is configured by
+ * hardware or BIOS before kernel boot.
+ */
+static u32 orig_umwait_control_cached __ro_after_init;
+
 /*
  * Serialize access to umwait_control_cached and IA32_UMWAIT_CONTROL MSR in
  * the sysfs write functions.
@@ -52,6 +58,23 @@ static int umwait_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * The CPU hotplug callback sets the control MSR to the original control
+ * value.
+ */
+static int umwait_cpu_offline(unsigned int cpu)
+{
+	/*
+	 * This code is protected by the CPU hotplug already and
+	 * orig_umwait_control_cached is never changed after it caches
+	 * the original control MSR value in umwait_init(). So there
+	 * is no race condition here.
+	 */
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached, 0);
+
+	return 0;
+}
+
 /*
  * On resume, restore IA32_UMWAIT_CONTROL MSR on the boot processor which
  * is the only active CPU at this time. The MSR is set up on the APs via the
@@ -185,8 +208,22 @@ static int __init umwait_init(void)
 	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
 		return -ENODEV;
 
+	/*
+	 * Cache the original control MSR value before the control MSR is
+	 * changed. This is the only place where orig_umwait_control_cached
+	 * is modified.
+	 */
+	rdmsrl(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached);
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
-				umwait_cpu_online, NULL);
+				umwait_cpu_online, umwait_cpu_offline);
+	if (ret < 0) {
+		/*
+		 * On failure, the control MSR on all CPUs has the
+		 * original control value.
+		 */
+		return ret;
+	}
 
 	register_syscore_ops(&umwait_syscore_ops);
 
diff --git a/arch/x86/math-emu/errors.c b/arch/x86/math-emu/errors.c
index 6b468517ab71..73dc66d887f3 100644
--- a/arch/x86/math-emu/errors.c
+++ b/arch/x86/math-emu/errors.c
@@ -178,13 +178,15 @@ void FPU_printall(void)
 	for (i = 0; i < 8; i++) {
 		FPU_REG *r = &st(i);
 		u_char tagi = FPU_gettagi(i);
+
 		switch (tagi) {
 		case TAG_Empty:
 			continue;
-			break;
 		case TAG_Zero:
 		case TAG_Special:
+			/* Update tagi for the printk below */
 			tagi = FPU_Special(r);
+			/* fall through */
 		case TAG_Valid:
 			printk("st(%d)  %c .%04lx %04lx %04lx %04lx e%+-6d ", i,
 			       getsign(r) ? '-' : '+',
@@ -198,7 +200,6 @@ void FPU_printall(void)
 			printk("Whoops! Error in errors.c: tag%d is %d ", i,
 			       tagi);
 			continue;
-			break;
 		}
 		printk("%s\n", tag_desc[(int)(unsigned)tagi]);
 	}
diff --git a/arch/x86/math-emu/fpu_trig.c b/arch/x86/math-emu/fpu_trig.c
index 783c509f957a..127ea54122d7 100644
--- a/arch/x86/math-emu/fpu_trig.c
+++ b/arch/x86/math-emu/fpu_trig.c
@@ -1352,7 +1352,7 @@ static void fyl2xp1(FPU_REG *st0_ptr, u_char st0_tag)
 		case TW_Denormal:
 			if (denormal_operand() < 0)
 				return;
-
+			/* fall through */
 		case TAG_Zero:
 		case TAG_Valid:
 			setsign(st0_ptr, getsign(st0_ptr) ^ getsign(st1_ptr));

