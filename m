Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2052C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5B320661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8irjMYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfCFT5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:57:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35517 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfCFT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:57:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so14344997qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 11:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P32weTIqXRD2n82dqeb0BVtjjajjdJVBUO2XBqbDDAs=;
        b=X8irjMYhT3j6eFFuz/8L0ZvQKdgJZBsoVEbD4yR2C/zdTQTFTxprW8anNl0DajxRlk
         4WA9F1teFnUc3CDTXavFlSglIDBXRj5yg2V4t24xHcjAxJx9AXKBjGhVhWkZxzg2r2Nw
         XpB9ZjXZi1i5jroV2dqfDQRCRIPgFPF3oz472a+ni8pjagHEAnQpMDfXPltoSALakuVq
         e/6YxHTFqRJtg3cTzWY5cgLR+Zuwvp3g/oDkpbA+/IsY9SnV/gSnDoRcH1hZP00oarXe
         4liLRYIzPGY9AbmiCVr+iLM/iuWxf/Wk0Kaf0FRK9K8suMBnqj3il9c0zhUzXYuxKLmO
         yA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P32weTIqXRD2n82dqeb0BVtjjajjdJVBUO2XBqbDDAs=;
        b=Q294iKh+kt9e4yZgqAted8G9LCT4NPY4SooEsxUIHDqFYXQ/xCh0svgTcM6KXzolks
         t5TJSkqx/XXB+6WUi4pGrGMc2wte92M/OKe9wGlMpH5Z4S1zFTbXiYCDjMkwljwiuMRx
         L2562GCBbEOq5Q/J4/WBVaxefI62HkWna9C6YhQx2+HSiixoInCXuW0tri07UAijlzT3
         A2AE5vdjSAUTIvU5DVZQN7S+K9/toObft9DWiGwUTh5bmxU5lupVj+8SvjdoeUseSQZN
         3kDlx0iq1gPGky/qd+TPJ57ItxcRwhRAgXjwll0siwR9T0A7FHWR2kIqr5pt3a+Gey0a
         xbtg==
X-Gm-Message-State: APjAAAUHveWqzngte4glqng7C1nRK4q/EMmizagsxdiir5LE02OW01/r
        r6u5kJbLzXhWgUGkF+OJ4iXkQ88=
X-Google-Smtp-Source: APXvYqzQy4WdRIYcm7dZQ4r1E/GgaspXw9rjIPhJ0eXuqcqD02uFYA2klg7luzZ8m8tQoCSESDvB7A==
X-Received: by 2002:ac8:3f0f:: with SMTP id c15mr7157986qtk.142.1551902237344;
        Wed, 06 Mar 2019 11:57:17 -0800 (PST)
Received: from mwhitehe.remote.csb (pool-98-116-99-216.nycmny.fios.verizon.net. [98.116.99.216])
        by smtp.gmail.com with ESMTPSA id y11sm2035077qky.2.2019.03.06.11.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 11:57:16 -0800 (PST)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        luto@kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH] x86/CPU: Use correct macros for Cyrix calls on Geode processors
Date:   Wed,  6 Mar 2019 14:57:08 -0500
Message-Id: <1551902228-21319-1-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/kernel/cpu/cyrix.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index d12226f..1d9b8aa 100644
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
1.8.3.1

