Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D074DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60C920675
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfLCQ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:26:59 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:40810 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfLCQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:26:50 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id ZUSm2100W5USYZQ06USmq9; Tue, 03 Dec 2019 17:26:47 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icB0g-0007fc-I3; Tue, 03 Dec 2019 17:26:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icB0g-0005Cf-Go; Tue, 03 Dec 2019 17:26:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/7] sh: kernel: disassemble: Fix broken lines in disassembly dumps
Date:   Tue,  3 Dec 2019 17:26:39 +0100
Message-Id: <20191203162645.19950-2-geert+renesas@glider.be>
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

 Code:
-  8c043d00:
-bf.s
-8c043d08
-
-  8c043d02:
-tst
-r2
-,
-r2
-
-  8c043d04:
-bf
-8c043d08
-
-->8c043d06:
-trapa
-#62
-
-  8c043d08:
-mov.l
-8c043d78 <dma_alloc_attrs+0xa4/0xb0>
-,
-r0
-  ! 8c044d14 <dma_alloc_from_dev_coherent+0x0/0x38>
-
-  8c043d0a:
-mov
-r15
-,
-r7
-
-  8c043d0c:
-mov
-r13
-,
-r6
-
-  8c043d0e:
-add
-#4
-,
-r7
-
-  8c043d10:
-mov
-r11
-,
-r5
-
+  8c043cf4:  bf.s      8c043cfc
+  8c043cf6:  tst       r2, r2
+  8c043cf8:  bf        8c043cfc
+->8c043cfa:  trapa     #62
+  8c043cfc:  mov.l     8c043d6c <dma_alloc_attrs+0xa4/0xb0>, r0  ! 8c044d08 <dma_alloc_from_dev_coherent+0x0/0x38>
+  8c043cfe:  mov       r15, r7
+  8c043d00:  mov       r13, r6
+  8c043d02:  add       #4, r7
+  8c043d04:  mov       r11, r5
---
 arch/sh/kernel/disassemble.c | 103 ++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 51 deletions(-)

diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
index 845543780cc55014..08e1af63edd9623c 100644
--- a/arch/sh/kernel/disassemble.c
+++ b/arch/sh/kernel/disassemble.c
@@ -376,148 +376,148 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 		}
 
 	ok:
