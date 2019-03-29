Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796BFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443602082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfC2Gp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:45:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfC2Gp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:45:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2T6jfCj3663174
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 23:45:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2T6jfwu3663171;
        Thu, 28 Mar 2019 23:45:41 -0700
Date:   Thu, 28 Mar 2019 23:45:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Robert Richter <tipbot@zytor.com>
Message-ID: <tip-0fca08122eaf5c956a2cbe12775245d747f8b1ac@git.kernel.org>
Cc:     matt@codeblueprint.co.uk, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        ard.biesheuvel@linaro.org, rrichter@marvell.com, jdelvare@suse.de,
        peterz@infradead.org
Reply-To: mingo@kernel.org, ard.biesheuvel@linaro.org, jdelvare@suse.de,
          rrichter@marvell.com, peterz@infradead.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          matt@codeblueprint.co.uk, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190328193429.21373-5-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-5-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Unify DMI setup code over the arm/arm64, ia64
 and x86 architectures
Git-Commit-ID: 0fca08122eaf5c956a2cbe12775245d747f8b1ac
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

Commit-ID:  0fca08122eaf5c956a2cbe12775245d747f8b1ac
Gitweb:     https://git.kernel.org/tip/0fca08122eaf5c956a2cbe12775245d747f8b1ac
Author:     Robert Richter <rrichter@marvell.com>
AuthorDate: Thu, 28 Mar 2019 20:34:28 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 29 Mar 2019 07:35:00 +0100

efi: Unify DMI setup code over the arm/arm64, ia64 and x86 architectures

All architectures (arm/arm64, ia64 and x86) do the same here, so unify
the code.

Note: We do not need to call dump_stack_set_arch_desc() in case of
!dmi_available. Both strings, dmi_ids_string and dump_stack_arch_
desc_str are initialized zero and thus nothing would change.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190328193429.21373-5-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/kernel/setup.c           |  4 +---
 arch/x86/kernel/setup.c            |  6 ++----
 drivers/firmware/dmi_scan.c        | 28 +++++++++++++++-------------
 drivers/firmware/efi/arm-runtime.c |  7 ++-----
 include/linux/dmi.h                |  8 ++------
 5 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 583a3746d70b..c9cfa760cd57 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -1058,9 +1058,7 @@ check_bugs (void)
 
 static int __init run_dmi_scan(void)
 {
-	dmi_scan_machine();
-	dmi_memdev_walk();
-	dmi_set_dump_stack_arch_desc();
+	dmi_setup();
 	return 0;
 }
 core_initcall(run_dmi_scan);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a527cd9..3773905cd2c1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1005,13 +1005,11 @@ void __init setup_arch(char **cmdline_p)
 	if (efi_enabled(EFI_BOOT))
 		efi_init();
 
-	dmi_scan_machine();
-	dmi_memdev_walk();
-	dmi_set_dump_stack_arch_desc();
+	dmi_setup();
 
 	/*
 	 * VMware detection requires dmi to be available, so this
-	 * needs to be done after dmi_scan_machine(), for the boot CPU.
+	 * needs to be done after dmi_setup(), for the boot CPU.
 	 */
 	init_hypervisor_platform();
 
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 099d83e4e910..fae2d5c43314 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -416,11 +416,8 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
 	nr++;
 }
 
