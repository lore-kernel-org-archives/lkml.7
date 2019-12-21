Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63673C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384522465E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Zy7fOLTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLUIck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:32:40 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13338 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfLUIcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:32:32 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47fzPp1kdgz9txh8;
        Sat, 21 Dec 2019 09:32:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Zy7fOLTm; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ss6Tha5HnOid; Sat, 21 Dec 2019 09:32:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47fzPp0jnbz9vBmv;
        Sat, 21 Dec 2019 09:32:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576917150; bh=w+xBToVhZ/hhpWFIpAvoRq9RuWR0Mj1UyY+7f+k+jhw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Zy7fOLTmrXxdKJvEZyMUeH5zMzM8ETFIXwB8Tq1mhKX7sZjT+bzxUg5i3sErxag5X
         bCRVN1Xq04EHomwO4imMFp4ULfD+U7s6lxz+4nYr3gnkM+srDaW8Vty8+qYde+xweM
         JyalDqg6SLgqUhA0aO/jPe5VHfse5cnSgzpFBVh8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 187058B77C;
        Sat, 21 Dec 2019 09:32:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bHtHoTsDflDm; Sat, 21 Dec 2019 09:32:31 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D446B8B752;
        Sat, 21 Dec 2019 09:32:30 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 9C35C637B6; Sat, 21 Dec 2019 08:32:30 +0000 (UTC)
Message-Id: <d33ad1b36ddff4dcc19f96c592c12a61cf85d406.1576916812.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1576916812.git.christophe.leroy@c-s.fr>
References: <cover.1576916812.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 09/17] powerpc/32: Use vmapped stacks for interrupts
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Sat, 21 Dec 2019 08:32:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to also catch overflows on IRQ stacks, use vmapped stacks.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c      | 22 ++++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index add67498c126..5c9b11878555 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -50,6 +50,7 @@
 #include <linux/debugfs.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/vmalloc.h>
 
 #include <linux/uaccess.h>
 #include <asm/io.h>
@@ -664,8 +665,29 @@ void do_IRQ(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+static void *__init alloc_vm_stack(void)
+{
+	return __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN, VMALLOC_START,
+				    VMALLOC_END, THREADINFO_GFP, PAGE_KERNEL,
+				     0, NUMA_NO_NODE, (void*)_RET_IP_);
+}
+
+static void __init vmap_irqstack_init(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		softirq_ctx[i] = alloc_vm_stack();
+		hardirq_ctx[i] = alloc_vm_stack();
+	}
+}
+
+
 void __init init_IRQ(void)
 {
+	if (IS_ENABLED(CONFIG_VMAP_STACK))
+		vmap_irqstack_init();
+
 	if (ppc_md.init_IRQ)
 		ppc_md.init_IRQ();
 }
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a55b4d9ab824..5b49b26eb154 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -153,6 +153,9 @@ void __init irqstack_early_init(void)
 {
 	unsigned int i;
 
+	if (IS_ENABLED(CONFIG_VMAP_STACK))
+		return;
+
 	/* interrupt stacks must be in lowmem, we get that for free on ppc32
 	 * as the memblock is limited to lowmem by default */
 	for_each_possible_cpu(i) {
-- 
2.13.3

