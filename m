Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F113C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773BC2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AFD8YxeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390442AbfFJWQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:16:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390389AbfFJWQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=skB+ZnavO/i7RNPtU2wJ23sFxTsqRf+NEErVUiBdRM8=; b=AFD8YxeSHzKPrhOrVzUrstkaZD
        +8OdqXAaOst5JO4QkLywitZN4dFaWbbARKg5GXO3RJm/VkYKGOqro+hPA7tnJnDE/YgvXaNEIH4bJ
        B9yzk/F+V/3RLSO7rH+msjmI2PUqVhmOU7DyeYEvezXbna6F+DZ4iGYT6Bgg67977t9h+kGYB8wNJ
        nxJEPQzgAYpEzCGNdbpj66ymR8md3w6p0aNP+0dvUcLDPlt7nYDZHhCbyCFlKWC6NFHVKI/d5E6iC
        U1WGag3M8zWwklrDgiyzWAacRtBfvNTwWIjcygHWUODgqtsQ6yd374bwQK7U2lOekGf28z1VcIp4K
        DI1BjtIA==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haSaw-0003Rh-EJ; Mon, 10 Jun 2019 22:16:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] riscv: provide a flat entry loader
Date:   Tue, 11 Jun 2019 00:16:14 +0200
Message-Id: <20190610221621.10938-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610221621.10938-1-hch@lst.de>
References: <20190610221621.10938-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows just loading the kernel at a pre-set address without
qemu going bonkers trying to map the ELF file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/Makefile        | 13 +++++++++----
 arch/riscv/boot/Makefile   |  7 ++++++-
 arch/riscv/boot/loader.S   |  8 ++++++++
 arch/riscv/boot/loader.lds | 14 ++++++++++++++
 4 files changed, 37 insertions(+), 5 deletions(-)
 create mode 100644 arch/riscv/boot/loader.S
 create mode 100644 arch/riscv/boot/loader.lds

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6b0741c9f348..69dbb6cb72f3 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -84,13 +84,18 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
 
-all: Image.gz
+ifeq ($(CONFIG_M_MODE),y)
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
index 0990a9fdbe5d..32d2addeddba 100644
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
+$(obj)/loader: $(obj)/loader.o $(obj)/Image FORCE
+	$(Q)$(LD) -T $(src)/loader.lds -o $@ $(obj)/loader.o
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
diff --git a/arch/riscv/boot/loader.lds b/arch/riscv/boot/loader.lds
new file mode 100644
index 000000000000..da9efd57bf44
--- /dev/null
+++ b/arch/riscv/boot/loader.lds
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+OUTPUT_ARCH(riscv)
+ENTRY(_start)
+
+SECTIONS
+{
+	. = 0x80000000;
+
+	.payload : {
+		*(.payload)
+		. = ALIGN(8);
+	}
+}
-- 
2.20.1

