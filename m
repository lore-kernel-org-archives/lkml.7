Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071FAC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE5E21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbfJAIZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:25:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:58684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbfJAIZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:25:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0FC3AF9F;
        Tue,  1 Oct 2019 08:25:36 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] xen/efi: have a common runtime setup function
Date:   Tue,  1 Oct 2019 10:25:34 +0200
Message-Id: <20191001082534.12067-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today the EFI runtime functions are setup in architecture specific
code (x86 and arm), with the functions themselves living in drivers/xen
as they are not architecture dependent.

As the setup is exactly the same for arm and x86 move the setup to
drivers/xen, too. This at once removes the need to make the single
functions global visible.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/arm/include/asm/xen/xen-ops.h   |  6 ---
 arch/arm/xen/Makefile                |  1 -
 arch/arm/xen/efi.c                   | 30 -------------
 arch/arm/xen/enlighten.c             |  1 -
 arch/arm64/include/asm/xen/xen-ops.h |  7 ---
 arch/arm64/xen/Makefile              |  1 -
 arch/x86/xen/efi.c                   | 16 +------
 drivers/xen/efi.c                    | 85 ++++++++++++++++++++----------------
 include/xen/xen-ops.h                | 25 +----------
 9 files changed, 50 insertions(+), 122 deletions(-)
 delete mode 100644 arch/arm/include/asm/xen/xen-ops.h
 delete mode 100644 arch/arm/xen/efi.c
 delete mode 100644 arch/arm64/include/asm/xen/xen-ops.h

diff --git a/arch/arm/include/asm/xen/xen-ops.h b/arch/arm/include/asm/xen/xen-ops.h
deleted file mode 100644
index ec154e719b11..000000000000
--- a/arch/arm/include/asm/xen/xen-ops.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_XEN_OPS_H
-#define _ASM_XEN_OPS_H
-
-void xen_efi_runtime_setup(void);
-
-#endif /* _ASM_XEN_OPS_H */
diff --git a/arch/arm/xen/Makefile b/arch/arm/xen/Makefile
index 7ed28982c4c3..c32d04713ba0 100644
--- a/arch/arm/xen/Makefile
+++ b/arch/arm/xen/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y		:= enlighten.o hypercall.o grant-table.o p2m.o mm.o
-obj-$(CONFIG_XEN_EFI) += efi.o
diff --git a/arch/arm/xen/efi.c b/arch/arm/xen/efi.c
deleted file mode 100644
index cb2aaf98e243..000000000000
--- a/arch/arm/xen/efi.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2015, Linaro Limited, Shannon Zhao
- */
-
-#include <linux/efi.h>
-#include <xen/xen-ops.h>
-#include <asm/xen/xen-ops.h>
-
-/* Set XEN EFI runtime services function pointers. Other fields of struct efi,
- * e.g. efi.systab, will be set like normal EFI.
- */
-void __init xen_efi_runtime_setup(void)
-{
-	efi.get_time                 = xen_efi_get_time;
-	efi.set_time                 = xen_efi_set_time;
-	efi.get_wakeup_time          = xen_efi_get_wakeup_time;
-	efi.set_wakeup_time          = xen_efi_set_wakeup_time;
-	efi.get_variable             = xen_efi_get_variable;
-	efi.get_next_variable        = xen_efi_get_next_variable;
-	efi.set_variable             = xen_efi_set_variable;
-	efi.set_variable_nonblocking = xen_efi_set_variable;
-	efi.query_variable_info      = xen_efi_query_variable_info;
-	efi.query_variable_info_nonblocking = xen_efi_query_variable_info;
-	efi.update_capsule           = xen_efi_update_capsule;
-	efi.query_capsule_caps       = xen_efi_query_capsule_caps;
-	efi.get_next_high_mono_count = xen_efi_get_next_high_mono_count;
-	efi.reset_system             = xen_efi_reset_system;
-}
-EXPORT_SYMBOL_GPL(xen_efi_runtime_setup);
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 1e57692552d9..99f955a5b694 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -15,7 +15,6 @@
 #include <xen/xen-ops.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
