Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C475DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E2120661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwKL4AZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfCFUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:49:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41390 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFUtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:49:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so14536192qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P32weTIqXRD2n82dqeb0BVtjjajjdJVBUO2XBqbDDAs=;
        b=YwKL4AZve6KLoNgVI8G9BqFZhR4QJ5ILt8UpNJQsA1yCkN4WCJrqwH9ZOz4wmFMiwq
         +R9knpYzy2AGisrW+sr4JMhziNrulBxBZjuUFgK62X8wh9JS6ru5uw24UpP3DV+8qP46
         PRlKoVIWY5+7eMg3AAFc5XjcZrsRuihhUXtmitqAddBfWhxM6c9myhu0BAqRogEtTb7A
         tzIbu1JR3XmJo5JFX4DSEUkQfD4gwrWSPudzt2NC6X2Y039ZbYhx/W0InlGCkuIqqBve
         4OBHMGJTsJ6CxJZaJcWbIgi/jkcNsg6qRH7CPSgjUpbbR5CkINmy+33o+Iez3ueS80ro
         JLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P32weTIqXRD2n82dqeb0BVtjjajjdJVBUO2XBqbDDAs=;
        b=bxj1sJLd/oOngOn2VRbiAfVHZ8yaUpw2d47ChPE/WiSPpF2BvWy0tbts/enVSUW2qR
         FwzWIVWyXutmQm4pIdAHlT+jlZCfJNHRoPNFngwMuMqowRj/EMbFjMl/9RBrB/d5itP+
         kbdgjqIZDoecx10ymnrkF2VSB2M+oP2O8LyAJokWsljYmzQPA2SYjh+24cOgXR4GoX0g
         d6IYfqAeutIqx7UxR0Ot/PJIES/S1yN92erbLkPgKJzHhlzVaiYRFQI71jzgIzvHvuZI
         SY2CboVKRmwwpi7nkHYEHd5h66t40FDfhdeuRpQ9335pA9e3yRUw30tyhVCbYIRnDWxm
         sabg==
X-Gm-Message-State: APjAAAVNg1NDYe1MfBuTIq1uvMgsE0X95iLF0UTrbSHnzqFC0JGJv4dt
        aBDTDEP0/Pjj9B5V00GgNJqMcNE=
X-Google-Smtp-Source: APXvYqxjlujfjzN6f25gAJZ5lg4I1WzbGXnFhR2DPQbWAJEdjOwlmb1dFi0XZLg3JZRRgOsGRt0bkA==
X-Received: by 2002:a0c:ae78:: with SMTP id z53mr7813221qvc.235.1551905381924;
        Wed, 06 Mar 2019 12:49:41 -0800 (PST)
Received: from mwhitehe.remote.csb (pool-98-116-99-216.nycmny.fios.verizon.net. [98.116.99.216])
        by smtp.gmail.com with ESMTPSA id b66sm1642627qkj.57.2019.03.06.12.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 12:49:40 -0800 (PST)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 1/2] x86/CPU: Use correct macros for Cyrix calls on Geode processors
Date:   Wed,  6 Mar 2019 15:49:26 -0500
Message-Id: <1551905367-26931-2-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551905367-26931-1-git-send-email-tedheadster@gmail.com>
References: <1551905367-26931-1-git-send-email-tedheadster@gmail.com>
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

