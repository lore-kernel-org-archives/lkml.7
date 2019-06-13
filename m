Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BC8C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C8820644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ofOdqb6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392809AbfFMQjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:39:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbfFMHJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=349ICr9dg05ay9BAc1k3mHyeKJ+n6JqFLuEAvRg0P7g=; b=ofOdqb6ENcKyitTdqRDziG85EX
        EDMzuugvtQfkRqTTdFMj3wdQRjzCSG9Xzyr5eesUCkx51FRLOXAF+Gj2GS3xzj+cNg/CJ4O2BXO3K
        +JSeRPsxOpXLJYJNm+AOXRMmA7qDoQm87doVz7/156WyI8XHwkhC3GX/qb0GhXlXEuiZvOaAxOoXj
        tDOW/PsnwLhAHVEgi+4LH7Lt5qD3bYeC1KlsIZhf19ETLpGP9Is2YxNKWprMgfD9tBTJ1ueMqACFv
        Ly0aOmygtu9XChaEuXrCgvGwarpjuXhbMR1HWVOz81lL0Jp+y/5xf1ArA3b92VOf8QobLN32Z5mgq
        qiVPtixw==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJrL-0004CK-0H; Thu, 13 Jun 2019 07:09:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] binfmt_flat: remove flat_old_ram_flag
Date:   Thu, 13 Jun 2019 09:08:50 +0200
Message-Id: <20190613070903.17214-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
References: <20190613070903.17214-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead add a Kconfig variable that only h8300 selects.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/flat.h        | 1 -
 arch/c6x/include/asm/flat.h        | 1 -
 arch/h8300/Kconfig                 | 1 +
 arch/h8300/include/asm/flat.h      | 1 -
 arch/m68k/include/asm/flat.h       | 1 -
 arch/microblaze/include/asm/flat.h | 1 -
 arch/sh/include/asm/flat.h         | 1 -
 arch/xtensa/include/asm/flat.h     | 1 -
 fs/Kconfig.binfmt                  | 3 +++
 fs/binfmt_flat.c                   | 3 ++-
 10 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
index a185fe023b60..acf162111ee2 100644
--- a/arch/arm/include/asm/flat.h
+++ b/arch/arm/include/asm/flat.h
@@ -9,7 +9,6 @@
 #include <linux/uaccess.h>
 
 #define	flat_argvp_envp_on_stack()		1
-#define	flat_old_ram_flag(flags)		(flags)
 
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
index c4d703b454c6..353e4d06e8c0 100644
--- a/arch/c6x/include/asm/flat.h
+++ b/arch/c6x/include/asm/flat.h
@@ -5,7 +5,6 @@
 #include <asm/unaligned.h>
 
 #define flat_argvp_envp_on_stack()			0
-#define flat_old_ram_flag(flags)			(flags)
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
 {
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index ecfc4b4b6373..d30e8727b02d 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -2,6 +2,7 @@
 config H8300
         def_bool y
 	select ARCH_32BIT_OFF_T
+	select BINFMT_FLAT_OLD_ALWAYS_RAM
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
 	select VIRT_TO_BUS
diff --git a/arch/h8300/include/asm/flat.h b/arch/h8300/include/asm/flat.h
index 7ef7eefded3d..14cc928d5478 100644
--- a/arch/h8300/include/asm/flat.h
+++ b/arch/h8300/include/asm/flat.h
@@ -9,7 +9,6 @@
 #include <asm/unaligned.h>
 
 #define	flat_argvp_envp_on_stack()		1
-#define	flat_old_ram_flag(flags)		1
 
 /*
  * on the H8 a couple of the relocations have an instruction in the
diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
index 217fa89c8e34..7b1fb5c2809e 100644
--- a/arch/m68k/include/asm/flat.h
+++ b/arch/m68k/include/asm/flat.h
@@ -9,7 +9,6 @@
 #include <linux/uaccess.h>
 
 #define	flat_argvp_envp_on_stack()		1
-#define	flat_old_ram_flag(flags)		(flags)
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
 {
diff --git a/arch/microblaze/include/asm/flat.h b/arch/microblaze/include/asm/flat.h
index 846084fa7f04..1cd8d7f4cf12 100644
--- a/arch/microblaze/include/asm/flat.h
+++ b/arch/microblaze/include/asm/flat.h
@@ -14,7 +14,6 @@
 #include <asm/unaligned.h>
 
 #define	flat_argvp_envp_on_stack()	0
-#define	flat_old_ram_flag(flags)	(flags)
 
 /*
  * Microblaze works a little differently from other arches, because
diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 0d520b4cc5ea..015678d7b771 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -12,7 +12,6 @@
 #include <asm/unaligned.h>
 
 #define	flat_argvp_envp_on_stack()		0
-#define	flat_old_ram_flag(flags)		(flags)
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
 {
diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/flat.h
index a1d88aa3ef8a..b215c1e66958 100644
--- a/arch/xtensa/include/asm/flat.h
+++ b/arch/xtensa/include/asm/flat.h
@@ -5,7 +5,6 @@
 #include <asm/unaligned.h>
 
 #define flat_argvp_envp_on_stack()			0
-#define flat_old_ram_flag(flags)			(flags)
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
 {
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index f87ddd1b6d72..5658e12ad944 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -97,6 +97,9 @@ config BINFMT_FLAT
 	help
 	  Support uClinux FLAT format binaries.
 
+config BINFMT_FLAT_OLD_ALWAYS_RAM
+	bool
+
 config BINFMT_ZFLAT
 	bool "Enable ZFLAT support"
 	depends on BINFMT_FLAT
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index c0e4535dc1ec..3e7f4a6cffa2 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -488,7 +488,8 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * fix up the flags for the older format,  there were all kinds
 	 * of endian hacks,  this only works for the simple cases
 	 */
-	if (rev == OLD_FLAT_VERSION && flat_old_ram_flag(flags))
+	if (rev == OLD_FLAT_VERSION &&
+	   (flags || IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM)))
 		flags = FLAT_FLAG_RAM;
 
 #ifndef CONFIG_BINFMT_ZFLAT
-- 
2.20.1

