Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8FAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442E120830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hpqzmp7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfEFSMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:12:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63707 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfEFSMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557166327; x=1588702327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kSNx+lxYuo3ZB4wLZaFfiu/cEsS0WNJBcu8Rvh04o+g=;
  b=Hpqzmp7lCbRcGmTNTF53P9yItCnAYnp5mwz6quSLtpq1wuprDykGxZ3M
   Y4Gj/oz2HAoaSYWJ482HB8V1q+M597CI7vIB1Y31z9wwVJP1sNhebWJ5w
   UJyJ2L++laUAqtAjsL8gxVKWvBuMoauVafeub54MI7bHnMnhb+VftL2Uu
   BaeOxsImhDBxZje4HXwYFP8qQwzrhCq4gAD8+6Tjv9tpj0zrK4MiNV7PI
   WJtex6J/z30ESlX8zv+icD49DiUKcIf2zU9cLIKJiCouY3zZ0x+0Nhry4
   JsgO0j0rGuRTRa1VkSrZODgxyw0TMvhqwKaDnblCD++ganuBH3OE9dbE5
   A==;
X-IronPort-AV: E=Sophos;i="5.60,438,1549900800"; 
   d="scan'208";a="107627387"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2019 02:12:07 +0800
IronPort-SDR: wzysNnNR4qSOsJJiwuoEHd7LNEb+BwGp3NByYDbrztM96rMKUA/NUeJws4E/0wlJfmdyw/6Y+O
 kVqC8j26/CzQhHihoNe9HfutJ2iIzTpjGf67yW0Fhi1wVUm0sUWT/22ZRHimQHu/R8Kk3MjXi5
 AH8yzIf64dfeksWMFOjYcC7Hd/0rEZO7zfabafMFJ02C6jt+fhOb4dkSZ0Wo/fQS9E0RhcYd44
 fIvDcAcN+iKJ+O/uDHgd8KhD6g7BeNByY3z1Tn/S5EtVATOzSvy/Tr260e4uC53lF6Nbe9Ezwn
 VpfRcai7aV+WJ47AaFrxeeJH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 06 May 2019 10:48:14 -0700
IronPort-SDR: N4vHFeb9yilB1u5h0DfwTf9Q8su5GyfQuHxi0t6LXwH6cd7GrO+Xw5I4Q+WLargOZI/0nbJc51
 +pFVB+xUHbPY0h6d2A70OerA+RcrN01QHI+tkORHVYYUPSi4GY2XI+5XoWlEb8D+JZbj0LCvOG
 TMs0rn7jcy87efy60PpWKc32uT1UXsg01Ve3PwIGs5EFKtHuhs323IN2HO1sNmxy7WQ4MIjvu8
 TSEHm9pd7Juov5SzdvM2EMtH46LAfbarnt4zXWoocw3id+eoFiXg2yDaKVxH3nOl+Pqc37Ku6s
 YtI=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 May 2019 11:12:07 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Tom Rini <trini@konsulko.com>,
        Karsten Merker <merker@debian.org>,
        Alexander Graf <agraf@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
        u-boot@lists.denx.de
Subject: [U-Boot] [v4 PATCH] RISCV: image: Add booti support
Date:   Mon,  6 May 2019 11:11:34 -0700
Message-Id: <20190506181134.9575-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds booti support for RISC-V Linux kernel. The existing
bootm method will also continue to work as it is.

It depends on the following kernel patch which adds the header to the
flat Image. Gzip compressed Image (Image.gz) support is not enabled with
this patch.

https://patchwork.kernel.org/patch/10925543/

Tested on HiFive Unleashed and QEMU.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Tested-by: Karsten Merker <merker@debian.org>
---
Changes from v3->v4
1. Rebased on top of master to avoid git am errors.

