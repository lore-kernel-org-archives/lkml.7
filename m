Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812EEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4060520857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="CnhKD1KK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfCATyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:54:08 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:1411 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCATyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4666; q=dns/txt; s=iport;
  t=1551470046; x=1552679646;
  h=from:to:cc:subject:date:message-id;
  bh=rFT1locVLkEIVP9ZhhjRCB9tjp1CHikuzrSwFXLQpug=;
  b=CnhKD1KKRlRgsRf3XpMRU2NxCfhi5j4a7py+VhUpxz6XtqBnfETpIaTy
   8EDiyIn235SFZytWIrmfbHsp9NG3/i1Vvio6KeWouxImw56uoruwnr/M0
   ljMIK0ZUysT56ZeyNln6jlQjwADSQrixiwB8opfxkspBr242aPc0Mc4yz
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AMAABCinlc/5NdJa1kGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYIEaIEDJ4wipXeBew0fhE2EIyI0CQ0BAwEBAwEDAm0?=
 =?us-ascii?q?ohkopgRUBEoMiAYF0Aax9ii8Uh3SEQxeBQD+BEY10AooRmWkJgkCFA4ssAhe?=
 =?us-ascii?q?TIYkogTiSRoFHOIFWMxoIGxWDJwmCHxeOHj8zkEoBAQ?=
X-IronPort-AV: E=Sophos;i="5.58,428,1544486400"; 
   d="scan'208";a="309027952"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 19:44:36 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id x21JiWLk018182;
        Fri, 1 Mar 2019 19:44:36 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Daniel Walker <dwalker@fifo99.com>,
        xe-linux-external@cisco.com,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] powerpc: convert to generic builtin command line
Date:   Fri,  1 Mar 2019 19:44:30 +0000
Message-Id: <1551469472-53043-3-git-send-email-danielwa@cisco.com>
X-Mailer: git-send-email 2.7.4
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.63.76, sjc-ads-2388.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the powerpc code to use the CONFIG_GENERIC_CMDLINE
option.

[maksym.kokhan@globallogic.com: add strlcat to prom_init_check.sh
whitelist]
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 arch/powerpc/Kconfig                   | 23 +----------------------
 arch/powerpc/kernel/prom.c             |  4 ++++
 arch/powerpc/kernel/prom_init.c        |  8 ++++----
 arch/powerpc/kernel/prom_init_check.sh |  2 +-
 4 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8be31261aec8..6321b2a0b87b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -172,6 +172,7 @@ config PPC
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_CMDLINE
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
@@ -777,28 +778,6 @@ config PPC_DENORMALISATION
 	  Add support for handling denormalisation of single precision
 	  values.  Useful for bare metal only.  If unsure say Y here.
 
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,9600 console=tty0 root=/dev/sda2"
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel. For these platforms, you can supply
-	  some command-line options at build time by entering them here.  In
-	  most cases you will need to specify the root device here.
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	depends on CMDLINE_BOOL
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-
 config EXTRA_TARGETS
 	string "Additional default image types"
 	help
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fe758cedb93f..d78b1d6fe1c8 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -34,6 +34,7 @@
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <linux/cpu.h>
+#include <linux/cmdline.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -716,6 +717,9 @@ void __init early_init_devtree(void *params)
 	 */
 	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
 
+	/* append and prepend any arguments built into the kernel. */
+	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
+
 	/* Scan memory nodes and rebuild MEMBLOCKs */
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f33ff4163a51..e8e9fca22470 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/bitops.h>
+#include <linux/cmdline.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/page.h>
@@ -637,11 +638,10 @@ static void __init early_cmdline_parse(void)
 	p = prom_cmd_line;
 	if ((long)prom.chosen > 0)
 		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
-#ifdef CONFIG_CMDLINE
+
 	if (l <= 0 || p[0] == '\0') /* dbl check */
-		strlcpy(prom_cmd_line,
-			CONFIG_CMDLINE, sizeof(prom_cmd_line));
-#endif /* CONFIG_CMDLINE */
+		cmdline_add_builtin_section(prom_cmd_line, NULL, sizeof(prom_cmd_line), __prombss);
+
 	prom_printf("command line: %s\n", prom_cmd_line);
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 667df97d2595..ab2acc8d8b5a 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -18,7 +18,7 @@
 
 WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
-__secondary_hold_acknowledge __secondary_hold_spinloop __start
+__secondary_hold_acknowledge __secondary_hold_spinloop __start strlcat
 strcmp strcpy strlcpy strlen strncmp strstr kstrtobool logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
 __prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
-- 
2.14.1

