Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F9A22C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564072641;
	bh=HvmbL0a4IPcOkUJ9Pp0wv3dUD1uBREBknPN3UfLuQ0w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OUawU9ZABjYJueQy2H/i0FqFk0HaEWEBIz/BEYq9YKQe4MN1TKKNB34mv6QpFEBE4
	 2yUrYKHb9RMigL5ysBPZrKjXCjRneN2Idc6NdtEfFLosdhvIWNtNdsjSvwiPKy/l4q
	 aQR7Nol1SgxLNLP+iyoBgTK2lhOarubvnOqExno4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfGYQhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbfGYQhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:37:18 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15EFC218F0;
        Thu, 25 Jul 2019 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564072638;
        bh=HvmbL0a4IPcOkUJ9Pp0wv3dUD1uBREBknPN3UfLuQ0w=;
        h=From:To:Cc:Subject:Date:From;
        b=hfRR2nMFRQOGde3sXF2mPlmC6EMaSJQpQopNxdHNDjJcOSg8+9QcLItSUc961G061
         tn0wuD2JOer/xmKw6Nw727MKHt3Ru4nnp9gfb3qMC8aAYZzvpidQjTGEjk+9qMHxru
         gvyrU1U4ZgrVjilb4h9alS+M0zA7lnzmxswkvPh4=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/hw_breakpoint: Prevent data breakpoints on cpu_entry_area
Date:   Thu, 25 Jul 2019 09:37:15 -0700
Message-Id: <cf0ca526e3bc946766ab70bada2686c82e7da1ce.1564072590.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A data breakpoint near the top of an IST stack will cause unresoverable
recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.
Prevent either of these from happening.

Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

The rest of my series is still in progress -- as we all know, idtentry
is a morass.  But this is self-contained and is an obvious fix.

arch/x86/include/asm/cpu_entry_area.h | 10 ++++++++++
 arch/x86/kernel/hw_breakpoint.c       | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index e23e2d9a92d7..3f50d4738487 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -126,6 +126,16 @@ static inline struct entry_stack *cpu_entry_stack(int cpu)
 	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
 }
 
+/*
+ * Checks whether the range from addr to end, inclusive, overlaps the CPU
+ * entry area range.
+ */
+static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
+{
+	return end >= CPU_ENTRY_AREA_PER_CPU &&
+		addr < (CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_TOT_SIZE);
+}
+
 #define __this_cpu_ist_top_va(name)					\
 	CEA_ESTACK_TOP(__this_cpu_read(cea_exception_stacks), name)
 
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 218c8917118e..dc4581fe4b4e 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -231,6 +231,23 @@ static int arch_build_bp_info(struct perf_event *bp,
 			      const struct perf_event_attr *attr,
 			      struct arch_hw_breakpoint *hw)
 {
+	unsigned long bp_end;
+
+	/* Ensure that bp_end does not oveflow. */
+	if (attr->bp_len >= ULONG_MAX - attr->bp_addr)
+		return -EINVAL;
+
+	bp_end = attr->bp_addr + attr->bp_len - 1;
+
+	/*
+	 * Prevent any breakpoint of any type that overlaps the
+	 * cpu_entry_area.  This protects the IST stacks and also
+	 * reduces the chance that we ever find out what happens if
+	 * there's a data breakpoint on the GDT, IDT, or TSS.
+	 */
+	if (within_cpu_entry_area(attr->bp_addr, bp_end))
+		return -EINVAL;
+
 	hw->address = attr->bp_addr;
 	hw->mask = 0;
 
-- 
2.21.0

