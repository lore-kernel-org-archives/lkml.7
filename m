Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026AEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38A0204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JS3QclBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfDQOMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:12:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732320AbfDQOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:12:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HECRxu3934333
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:12:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HECRxu3934333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510348;
        bh=OhcV/FRotL36qxGr8OBhsLpuNgzyt92MJjjAa8bY5Zo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JS3QclBz6oeDU+n8E8Vpw1qocyeajhtUQO5vIGAh6ut7d2lvRL8N7VrOQ0F4iINDV
         yVuufsp9/5+DG40TY5k9ImuMCAAXLjL6JjRDRE7j/gWa6M4sJ0IMTrAdzwPPsk3w+B
         6kQhzbPtL25P3bPJBHd72sq8zEDxDIAHyZy/wJB8t8H1PgV3tLWc6e9pjCXmuPk/qx
         EIx/wGnA+SjaaYSbsTgsbZJcytESCnyPABK2KMiNzsWawf3REt53nwS2wBB9qsCPQA
         dVgpJOoL4MfVc2zZd4foY+SnrntjVU8YOhWx1C6YwU7FC2nAR2fxu6uDQo3tp8T+6E
         LozVX7FszrecQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HECRl23934329;
        Wed, 17 Apr 2019 07:12:27 -0700
Date:   Wed, 17 Apr 2019 07:12:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-afcd21dad88b68d646e91ed36948117d58b4c197@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org,
        mingo@kernel.org, sean.j.christopherson@intel.com, hpa@zytor.com,
        jpoimboe@redhat.com, bp@suse.de, tglx@linutronix.de, x86@kernel.org
Reply-To: bp@suse.de, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
          linux-kernel@vger.kernel.org, luto@kernel.org, hpa@zytor.com,
          sean.j.christopherson@intel.com, mingo@kernel.org,
          jpoimboe@redhat.com
In-Reply-To: <20190414160144.974900463@linutronix.de>
References: <20190414160144.974900463@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/dumpstack/64: Use cpu_entry_area instead of
 orig_ist
Git-Commit-ID: afcd21dad88b68d646e91ed36948117d58b4c197
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

Commit-ID:  afcd21dad88b68d646e91ed36948117d58b4c197
Gitweb:     https://git.kernel.org/tip/afcd21dad88b68d646e91ed36948117d58b4c197
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:52 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 13:05:06 +0200

x86/dumpstack/64: Use cpu_entry_area instead of orig_ist

The orig_ist[] array is a shadow copy of the IST array in the TSS. The
reason why it exists is that older kernels used two TSS variants with
different pointers into the debug stack. orig_ist[] contains the real
starting points.

There is no point anymore to do so because the same information can be
retrieved using the base address of the cpu entry area mapping and the
offsets of the various exception stacks.

No functional change. Preparation for removing orig_ist.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.974900463@linutronix.de
---
 arch/x86/kernel/dumpstack_64.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 455b47ef9250..f6fbd0438f9e 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -16,6 +16,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 
+#include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 
 static const char *exception_stack_names[N_EXCEPTION_STACKS] = {
@@ -25,11 +26,6 @@ static const char *exception_stack_names[N_EXCEPTION_STACKS] = {
 		[ ESTACK_MCE	]	= "#MC",
 };
 
-static const unsigned long exception_stack_sizes[N_EXCEPTION_STACKS] = {
-	[0 ... N_EXCEPTION_STACKS - 1]		= EXCEPTION_STKSZ,
-	[ESTACK_DB]				= DEBUG_STKSZ
-};
-
 const char *stack_type_name(enum stack_type type)
 {
 	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
@@ -52,25 +48,44 @@ const char *stack_type_name(enum stack_type type)
 	return NULL;
 }
 
+struct estack_layout {
+	unsigned int	begin;
+	unsigned int	end;
+};
+
+#define	ESTACK_ENTRY(x)	{						  \
+	.begin	= offsetof(struct cea_exception_stacks, x## _stack),	  \
+	.end	= offsetof(struct cea_exception_stacks, x## _stack_guard) \
+	}
+
+static const struct estack_layout layout[N_EXCEPTION_STACKS] = {
+	[ ESTACK_DF	]	= ESTACK_ENTRY(DF),
+	[ ESTACK_NMI	]	= ESTACK_ENTRY(NMI),
+	[ ESTACK_DB	]	= ESTACK_ENTRY(DB),
+	[ ESTACK_MCE	]	= ESTACK_ENTRY(MCE),
+};
+
 static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin, *end;
+	unsigned long estacks, begin, end, stk = (unsigned long)stack;
 	struct pt_regs *regs;
-	unsigned k;
+	unsigned int k;
 
 	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
 
+	estacks = (unsigned long)__this_cpu_read(cea_exception_stacks);
+
 	for (k = 0; k < N_EXCEPTION_STACKS; k++) {
-		end   = (unsigned long *)raw_cpu_ptr(&orig_ist)->ist[k];
-		begin = end - (exception_stack_sizes[k] / sizeof(long));
+		begin = estacks + layout[k].begin;
+		end   = estacks + layout[k].end;
 		regs  = (struct pt_regs *)end - 1;
 
-		if (stack < begin || stack >= end)
+		if (stk < begin || stk >= end)
 			continue;
 
 		info->type	= STACK_TYPE_EXCEPTION + k;
-		info->begin	= begin;
-		info->end	= end;
+		info->begin	= (unsigned long *)begin;
+		info->end	= (unsigned long *)end;
 		info->next_sp	= (unsigned long *)regs->sp;
 
 		return true;
