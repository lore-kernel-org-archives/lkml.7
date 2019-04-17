Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A4C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615A820872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fb4C+gq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfDQOXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:23:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732528AbfDQOXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:23:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEMt7m3936124
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:22:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEMt7m3936124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510975;
        bh=v/P71svafoCTqqCnxUYvM7gCOxYmcVYByvKVH8YrOUY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Fb4C+gq2G6hCUhKFtup/CV+QjE2KGVgTgwydVNszB/RWwugUsfYMY8GlXXqPLlCwA
         VJSUdT/YamV8tdJf5LZouWft0yg4ekrqR9TH2bAxf/uOe4gvMTbFK8M0Q0UDYUoG3S
         if7N3r+hl/omB2y3Q1O3HNWFw31nIIilXax0XiY0Y42Pe9+r0JA/2s53uah+eyRn4w
         kYtEziuzpANuOSugoimWR/6BgB9UmvMkibaPL/W8fQXKFIojEB6kV6ixmh+qJ0hSDH
         wm4e2qrK11Tt50JrCW+WzkI1V2onmhgknKi8F2eN2y+B9fmoBO5D9FL0npU6PQkeCi
         fiOg+nhM2TRXg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEMsoZ3936121;
        Wed, 17 Apr 2019 07:22:54 -0700
Date:   Wed, 17 Apr 2019 07:22:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-18b7a6bef62de1d598fbff23b52114b7775ecf00@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, mingo@redhat.com, luto@kernel.org,
        nstange@suse.de, mingo@kernel.org, x86@kernel.org,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com
Reply-To: luto@kernel.org, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          sean.j.christopherson@intel.com, x86@kernel.org,
          mingo@kernel.org, nstange@suse.de, jpoimboe@redhat.com
In-Reply-To: <20190414160146.363733568@linutronix.de>
References: <20190414160146.363733568@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/64: Remap the IRQ stack with guard pages
Git-Commit-ID: 18b7a6bef62de1d598fbff23b52114b7775ecf00
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

Commit-ID:  18b7a6bef62de1d598fbff23b52114b7775ecf00
Gitweb:     https://git.kernel.org/tip/18b7a6bef62de1d598fbff23b52114b7775ecf00
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sun, 14 Apr 2019 18:00:07 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:40:57 +0200

x86/irq/64: Remap the IRQ stack with guard pages

The IRQ stack lives in percpu space, so an IRQ handler that overflows it
will overwrite other data structures.

Use vmap() to remap the IRQ stack so that it will have the usual guard
pages that vmap()/vmalloc() allocations have. With this, the kernel will
panic immediately on an IRQ stack overflow.

[ tglx: Move the map code to a proper place and invoke it only when a CPU
  	is about to be brought online. No point in installing the map at
  	early boot for all possible CPUs. Fail the CPU bringup if the vmap()
  	fails as done for all other preparatory stages in CPU hotplug. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160146.363733568@linutronix.de
---
 arch/x86/kernel/irq_64.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index c0f89d136b80..f107eb2021f6 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -91,6 +91,35 @@ bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 	return true;
 }
 
+#ifdef CONFIG_VMAP_STACK
+/*
+ * VMAP the backing store with guard pages
+ */
+static int map_irq_stack(unsigned int cpu)
+{
+	char *stack = (char *)per_cpu_ptr(&irq_stack_backing_store, cpu);
+	struct page *pages[IRQ_STACK_SIZE / PAGE_SIZE];
+	void *va;
+	int i;
+
+	for (i = 0; i < IRQ_STACK_SIZE / PAGE_SIZE; i++) {
+		phys_addr_t pa = per_cpu_ptr_to_phys(stack + (i << PAGE_SHIFT));
+
+		pages[i] = pfn_to_page(pa >> PAGE_SHIFT);
+	}
+
+	va = vmap(pages, IRQ_STACK_SIZE / PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
+	if (!va)
+		return -ENOMEM;
+
+	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
+	return 0;
+}
+#else
+/*
+ * If VMAP stacks are disabled due to KASAN, just use the per cpu
+ * backing store without guard pages.
+ */
 static int map_irq_stack(unsigned int cpu)
 {
 	void *va = per_cpu_ptr(&irq_stack_backing_store, cpu);
@@ -98,6 +127,7 @@ static int map_irq_stack(unsigned int cpu)
 	per_cpu(hardirq_stack_ptr, cpu) = va + IRQ_STACK_SIZE;
 	return 0;
 }
+#endif
 
 int irq_init_percpu_irqstack(unsigned int cpu)
 {
