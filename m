Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC410C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6C220835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oP4zRwJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfD3LVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:21:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3LVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:21:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBKijg1347492
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:20:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBKijg1347492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623245;
        bh=C3t0slo8rzkJUyCXpbSIjvhOc4r5emWnLyOAWlZs5yE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=oP4zRwJ1czyBEH/vhk20eXQZMX4bvYf/RyvH0pwHj+FatGAIki+jZf7iKUXseE0+g
         MmwvV3v6VShRpqHdTi4crfvklL9M8oMScw//xnGmZ4FZBv57s6OwjIBdUTChBQhegZ
         xrd2drw0VE7S6xl0pGcc2zXYjycv4vU9tBGVi8CEpjkjeo51+b6gwwXJEWyA98qWyC
         DXbonRhXXR7+kWfRcn8+0EtJZ97P3YRkSD6CtUYh0Oxz3HI4vzFmuQjbexLXBqmbdN
         bSTWJQUAC2a35+xMFha0zPYYYtYk0wXkqTy5XsmIz9QxYlkVNHpOZTU+ylmhQB1Uwf
         Nyb67qOnaaoew==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBKhQD1347488;
        Tue, 30 Apr 2019 04:20:43 -0700
Date:   Tue, 30 Apr 2019 04:20:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-86a22057127d1c0462a18901421bf1ff89491392@git.kernel.org>
Cc:     linux_dti@icloud.com, kristen@linux.intel.com, bp@alien8.de,
        deneen.t.dock@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, riel@surriel.com,
        namit@vmware.com, mingo@kernel.org, rick.p.edgecombe@intel.com,
        tglx@linutronix.de, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, hpa@zytor.com,
        torvalds@linux-foundation.org, luto@kernel.org,
        will.deacon@arm.com, kernel-hardening@lists.openwall.com
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
          ard.biesheuvel@linaro.org, will.deacon@arm.com,
          kernel-hardening@lists.openwall.com, luto@kernel.org,
          rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
          tglx@linutronix.de, riel@surriel.com, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          namit@vmware.com, mingo@kernel.org, linux_dti@icloud.com,
          kristen@linux.intel.com, deneen.t.dock@intel.com, bp@alien8.de
In-Reply-To: <20190426001143.4983-9-namit@vmware.com>
References: <20190426001143.4983-9-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/kgdb: Avoid redundant comparison of patched code
Git-Commit-ID: 86a22057127d1c0462a18901421bf1ff89491392
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

Commit-ID:  86a22057127d1c0462a18901421bf1ff89491392
Gitweb:     https://git.kernel.org/tip/86a22057127d1c0462a18901421bf1ff89491392
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:28 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:53 +0200

x86/kgdb: Avoid redundant comparison of patched code

text_poke() already ensures that the written value is the correct one
and fails if that is not the case. There is no need for an additional
comparison. Remove it.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-9-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kgdb.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 2b203ee5b879..13b13311b792 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -747,7 +747,6 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 {
 	int err;
-	char opc[BREAK_INSTR_SIZE];
 
 	bpt->type = BP_BREAKPOINT;
 	err = probe_kernel_read(bpt->saved_instr, (char *)bpt->bpt_addr,
@@ -766,11 +765,6 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 		return -EBUSY;
 	text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
 		       BREAK_INSTR_SIZE);
-	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
-	if (err)
-		return err;
-	if (memcmp(opc, arch_kgdb_ops.gdb_bpt_instr, BREAK_INSTR_SIZE))
-		return -EINVAL;
 	bpt->type = BP_POKE_BREAKPOINT;
 
 	return err;
@@ -778,9 +772,6 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 
 int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 {
-	int err;
-	char opc[BREAK_INSTR_SIZE];
-
 	if (bpt->type != BP_POKE_BREAKPOINT)
 		goto knl_write;
 	/*
@@ -791,10 +782,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 		goto knl_write;
 	text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
 		       BREAK_INSTR_SIZE);
-	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
-	if (err || memcmp(opc, bpt->saved_instr, BREAK_INSTR_SIZE))
-		goto knl_write;
-	return err;
+	return 0;
 
 knl_write:
 	return probe_kernel_write((char *)bpt->bpt_addr,
