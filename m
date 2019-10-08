Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7BDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E952070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IXmN2l/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfJHVin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:38:43 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:43020 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730549AbfJHVil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:38:41 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 20B12C016B;
        Tue,  8 Oct 2019 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1570570720; bh=JAzSMbVKPnZ9LRpz5V9AajWg5VC5h3GO+qyt5a4bXd0=;
        h=From:To:Cc:Subject:Date:From;
        b=IXmN2l/jckt3C4NEgwFRsV9LU+Y6rqIDsnWdolKOVZA3nyjDaGiE9S3UustmW3vmn
         jOjObD9GgyEui7tBwFVzwLi0cMG6/LxAzE8FB1MlFpwRryT56A0Xp+rRcHJs/FrnyQ
         Cj7BGMWQvqR3Dmduyd2X5zl+fz/Y50Ffg/87QjEHWGsqTn/dOFC18aToxQW4QKootU
         C2VgYfAyYyjFiOmBXA7vg2uQrSsB61lFw2wADHtsUk04+uK3UyD7KkgPxoOrItbG+5
         dK62zsewhuIYDPk9rd3h+2Knyc/xL34gpJhJhWIozHxfF1waDOL0Oq66KvKgwOQ+us
         F5PZXDU4zPAOA==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 536FDA006B;
        Tue,  8 Oct 2019 21:38:39 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
Date:   Tue,  8 Oct 2019 14:38:36 -0700
Message-Id: <20191008213836.19266-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the intermediate p4d accessors to make it 5 level compliant.

Thi sis non-functional change anyways since ARC has software page walker
with 2 lookup levels (pgd -> pte)

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/pgtable.h |  1 -
 arch/arc/mm/fault.c            | 10 ++++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 976b5931372e..902d45428cea 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -33,7 +33,6 @@
 #define _ASM_ARC_PGTABLE_H
 
 #include <linux/bits.h>
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 #include <asm/page.h>
 #include <asm/mmu.h>	/* to propagate CONFIG_ARC_MMU_VER <n> */
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 3861543b66a0..fb86bc3e9b35 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -30,6 +30,7 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	 * with the 'reference' page table.
 	 */
 	pgd_t *pgd, *pgd_k;
+	p4d_t *p4d, *p4d_k;
 	pud_t *pud, *pud_k;
 	pmd_t *pmd, *pmd_k;
 
@@ -39,8 +40,13 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	if (!pgd_present(*pgd_k))
 		goto bad_area;
 
-	pud = pud_offset(pgd, address);
-	pud_k = pud_offset(pgd_k, address);
+	p4d = p4d_offset(pgd, address);
+	p4d_k = p4d_offset(pgd_k, address);
+	if (!p4d_present(*p4d_k))
+		goto bad_area;
+
+	pud = pud_offset(p4d, address);
+	pud_k = pud_offset(p4d_k, address);
 	if (!pud_present(*pud_k))
 		goto bad_area;
 
-- 
2.20.1

