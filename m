Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD58C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93D020820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HKSjnXpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389863AbfFJVU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:20:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388642AbfFJVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g0IwcQvIyqL3tsx078/NiWA7dtMhIrKr9WJTKTcAruU=; b=HKSjnXpXMEzG8SwWHqMqP4qXQe
        RyXxhHYvlSNqS5VwKqhBm7QCrPna0l8e2qZL2ZCqTG/1eX/OnFTA+aG0dTPHkwMkBSUnx1qTmwY0j
        b+6UgPWz07I1hlRWSzW3xdBDMF+aMPCTyrrD8YZe75vP/Z17CajosDFFOLK7DHo2eR0vGSZ2tpAbm
        3RBlctUmWmZkCQ9VJJpZX5NDycqeWDlm0fvo+S9JNB/ZDxiBzdMN3dcw6AJ2QcwDfmKIw/hOz9+A9
        CLXMzn2AgoiTr2WUYDEhV4G7w8lBIg7zqjTu33Kk+nGs90iKrnZV0D4RzLG//41m/G/2ywofcf9EX
        NODrvffg==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haRiG-0000Jd-GY; Mon, 10 Jun 2019 21:20:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] binfmt_flat: remove flat_reloc_valid
Date:   Mon, 10 Jun 2019 23:20:01 +0200
Message-Id: <20190610212015.9157-2-hch@lst.de>
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

This helper is the same for all architectures, open code it in the only
caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/flat.h        | 1 -
 arch/c6x/include/asm/flat.h        | 1 -
 arch/h8300/include/asm/flat.h      | 1 -
 arch/m68k/include/asm/flat.h       | 1 -
 arch/microblaze/include/asm/flat.h | 1 -
 arch/sh/include/asm/flat.h         | 1 -
 arch/xtensa/include/asm/flat.h     | 1 -
 fs/binfmt_flat.c                   | 2 +-
 8 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
index f0c75ddeea23..10cce9ecf151 100644
--- a/arch/arm/include/asm/flat.h
+++ b/arch/arm/include/asm/flat.h
@@ -10,7 +10,6 @@
 
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		(flags)
-#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
 
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
index 76fd0bb962a3..ecc6aea6606c 100644
--- a/arch/c6x/include/asm/flat.h
+++ b/arch/c6x/include/asm/flat.h
@@ -6,7 +6,6 @@
 
 #define flat_argvp_envp_on_stack()			0
 #define flat_old_ram_flag(flags)			(flags)
-#define flat_reloc_valid(reloc, size)			((reloc) <= (size))
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
 {
diff --git a/arch/h8300/include/asm/flat.h b/arch/h8300/include/asm/flat.h
index f4cdfcbdd2ba..dcc7775115dd 100644
--- a/arch/h8300/include/asm/flat.h
+++ b/arch/h8300/include/asm/flat.h
@@ -10,7 +10,6 @@
 
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		1
-#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
 #define	flat_set_persistent(relval, p)		0
 
 /*
diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
index 4f1d1e373420..a631caf5e18f 100644
--- a/arch/m68k/include/asm/flat.h
+++ b/arch/m68k/include/asm/flat.h
@@ -10,7 +10,6 @@
 
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		(flags)
-#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
 {
diff --git a/arch/microblaze/include/asm/flat.h b/arch/microblaze/include/asm/flat.h
index 3d2747d4c967..34be5ed011be 100644
--- a/arch/microblaze/include/asm/flat.h
+++ b/arch/microblaze/include/asm/flat.h
@@ -15,7 +15,6 @@
 
 #define	flat_argvp_envp_on_stack()	0
 #define	flat_old_ram_flag(flags)	(flags)
-#define	flat_reloc_valid(reloc, size)	((reloc) <= (size))
 #define	flat_set_persistent(relval, p)		0
 
 /*
diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 843d458b8329..8f2929b32f2e 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -13,7 +13,6 @@
 
 #define	flat_argvp_envp_on_stack()		0
 #define	flat_old_ram_flag(flags)		(flags)
-#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
 {
diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/flat.h
index b8532d7877b3..6ee5a35eb0ec 100644
--- a/arch/xtensa/include/asm/flat.h
+++ b/arch/xtensa/include/asm/flat.h
@@ -6,7 +6,6 @@
 
 #define flat_argvp_envp_on_stack()			0
 #define flat_old_ram_flag(flags)			(flags)
-#define flat_reloc_valid(reloc, size)			((reloc) <= (size))
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
 					u32 *addr, u32 *persistent)
 {
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 82a48e830018..afddea583999 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -345,7 +345,7 @@ calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
 	start_code = p->lib_list[id].start_code;
 	text_len = p->lib_list[id].text_len;
 
-	if (!flat_reloc_valid(r, start_brk - start_data + text_len)) {
+	if (r > start_brk - start_data + text_len) {
 		pr_err("reloc outside program 0x%lx (0 - 0x%lx/0x%lx)",
 		       r, start_brk-start_data+text_len, text_len);
 		goto failed;
-- 
2.20.1

