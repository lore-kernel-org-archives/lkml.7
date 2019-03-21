Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE6D218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfCULkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:40:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCULkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:40:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LBe4PY109319
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 04:40:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LBe3nL109314;
        Thu, 21 Mar 2019 04:40:03 -0700
Date:   Thu, 21 Mar 2019 04:40:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matthew Whitehead <tipbot@zytor.com>
Message-ID: <tip-18fb053f9b827bd98cfc64f2a35df8ab19745a1d@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, tedheadster@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tedheadster@gmail.com
In-Reply-To: <1552596361-8967-2-git-send-email-tedheadster@gmail.com>
References: <1552596361-8967-2-git-send-email-tedheadster@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu/cyrix: Use correct macros for Cyrix calls
 on Geode processors
Git-Commit-ID: 18fb053f9b827bd98cfc64f2a35df8ab19745a1d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  18fb053f9b827bd98cfc64f2a35df8ab19745a1d
Gitweb:     https://git.kernel.org/tip/18fb053f9b827bd98cfc64f2a35df8ab19745a1d
Author:     Matthew Whitehead <tedheadster@gmail.com>
AuthorDate: Thu, 14 Mar 2019 16:46:00 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 12:28:50 +0100

x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

There are comments in processor-cyrix.h advising you to _not_ make calls
using the deprecated macros in this style:

  setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);

This is because it expands the macro into a non-functioning calling
sequence. The calling order must be:

  outb(CX86_CCR2, 0x22);
  inb(0x23);

From the comments:

 * When using the old macros a line like
 *   setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
 * gets expanded to:
 *  do {
 *    outb((CX86_CCR2), 0x22);
 *    outb((({
 *        outb((CX86_CCR2), 0x22);
 *        inb(0x23);
 *    }) | 0x88), 0x23);
 *  } while (0);

The new macros fix this problem, so use them instead. Tested on an
actual Geode processor.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: luto@kernel.org
Link: https://lkml.kernel.org/r/1552596361-8967-2-git-send-email-tedheadster@gmail.com

---
 arch/x86/kernel/cpu/cyrix.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index d12226f60168..1d9b8aaea06c 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -124,7 +124,7 @@ static void set_cx86_reorder(void)
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN */
 
 	/* Load/Store Serialize to mem access disable (=reorder it) */
-	setCx86_old(CX86_PCR0, getCx86_old(CX86_PCR0) & ~0x80);
+	setCx86(CX86_PCR0, getCx86(CX86_PCR0) & ~0x80);
 	/* set load/store serialize from 1GB to 4GB */
 	ccr3 |= 0xe0;
 	setCx86(CX86_CCR3, ccr3);
@@ -135,11 +135,11 @@ static void set_cx86_memwb(void)
 	pr_info("Enable Memory-Write-back mode on Cyrix/NSC processor.\n");
 
 	/* CCR2 bit 2: unlock NW bit */
-	setCx86_old(CX86_CCR2, getCx86_old(CX86_CCR2) & ~0x04);
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) & ~0x04);
 	/* set 'Not Write-through' */
 	write_cr0(read_cr0() | X86_CR0_NW);
 	/* CCR2 bit 2: lock NW bit and set WT1 */
-	setCx86_old(CX86_CCR2, getCx86_old(CX86_CCR2) | 0x14);
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x14);
 }
 
 /*
@@ -153,14 +153,14 @@ static void geode_configure(void)
 	local_irq_save(flags);
 
 	/* Suspend on halt power saving and enable #SUSP pin */
-	setCx86_old(CX86_CCR2, getCx86_old(CX86_CCR2) | 0x88);
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
 
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* enable MAPEN */
 
 
 	/* FPU fast, DTE cache, Mem bypass */
-	setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x38);
+	setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x38);
 	setCx86(CX86_CCR3, ccr3);			/* disable MAPEN */
 
 	set_cx86_memwb();
@@ -296,7 +296,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
 			/* Enable cxMMX extensions (GX1 Datasheet 54) */
-			setCx86_old(CX86_CCR7, getCx86_old(CX86_CCR7) | 1);
+			setCx86(CX86_CCR7, getCx86(CX86_CCR7) | 1);
 
 			/*
 			 * GXm : 0x30 ... 0x5f GXm  datasheet 51
@@ -319,7 +319,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		if (dir1 > 7) {
 			dir0_msn++;  /* M II */
 			/* Enable MMX extensions (App note 108) */
-			setCx86_old(CX86_CCR7, getCx86_old(CX86_CCR7)|1);
+			setCx86(CX86_CCR7, getCx86(CX86_CCR7)|1);
 		} else {
 			/* A 6x86MX - it has the bug. */
 			set_cpu_bug(c, X86_BUG_COMA);
