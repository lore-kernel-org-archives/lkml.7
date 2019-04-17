Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B59FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5DE206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XTYjoInI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfDQOKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:10:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfDQOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:10:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEAENS3933909
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:10:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEAENS3933909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510215;
        bh=j/+wbXpQc3Op65PFxRA9DIkvVKG6TrYNU9scc2J4IoY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XTYjoInIL+JFkE//ZbtUSgLqDfASNoy9iqKl65RGcVTp0iqKnYfB+dqZJZEC4DBbb
         ftAIL0LO+KzdazRihbrDCIYkS/5JSRRrm4beXfsdDoy64Qm2vMNNkX6VpgG5edkY86
         WP3kmjwO4qDvU0PsjsnAr6zKt2jLLvRdy6CVgwIdk3mn6jkQKAhZKqoQcOb3HLX5BJ
         pS7A7t2w+CS7j7MNTtTDvA3ttv1FPhwmHVThMvC8k8A6IUYHbWLc6Lg1WvzSby6xRc
         ON4mgwTPSzdjtgN5e3MdIIB8kiT1PK4H6413sRbZ3BTfc0CNNwVkJFO7w3es9vhzmr
         EgM87JXWRBfIQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEAEiO3933906;
        Wed, 17 Apr 2019 07:10:14 -0700
Date:   Wed, 17 Apr 2019 07:10:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7623f37e411156e6e09b95cf5c76e509c5fda640@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        dave.hansen@linux.intel.com, mingo@redhat.com,
        sean.j.christopherson@intel.com, x86@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, bp@suse.de,
        jpoimboe@redhat.com
Reply-To: peterz@infradead.org, luto@kernel.org,
          dave.hansen@linux.intel.com, x86@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          jpoimboe@redhat.com, bp@suse.de, mingo@redhat.com,
          sean.j.christopherson@intel.com
In-Reply-To: <20190414160144.680960459@linutronix.de>
References: <20190414160144.680960459@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/cpu_entry_area: Provide exception stack accessor
Git-Commit-ID: 7623f37e411156e6e09b95cf5c76e509c5fda640
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

Commit-ID:  7623f37e411156e6e09b95cf5c76e509c5fda640
Gitweb:     https://git.kernel.org/tip/7623f37e411156e6e09b95cf5c76e509c5fda640
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:49 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 13:00:22 +0200

x86/cpu_entry_area: Provide exception stack accessor

Store a pointer to the per cpu entry area exception stack mappings to allow
fast retrieval.

Required for converting various places from using the shadow IST array to
directly doing address calculations on the actual mapping address.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.680960459@linutronix.de
---
 arch/x86/include/asm/cpu_entry_area.h | 4 ++++
 arch/x86/mm/cpu_entry_area.c          | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index af8c312673de..9b406f067ecf 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -99,6 +99,7 @@ struct cpu_entry_area {
 #define CPU_ENTRY_AREA_TOT_SIZE	(CPU_ENTRY_AREA_SIZE * NR_CPUS)
 
 DECLARE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
+DECLARE_PER_CPU(struct cea_exception_stacks *, cea_exception_stacks);
 
 extern void setup_cpu_entry_areas(void);
 extern void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags);
@@ -118,4 +119,7 @@ static inline struct entry_stack *cpu_entry_stack(int cpu)
 	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
 }
 
+#define __this_cpu_ist_top_va(name)					\
+	CEA_ESTACK_TOP(__this_cpu_read(cea_exception_stacks), name)
+
 #endif
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 2b1407662a6d..a00d0d059c8a 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -14,6 +14,7 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage)
 
 #ifdef CONFIG_X86_64
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
+DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
 #endif
 
 struct cpu_entry_area *get_cpu_entry_area(int cpu)
@@ -92,6 +93,9 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 	unsigned int npages;
 
 	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
+
+	per_cpu(cea_exception_stacks, cpu) = &cea->estacks;
+
 	/*
 	 * The exceptions stack mappings in the per cpu area are protected
 	 * by guard pages so each stack must be mapped separately.
