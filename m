Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE39C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8AA204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uaORnqPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfCVII5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:08:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64222 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbfCVIIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:08:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Qbrs3CZMz9vCyQ;
        Fri, 22 Mar 2019 09:08:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=uaORnqPO; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0QaeGDbTtsSJ; Fri, 22 Mar 2019 09:08:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Qbrs21w6z9vCyP;
        Fri, 22 Mar 2019 09:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553242125; bh=jW+6auvhu8fUHifNrjMO15H6gNILn2m8hocCxQxL7b4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=uaORnqPOyehU9M7bi5RZAZfy0eVbWlEnaAMyMx/RIfmjjYeyHU/zr49gGVxUWWQyU
         KxphnibJ4NIo85y0fiC2/36/mDBcvVGTZygbDMDOJA156w93OygQu0diTu9EkxJjOu
         u+GVMjcpL/Hfrx9CrniNuPnyG1UDzuxa9+gqm5jk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A6D18B845;
        Fri, 22 Mar 2019 09:08:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ye47tXitqBGN; Fri, 22 Mar 2019 09:08:46 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 11EB08B844;
        Fri, 22 Mar 2019 09:08:46 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F39F56CD85; Fri, 22 Mar 2019 08:08:45 +0000 (UTC)
Message-Id: <9f3560c21cee3942f15c20eac53753626a736fd0.1553242059.git.christophe.leroy@c-s.fr>
In-Reply-To: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
References: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 7/7] powerpc/setup: replace ifdefs by IS_ENABLED() wherever
 possible.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 22 Mar 2019 08:08:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to ifdefs, IS_ENABLED() provide a cleaner code and allows
to detect compilation failure regardless of the selected options.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/setup-common.c | 39 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index b6c86287085a..6a936cb98b79 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -196,14 +196,15 @@ static void show_cpuinfo_summary(struct seq_file *m)
 {
 	struct device_node *root;
 	const char *model = NULL;
-#if defined(CONFIG_SMP) && defined(CONFIG_PPC32)
 	unsigned long bogosum = 0;
 	int i;
-	for_each_online_cpu(i)
-		bogosum += loops_per_jiffy;
-	seq_printf(m, "total bogomips\t: %lu.%02lu\n",
-		   bogosum/(500000/HZ), bogosum/(5000/HZ) % 100);
-#endif /* CONFIG_SMP && CONFIG_PPC32 */
+
+	if (IS_ENABLED(CONFIG_SMP) && IS_ENABLED(CONFIG_PPC32)) {
+		for_each_online_cpu(i)
+			bogosum += loops_per_jiffy;
+		seq_printf(m, "total bogomips\t: %lu.%02lu\n",
+			   bogosum / (500000 / HZ), bogosum / (5000 / HZ) % 100);
+	}
 	seq_printf(m, "timebase\t: %lu\n", ppc_tb_freq);
 	if (ppc_md.name)
 		seq_printf(m, "platform\t: %s\n", ppc_md.name);
@@ -217,11 +218,10 @@ static void show_cpuinfo_summary(struct seq_file *m)
 	if (ppc_md.show_cpuinfo != NULL)
 		ppc_md.show_cpuinfo(m);
 
-#ifdef CONFIG_PPC32
 	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n",
-		   (unsigned int)(total_memory / (1024 * 1024)));
-#endif
+	if (IS_ENABLED(CONFIG_PPC32))
+		seq_printf(m, "Memory\t\t: %d MB\n",
+			   (unsigned int)(total_memory / (1024 * 1024)));
 }
 
 static int show_cpuinfo(struct seq_file *m, void *v)
@@ -329,11 +329,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "revision\t: %hd.%hd (pvr %04x %04x)\n",
 		   maj, min, PVR_VER(pvr), PVR_REV(pvr));
 
-#ifdef CONFIG_PPC32
-	seq_printf(m, "bogomips\t: %lu.%02lu\n",
-		   loops_per_jiffy / (500000/HZ),
-		   (loops_per_jiffy / (5000/HZ)) % 100);
-#endif
+	if (IS_ENABLED(CONFIG_PPC32))
+		seq_printf(m, "bogomips\t: %lu.%02lu\n", loops_per_jiffy / (500000 / HZ),
+			   (loops_per_jiffy / (5000 / HZ)) % 100);
+
 	seq_printf(m, "\n");
 
 	/* If this is the last cpu, print the summary */
@@ -957,9 +956,9 @@ void __init setup_arch(char **cmdline_p)
 
 	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
+	if (IS_ENABLED(CONFIG_DUMMY_CONSOLE))
+		conswitchp = &dummy_con;
+
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
@@ -971,10 +970,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Initialize the MMU context management stuff. */
 	mmu_context_init();
 
-#ifdef CONFIG_PPC64
 	/* Interrupt code needs to be 64K-aligned. */
-	if ((unsigned long)_stext & 0xffff)
+	if (IS_ENABLED(CONFIG_PPC64) && (unsigned long)_stext & 0xffff)
 		panic("Kernelbase not 64K-aligned (0x%lx)!\n",
 		      (unsigned long)_stext);
-#endif
 }
-- 
2.13.3

