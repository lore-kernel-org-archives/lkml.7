Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2656C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F7E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XJnI3V02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbfDQOL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:11:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39545 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732306AbfDQOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:11:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEBe2A3934046
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:11:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEBe2A3934046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510301;
        bh=3wJ2H8Gux5Xoa6XaVRQZIcFRz1QtXjVniFlXmGL8ESM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XJnI3V025estYH+/6FjT2cIIJcW9ThAJxcnolun0pt+EVvnXkwVdf10WdIxdgAadS
         oYn0u1GKE6/oqPKYKKN81EHaopYoyZXifmgyAGNJJ+hT/+4vsL8Yn0eqeS/EFBpEI8
         uPYCrl7rNsLmAsvNCQfYdOxMtDNwkedowNE3LUVFM9M/MM3gYkSblOPgbIA/m1f3sR
         KxQFXXWav/pdZhpU8CluZQct9NFLCQ5Ej+UTrNZcxLHCmCQWwdWOuR+unQ+7OkTLtM
         kqj0VR6WK6bd6O+ClMAKPScEcbwzzPqhERyFp/wtzKzxagejwajVddRpPrW7EDMOp1
         uhfnxJbcKDU+w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEBeEu3934043;
        Wed, 17 Apr 2019 07:11:40 -0700
Date:   Wed, 17 Apr 2019 07:11:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-bf5882abab773afd1277415e2f826b21de28f30d@git.kernel.org>
Cc:     nstange@suse.de, sean.j.christopherson@intel.com, bp@suse.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        jpoimboe@redhat.com, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          bp@suse.de, mingo@kernel.org, luto@kernel.org,
          jpoimboe@redhat.com, x86@kernel.org, mingo@redhat.com,
          sean.j.christopherson@intel.com, nstange@suse.de
In-Reply-To: <20190414160144.885741626@linutronix.de>
References: <20190414160144.885741626@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/64: Use cpu entry area instead of orig_ist
Git-Commit-ID: bf5882abab773afd1277415e2f826b21de28f30d
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

Commit-ID:  bf5882abab773afd1277415e2f826b21de28f30d
Gitweb:     https://git.kernel.org/tip/bf5882abab773afd1277415e2f826b21de28f30d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:51 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 13:02:48 +0200

x86/irq/64: Use cpu entry area instead of orig_ist

The orig_ist[] array is a shadow copy of the IST array in the TSS. The
reason why it exists is that older kernels used two TSS variants with
different pointers into the debug stack. orig_ist[] contains the real
starting points.

There is no point anymore to do so because the same information can be
retrieved using the base address of the cpu entry area mapping and the
offsets of the various exception stacks.

No functional change. Preparation for removing orig_ist.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.885741626@linutronix.de
---
 arch/x86/kernel/irq_64.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 182e8b245e06..7eb6f8d11bfd 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -18,6 +18,8 @@
 #include <linux/uaccess.h>
 #include <linux/smp.h>
 #include <linux/sched/task_stack.h>
+
+#include <asm/cpu_entry_area.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 
@@ -43,10 +45,9 @@ static inline void stack_overflow_check(struct pt_regs *regs)
 {
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 #define STACK_MARGIN	128
-	struct orig_ist *oist;
-	u64 irq_stack_top, irq_stack_bottom;
-	u64 estack_top, estack_bottom;
+	u64 irq_stack_top, irq_stack_bottom, estack_top, estack_bottom;
 	u64 curbase = (u64)task_stack_page(current);
+	struct cea_exception_stacks *estacks;
 
 	if (user_mode(regs))
 		return;
@@ -60,9 +61,9 @@ static inline void stack_overflow_check(struct pt_regs *regs)
 	if (regs->sp >= irq_stack_bottom && regs->sp <= irq_stack_top)
 		return;
 
-	oist = this_cpu_ptr(&orig_ist);
-	estack_top = (u64)oist->ist[ESTACK_DB];
-	estack_bottom = estack_top - DEBUG_STKSZ + STACK_MARGIN;
+	estacks = __this_cpu_read(cea_exception_stacks);
+	estack_top = CEA_ESTACK_TOP(estacks, DB);
+	estack_bottom = CEA_ESTACK_BOT(estacks, DB) + STACK_MARGIN;
 	if (regs->sp >= estack_bottom && regs->sp <= estack_top)
 		return;
 
