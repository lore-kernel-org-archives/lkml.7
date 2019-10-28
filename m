Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4467CA9EC3
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B08E214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t9fjs8TL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbfJ1MLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:11:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388912AbfJ1MLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z+V9OM5MXohFC2jDxXWFrYB+yMdY+FvZx5tHVe8fv6w=; b=t9fjs8TLLvXBB8E3TRnR7sRIxm
        BkKzZRJiP+hBKyktySUOzXuNHks9OeI5ZhInmkq1uIY3adztocIveN8AI/eaKdyaBWFi+2OtzCQqx
        uA+1BEE9tYjWYGtnjVIZJsZ+RcMOXjwzb4oOLf/hPT0oRkcVFLY1+2kRrWHbfGiESTN72nIN1f0fj
        Vwe4Ceyl6bSPnSoYqIsOOg2IJMQaBRObX89lm74oIOJmykdOIQSFZZF4ZFEWgUO9Pus91c8GKx3C7
        Gm+iJDmO5EIPQfzhb4r122KTMgr5yur+qAH2HwYtBxsKUMJKM9lkpYSduRnU+7cfBsnGNz9HOt9LX
        wzqKujrQ==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP3rh-0007LO-Pt; Mon, 28 Oct 2019 12:11:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 11/12] riscv: provide a flat image loader
Date:   Mon, 28 Oct 2019 13:10:42 +0100
Message-Id: <20191028121043.22934-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028121043.22934-1-hch@lst.de>
References: <20191028121043.22934-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows just loading the kernel at a pre-set address without
qemu going bonkers trying to map the ELF file.

Contains a controbution from Aurabindo Jayamohanan to reuse the
PAGE_OFFSET definition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Makefile          | 13 +++++++++----
 arch/riscv/boot/Makefile     |  7 ++++++-
 arch/riscv/boot/loader.S     |  8 ++++++++
 arch/riscv/boot/loader.lds.S | 16 ++++++++++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)
 create mode 100644 arch/riscv/boot/loader.S
 create mode 100644 arch/riscv/boot/loader.lds.S

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index f5e914210245..b9009a2fbaf5 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -83,13 +83,18 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
 
-all: Image.gz
+ifeq ($(CONFIG_RISCV_M_MODE),y)
+KBUILD_IMAGE := $(boot)/loader
+else
+KBUILD_IMAGE := $(boot)/Image.gz
+endif
+BOOT_TARGETS := Image Image.gz loader
 
-Image: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+all:	$(notdir $(KBUILD_IMAGE))
 
-Image.%: Image
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+	@$(kecho) '  Kernel: $(boot)/$@ is ready'
 
 zinstall install:
 	$(Q)$(MAKE) $(build)=$(boot) $@
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 0990a9fdbe5d..433ccbcabb23 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -16,7 +16,7 @@
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-targets := Image
+targets := Image loader
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -24,6 +24,11 @@ $(obj)/Image: vmlinux FORCE
 $(obj)/Image.gz: $(obj)/Image FORCE
 	$(call if_changed,gzip)
 
+loader.o: $(src)/loader.S $(obj)/Image
+
+$(obj)/loader: $(obj)/loader.o $(obj)/Image $(obj)/loader.lds FORCE
+	$(Q)$(LD) -T $(obj)/loader.lds -o $@ $(obj)/loader.o
+
 install:
 	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
diff --git a/arch/riscv/boot/loader.S b/arch/riscv/boot/loader.S
new file mode 100644
index 000000000000..5586e2610dbb
--- /dev/null
+++ b/arch/riscv/boot/loader.S
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+	.align 4
+	.section .payload, "ax", %progbits
+	.globl _start
+_start:
+	.incbin "arch/riscv/boot/Image"
+
diff --git a/arch/riscv/boot/loader.lds.S b/arch/riscv/boot/loader.lds.S
new file mode 100644
index 000000000000..47a5003c2e28
--- /dev/null
+++ b/arch/riscv/boot/loader.lds.S
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <asm/page.h>
+
+OUTPUT_ARCH(riscv)
+ENTRY(_start)
+
+SECTIONS
+{
+	. = PAGE_OFFSET;
+
+	.payload : {
+		*(.payload)
+		. = ALIGN(8);
+	}
+}
-- 
2.20.1

