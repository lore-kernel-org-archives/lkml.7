Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81108C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543422071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PnPyQyQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfKZMgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:36:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:25835 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbfKZMgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:36:12 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Mk0T6mvNz9v0GC;
        Tue, 26 Nov 2019 13:36:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PnPyQyQ0; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PtuDK7RrT_qk; Tue, 26 Nov 2019 13:36:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Mk0T5lz7z9v0G3;
        Tue, 26 Nov 2019 13:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574771769; bh=gOKxrtnFAgRuj43vPkwpnRsML3n0B7clWBuAh6m562Y=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=PnPyQyQ04mngmpm+Thv3+/K8x1FG75fVbSBF1KM3i+WrO6Qb9OaPFjP5oNeeyzR9s
         HcMx3OBvoR20fF6He9obZJQQjOQD7YULSiTqVWnWChzOsoYzs1PDGy8jWocFqUcc6R
         tVG2d4UEHAC58vv9yBq4sm3lFTpyDvrZBEO0Tfq4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 099468B7FC;
        Tue, 26 Nov 2019 13:36:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id y-1AHrQMGz9a; Tue, 26 Nov 2019 13:36:10 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C83918B771;
        Tue, 26 Nov 2019 13:36:10 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 94CDE6B76A; Tue, 26 Nov 2019 12:36:10 +0000 (UTC)
Message-Id: <f28c9b5daf833e3b88f9c1245494b8aa73651a98.1574771540.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1574771539.git.christophe.leroy@c-s.fr>
References: <cover.1574771539.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 07/16] powerpc: align stack to 2 * THREAD_SIZE with
 VMAP_STACK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Tue, 26 Nov 2019 12:36:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ease stack overflow detection, align
stack to 2 * THREAD_SIZE when using VMAP_STACK.
This allows overflow detection using a single bit check.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/thread_info.h | 13 +++++++++++++
 arch/powerpc/kernel/setup_32.c         |  2 +-
 arch/powerpc/kernel/setup_64.c         |  2 +-
 arch/powerpc/kernel/vmlinux.lds.S      |  2 +-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 488d5c4670ff..a2270749b282 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -22,6 +22,19 @@
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
+/*
+ * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
+ * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
+ * assembly.
+ */
+#ifdef CONFIG_VMAP_STACK
+#define THREAD_ALIGN_SHIFT	(THREAD_SHIFT + 1)
+#else
+#define THREAD_ALIGN_SHIFT	THREAD_SHIFT
+#endif
+
+#define THREAD_ALIGN		(1 << THREAD_ALIGN_SHIFT)
+
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index dcffe927f5b9..f014c4f7a337 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -140,7 +140,7 @@ arch_initcall(ppc_init);
 
 static void *__init alloc_stack(void)
 {
-	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_ALIGN);
 
 	if (!ptr)
 		panic("cannot allocate %d bytes for stack at %pS\n",
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6104917a282d..e05e6dd67ae6 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -633,7 +633,7 @@ static void *__init alloc_stack(unsigned long limit, int cpu)
 
 	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
 
-	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
+	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_ALIGN,
 				     MEMBLOCK_LOW_LIMIT, limit,
 				     early_cpu_to_node(cpu));
 	if (!ptr)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..d38335129c06 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -346,7 +346,7 @@ SECTIONS
 #endif
 
 	/* The initial task and kernel stack */
-	INIT_TASK_DATA_SECTION(THREAD_SIZE)
+	INIT_TASK_DATA_SECTION(THREAD_ALIGN)
 
 	.data..page_aligned : AT(ADDR(.data..page_aligned) - LOAD_OFFSET) {
 		PAGE_ALIGNED_DATA(PAGE_SIZE)
-- 
2.13.3

