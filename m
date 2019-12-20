Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366F9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3C024672
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wicgqo9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLTA5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:57:20 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46466 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfLTA5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:57:20 -0500
Received: by mail-pf1-f201.google.com with SMTP id w127so4921593pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 16:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Nm89Dtlt0fhaI6YSKMozjprE7OGPyoiTJKu0/ET0AB4=;
        b=Wicgqo9QmSKufWEegg0ttEqE4qIsXexcraZWjhQ8voH+mkXuwME1CGrQgQQXzyD5An
         TJonosL13dNnEQNQqHnx5OkHYBxiV5Wisza5lYIRg31dNo0W87FmYAWU2BiX9GoBkuyd
         UdYu0yVVVujsDKCGcWRjT5kB2nAvkeycWfBzz/hbNAiY0/d+7F/9XVAfiTiVyR8jDBOJ
         qiEXT7iFlp5Rm3rCP3gDf4ex4WLHV4xZBHf1SJqS4yVnkr7+nkDDQ2bxV/klCDFo2PMo
         C9bzx1Bek1y+YWiV/MZp0IIZbs99k68SG+iuY43pYdGy77Ras6TdHqhkS9wD3hnyrGwN
         P+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Nm89Dtlt0fhaI6YSKMozjprE7OGPyoiTJKu0/ET0AB4=;
        b=ueDC4rDh9uQH39KY1olyXFNEjUBonedabLLR6ZU4Bg2+EBLQfHqTSmQDhNQB5kUxMd
         Cpd0tQM3Bc8XhC/N61D4X3SFOeba+Bi4F3JxahgwREC3zD6JUSFBc5ZinMYw3k4mG1ox
         QsgkMbep6MpDyBmjdPkX8Tcl0pEOrodnUYWYBu4p5L5jo65YsaL2TytzNpimeRtvA/hq
         iBMhaj36DA1JnwaJyhhYGsX4xjXnwITk0SZHtL+vwZaITAO30AH0acB19r9vnU2Mf0C5
         Su7vbAm93E8z9iM0OBvOwTQSEcqX9vOam3Bvsq7YRz4ZJuwkbppTehp8nkUd1z5llCWX
         dwdQ==
X-Gm-Message-State: APjAAAVgcCfz8DGWNylhljXzaOq91uqPMfUCopqiuShlu0cxnyQ+9RnH
        CrDq0ViN1w2lvXuP5AE7ib79yKaVGoW9
X-Google-Smtp-Source: APXvYqxsZXXrQmwLxDA+ea/egRRaweSkKU9q9W8NWHnVPPNJxbstH3jz/mlsjRLHdqNj+1MRCWMFiUnw4VD0
X-Received: by 2002:a63:2a06:: with SMTP id q6mr11582301pgq.92.1576803439359;
 Thu, 19 Dec 2019 16:57:19 -0800 (PST)
Date:   Thu, 19 Dec 2019 16:57:08 -0800
Message-Id: <20191220005708.65594-1-ganshun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] Reserve EBDA region
From:   Gan Shun Lim <ganshun@google.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Gan Shun Lim <ganshun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we boot LinuxBoot-style (as a UEFI binary), sometimes UEFI does
not correctly mark the EBDA region as reserved. We reserve it in all
e820 maps to ensure both the Linuxboot kernel and the future kexec-ed
kernel do not corrupt it. This patch also adds a LinuxBoot config that
selects the RESERVE_EBDA automatically.

Signed-off-by: Gan Shun Lim <ganshun@google.com>
---
 arch/x86/Kconfig                | 23 ++++++++++++++++++++
 arch/x86/include/asm/e820/api.h |  1 +
 arch/x86/kernel/e820.c          | 38 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/setup.c         |  4 ++++
 4 files changed, 66 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e89499536606..bf3bd0381df70 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2467,6 +2467,29 @@ config MODIFY_LDT_SYSCALL
 
 source "kernel/livepatch/Kconfig"
 
