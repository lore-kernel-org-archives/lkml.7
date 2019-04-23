Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C388C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392BA214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfDWNEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:04:37 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:7573 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWNEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:04:36 -0400
X-IronPort-AV: E=Sophos;i="5.60,385,1549929600"; 
   d="scan'208";a="84185214"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 2/2] xen/pvh: correctly setup the PV EFI interface for dom0
Date:   Tue, 23 Apr 2019 15:04:16 +0200
Message-ID: <20190423130416.68935-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190423130416.68935-1-roger.pau@citrix.com>
References: <20190423130416.68935-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This involves initializing the boot params EFI related fields and the
efi global variable.

Without this fix a PVH dom0 doesn't detect when booted from EFI, and
thus doesn't support accessing any of the EFI related data.

Reported-by: PGNet Dev <pgnet.dev@gmail.com>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: platform-driver-x86@vger.kernel.org
---
Changes since v1:
 - Call xen_efi_init from xen_pvh_init, this avoids having to move the
   prototype of xen_efi_init to a different header.
---
 arch/x86/platform/pvh/enlighten.c |  8 ++++----
 arch/x86/xen/efi.c                | 12 ++++++------
 arch/x86/xen/enlighten_pv.c       |  2 +-
 arch/x86/xen/enlighten_pvh.c      |  6 +++++-
 arch/x86/xen/xen-ops.h            |  4 ++--
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 62f5c7045944..1861a2ba0f2b 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -44,8 +44,6 @@ void __init __weak mem_map_via_hcall(struct boot_params *ptr __maybe_unused)
 
 static void __init init_pvh_bootparams(bool xen_guest)
 {
-	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
-
 	if ((pvh_start_info.version > 0) && (pvh_start_info.memmap_entries)) {
 		struct hvm_memmap_table_entry *ep;
 		int i;
@@ -103,7 +101,7 @@ static void __init init_pvh_bootparams(bool xen_guest)
  * If we are trying to boot a Xen PVH guest, it is expected that the kernel
  * will have been configured to provide the required override for this routine.
  */
-void __init __weak xen_pvh_init(void)
+void __init __weak xen_pvh_init(struct boot_params *boot_params)
 {
 	xen_raw_printk("Error: Missing xen PVH initialization\n");
 	BUG();
@@ -112,7 +110,7 @@ void __init __weak xen_pvh_init(void)
 static void hypervisor_specific_init(bool xen_guest)
 {
 	if (xen_guest)
-		xen_pvh_init();
+		xen_pvh_init(&pvh_bootparams);
 }
 
 /*
@@ -131,6 +129,8 @@ void __init xen_prepare_pvh(void)
 		BUG();
 	}
 
+	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
+
 	hypervisor_specific_init(xen_guest);
 
 	init_pvh_bootparams(xen_guest);
diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 1fbb629a9d78..0d3365cb64de 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -158,7 +158,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
 	return efi_secureboot_mode_unknown;
 }
 
-void __init xen_efi_init(void)
+void __init xen_efi_init(struct boot_params *boot_params)
 {
 	efi_system_table_t *efi_systab_xen;
 
@@ -167,12 +167,12 @@ void __init xen_efi_init(void)
 	if (efi_systab_xen == NULL)
 		return;
 
-	strncpy((char *)&boot_params.efi_info.efi_loader_signature, "Xen",
-			sizeof(boot_params.efi_info.efi_loader_signature));
-	boot_params.efi_info.efi_systab = (__u32)__pa(efi_systab_xen);
-	boot_params.efi_info.efi_systab_hi = (__u32)(__pa(efi_systab_xen) >> 32);
+	strncpy((char *)&boot_params->efi_info.efi_loader_signature, "Xen",
+			sizeof(boot_params->efi_info.efi_loader_signature));
+	boot_params->efi_info.efi_systab = (__u32)__pa(efi_systab_xen);
+	boot_params->efi_info.efi_systab_hi = (__u32)(__pa(efi_systab_xen) >> 32);
 
-	boot_params.secure_boot = xen_efi_get_secureboot();
+	boot_params->secure_boot = xen_efi_get_secureboot();
 
 	set_bit(EFI_BOOT, &efi.flags);
 	set_bit(EFI_PARAVIRT, &efi.flags);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c54a493e139a..4722ba2966ac 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1403,7 +1403,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	/* We need this for printk timestamps */
 	xen_setup_runstate_info(0);
 
-	xen_efi_init();
+	xen_efi_init(&boot_params);
 
 	/* Start the world */
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index bbffa409e0e8..80a79db72fcf 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -13,6 +13,8 @@
 
 #include <xen/interface/memory.h>
 
+#include "xen-ops.h"
+
 /*
  * PVH variables.
  *
@@ -21,7 +23,7 @@
  */
 bool xen_pvh __attribute__((section(".data"))) = 0;
 
-void __init xen_pvh_init(void)
+void __init xen_pvh_init(struct boot_params *boot_params)
 {
 	u32 msr;
 	u64 pfn;
@@ -33,6 +35,8 @@ void __init xen_pvh_init(void)
 	msr = cpuid_ebx(xen_cpuid_base() + 2);
 	pfn = __pa(hypercall_page);
 	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+
+	xen_efi_init(boot_params);
 }
 
 void __init mem_map_via_hcall(struct boot_params *boot_params_p)
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 0e60bd918695..2f111f47ba98 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -122,9 +122,9 @@ static inline void __init xen_init_vga(const struct dom0_vga_console_info *info,
 void __init xen_init_apic(void);
 
 #ifdef CONFIG_XEN_EFI
-extern void xen_efi_init(void);
+extern void xen_efi_init(struct boot_params *boot_params);
 #else
-static inline void __init xen_efi_init(void)
+static inline void __init xen_efi_init(struct boot_params *boot_params)
 {
 }
 #endif
-- 
2.17.2 (Apple Git-113)

