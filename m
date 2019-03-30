Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF262C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9280F206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907640;
	bh=j4Nzli8aPkFidBiHM9Ytw3zvpcjyuMHmOEjV1GrbIdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdyL9RX3LnSpDxj+/NcMhfFEBngFozmAvwq3zsKx0FqJjYhNwRljqXCtbrtM9k1DI
	 cArNr0f35FDVh/fd3RkZ+WRoXWQ68FUcUrHdvYwAHbPjUf8P2/dWO6m8nsHvmw57Jb
	 8lhFgWMIGGod5Ua0mIY9NeGdD9wSCb1dl85Jaly4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfC3BAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731983AbfC3A4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:56:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1076218AC;
        Sat, 30 Mar 2019 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907403;
        bh=j4Nzli8aPkFidBiHM9Ytw3zvpcjyuMHmOEjV1GrbIdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+XW+k5XlRIg5VdSm6ZoKoSYW3HwsKnB1xfP6gDwOTuhed8EKrqAXfiduST2Hvuyu
         X1+tB8pPzBaxFGw0SAY9bMp3bpvOGtU9rcOQAzn8HHV+cs50TioY9M5pRhIOqB4PEX
         Dc+orhhLsvZQnRUTPbvgPhGuwYAKR2A4i4YPQr4A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, luto@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 23/27] x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors
Date:   Fri, 29 Mar 2019 20:55:49 -0400
Message-Id: <20190330005555.28087-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005555.28087-1-sashal@kernel.org>
References: <20190330005555.28087-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Whitehead <tedheadster@gmail.com>

[ Upstream commit 18fb053f9b827bd98cfc64f2a35df8ab19745a1d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/cyrix.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index d39cfb2c6b63..311d0fad17e6 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -121,7 +121,7 @@ static void set_cx86_reorder(void)
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN */
 
 	/* Load/Store Serialize to mem access disable (=reorder it) */
-	setCx86_old(CX86_PCR0, getCx86_old(CX86_PCR0) & ~0x80);
+	setCx86(CX86_PCR0, getCx86(CX86_PCR0) & ~0x80);
 	/* set load/store serialize from 1GB to 4GB */
 	ccr3 |= 0xe0;
 	setCx86(CX86_CCR3, ccr3);
@@ -132,11 +132,11 @@ static void set_cx86_memwb(void)
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
@@ -150,14 +150,14 @@ static void geode_configure(void)
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
@@ -293,7 +293,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
 			/* Enable cxMMX extensions (GX1 Datasheet 54) */
-			setCx86_old(CX86_CCR7, getCx86_old(CX86_CCR7) | 1);
+			setCx86(CX86_CCR7, getCx86(CX86_CCR7) | 1);
 
 			/*
 			 * GXm : 0x30 ... 0x5f GXm  datasheet 51
@@ -316,7 +316,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
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

