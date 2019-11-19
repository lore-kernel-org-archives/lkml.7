Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2970BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A124320872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I4Jre43Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfKSGBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:01:19 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:28635 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfKSFoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:44:12 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191119054410epoutp04146a56064f0c8854343ecc77131f7457~YegljOgNk0693506935epoutp04M
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 05:44:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191119054410epoutp04146a56064f0c8854343ecc77131f7457~YegljOgNk0693506935epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574142250;
        bh=QyPkrsaltRC54WIiNJdMbWI+p4JqBzFBPnyCo+00/Xw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=I4Jre43Qn0YJjcVV8TFHUEGtnLOjTGlKfmJS9csknGT2/9rYYxpcmQbZguq3uFO6J
         Lu7d72nz2YZ9Q0B+WXnT/tb1tWXxTKlj7WV6mAlJrMCuvtsO/7D5Lq0w7lhiKpGPOo
         nA0Me28ueO0jHtNz06vk9PDavLx1NhBp1vQAIblw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191119054410epcas5p24daff299eed9533e04a92c8e0d27ab35~YeglKyGrI1350413504epcas5p2s;
        Tue, 19 Nov 2019 05:44:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.70.04403.A2183DD5; Tue, 19 Nov 2019 14:44:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191119051537epcas5p2da5439a60d1167b8cc7e2179487996aa~YeHqZArTQ2360123601epcas5p2D;
        Tue, 19 Nov 2019 05:15:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119051537epsmtrp1977f5c869323dce3196676af087987d5~YeHqYLMda1009210092epsmtrp11;
        Tue, 19 Nov 2019 05:15:37 +0000 (GMT)
X-AuditID: b6c32a4a-3cbff70000001133-e9-5dd3812ae0e3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.57.03654.97A73DD5; Tue, 19 Nov 2019 14:15:37 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119051535epsmtip12326a990fb36f739e94802d8fe63aaf7~YeHn9OTdQ2224622246epsmtip1m;
        Tue, 19 Nov 2019 05:15:34 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, v.narang@samsung.com,
        a.sahrawat@samsung.com, avnish.jain@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] mm: Map next task stack in previous mm.
Date:   Tue, 19 Nov 2019 10:45:20 +0530
Message-Id: <1574140520-9738-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7bCmhq5W4+VYg9aZLBYXd6dazPjzk8ni
        84Z/bBYvNrQzWkzbKG5xedccNovzu9ayWhye38ZicenAAiaL470HmCw2b5rKbHHo5FxGix8b
        HrM68Hp8b+1j8di8Qstj06pONo93586xe8w7Gejxft9VNo++LasYPT5vkvM40fKFNYAzissm
        JTUnsyy1SN8ugSujbeoztoJdghU7OjewNDD+5u1i5OSQEDCReL70IGsXIxeHkMBuRonFk24x
        giSEBD4xSvS8sYJIfGOUWHdnMxNMx6+3F5ggivYySnzZEANR9JVR4vPeH2DdbAJ6Eqt27WEB
        SYgIdDNKTHzcAeYwCyxllPj6dj0zSJWwgI3Eq0cLwDpYBFQlvs+eywJi8wq4Sfz8sglqnZzE
        zXOdzBD2CTaJTXvEIWwXiaUPb0PFhSVeHd/CDmFLSbzsb2MHWSYh0Mwo8WnfWkYIZwqjxNKL
        H1khquwlXjc3AG3gADpJU2L9Ln2IsKzE1FPrwBYzC/BJ9P5+AnUEr8SOeTC2qkTLzQ1QY6Ql
        Pn/8yAJhe0icXvKKDWSkkECsxLGbURMYZWchLFjAyLiKUTK1oDg3PbXYtMAoL7Vcrzgxt7g0
        L10vOT93EyM4rWh57WBcds7nEKMAB6MSD+8JlcuxQqyJZcWVuYcYJTiYlUR4/R5diBXiTUms
        rEotyo8vKs1JLT7EKM3BoiTOO4n1aoyQQHpiSWp2ampBahFMlomDU6qBcd/mbeo+pxYnTtuz
        ztVzqfDVQsXAPa5ZscW236f+Xf3uUeTh/4as1xYsWLqjQedJnHBHeb2lz7K2s8d+/wh5fOhn
        vJmv8yLlZaeExIp6J/UfmczUN1H63qJzwc8YthyxX6b4fI7goxtNgp86159fm1zkMyl1sdvk
        wq0BiiLvBKUq5slviTxypkCJpTgj0VCLuag4EQACze3XJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnG5l1eVYgzv9KhYXd6dazPjzk8ni
        84Z/bBYvNrQzWkzbKG5xedccNovzu9ayWhye38ZicenAAiaL470HmCw2b5rKbHHo5FxGix8b
        HrM68Hp8b+1j8di8Qstj06pONo93586xe8w7Gejxft9VNo++LasYPT5vkvM40fKFNYAzissm
        JTUnsyy1SN8ugSujbeoztoJdghU7OjewNDD+5u1i5OSQEDCR+PX2AlMXIxeHkMBuRom7d/+y
        QiSkJX7+e88CYQtLrPz3nB2i6DOjxIb+f2BFbAJ6Eqt27WEBSYgITGWUOPKthRkkwSywmlFi
        ziZBEFtYwEbi1aMFjCA2i4CqxPfZc8Gm8gq4Sfz8sokJYoOcxM1zncwTGHkWMDKsYpRMLSjO
        Tc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDlItzR2Ml5fEH2IU4GBU4uE9oXI5Vog1say4MvcQ
        owQHs5IIr9+jC7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJx
        cEo1MFbPUH05KWPB5PLEd90ZYXdn82+xr1dQYD+SeSop882rR8URm15+0uDLjnz3PH9pSPVE
        g5gfdnvW3ctdvoRJ+uL/KpOJqVktnRnq2hHBui6F987sE9pz1FJTTO387LyJs0RZvzTUeTSv
        cn7om+9k+rxid0DYp9DkLW9YH9eIK8z9f/psczubihJLcUaioRZzUXEiAE9HthJOAgAA
