Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B478C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C59A214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612372;
	bh=knZ6utUagg4dxcdEvlxLaM20sxni76C8fY/RxYivpb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JGuM7wdNaV2pgzCUYeIghvKnbEqxrsQAgBmnDkOrD9Ep6QgKni1OIP8IVJZMqqoZ7
	 8wIOzSZ73WZOj7MQgqzlvLWJYzrOgQL2IA4+3gD89I8Pbz6LvHcaQq4guJBz7qFQ8D
	 Bv/IBDJa4h3FBMu9ji6vRmDMI0SW/jyn1lWQ79V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390272AbfDRSAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390259AbfDRSAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:00:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02DC2217FA;
        Thu, 18 Apr 2019 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610399;
        bh=knZ6utUagg4dxcdEvlxLaM20sxni76C8fY/RxYivpb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whDW99H1u7p058H15RlBAhcp53GBqWy6nYNx5ETD/zpwUulxjhtgSkiHfLRTwla0V
         nSIKKRqOM9iTTYvbdOUDBVi/4z3AGcenK2zeBu9P5pYRBG9oP6F4WzKx3ZIYsO6eP9
         FSG5xQz039nAGK7Psqj03zND8U1kDyD5Pu0yaIjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Whitehead <tedheadster@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, luto@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/110] x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors
Date:   Thu, 18 Apr 2019 19:56:35 +0200
Message-Id: <20190418160443.198111456@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 18fb053f9b827bd98cfc64f2a35df8ab19745a1d ]

There are comments in processor-cyrix.h advising you to _not_ make calls
using the deprecated macros in this style:

  setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);

This is because it expands the macro into a non-functioning calling
sequence. The calling order must be:

  outb(CX86_CCR2, 0x22);
  inb(0x23);

>From the comments:

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/cyrix.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 8949b7ae6d92..fa61c870ada9 100644
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
-- 
2.19.1