-void __init dmi_memdev_walk(void)
+static void __init dmi_memdev_walk(void)
 {
-	if (!dmi_available)
-		return;
-
 	if (dmi_walk_early(count_mem_devices) == 0 && dmi_memdev_nr) {
 		dmi_memdev = dmi_alloc(sizeof(*dmi_memdev) * dmi_memdev_nr);
 		if (dmi_memdev)
@@ -614,7 +611,7 @@ static int __init dmi_smbios3_present(const u8 *buf)
 	return 1;
 }
 
-void __init dmi_scan_machine(void)
+static void __init dmi_scan_machine(void)
 {
 	char __iomem *p, *q;
 	char buf[32];
@@ -769,15 +766,20 @@ static int __init dmi_init(void)
 subsys_initcall(dmi_init);
 
 /**
- * dmi_set_dump_stack_arch_desc - set arch description for dump_stack()
+ *	dmi_setup - scan and setup DMI system information
  *
- * Invoke dump_stack_set_arch_desc() with DMI system information so that
- * DMI identifiers are printed out on task dumps.  Arch boot code should
- * call this function after dmi_scan_machine() if it wants to print out DMI
- * identifiers on task dumps.
+ *	Scan the DMI system information. This setups DMI identifiers
+ *	(dmi_system_id) for printing it out on task dumps and prepares
+ *	DIMM entry information (dmi_memdev_info) from the SMBIOS table
+ *	for using this when reporting memory errors.
  */
-void __init dmi_set_dump_stack_arch_desc(void)
+void __init dmi_setup(void)
 {
+	dmi_scan_machine();
+	if (!dmi_available)
+		return;
+
+	dmi_memdev_walk();
 	dump_stack_set_arch_desc("%s", dmi_ids_string);
 }
 
@@ -841,7 +843,7 @@ static bool dmi_is_end_of_table(const struct dmi_system_id *dmi)
  *	returns non zero or we hit the end. Callback function is called for
  *	each successful match. Returns the number of matches.
  *
- *	dmi_scan_machine must be called before this function is called.
+ *	dmi_setup must be called before this function is called.
  */
 int dmi_check_system(const struct dmi_system_id *list)
 {
@@ -871,7 +873,7 @@ EXPORT_SYMBOL(dmi_check_system);
  *	Walk the blacklist table until the first match is found.  Return the
  *	pointer to the matching entry or NULL if there's no match.
  *
- *	dmi_scan_machine must be called before this function is called.
+ *	dmi_setup must be called before this function is called.
  */
 const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list)
 {
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 4a0dfe4ab829..e2ac5fa5531b 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -162,14 +162,11 @@ void efi_virtmap_unload(void)
 static int __init arm_dmi_init(void)
 {
 	/*
-	 * On arm64/ARM, DMI depends on UEFI, and dmi_scan_machine() needs to
+	 * On arm64/ARM, DMI depends on UEFI, and dmi_setup() needs to
 	 * be called early because dmi_id_init(), which is an arch_initcall
 	 * itself, depends on dmi_scan_machine() having been called already.
 	 */
-	dmi_scan_machine();
-	dmi_memdev_walk();
-	if (dmi_available)
-		dmi_set_dump_stack_arch_desc();
+	dmi_setup();
 	return 0;
 }
 core_initcall(arm_dmi_init);
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index c46fdb36700b..8de8c4f15163 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -102,9 +102,7 @@ const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list);
 extern const char * dmi_get_system_info(int field);
 extern const struct dmi_device * dmi_find_device(int type, const char *name,
 	const struct dmi_device *from);
-extern void dmi_scan_machine(void);
-extern void dmi_memdev_walk(void);
-extern void dmi_set_dump_stack_arch_desc(void);
+extern void dmi_setup(void);
 extern bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp);
 extern int dmi_get_bios_year(void);
 extern int dmi_name_in_vendors(const char *str);
@@ -122,9 +120,7 @@ static inline int dmi_check_system(const struct dmi_system_id *list) { return 0;
 static inline const char * dmi_get_system_info(int field) { return NULL; }
 static inline const struct dmi_device * dmi_find_device(int type, const char *name,
 	const struct dmi_device *from) { return NULL; }
-static inline void dmi_scan_machine(void) { return; }
-static inline void dmi_memdev_walk(void) { }
-static inline void dmi_set_dump_stack_arch_desc(void) { }
+static inline void dmi_setup(void) { }
 static inline bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
 {
 	if (yearp)
