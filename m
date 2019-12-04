Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1070CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C851520659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575435050;
	bh=XIl3RHRlV3SwnX/EDjTte9f3xzuLIvGneHlryHQtufY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=huwZZ+J6ErnPBYl3L6d4oRVRALWx6z4BupOlDPGRKhVOLi2zyzrKTYd7lhWkciIcJ
	 MKtPnGXU42LVLtv1el7Q/YlFSZjeyc4/oQE8ZqM9MuoVNg03Ddp+B8rADdfhTHbHlt
	 0LJ1fTx0rG4s9nE/Kpwp71jblajQdU0j2uclQJvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLDEut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:50:49 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:44701 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLDEut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:50:49 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id xB44nqwx028807;
        Wed, 4 Dec 2019 13:49:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com xB44nqwx028807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575434993;
        bh=Jt7OPPgzmKjsthv+1fEhc/PB2RQML0mCHB/Yk4eNpNM=;
        h=From:To:Cc:Subject:Date:From;
        b=VrRX0cOfzpxSGvNmzzdQh0kNkcAtNB8Cb66qhyQf0UGmGl8TeheA+xVlfDDsx8oTd
         ihGuCs2kY4Pr+9z9J8nqgtAO8+eO2LOQ0zrzEwUdZHx/ZQ9nHPhuYWHon0x/O0Fnpg
         5rt+uRgMvAAAdrgMm0yy9pxfWqGApcLo+xO/1su5oNizCS6GED3NtjZMsHPiTQpTWL
         FEEoPUgfmPjop9Y2WDJssDfI+1dVnTJynKSvUMETpPNHsf00ot9xMRCfUeULrEVXKJ
         cXYaJFXomi2+r70KP8QRaHHQptdnDXcURrZNyvkIMwejKFr1wtm82d9x1YYB30mq1a
         lVwcaIoUGFiAA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: decompressor: simplify libfdt builds
Date:   Wed,  4 Dec 2019 13:49:50 +0900
Message-Id: <20191204044950.10418-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copying source files during the build time may not end up with
as clean code as expected.

lib/fdt*.c simply wrap scripts/dtc/libfdt/fdt*.c, and it works
nicely. Let's follow that approach for the arm decompressor, too.

Add four wrappers, arch/arm/boot/compressed/fdt*.c and remove
the Makefile messes. Another nice thing is we no longer need to
maintain the own libfdt_env.h because the decompressor can include
<linux/libfdt_env.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.5-rc1


 arch/arm/boot/compressed/.gitignore     |  9 -------
 arch/arm/boot/compressed/Makefile       | 33 +++++++------------------
 arch/arm/boot/compressed/atags_to_fdt.c |  1 +
 arch/arm/boot/compressed/fdt.c          |  1 +
 arch/arm/boot/compressed/fdt_ro.c       |  1 +
 arch/arm/boot/compressed/fdt_rw.c       |  1 +
 arch/arm/boot/compressed/fdt_wip.c      |  1 +
 arch/arm/boot/compressed/libfdt_env.h   | 24 ------------------
 8 files changed, 14 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm/boot/compressed/fdt.c
 create mode 100644 arch/arm/boot/compressed/fdt_ro.c
 create mode 100644 arch/arm/boot/compressed/fdt_rw.c
 create mode 100644 arch/arm/boot/compressed/fdt_wip.c
 delete mode 100644 arch/arm/boot/compressed/libfdt_env.h

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index 86b2f5d28240..2fdb4885846b 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -6,12 +6,3 @@ hyp-stub.S
 piggy_data
 vmlinux
 vmlinux.lds
-
-# borrowed libfdt files
-fdt.c
-fdt.h
-fdt_ro.c
-fdt_rw.c
-fdt_wip.c
-libfdt.h
-libfdt_internal.h
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index da599c3a1193..d01ce71afac6 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -76,29 +76,23 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
 compress-$(CONFIG_KERNEL_XZ)   = xzkern
 compress-$(CONFIG_KERNEL_LZ4)  = lz4
 