+config LINUXBOOT
+	bool "LinuxBoot"
+	select KEXEC_CORE
+	select KEXEC
+	select KEXEC_FILE
+	select EFI
+	select EFI_STUB
+	select RESERVE_EBDA
+	help
+	  Include code to handle booting directly out of firmware.
+	  On EFI systems, this means booting with the EFI boot stub
+	  as an EFI application, embedded in the firmware image. LinuxBoot
+	  should then kexec the actual runtime operating system, and is not
+	  meant to keep running.
+
+config RESERVE_EBDA
+	bool "Reserve the EBDA on boot"
+	help
+	  The Extended BIOS Data Area can be left unreserved when booting
+	  LinuxBoot as an EFI application. This unconditionally marks the
+	  area as reserved for both current and kexec-ed kernels so that
+	  it's not accidently corrupted on kexec.
+
 endmenu
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d97..57c6bc2f78fda 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -29,6 +29,7 @@ extern u64  e820__memblock_alloc_reserved(u64 size, u64 align);
 extern void e820__memblock_setup(void);
 
 extern void e820__reserve_setup_data(void);
+extern void e820__reserve_ebda(void);
 extern void e820__finish_early_params(void);
 extern void e820__reserve_resources(void);
 extern void e820__reserve_resources_late(void);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c5399e80c59c5..8401d3fd9b945 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -18,6 +18,7 @@
 #include <linux/memory_hotplug.h>
 
 #include <asm/e820/api.h>
+#include <asm/bios_ebda.h>
 #include <asm/setup.h>
 
 /*
@@ -523,6 +524,14 @@ static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type o
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
 
+static u64 __init e820__range_update_firmware(u64 start, u64 size,
+					      enum e820_type old_type,
+					      enum e820_type  new_type)
+{
+	return __e820__range_update(e820_table_firmware, start, size,
+				    old_type, new_type);
+}
+
 /* Remove a range of memory from the E820 table: */
 u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
 {
@@ -1022,6 +1031,35 @@ void __init e820__reserve_setup_data(void)
 	e820__print_table("reserve setup_data");
 }
 
+void __init e820__reserve_ebda(void)
+{
+	unsigned long address;
+	unsigned long start_page, new_length;
+	size_t length;
+
+	address = get_bios_ebda();
+	if (!address) {
+		pr_info("BIOS EBDA non-existent.\n");
+		return;
+	}
+	length = get_bios_ebda_length();
+	start_page = ALIGN_DOWN(address, PAGE_SIZE);
+	new_length = PAGE_ALIGN(address + length) - start_page;
+	pr_info("BIOS EBDA structure found at phys 0x%lx, length 0x%x\n",
+		address, (unsigned int)length);
+	pr_info("Reserving EBDA Page aligned starting at 0x%lx, length 0x%lx\n",
+		start_page, new_length);
+	// Reserve page aligned because memremap doesn't allow us to access
+	// mixed pages.
+	e820__range_update(start_page, new_length, E820_TYPE_RAM,
+			   E820_TYPE_RESERVED);
+	// reserve only the actual ebda region to pass on.
+	e820__range_update_kexec(address, length, E820_TYPE_RAM,
+				 E820_TYPE_RESERVED);
+	e820__range_update_firmware(address, length, E820_TYPE_RAM,
+				    E820_TYPE_RESERVED);
+}
+
 /*
  * Called after parse_early_param(), after early parameters (such as mem=)
  * have been processed, in which case we already have an E820 table filled in
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cedfe2077a69b..06226d8222d13 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1036,6 +1036,10 @@ void __init setup_arch(char **cmdline_p)
 		setup_clear_cpu_cap(X86_FEATURE_APIC);
 	}
 
+#ifdef CONFIG_LINUXBOOT_RESERVE_EBDA
+	/* update the e820_saved too */
+	e820__reserve_ebda();
+#endif
 	e820__reserve_setup_data();
 	e820__finish_early_params();
 
-- 
2.24.1.735.g03f4e72817-goog

