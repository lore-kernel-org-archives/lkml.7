Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0B2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E4420854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrI7HMc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfCNUqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:46:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33713 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCNUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:46:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id x9so4240493qkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P32weTIqXRD2n82dqeb0BVtjjajjdJVBUO2XBqbDDAs=;
        b=ZrI7HMc0nalbpddZaVLGiYq1TvdhKUnO3vWLZDGmrismwQKVVSmg8Z5gSZwH5pFxfz
         NefYNN4EsHQnAmAyzsJv39qBM4CW39uu15omF+Pju/vL9yO7milXa0CUon79Zk0g5oaq
         xRh95gTOKA2nC2obOYtB0ALvBpf7ZeY3bMRCLbs7fRC0HuHMWqpxKBpBm/7Yj2mqP0gn
         CezgaNZa+FY07GRCG/wPnM1GRPPZec2c7IhVLfXxVTH3llXSFXcyxx9F4nx1w8VTQHvs
         o43TXF+VCz5UA3g+TZ1skhTnOdVA3bM+Hg3VCvETTdwCeIyQ6iqOOWsJIETulD21y2Hc
         dTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P32weTIqXRD2n82dqeb0BVtjjajjdJVBUO2XBqbDDAs=;
        b=bErqWbJzAECuEKdXozqp5yFITKFVENJMZe3hRk03MCHnui+vS+a1D1N3nAObBR5kb2
         4eysRswszEWDmmSx5b0TR3bnbEU9N3ZvNeHj3nmqRRPRPsITrttXjA276GLU09Prdc2N
         2s6HV9gFvzV7myIVLi02Jee7b8WBC4DZbd4bnGONuShFJnhJSmYzF8vsPiiVAuTXrGkK
         TZe7EJl8PekVFaNHwf25foPeElZ9xrFGEU00Yn+nVe637bgvHBbOH2xP+WSQBOvZcsPV
         b64qXJteJC3RMn7L9Wf0VqVd2/HTz/qHIVeATWKL1kYPM1DxRP123nw28/aC0lCLTZ47
         OQcw==
X-Gm-Message-State: APjAAAWEfk27hyInDK5Y/66WXJF+oc4kpeXZKlDCbd4jQJpcB2inordq
        J2Wjsz+seFuf6k1hYpnCHmo0uF4=
X-Google-Smtp-Source: APXvYqygt/upUjJK32/NdKSVvc0kWzdScyBxzDhufZ8XwWK3HP7j5bnBIpWmgsi7cbjzzWVM3gK6NA==
X-Received: by 2002:a37:c046:: with SMTP id o67mr177342qki.221.1552596376963;
        Thu, 14 Mar 2019 13:46:16 -0700 (PDT)
Received: from mwhitehe.remote.csb (ip-107-51-47-37.nymnny.spcsdns.net. [107.51.47.37])
        by smtp.gmail.com with ESMTPSA id j188sm16460qkc.55.2019.03.14.13.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:46:16 -0700 (PDT)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 1/2] x86/CPU: Use correct macros for Cyrix calls on Geode processors
Date:   Thu, 14 Mar 2019 16:46:00 -0400
Message-Id: <1552596361-8967-2-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1552596361-8967-1-git-send-email-tedheadster@gmail.com>
References: <1552596361-8967-1-git-send-email-tedheadster@gmail.com>
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