-# Borrowed libfdt files for the ATAG compatibility mode
-
-libfdt		:= fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
-libfdt_hdrs	:= fdt.h libfdt.h libfdt_internal.h
-
-libfdt_objs	:= $(addsuffix .o, $(basename $(libfdt)))
-
-$(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/libfdt/%
-	$(call cmd,shipped)
+ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
+libfdt_objs = fdt_rw.o fdt_ro.o fdt_wip.o fdt.o atags_to_fdt.o
 
-$(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
-	$(addprefix $(obj)/,$(libfdt_hdrs))
+OBJS	+= $(libfdt_objs)
 
-ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
-OBJS	+= $(libfdt_objs) atags_to_fdt.o
+# -fstack-protector-strong triggers protection checks in this code,
+# but it is being used too early to link to meaningful stack_chk logic.
+nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
+$(foreach o, $(libfdt_objs), \
+	$(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt) $(nossp-flags-y))
 endif
 
 targets       := vmlinux vmlinux.lds piggy_data piggy.o \
 		 lib1funcs.o ashldi3.o bswapsdi2.o \
 		 head.o $(OBJS)
 
-clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S \
-		$(libfdt) $(libfdt_hdrs) hyp-stub.S
+clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S hyp-stub.S
 
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS += $(DISABLE_ARM_SSP_PER_TASK_PLUGIN)
@@ -108,15 +102,6 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
-# -fstack-protector-strong triggers protection checks in this code,
-# but it is being used too early to link to meaningful stack_chk logic.
-nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
-CFLAGS_atags_to_fdt.o := $(nossp-flags-y)
-CFLAGS_fdt.o := $(nossp-flags-y)
-CFLAGS_fdt_ro.o := $(nossp-flags-y)
-CFLAGS_fdt_rw.o := $(nossp-flags-y)
-CFLAGS_fdt_wip.o := $(nossp-flags-y)
-
 ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 64c49747f8a3..8452753efebe 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/libfdt_env.h>
 #include <asm/setup.h>
 #include <libfdt.h>
 
diff --git a/arch/arm/boot/compressed/fdt.c b/arch/arm/boot/compressed/fdt.c
new file mode 100644
index 000000000000..49bc1fc1e273
--- /dev/null
+++ b/arch/arm/boot/compressed/fdt.c
@@ -0,0 +1 @@
+#include "../../../../lib/fdt.c"
diff --git a/arch/arm/boot/compressed/fdt_ro.c b/arch/arm/boot/compressed/fdt_ro.c
new file mode 100644
index 000000000000..fc7f8313e93e
--- /dev/null
+++ b/arch/arm/boot/compressed/fdt_ro.c
@@ -0,0 +1 @@
+#include "../../../../lib/fdt_ro.c"
diff --git a/arch/arm/boot/compressed/fdt_rw.c b/arch/arm/boot/compressed/fdt_rw.c
new file mode 100644
index 000000000000..7e9777da2708
--- /dev/null
+++ b/arch/arm/boot/compressed/fdt_rw.c
@@ -0,0 +1 @@
+#include "../../../../lib/fdt_rw.c"
diff --git a/arch/arm/boot/compressed/fdt_wip.c b/arch/arm/boot/compressed/fdt_wip.c
new file mode 100644
index 000000000000..f0b580e760a7
--- /dev/null
+++ b/arch/arm/boot/compressed/fdt_wip.c
@@ -0,0 +1 @@
+#include "../../../../lib/fdt_wip.c"
diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
deleted file mode 100644
index 6a0f1f524466..000000000000
--- a/arch/arm/boot/compressed/libfdt_env.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ARM_LIBFDT_ENV_H
-#define _ARM_LIBFDT_ENV_H
-
-#include <linux/limits.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <asm/byteorder.h>
-
-#define INT32_MAX	S32_MAX
-#define UINT32_MAX	U32_MAX
-
-typedef __be16 fdt16_t;
-typedef __be32 fdt32_t;
-typedef __be64 fdt64_t;
-
-#define fdt16_to_cpu(x)		be16_to_cpu(x)
-#define cpu_to_fdt16(x)		cpu_to_be16(x)
-#define fdt32_to_cpu(x)		be32_to_cpu(x)
-#define cpu_to_fdt32(x)		cpu_to_be32(x)
-#define fdt64_to_cpu(x)		be64_to_cpu(x)
-#define cpu_to_fdt64(x)		cpu_to_be64(x)
-
-#endif
-- 
2.17.1

