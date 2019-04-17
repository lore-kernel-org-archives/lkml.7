Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37414C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2D420872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gTl4xDly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbfDQOWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:22:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33415 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:22:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HELVE43936008
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:21:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HELVE43936008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510892;
        bh=JLMFnSTmwiTGnJhJvK0TFLJv2DESJbRYXVk6vSfE3o8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gTl4xDlyLrQd142DDth3aD0Zq+P85itpsVTEomJZzrz4lIf8A5LtBQGQIZeU51qyw
         DgPto62ufabLfnfc5MWi00YEDYmv1Xvq0rCJRDTEA0YEEbdlEZDOrHWaYhv9cu0/Iv
         S+sE0C1fxHeh9gnHdKM/OnbpRh2Yqd0wd+arSgJpi3cGkZiDQzpLj8jNz7eyQPVdXn
         q8etANteIoXDANRinlBhYx4wzXyBuvt2x9E4C519SYXqM9FsBgw645MUtH/0XN2OR/
         zmxQwQsEn3VJsiPgQYLaLGo3EZAetJEGgIH487iMJZRomVfsFinMrnEYhU+005ilbg
         h5Azc/O98Dd5Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HELVUe3936005;
        Wed, 17 Apr 2019 07:21:31 -0700
Date:   Wed, 17 Apr 2019 07:21:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-0ac26104208450d35c4e68754ce0c67b3a4d7802@git.kernel.org>
Cc:     hpa@zytor.com, pasha.tatashin@oracle.com, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, chang.seok.bae@intel.com,
        sean.j.christopherson@intel.com, konrad.wilk@oracle.com,
        nstange@suse.de, bp@suse.de, jpoimboe@redhat.com, mingo@kernel.org,
        x86@kernel.org, peterz@infradead.org, wang.yi59@zte.com.cn,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Reply-To: tglx@linutronix.de, luto@kernel.org, pasha.tatashin@oracle.com,
          hpa@zytor.com, konrad.wilk@oracle.com,
          sean.j.christopherson@intel.com, chang.seok.bae@intel.com,
          mingo@redhat.com, jpoimboe@redhat.com, bp@suse.de,
          nstange@suse.de, linux@dominikbrodowski.net,
          linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
          peterz@infradead.org, x86@kernel.org, mingo@kernel.org
In-Reply-To: <20190414160146.177558566@linutronix.de>
References: <20190414160146.177558566@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/64: Init hardirq_stack_ptr during CPU hotplug
Git-Commit-ID: 0ac26104208450d35c4e68754ce0c67b3a4d7802
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

Commit-ID:  0ac26104208450d35c4e68754ce0c67b3a4d7802
Gitweb:     https://git.kernel.org/tip/0ac26104208450d35c4e68754ce0c67b3a4d7802
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 18:00:05 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:34:21 +0200

x86/irq/64: Init hardirq_stack_ptr during CPU hotplug

Preparatory change for disentangling the irq stack union as a
prerequisite for irq stacks with guard pages.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Cc: Yi Wang <wang.yi59@zte.com.cn>
Link: https://lkml.kernel.org/r/20190414160146.177558566@linutronix.de
---
 arch/x86/include/asm/irq.h   |  4 ----
 arch/x86/kernel/cpu/common.c |  4 +---
 arch/x86/kernel/irq_64.c     | 15 +++++++++++++++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index d751e8440a6b..8f95686ec27e 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -16,11 +16,7 @@ static inline int irq_canonicalize(int irq)
 	return ((irq == 2) ? 9 : irq);
 }
 
-#ifdef CONFIG_X86_32
 extern int irq_init_percpu_irqstack(unsigned int cpu);
-#else
-static inline int irq_init_percpu_irqstack(unsigned int cpu) { return 0; }
-#endif
 
 #define __ARCH_HAS_DO_SOFTIRQ
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 13ec72bb8f36..1222080838da 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1510,9 +1510,7 @@ DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
-DEFINE_PER_CPU(char *, hardirq_stack_ptr) =
-	init_per_cpu_var(irq_stack_union.irq_stack) + IRQ_STACK_SIZE;
-
+DEFINE_PER_CPU(char *, hardirq_stack_ptr);
 DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index f0c7356c8969..c0bea0d7d76a 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -87,3 +87,18 @@ bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 	generic_handle_irq_desc(desc);
 	return true;
 }
+
+static int map_irq_stack(unsigned int cpu)
+{
+	void *va = per_cpu_ptr(irq_stack_union.irq_stack, cpu);
+
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	return 0;
+}
+
+int irq_init_percpu_irqstack(unsigned int cpu)
+{
+	if (per_cpu(hardirq_stack_ptr, cpu))
+		return 0;
+	return map_irq_stack(cpu);
+}
