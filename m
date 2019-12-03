Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61392C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1632068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfLCQ1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:27:16 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:34558 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfLCQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:26:50 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id ZUSm2100p5USYZQ01USmMd; Tue, 03 Dec 2019 17:26:47 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icB0g-0007ff-JI; Tue, 03 Dec 2019 17:26:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icB0g-0005Cl-IA; Tue, 03 Dec 2019 17:26:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/7] sh: process: Fix broken lines in register dumps
Date:   Tue,  3 Dec 2019 17:26:41 +0100
Message-Id: <20191203162645.19950-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203162645.19950-1-geert+renesas@glider.be>
References: <20191203162645.19950-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rejoin the broken lines by using pr_cont().
Convert the remaining printk() calls to pr_*() while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Sample impact:

 PC is at dma_alloc_attrs+0x32/0xb0
 PR is at platform_resource_setup_memory+0xbc/0x150
-PC  : 8c043d06 SP  : 8f41fe9c SR  : 40000001
-TEA : 00000000
-R0  : 8c043cd4 R1  : 00000000 R2  : 00000000 R3  : 8c213e7c
+PC  : 8c043cfa SP  : 8f41fe9c SR  : 40000001 TEA : 8c00369e
+R0  : 8c043cc8 R1  : 00000000 R2  : 00000000 R3  : 8c213e7c
 R4  : 8c29cc38 R5  : 00100000 R6  : 8f41fecc R7  : 00000cc0
 R8  : 8c29cc38 R9  : 8c29720c R10 : 00000cc0 R11 : 00100000
-R12 : 00000000 R13 : 8f41fecc R14 : 8c274773
-MACH: 00000001 MACL: b16b1ded GBR : 09102e96 PR  : 8c2c0524
+R12 : 00000000 R13 : 8f41fecc R14 : 8c27479f
+MACH: 00000001 MACL: b16b1ded GBR : 004c5450 PR  : 8c2c0524
---
 arch/sh/kernel/process_32.c | 38 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index a094633874c373ef..348c245124c2c227 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -30,34 +30,30 @@
 
 void show_regs(struct pt_regs * regs)
 {
-	printk("\n");
+	pr_info("\n");
 	show_regs_print_info(KERN_DEFAULT);
 
-	printk("PC is at %pS\n", (void *)instruction_pointer(regs));
-	printk("PR is at %pS\n", (void *)regs->pr);
+	pr_info("PC is at %pS\n", (void *)instruction_pointer(regs));
+	pr_info("PR is at %pS\n", (void *)regs->pr);
 
-	printk("PC  : %08lx SP  : %08lx SR  : %08lx ",
-	       regs->pc, regs->regs[15], regs->sr);
+	pr_info("PC  : %08lx SP  : %08lx SR  : %08lx ", regs->pc,
+		regs->regs[15], regs->sr);
 #ifdef CONFIG_MMU
-	printk("TEA : %08x\n", __raw_readl(MMU_TEA));
+	pr_cont("TEA : %08x\n", __raw_readl(MMU_TEA));
 #else
-	printk("\n");
+	pr_cont("\n");
 #endif
 
-	printk("R0  : %08lx R1  : %08lx R2  : %08lx R3  : %08lx\n",
-	       regs->regs[0],regs->regs[1],
-	       regs->regs[2],regs->regs[3]);
-	printk("R4  : %08lx R5  : %08lx R6  : %08lx R7  : %08lx\n",
-	       regs->regs[4],regs->regs[5],
-	       regs->regs[6],regs->regs[7]);
-	printk("R8  : %08lx R9  : %08lx R10 : %08lx R11 : %08lx\n",
-	       regs->regs[8],regs->regs[9],
-	       regs->regs[10],regs->regs[11]);
-	printk("R12 : %08lx R13 : %08lx R14 : %08lx\n",
-	       regs->regs[12],regs->regs[13],
-	       regs->regs[14]);
-	printk("MACH: %08lx MACL: %08lx GBR : %08lx PR  : %08lx\n",
-	       regs->mach, regs->macl, regs->gbr, regs->pr);
+	pr_info("R0  : %08lx R1  : %08lx R2  : %08lx R3  : %08lx\n",
+		regs->regs[0], regs->regs[1], regs->regs[2], regs->regs[3]);
+	pr_info("R4  : %08lx R5  : %08lx R6  : %08lx R7  : %08lx\n",
+		regs->regs[4], regs->regs[5], regs->regs[6], regs->regs[7]);
+	pr_info("R8  : %08lx R9  : %08lx R10 : %08lx R11 : %08lx\n",
+		regs->regs[8], regs->regs[9], regs->regs[10], regs->regs[11]);
+	pr_info("R12 : %08lx R13 : %08lx R14 : %08lx\n",
+		regs->regs[12], regs->regs[13], regs->regs[14]);
+	pr_info("MACH: %08lx MACL: %08lx GBR : %08lx PR  : %08lx\n",
+		regs->mach, regs->macl, regs->gbr, regs->pr);
 
 	show_trace(NULL, (unsigned long *)regs->regs[15], regs);
 	show_code(regs);
-- 
2.17.1