-#include <asm/xen/xen-ops.h>
 #include <asm/system_misc.h>
 #include <asm/efi.h>
 #include <linux/interrupt.h>
diff --git a/arch/arm64/include/asm/xen/xen-ops.h b/arch/arm64/include/asm/xen/xen-ops.h
deleted file mode 100644
index e6e784051932..000000000000
--- a/arch/arm64/include/asm/xen/xen-ops.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_XEN_OPS_H
-#define _ASM_XEN_OPS_H
-
-void xen_efi_runtime_setup(void);
-
-#endif /* _ASM_XEN_OPS_H */
diff --git a/arch/arm64/xen/Makefile b/arch/arm64/xen/Makefile
index a4fc65f3928d..b66215e8658e 100644
--- a/arch/arm64/xen/Makefile
+++ b/arch/arm64/xen/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 xen-arm-y	+= $(addprefix ../../arm/xen/, enlighten.o grant-table.o p2m.o mm.o)
 obj-y		:= xen-arm.o hypercall.o
-obj-$(CONFIG_XEN_EFI) += $(addprefix ../../arm/xen/, efi.o)
diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 7e3eb70f411a..a04551ee5568 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -57,21 +57,7 @@ static efi_system_table_t __init *xen_efi_probe(void)
 		return NULL;
 
 	/* Here we know that Xen runs on EFI platform. */
-
-	efi.get_time                 = xen_efi_get_time;
-	efi.set_time                 = xen_efi_set_time;
-	efi.get_wakeup_time          = xen_efi_get_wakeup_time;
-	efi.set_wakeup_time          = xen_efi_set_wakeup_time;
-	efi.get_variable             = xen_efi_get_variable;
-	efi.get_next_variable        = xen_efi_get_next_variable;
-	efi.set_variable             = xen_efi_set_variable;
-	efi.set_variable_nonblocking = xen_efi_set_variable;
-	efi.query_variable_info      = xen_efi_query_variable_info;
-	efi.query_variable_info_nonblocking = xen_efi_query_variable_info;
-	efi.update_capsule           = xen_efi_update_capsule;
-	efi.query_capsule_caps       = xen_efi_query_capsule_caps;
-	efi.get_next_high_mono_count = xen_efi_get_next_high_mono_count;
-	efi.reset_system             = xen_efi_reset_system;
+	xen_efi_runtime_setup();
 
 	efi_systab_xen.tables = info->cfg.addr;
 	efi_systab_xen.nr_tables = info->cfg.nent;
diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
index 89d60f8e3c18..ffbdaa9f4a45 100644
--- a/drivers/xen/efi.c
+++ b/drivers/xen/efi.c
@@ -40,7 +40,7 @@
 
 #define efi_data(op)	(op.u.efi_runtime_call)
 
-efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
+static efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
 	struct xen_platform_op op = INIT_EFI_OP(get_time);
 
@@ -61,9 +61,8 @@ efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_get_time);
 
-efi_status_t xen_efi_set_time(efi_time_t *tm)
+static efi_status_t xen_efi_set_time(efi_time_t *tm)
 {
 	struct xen_platform_op op = INIT_EFI_OP(set_time);
 
@@ -75,10 +74,10 @@ efi_status_t xen_efi_set_time(efi_time_t *tm)
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_set_time);
 
-efi_status_t xen_efi_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
-				     efi_time_t *tm)
+static efi_status_t xen_efi_get_wakeup_time(efi_bool_t *enabled,
+					    efi_bool_t *pending,
+					    efi_time_t *tm)
 {
 	struct xen_platform_op op = INIT_EFI_OP(get_wakeup_time);
 
@@ -98,9 +97,8 @@ efi_status_t xen_efi_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_get_wakeup_time);
 
