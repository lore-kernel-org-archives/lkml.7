Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AE7C73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232F121707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="Y/8+Bkta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfGIMPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:15:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33109 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfGIMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:15:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so4424295pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJzVf8ePz92EuVzLMfLPbljGXsEH0ENJuGJ8qCk3dtg=;
        b=Y/8+BktagPsVjEodnOtdSnVQBboOpWy8Ukuc4xnOew3GCDUrIqFAa+v2DGPzMYPLTr
         DIyUThl4ySWwluFZI2ifBCtAS+y2cT0ntV6hdqO1OfSLVParmN5hhgkxPc563fOXUta4
         upQJjhoDg2VFKse4TgeyuEPWcbzTS+n5vAUo9hYwSeAkhUDFZuVIpxc+XE71Ex5Iq8oT
         /FOb6oYWfKAweWNYgh85PLGsy1LqdmUMRsOwheS9lMhImozk5CJOsvhiMbxlF0v3LzQg
         3c3d9bV5Rq1tzI+okjNqdnwabz68G3fUuS44arIRhSA7IWty3OIYhQnNAcVojEvM7sga
         5I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJzVf8ePz92EuVzLMfLPbljGXsEH0ENJuGJ8qCk3dtg=;
        b=WccvH5f5TsVOoOqhuX5D6woboguo2EPFVTr5Gkf6DqmFRHuT1Iw/Z+zWlvzphNDGWV
         PPBoKSoB2lvbJ38WhrEZNnmnDYRlV6BPYC5ZyoHH3rZSXpbn7IcOuHwFVfW01HkI/5BE
         X6LoDTujsiltRg//aRSpO9to5lB2NVPU2OfU32+Bii098DEilg8Wwh32TNZPqD6HEpUi
         NXJyk0u2u6wXelXknwGr7LXwRE0ghX/NiaoqfhJHijnRqQUXwE49vb5b7dfWGC5g77nG
         vRiI3ljb7cnKGCpwgMtyGEEX8V0pgIXcLkHmeINRJbuu4SXt/Pf9cWu399UDBD+Tnt8s
         qu+Q==
X-Gm-Message-State: APjAAAVctXLYtEyrjOx/kVWDk5utrN42N5/TLqrhiUByqMsTnJ+rzscP
        RQbxJHdhu0FF44cx473oMy/Lcw==
X-Google-Smtp-Source: APXvYqznakK/ppI4kgBJucoH/5l1KUpuuI6JglAn8z1HDKR3+4eXRffTRdSHVsigXE4ao1gi4cFlcg==
X-Received: by 2002:a63:d944:: with SMTP id e4mr29885876pgj.261.1562674551130;
        Tue, 09 Jul 2019 05:15:51 -0700 (PDT)
Received: from santosiv.in.ibm.com ([223.186.121.175])
        by smtp.gmail.com with ESMTPSA id o15sm21243933pgj.18.2019.07.09.05.15.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 05:15:50 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [v5 2/6] powerpc/mce: Fix MCE handling for huge pages
Date:   Tue,  9 Jul 2019 17:45:20 +0530
Message-Id: <20190709121524.18762-3-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709121524.18762-1-santosh@fossix.org>
References: <20190709121524.18762-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balbir Singh <bsingharora@gmail.com>

The current code would fail on huge pages addresses, since the shift
would be incorrect. Use the correct page shift value returned by
__find_linux_pte() to get the correct pfn. The code is more generic
and can handle both regular and compound pages.

Fixes: ba41e1e1ccb9 ("powerpc/mce: Hookup derror (load/store) UE errors")

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[arbab@linux.ibm.com: Fixup pseries_do_memory_failure()]
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/include/asm/mce.h       |  3 ++-
 arch/powerpc/kernel/mce_power.c      | 26 ++++++++++++++++----------
 arch/powerpc/platforms/pseries/ras.c |  6 ++++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index a4c6a74ad2fb..94888a7025b3 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -209,7 +209,8 @@ extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
 extern void machine_check_print_event_info(struct machine_check_event *evt,
 					   bool user_mode, bool in_guest);
-unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr);
+unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr,
+			  unsigned int *shift);
 #ifdef CONFIG_PPC_BOOK3S_64
 void flush_and_reload_slb(void);
 #endif /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index e39536aad30d..04666c0b40a8 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -23,7 +23,8 @@
  * Convert an address related to an mm to a PFN. NOTE: we are in real
  * mode, we could potentially race with page table updates.
  */
-unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
+unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr,
+			  unsigned int *shift)
 {
 	pte_t *ptep;
 	unsigned long flags;
@@ -36,13 +37,15 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 
 	local_irq_save(flags);
 	if (mm == current->mm)
-		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
+		ptep = find_current_mm_pte(mm->pgd, addr, NULL, shift);
 	else
-		ptep = find_init_mm_pte(addr, NULL);
+		ptep = find_init_mm_pte(addr, shift);
 	local_irq_restore(flags);
 	if (!ptep || pte_special(*ptep))
 		return ULONG_MAX;
-	return pte_pfn(*ptep);
+	if (!*shift)
+		*shift = PAGE_SHIFT;
+	return (pte_val(*ptep) & PTE_RPN_MASK) >> *shift;
 }
 
 /* flush SLBs and reload */
@@ -358,15 +361,16 @@ static int mce_find_instr_ea_and_pfn(struct pt_regs *regs, uint64_t *addr,
 	unsigned long pfn, instr_addr;
 	struct instruction_op op;
 	struct pt_regs tmp = *regs;
+	unsigned int shift;
 
-	pfn = addr_to_pfn(regs, regs->nip);
+	pfn = addr_to_pfn(regs, regs->nip, &shift);
 	if (pfn != ULONG_MAX) {
-		instr_addr = (pfn << PAGE_SHIFT) + (regs->nip & ~PAGE_MASK);
+		instr_addr = (pfn << shift) + (regs->nip & ((1 << shift) - 1));
 		instr = *(unsigned int *)(instr_addr);
 		if (!analyse_instr(&op, &tmp, instr)) {
-			pfn = addr_to_pfn(regs, op.ea);
+			pfn = addr_to_pfn(regs, op.ea, &shift);
 			*addr = op.ea;
-			*phys_addr = (pfn << PAGE_SHIFT);
+			*phys_addr = (pfn << shift);
 			return 0;
 		}
 		/*
@@ -442,12 +446,14 @@ static int mce_handle_ierror(struct pt_regs *regs,
 			if (mce_err->sync_error &&
 				table[i].error_type == MCE_ERROR_TYPE_UE) {
 				unsigned long pfn;
+				unsigned int shift;
 
 				if (get_paca()->in_mce < MAX_MCE_DEPTH) {
-					pfn = addr_to_pfn(regs, regs->nip);
+					pfn = addr_to_pfn(regs, regs->nip,
+							  &shift);
 					if (pfn != ULONG_MAX) {
 						*phys_addr =
-							(pfn << PAGE_SHIFT);
+							(pfn << shift);
 					}
 				}
 			}
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index f16fdd0f71f7..5e43283d3300 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -740,12 +740,14 @@ static void pseries_do_memory_failure(struct pt_regs *regs,
 		paddr = be64_to_cpu(mce_log->logical_address);
 	} else if (mce_log->sub_err_type & UE_EFFECTIVE_ADDR_PROVIDED) {
 		unsigned long pfn;
+		unsigned int shift;
 
 		pfn = addr_to_pfn(regs,
-				  be64_to_cpu(mce_log->effective_address));
+				  be64_to_cpu(mce_log->effective_address),
+				  &shift);
 		if (pfn == ULONG_MAX)
 			return;
-		paddr = pfn << PAGE_SHIFT;
+		paddr = pfn << shift;
 	} else {
 		return;
 	}
-- 
2.20.1

