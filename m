Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B363C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5633A20685
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWPZv7J6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfC1Te4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:34:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38777 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfC1Teq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:34:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so64756wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLhZJfqzPBQPaOfw6+hXJCxqv7TmfGdAb1ivjJuJyjA=;
        b=MWPZv7J6oPHLFpXOfSZPgQsHD4lk1Ew1EFrZb4EvnJPQrkQweJ5QKwXNSYAUFsWm4G
         qvvoRChx5c+Xo71Hw4slvs2orT5RxOZLxX+0gvRisUe590glKi3J6HYDMbGM+myrZM5B
         uV8Be09ACwfaXSyTBOF2E/B52k25wrzumpZfhIRXFf4lL5dNk2cXczXwttNRQV8zBXkD
         bYZtiIQPjGB1FXi06Gdg99bncrmAkki7uTXWDPOdST/OsAeHkeSbVli2Zgy61ZUGyyve
         10q3U0nQrRJQ7OlW3akOZ3Ic3pN6MdKh/wiOw1hUBaygeVaeuldnyrk4NWBITbK0tDU7
         Q+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLhZJfqzPBQPaOfw6+hXJCxqv7TmfGdAb1ivjJuJyjA=;
        b=c1LpcKgIEC1wT3hk8Lg3m2MY3UarWs4vz2b89WtkPUxcjZE92pVxaZtlH0emFAL5jN
         yaG2itminuCksGwt6uVOGlQ3nYnG6lqraRcIntCZb8s9nIp0uTqYlN6VA5ax34KtC0/t
         rrK+OkndSuABTDJQ6NzDODJKiqbJscchgQieTG3giuweHWn0gFIqtAwXBGodXo1CxIvQ
         +xJsSX+PcR54KvyS1xf6dHrT+So8zwLw/52CQqwhxXtuBVyAQBHR7vC26jB1OCPHosGu
         K+h63z5eU326kIKyaf6oCg9Hp3pkCaTr4ttKdDLyswY9P/AnAu+DRV/pbzDMlFgAY+TU
         nZnQ==
X-Gm-Message-State: APjAAAWWu+iG3MFpKXprksavZbkNGed1SM3QT6HsUdiYVyoLI+V4Lew3
        QQYtu362+AeRIS/VLrAt088gxw==
X-Google-Smtp-Source: APXvYqyg/xcpWj2gsuGwxR/Xi0Wm9zPI2xNrvwYxJ/T4XhrMmbtR2wiweAaT0Rq2dlEvzxeFgedE2w==
X-Received: by 2002:a1c:2b41:: with SMTP id r62mr1046476wmr.94.1553801683104;
        Thu, 28 Mar 2019 12:34:43 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:dd62:8a50:1468:989d])
        by smtp.gmail.com with ESMTPSA id d6sm27739186wrx.62.2019.03.28.12.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:34:42 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Robert Richter <rrichter@marvell.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 4/5] efi: Unify dmi setup code over architectures arm/arm64, ia64 and x86
Date:   Thu, 28 Mar 2019 20:34:28 +0100
Message-Id: <20190328193429.21373-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@marvell.com>

All architectures (arm/arm64, ia64 and x86) do the same here, so unify
the code.

Note: We do not need to call dump_stack_set_arch_desc() in case of
!dmi_available. Both strings, dmi_ids_string and dump_stack_arch_
desc_str are initialized zero and thus nothing would change.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
-- 
2.20.1