-efi_status_t xen_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
+static efi_status_t xen_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 {
 	struct xen_platform_op op = INIT_EFI_OP(set_wakeup_time);
 
@@ -117,11 +115,10 @@ efi_status_t xen_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_set_wakeup_time);
 
-efi_status_t xen_efi_get_variable(efi_char16_t *name, efi_guid_t *vendor,
-				  u32 *attr, unsigned long *data_size,
-				  void *data)
+static efi_status_t xen_efi_get_variable(efi_char16_t *name, efi_guid_t *vendor,
+					 u32 *attr, unsigned long *data_size,
+					 void *data)
 {
 	struct xen_platform_op op = INIT_EFI_OP(get_variable);
 
@@ -141,11 +138,10 @@ efi_status_t xen_efi_get_variable(efi_char16_t *name, efi_guid_t *vendor,
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_get_variable);
 
-efi_status_t xen_efi_get_next_variable(unsigned long *name_size,
-				       efi_char16_t *name,
-				       efi_guid_t *vendor)
+static efi_status_t xen_efi_get_next_variable(unsigned long *name_size,
+					      efi_char16_t *name,
+					      efi_guid_t *vendor)
 {
 	struct xen_platform_op op = INIT_EFI_OP(get_next_variable_name);
 
@@ -165,11 +161,10 @@ efi_status_t xen_efi_get_next_variable(unsigned long *name_size,
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_get_next_variable);
 
-efi_status_t xen_efi_set_variable(efi_char16_t *name, efi_guid_t *vendor,
-				 u32 attr, unsigned long data_size,
-				 void *data)
+static efi_status_t xen_efi_set_variable(efi_char16_t *name, efi_guid_t *vendor,
+					 u32 attr, unsigned long data_size,
+					 void *data)
 {
 	struct xen_platform_op op = INIT_EFI_OP(set_variable);
 
@@ -186,11 +181,10 @@ efi_status_t xen_efi_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_set_variable);
 
-efi_status_t xen_efi_query_variable_info(u32 attr, u64 *storage_space,
-					 u64 *remaining_space,
-					 u64 *max_variable_size)
+static efi_status_t xen_efi_query_variable_info(u32 attr, u64 *storage_space,
+						u64 *remaining_space,
+						u64 *max_variable_size)
 {
 	struct xen_platform_op op = INIT_EFI_OP(query_variable_info);
 
@@ -208,9 +202,8 @@ efi_status_t xen_efi_query_variable_info(u32 attr, u64 *storage_space,
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_query_variable_info);
 
-efi_status_t xen_efi_get_next_high_mono_count(u32 *count)
+static efi_status_t xen_efi_get_next_high_mono_count(u32 *count)
 {
 	struct xen_platform_op op = INIT_EFI_OP(get_next_high_monotonic_count);
 
@@ -221,10 +214,9 @@ efi_status_t xen_efi_get_next_high_mono_count(u32 *count)
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_get_next_high_mono_count);
 
-efi_status_t xen_efi_update_capsule(efi_capsule_header_t **capsules,
-				    unsigned long count, unsigned long sg_list)
+static efi_status_t xen_efi_update_capsule(efi_capsule_header_t **capsules,
+				unsigned long count, unsigned long sg_list)
 {
 	struct xen_platform_op op = INIT_EFI_OP(update_capsule);
 
@@ -241,11 +233,9 @@ efi_status_t xen_efi_update_capsule(efi_capsule_header_t **capsules,
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_update_capsule);
 
-efi_status_t xen_efi_query_capsule_caps(efi_capsule_header_t **capsules,
-					unsigned long count, u64 *max_size,
-					int *reset_type)
+static efi_status_t xen_efi_query_capsule_caps(efi_capsule_header_t **capsules,
+			unsigned long count, u64 *max_size, int *reset_type)
 {
 	struct xen_platform_op op = INIT_EFI_OP(query_capsule_capabilities);
 
@@ -264,10 +254,9 @@ efi_status_t xen_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 
 	return efi_data(op).status;
 }
-EXPORT_SYMBOL_GPL(xen_efi_query_capsule_caps);
 
-void xen_efi_reset_system(int reset_type, efi_status_t status,
-			  unsigned long data_size, efi_char16_t *data)
+static void xen_efi_reset_system(int reset_type, efi_status_t status,
+				 unsigned long data_size, efi_char16_t *data)
 {
 	switch (reset_type) {
 	case EFI_RESET_COLD:
@@ -281,4 +270,26 @@ void xen_efi_reset_system(int reset_type, efi_status_t status,
 		BUG();
 	}
 }
-EXPORT_SYMBOL_GPL(xen_efi_reset_system);
+
+/*
+ * Set XEN EFI runtime services function pointers. Other fields of struct efi,
+ * e.g. efi.systab, will be set like normal EFI.
+ */
+void __init xen_efi_runtime_setup(void)
+{
+	efi.get_time			= xen_efi_get_time;
+	efi.set_time			= xen_efi_set_time;
+	efi.get_wakeup_time		= xen_efi_get_wakeup_time;
+	efi.set_wakeup_time		= xen_efi_set_wakeup_time;
+	efi.get_variable		= xen_efi_get_variable;
+	efi.get_next_variable		= xen_efi_get_next_variable;
+	efi.set_variable		= xen_efi_set_variable;
+	efi.set_variable_nonblocking	= xen_efi_set_variable;
+	efi.query_variable_info		= xen_efi_query_variable_info;
+	efi.query_variable_info_nonblocking = xen_efi_query_variable_info;
+	efi.update_capsule		= xen_efi_update_capsule;
+	efi.query_capsule_caps		= xen_efi_query_capsule_caps;
+	efi.get_next_high_mono_count	= xen_efi_get_next_high_mono_count;
+	efi.reset_system		= xen_efi_reset_system;
+}
+EXPORT_SYMBOL_GPL(xen_efi_runtime_setup);
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 98b30c1613b2..d89969aa9942 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -212,30 +212,7 @@ int xen_xlate_map_ballooned_pages(xen_pfn_t **pfns, void **vaddr,
 
 bool xen_running_on_version_or_later(unsigned int major, unsigned int minor);
 
-efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
-efi_status_t xen_efi_set_time(efi_time_t *tm);
-efi_status_t xen_efi_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
-				     efi_time_t *tm);
-efi_status_t xen_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm);
-efi_status_t xen_efi_get_variable(efi_char16_t *name, efi_guid_t *vendor,
-				  u32 *attr, unsigned long *data_size,
-				  void *data);
-efi_status_t xen_efi_get_next_variable(unsigned long *name_size,
-				       efi_char16_t *name, efi_guid_t *vendor);
-efi_status_t xen_efi_set_variable(efi_char16_t *name, efi_guid_t *vendor,
-				  u32 attr, unsigned long data_size,
-				  void *data);
-efi_status_t xen_efi_query_variable_info(u32 attr, u64 *storage_space,
-					 u64 *remaining_space,
-					 u64 *max_variable_size);
-efi_status_t xen_efi_get_next_high_mono_count(u32 *count);
-efi_status_t xen_efi_update_capsule(efi_capsule_header_t **capsules,
-				    unsigned long count, unsigned long sg_list);
-efi_status_t xen_efi_query_capsule_caps(efi_capsule_header_t **capsules,
-					unsigned long count, u64 *max_size,
-					int *reset_type);
-void xen_efi_reset_system(int reset_type, efi_status_t status,
-			  unsigned long data_size, efi_char16_t *data);
+void xen_efi_runtime_setup(void);
 
 
 #ifdef CONFIG_PREEMPT
-- 
2.16.4