-		printk("%-8s  ", op->name);
+		pr_cont("%-8s  ", op->name);
 		lastsp = (op->arg[0] == A_END);
 		disp_pc = 0;
 		for (n = 0; n < 6 && op->arg[n] != A_END; n++) {
 			if (n && op->arg[1] != A_END)
-				printk(", ");
+				pr_cont(", ");
 			switch (op->arg[n]) {
 			case A_IMM:
-				printk("#%d", (char)(imm));
+				pr_cont("#%d", (char)(imm));
 				break;
 			case A_R0:
-				printk("r0");
+				pr_cont("r0");
 				break;
 			case A_REG_N:
-				printk("r%d", rn);
+				pr_cont("r%d", rn);
 				break;
 			case A_INC_N:
-				printk("@r%d+", rn);
+				pr_cont("@r%d+", rn);
 				break;
 			case A_DEC_N:
-				printk("@-r%d", rn);
+				pr_cont("@-r%d", rn);
 				break;
 			case A_IND_N:
-				printk("@r%d", rn);
+				pr_cont("@r%d", rn);
 				break;
 			case A_DISP_REG_N:
-				printk("@(%d,r%d)", imm, rn);
+				pr_cont("@(%d,r%d)", imm, rn);
 				break;
 			case A_REG_M:
-				printk("r%d", rm);
+				pr_cont("r%d", rm);
 				break;
 			case A_INC_M:
-				printk("@r%d+", rm);
+				pr_cont("@r%d+", rm);
 				break;
 			case A_DEC_M:
-				printk("@-r%d", rm);
+				pr_cont("@-r%d", rm);
 				break;
 			case A_IND_M:
-				printk("@r%d", rm);
+				pr_cont("@r%d", rm);
 				break;
 			case A_DISP_REG_M:
-				printk("@(%d,r%d)", imm, rm);
+				pr_cont("@(%d,r%d)", imm, rm);
 				break;
 			case A_REG_B:
-				printk("r%d_bank", rb);
+				pr_cont("r%d_bank", rb);
 				break;
 			case A_DISP_PC:
 				disp_pc = 1;
 				disp_pc_addr = imm + 4 + (memaddr & relmask);
-				printk("%08x <%pS>", disp_pc_addr,
-				       (void *)disp_pc_addr);
+				pr_cont("%08x <%pS>", disp_pc_addr,
+					(void *)disp_pc_addr);
 				break;
 			case A_IND_R0_REG_N:
-				printk("@(r0,r%d)", rn);
+				pr_cont("@(r0,r%d)", rn);
 				break;
 			case A_IND_R0_REG_M:
-				printk("@(r0,r%d)", rm);
+				pr_cont("@(r0,r%d)", rm);
 				break;
 			case A_DISP_GBR:
-				printk("@(%d,gbr)",imm);
+				pr_cont("@(%d,gbr)", imm);
 				break;
 			case A_R0_GBR:
-				printk("@(r0,gbr)");
+				pr_cont("@(r0,gbr)");
 				break;
 			case A_BDISP12:
 			case A_BDISP8:
-				printk("%08x", imm + memaddr);
+				pr_cont("%08x", imm + memaddr);
 				break;
 			case A_SR:
-				printk("sr");
+				pr_cont("sr");
 				break;
 			case A_GBR:
-				printk("gbr");
+				pr_cont("gbr");
 				break;
 			case A_VBR:
-				printk("vbr");
+				pr_cont("vbr");
 				break;
 			case A_SSR:
-				printk("ssr");
+				pr_cont("ssr");
 				break;
 			case A_SPC:
-				printk("spc");
+				pr_cont("spc");
 				break;
 			case A_MACH:
-				printk("mach");
+				pr_cont("mach");
 				break;
 			case A_MACL:
-				printk("macl");
+				pr_cont("macl");
 				break;
 			case A_PR:
-				printk("pr");
+				pr_cont("pr");
 				break;
 			case A_SGR:
-				printk("sgr");
+				pr_cont("sgr");
 				break;
 			case A_DBR:
-				printk("dbr");
+				pr_cont("dbr");
 				break;
 			case FD_REG_N:
 			case F_REG_N:
-				printk("fr%d", rn);
+				pr_cont("fr%d", rn);
 				break;
 			case F_REG_M:
-				printk("fr%d", rm);
+				pr_cont("fr%d", rm);
 				break;
 			case DX_REG_N:
 				if (rn & 1) {
-					printk("xd%d", rn & ~1);
+					pr_cont("xd%d", rn & ~1);
 					break;
 				}
 				/* else, fall through */
 			case D_REG_N:
-				printk("dr%d", rn);
+				pr_cont("dr%d", rn);
 				break;
 			case DX_REG_M:
 				if (rm & 1) {
-					printk("xd%d", rm & ~1);
+					pr_cont("xd%d", rm & ~1);
 					break;
 				}
 				/* else, fall through */
 			case D_REG_M:
-				printk("dr%d", rm);
+				pr_cont("dr%d", rm);
 				break;
 			case FPSCR_M:
 			case FPSCR_N:
-				printk("fpscr");
+				pr_cont("fpscr");
 				break;
 			case FPUL_M:
 			case FPUL_N:
-				printk("fpul");
+				pr_cont("fpul");
 				break;
 			case F_FR0:
-				printk("fr0");
+				pr_cont("fr0");
 				break;
 			case V_REG_N:
-				printk("fv%d", rn*4);
+				pr_cont("fv%d", rn*4);
 				break;
 			case V_REG_M:
-				printk("fv%d", rm*4);
+				pr_cont("fv%d", rm*4);
 				break;
 			case XMTRX_M4:
-				printk("xmtrx");
+				pr_cont("xmtrx");
 				break;
 			default:
 				return;
@@ -532,7 +532,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 			else
 				__get_user(val, (u32 *)disp_pc_addr);
 
-			printk("  ! %08x <%pS>", val, (void *)val);
+			pr_cont("  ! %08x <%pS>", val, (void *)val);
 		}
 
 		return;
@@ -541,7 +541,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 
 	}
 
-	printk(".word 0x%x%x%x%x", nibs[0], nibs[1], nibs[2], nibs[3]);
+	pr_info(".word 0x%x%x%x%x", nibs[0], nibs[1], nibs[2], nibs[3]);
 }
 
 void show_code(struct pt_regs *regs)
@@ -552,20 +552,21 @@ void show_code(struct pt_regs *regs)
 	if (regs->pc & 0x1)
 		return;
 
-	printk("Code:\n");
+	pr_info("Code:\n");
 
 	for (i = -3 ; i < 6 ; i++) {
 		unsigned short insn;
 
 		if (__get_user(insn, pc + i)) {
-			printk(" (Bad address in pc)\n");
+			pr_err(" (Bad address in pc)\n");
 			break;
 		}
 
-		printk("%s%08lx:  ", (i ? "  ": "->"), (unsigned long)(pc + i));
+		pr_info("%s%08lx:  ", (i ? "  " : "->"),
+			(unsigned long)(pc + i));
 		print_sh_insn((unsigned long)(pc + i), insn);
-		printk("\n");
+		pr_cont("\n");
 	}
 
-	printk("\n");
+	pr_info("\n");
 }
-- 
2.17.1

