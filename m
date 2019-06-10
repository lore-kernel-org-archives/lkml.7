Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99B1C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C304820820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RLeDGOFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390249AbfFJVUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:20:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390184AbfFJVUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1jVYMx/arZAqs3yuKoy0cJPUA3vC+BJxP8Rm0Qe6EP0=; b=RLeDGOFuoEZIU9Yz3L63IZUUz5
        dMkmwauB0/YGOaKSByq48/Po0fjYbOpKaT2U5m6IsGlvf80ujBTEc4ShK/FrfLnQBAtVz+s9/5NwH
        2OcXoPeCABwy6MXhqnLwhl1y6ffF+r7nA+a6FDl06pRqMso7LCdeA1DVEX+i5Ptxhs6XMA1RbIJ2+
        Ch7L+/809ketnOVB2AYZfg4ylqI/N+LRd/HF6NTQ69H9fvrY3oGAg5suKEzMBhwqdrKNjjYzYGCDn
        SG/ryasHhHqXAhnDDEAIrXpKu/HWWQvfkljoPukucA0zTwcjXn8KEkkc/9BTehqzpG4SOi5mnwCkP
        gs3Bsz0w==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haRic-0000bq-Co; Mon, 10 Jun 2019 21:20:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] binfmt_flat: add a ARCH_HAS_BINFMT_FLAT option
Date:   Mon, 10 Jun 2019 23:20:09 +0200
Message-Id: <20190610212015.9157-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610212015.9157-1-hch@lst.de>
References: <20190610212015.9157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow architectures to opt into ARCH_HAS_BINFMT_FLAT support instead of
assuming that all nommu ports support the format.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig        | 1 +
 arch/c6x/Kconfig        | 1 +
 arch/h8300/Kconfig      | 1 +
 arch/m68k/Kconfig       | 1 +
 arch/microblaze/Kconfig | 1 +
 arch/sh/Kconfig         | 1 +
 arch/xtensa/Kconfig     | 1 +
 fs/Kconfig.binfmt       | 5 ++++-
 8 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1b48c0bde76..695a26c68064 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -4,6 +4,7 @@ config ARM
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_CLOCKSOURCE_DATA
+	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index eeb0471268a0..78dfe186d708 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -7,6 +7,7 @@
 config C6X
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select CLKDEV_LOOKUP
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 7457f190caaa..ec800e9d5aad 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -2,6 +2,7 @@
 config H8300
         def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_BINFMT_FLAT
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select BINFMT_FLAT_OLD_ALWAYS_RAM
 	select GENERIC_ATOMIC64
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index fd69ee5ad6ab..c0c43c624afa 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,6 +3,7 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index f11433daab4a..d411de05b628 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -3,6 +3,7 @@ config MICROBLAZE
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_NO_SWAP
+	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_DMA_COHERENT_TO_PFN if MMU
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index b77f512bb176..df3e6215b78c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config SUPERH
 	def_bool y
+	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 6ec1b75eabc5..ebc135bda921 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -2,6 +2,7 @@
 config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 82f7d7f234f3..286b425b30b9 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -91,9 +91,12 @@ config BINFMT_SCRIPT
 
 	  Most systems will not boot if you say M or N here.  If unsure, say Y.
 
+config ARCH_HAS_BINFMT_FLAT
+	bool
+
 config BINFMT_FLAT
 	bool "Kernel support for flat binaries"
-	depends on !MMU || ARM || M68K
+	depends on ARCH_HAS_BINFMT_FLAT
 	help
 	  Support uClinux FLAT format binaries.
 
-- 
2.20.1

