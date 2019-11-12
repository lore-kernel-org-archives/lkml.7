Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8EFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C01206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKLK1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:27:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfKLK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:27:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUTO4-0007n6-UD; Tue, 12 Nov 2019 11:27:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 942A71C0357;
        Tue, 12 Nov 2019 11:27:04 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:27:04 -0000
From:   "tip-bot2 for Dominik Brodowski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the
 UEFI RNG table
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157355442425.29376.14080787563048463732.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     0d95981438c3bdb53cc99b0fb656d24d7a80e1f3
Gitweb:        https://git.kernel.org/tip/0d95981438c3bdb53cc99b0fb656d24d7a80e1f3
Author:        Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate:    Wed, 06 Nov 2019 08:06:13 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 07 Nov 2019 10:18:45 +01:00

x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table

Invoke the EFI_RNG_PROTOCOL protocol in the context of the x86 EFI stub,
same as is done on arm/arm64 since commit 568bc4e87033 ("efi/arm*/libstub:
Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table"). Within the stub,
a Linux-specific RNG seed UEFI config table will be seeded. The EFI routines
in the core kernel will pick that up later, yet still early during boot,
to seed the kernel entropy pool. If CONFIG_RANDOM_TRUST_BOOTLOADER, entropy
is credited for this seed.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c       | 3 +++
 drivers/firmware/efi/libstub/Makefile  | 5 +++--
 drivers/firmware/efi/libstub/efistub.h | 2 --
 include/linux/efi.h                    | 2 ++
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 82bc60c..68945c5 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -782,6 +782,9 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation(sys_table);
+
+	efi_random_get_seed(sys_table);
+
 	efi_retrieve_tpm2_eventlog(sys_table);
 
 	setup_graphics(boot_params);
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ee0661d..c35f893 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -38,7 +38,8 @@ OBJECT_FILES_NON_STANDARD	:= y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT			:= n
 
-lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o
+lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
+				   random.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
@@ -47,7 +48,7 @@ arm-deps-$(CONFIG_ARM64) += sort.c
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o random.o \
+lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o \
 				   $(patsubst %.c,lib-%.o,$(arm-deps-y))
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 7f1556f..05739ae 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -63,8 +63,6 @@ efi_status_t efi_random_alloc(efi_system_table_t *sys_table_arg,
 
 efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
 
-efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
-
 void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid);
 
 /* Helper macros for the usual case of using simple C variables: */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d87acf6..028efa7 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1645,6 +1645,8 @@ static inline void
 efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg) { }
 #endif
 
+efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
+
 void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
 
 /*