X-CMS-MailID: 20191119051537epcas5p2da5439a60d1167b8cc7e2179487996aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20191119051537epcas5p2da5439a60d1167b8cc7e2179487996aa
References: <CGME20191119051537epcas5p2da5439a60d1167b8cc7e2179487996aa@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue: In context switch, stack of next task (kernel thread)
is not mapped in previous task PGD.

Issue faced while porting VMAP stack on ARM.
currently forcible mapping is done in case of switching mm, but if
next task is kernel thread then it can cause issue.

Thus Map stack of next task in prev if next task is kernel thread,
as kernel thread will use mm of prev task.

"Since we don't have reproducible setup for x86, 
changes verified on ARM. So not sure about arch specific handling
for X86"

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/x86/mm/tlb.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e6a9edc5baaf..28328cf8e79c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -161,11 +161,17 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
-static void sync_current_stack_to_mm(struct mm_struct *mm)
+static void sync_stack_to_mm(struct mm_struct *mm, struct task_struct *tsk)
 {
-	unsigned long sp = current_stack_pointer;
-	pgd_t *pgd = pgd_offset(mm, sp);
+	unsigned long sp;
+	pgd_t *pgd;
 
+	if (!tsk)
+		sp = current_stack_pointer;
+	else
+		sp = (unsigned long)tsk->stack;
+
+	pgd = pgd_offset(mm, sp);
 	if (pgtable_l5_enabled()) {
 		if (unlikely(pgd_none(*pgd))) {
 			pgd_t *pgd_ref = pgd_offset_k(sp);
@@ -383,7 +389,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			 * mapped in the new pgd, we'll double-fault.  Forcibly
 			 * map it.
 			 */
-			sync_current_stack_to_mm(next);
+			sync_stack_to_mm(next, NULL);
 		}
 
 		/*
@@ -460,6 +466,15 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
  */
 void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
+	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+		/*
+		 * If tsk stack is in vmalloc space and isn't
+		 * mapped in the new pgd, we'll double-fault.  Forcibly
+		 * map it.
+		 */
+		sync_stack_to_mm(mm, tsk);
+	}
+
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
-- 
2.17.1

