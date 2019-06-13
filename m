Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6764A20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G7FwHj2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392691AbfFMQjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:39:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbfFMHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/K0yJ79eNsZTexuMmjUga9vIzUpMCAOhnqGbqeYEWjk=; b=G7FwHj2cYxWT08k9ykM8N40mCq
        MuOhqlaPuCjaxM3kbRVAqTiCNcrKIF6o69W6/1VOy/6rpxuAtDhgOx5pGYkNW2SeJWeUJS2lGaBTL
        EbPb6tuiNq9jrlUKM1puh8PzhseljVMYpQPkUr9oVrtJGQOkVBnK1PJxetZkajrL46o5yKFNeIh0u
        RlWlMqbJhunVlPmiAH6V/K5TguEFepg111i6WZ3ZYKyzfzpDQ1cxZsesnXqe5+P4x1rUhcDT+nWcp
        vxV7G0ID8hQ/YJ1COW2FAWsoiOmeNDqniBDoD+F4/F740kesngR57vPe+91zK03CtUGjTClYw5bde
        dtnqoGPA==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJrA-00049B-Ok; Thu, 13 Jun 2019 07:09:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 01/17] binfmt_flat: remove flat_reloc_valid
Date:   Thu, 13 Jun 2019 09:08:47 +0200
Message-Id: <20190613070903.17214-2-hch@lst.de>
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

This helper is the same for all architectures, open code it in the only
caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
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