Changes from v2->v3
1. Updated the image header structure as per kernel patch.
2. Removed Image.gz support as it will be added as separate RFC patch.
---
 arch/riscv/lib/Makefile |  1 +
 arch/riscv/lib/image.c  | 55 +++++++++++++++++++++++++++++++++++++++++
 cmd/Kconfig             |  2 +-
 cmd/booti.c             |  8 ++++--
 4 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/lib/image.c

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 1c332db436a9..6ae6ebbeafda 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -7,6 +7,7 @@
 # Rick Chen, Andes Technology Corporation <rick@andestech.com>
 
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
+obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-$(CONFIG_RISCV_RDTIME) += rdtime.o
diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
new file mode 100644
index 000000000000..d063beb7dfbe
--- /dev/null
+++ b/arch/riscv/lib/image.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ * Authors:
+ *	Atish Patra <atish.patra@wdc.com>
+ * Based on arm/lib/image.c
+ */
+
+#include <common.h>
+#include <mapmem.h>
+#include <errno.h>
+#include <linux/sizes.h>
+#include <linux/stddef.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* ASCII version of "RISCV" defined in Linux kernel */
+#define LINUX_RISCV_IMAGE_MAGIC 0x5643534952
+
+struct linux_image_h {
+	uint32_t	code0;		/* Executable code */
+	uint32_t	code1;		/* Executable code */
+	uint64_t	text_offset;	/* Image load offset */
+	uint64_t	image_size;	/* Effective Image size */
+	uint64_t	res1;		/* reserved */
+	uint64_t	res2;		/* reserved */
+	uint64_t	res3;		/* reserved */
+	uint64_t	magic;		/* Magic number */
+	uint32_t	res4;		/* reserved */
+	uint32_t	res5;		/* reserved */
+};
+
+int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
+		bool force_reloc)
+{
+	struct linux_image_h *lhdr;
+
+	lhdr = (struct linux_image_h *)map_sysmem(image, 0);
+
+	if (lhdr->magic != LINUX_RISCV_IMAGE_MAGIC) {
+		puts("Bad Linux RISCV Image magic!\n");
+		return -EINVAL;
+	}
+
+	if (lhdr->image_size == 0) {
+		puts("Image lacks image_size field, error!\n");
+		return -EINVAL;
+	}
+	*size = lhdr->image_size;
+	*relocated_addr = gd->ram_base + lhdr->text_offset;
+
+	unmap_sysmem(lhdr);
+
+	return 0;
+}
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 069e0ea7300b..4e11e0f404c8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -223,7 +223,7 @@ config CMD_BOOTZ
 
 config CMD_BOOTI
 	bool "booti"
-	depends on ARM64
+	depends on ARM64 || RISCV
 	default y
 	help
 	  Boot an AArch64 Linux Kernel image from memory.
diff --git a/cmd/booti.c b/cmd/booti.c
index 04353b68eccc..5e902993865b 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -77,7 +77,11 @@ int do_booti(cmd_tbl_t *cmdtp, int flag, int argc, char * const argv[])
 	bootm_disable_interrupts();
 
 	images.os.os = IH_OS_LINUX;
+#ifdef CONFIG_RISCV_SMODE
+	images.os.arch = IH_ARCH_RISCV;
+#elif CONFIG_ARM64
 	images.os.arch = IH_ARCH_ARM64;
+#endif
 	ret = do_bootm_states(cmdtp, flag, argc, argv,
 #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
 			      BOOTM_STATE_RAMDISK |
@@ -92,7 +96,7 @@ int do_booti(cmd_tbl_t *cmdtp, int flag, int argc, char * const argv[])
 #ifdef CONFIG_SYS_LONGHELP
 static char booti_help_text[] =
 	"[addr [initrd[:size]] [fdt]]\n"
-	"    - boot arm64 Linux Image stored in memory\n"
+	"    - boot arm64/riscv Linux Image stored in memory\n"
 	"\tThe argument 'initrd' is optional and specifies the address\n"
 	"\tof an initrd in memory. The optional parameter ':size' allows\n"
 	"\tspecifying the size of a RAW initrd.\n"
@@ -107,5 +111,5 @@ static char booti_help_text[] =
 
 U_BOOT_CMD(
 	booti,	CONFIG_SYS_MAXARGS,	1,	do_booti,
-	"boot arm64 Linux Image image from memory", booti_help_text
+	"boot arm64/riscv Linux Image image from memory", booti_help_text
 );
-- 
2.21.0

