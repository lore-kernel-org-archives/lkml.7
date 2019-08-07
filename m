Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8A5C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D52921EF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="mKOema1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbfHGO51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:57:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37363 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbfHGO50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:57:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so41252076plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWA4gPdFOegi4jl7WWcpLywZZ4AlLnbcnJjBWA9qvTU=;
        b=mKOema1Ajq+z1Khb9mW00Qfcl+gyfy6Kwadktgu2MAHHbsu5yl4P5w7PvvtKSdFdMW
         AX8fHsWGvcXQYvUCF5nP+wzMBMa6s5V3KV/G0ZfsLmB4/Ep1Ds281Hj1njioXbEZTGNq
         +9b4B8AEa6rzlaqGVyRCwyYkJJf4eVmPmUsnQvygZ/ZVtA+askskQv1g00mlM1X0v+Ep
         z4Tlr4mNnEnoiHlaLh3XXYAHeLzU/9gsnrXvceabxXSY7gCDg8ilRBA6ujzJETeHJaPv
         9Kqo/UmemZyaaBp24eOLrrk+0msm8YeZO7bLbtyT5IMHEqO7PGPR7i7SW/58ZrDBewT/
         jkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWA4gPdFOegi4jl7WWcpLywZZ4AlLnbcnJjBWA9qvTU=;
        b=FW40zLpjM99ZDk8sy5BJydfnXX/okMYlW8wqzWXPfVNh30iAJd7F8G/OsyjSROqZxt
         VvevLqWYKcgAc0lHnPGHLP1ubieewQ7T5gboDmaeDzrM4Kw1v5idxRB0ruzngjbaUVLz
         wGPH+efIiK0d4DyMS97v8Y76eiQe6zfaLDo2GPXizCQpKNri9qg4G0gUx2NZvJYdCktW
         xl1pwLvVuPIAxVH+msRtjRjSd9IwjAaTYU+WxFLiE7uWMGd1eQppq5bC9xLZa9mGth7D
         KePIBOE6v6vZXHsRzMw8B7BGW1J+8nGl3PZq1KrXcvaU6O+sEoyRHW5QsELPIKGCdNru
         r6tg==
X-Gm-Message-State: APjAAAXz2uDFHB+8KE16rvAUl52XK/uiBA8hajXLxa47TTMIEis71k3Z
        aBl+RvYZkhsrl249kJH+N91zMU9taD9EfQ==
X-Google-Smtp-Source: APXvYqz+BDHbgD7qukH/vezP1VLN3whoqN72vAt1hbNGgTnhWIm/NyG0wpSVl/DBavTZdzdqMlZAuQ==
X-Received: by 2002:a17:902:ea:: with SMTP id a97mr8485356pla.182.1565189845515;
        Wed, 07 Aug 2019 07:57:25 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([183.82.17.96])
        by smtp.gmail.com with ESMTPSA id l4sm93617475pff.50.2019.08.07.07.57.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 07:57:24 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 3/7] powerpc/mce: Fix MCE handling for huge pages
Date:   Wed,  7 Aug 2019 20:26:56 +0530
Message-Id: <20190807145700.25599-4-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807145700.25599-1-santosh@fossix.org>
References: <20190807145700.25599-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balbir Singh <bsingharora@gmail.com>

The current code would fail on huge pages addresses, since the shift would
be incorrect. Use the correct page shift value returned by
__find_linux_pte() to get the correct physical address. The code is more
generic and can handle both regular and compound pages.

Fixes: ba41e1e1ccb9 ("powerpc/mce: Hookup derror (load/store) UE errors")
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[arbab@linux.ibm.com: Fixup pseries_do_memory_failure()]
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Co-developed-by: Santosh Sivaraj <santosh@fossix.org>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/include/asm/mce.h       |  2 +-
 arch/powerpc/kernel/mce_power.c      | 50 ++++++++++++++--------------
 arch/powerpc/platforms/pseries/ras.c |  9 ++---
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index a4c6a74ad2fb..f3a6036b6bc0 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -209,7 +209,7 @@ extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
 extern void machine_check_print_event_info(struct machine_check_event *evt,
 					   bool user_mode, bool in_guest);
-unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr);
+unsigned long addr_to_phys(struct pt_regs *regs, unsigned long addr);
 #ifdef CONFIG_PPC_BOOK3S_64
 void flush_and_reload_slb(void);
 #endif /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index a814d2dfb5b0..bed38a8e2e50 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -20,13 +20,14 @@
 #include <asm/exception-64s.h>
 
 /*
- * Convert an address related to an mm to a PFN. NOTE: we are in real
- * mode, we could potentially race with page table updates.
+ * Convert an address related to an mm to a physical address.
+ * NOTE: we are in real mode, we could potentially race with page table updates.
  */
-unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
+unsigned long addr_to_phys(struct pt_regs *regs, unsigned long addr)
 {
-	pte_t *ptep;
-	unsigned long flags;
+	pte_t *ptep, pte;
+	unsigned int shift;
+	unsigned long flags, phys_addr;
 	struct mm_struct *mm;
 
 	if (user_mode(regs))
@@ -35,14 +36,21 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 		mm = &init_mm;
 
 	local_irq_save(flags);
-	if (mm == current->mm)
-		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
-	else
-		ptep = find_init_mm_pte(addr, NULL);
+	ptep = __find_linux_pte(mm->pgd, addr, NULL, &shift);
 	local_irq_restore(flags);
+
 	if (!ptep || pte_special(*ptep))
 		return ULONG_MAX;
-	return pte_pfn(*ptep);
+
+	pte = *ptep;
+	if (shift > PAGE_SHIFT) {
+		unsigned long rpnmask = (1ul << shift) - PAGE_SIZE;
+
+		pte = __pte(pte_val(pte) | (addr & rpnmask));
+	}
+	phys_addr = pte_pfn(pte) << PAGE_SHIFT;
+
+	return phys_addr;
 }
 
 /* flush SLBs and reload */
@@ -354,18 +362,16 @@ static int mce_find_instr_ea_and_pfn(struct pt_regs *regs, uint64_t *addr,
 	 * faults
 	 */
 	int instr;
-	unsigned long pfn, instr_addr;
+	unsigned long instr_addr;
 	struct instruction_op op;
 	struct pt_regs tmp = *regs;
 
-	pfn = addr_to_pfn(regs, regs->nip);
-	if (pfn != ULONG_MAX) {
-		instr_addr = (pfn << PAGE_SHIFT) + (regs->nip & ~PAGE_MASK);
+	instr_addr = addr_to_phys(regs, regs->nip) + (regs->nip & ~PAGE_MASK);
+	if (instr_addr != ULONG_MAX) {
 		instr = *(unsigned int *)(instr_addr);
 		if (!analyse_instr(&op, &tmp, instr)) {
-			pfn = addr_to_pfn(regs, op.ea);
 			*addr = op.ea;
-			*phys_addr = (pfn << PAGE_SHIFT);
+			*phys_addr = addr_to_phys(regs, op.ea);
 			return 0;
 		}
 		/*
@@ -440,15 +446,9 @@ static int mce_handle_ierror(struct pt_regs *regs,
 			*addr = regs->nip;
 			if (mce_err->sync_error &&
 				table[i].error_type == MCE_ERROR_TYPE_UE) {
-				unsigned long pfn;
-
-				if (get_paca()->in_mce < MAX_MCE_DEPTH) {
-					pfn = addr_to_pfn(regs, regs->nip);
-					if (pfn != ULONG_MAX) {
-						*phys_addr =
-							(pfn << PAGE_SHIFT);
-					}
-				}
+				if (get_paca()->in_mce < MAX_MCE_DEPTH)
+					*phys_addr = addr_to_phys(regs,
+								 regs->nip);
 			}
 		}
 		return handled;
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index f16fdd0f71f7..5743f6353638 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -739,13 +739,10 @@ static void pseries_do_memory_failure(struct pt_regs *regs,
 	if (mce_log->sub_err_type & UE_LOGICAL_ADDR_PROVIDED) {
 		paddr = be64_to_cpu(mce_log->logical_address);
 	} else if (mce_log->sub_err_type & UE_EFFECTIVE_ADDR_PROVIDED) {
-		unsigned long pfn;
-
-		pfn = addr_to_pfn(regs,
-				  be64_to_cpu(mce_log->effective_address));
-		if (pfn == ULONG_MAX)
+		paddr = addr_to_phys(regs,
+				     be64_to_cpu(mce_log->effective_address));
+		if (paddr == ULONG_MAX)
 			return;
-		paddr = pfn << PAGE_SHIFT;
 	} else {
 		return;
 	}
-- 
2.20.1

