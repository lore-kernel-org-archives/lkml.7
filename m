Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBCEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7A5206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfC0FhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfC0FhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:37:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D72D305390F;
        Wed, 27 Mar 2019 05:37:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 751275C582;
        Wed, 27 Mar 2019 05:36:54 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
Subject: [PATCH 2/3 v2] x86/kexec: Set the C-bit in the identity map page table when SEV is active
Date:   Wed, 27 Mar 2019 13:36:28 +0800
Message-Id: <20190327053629.17935-3-lijiang@redhat.com>
In-Reply-To: <20190327053629.17935-1-lijiang@redhat.com>
References: <20190327053629.17935-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 27 Mar 2019 05:37:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SEV is active, the second kernel image is loaded into the
encrypted memory. Lets make sure that when kexec builds the
identity mapping page table it adds the memory encryption mask(C-bit).

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index f60611531d17..11fe352f7344 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -56,6 +56,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	pte_t *pte;
 	unsigned long vaddr, paddr;
 	int result = -ENOMEM;
+	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
 
 	vaddr = (unsigned long)relocate_kernel;
 	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
@@ -92,7 +93,11 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
-	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
+
+	if (sev_active())
+		prot = PAGE_KERNEL_EXEC;
+
+	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
 	return 0;
 err:
 	return result;
@@ -129,6 +134,11 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	level4p = (pgd_t *)__va(start_pgtable);
 	clear_page(level4p);
 
+	if (sev_active()) {
+		info.page_flag |= _PAGE_ENC;
+		info.kernpg_flag = _KERNPG_TABLE;
+	}
+
 	if (direct_gbpages)
 		info.direct_gbpages = true;
 
-- 
2.17.1

