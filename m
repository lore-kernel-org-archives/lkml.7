Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B74AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAD92147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gUrIywJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbfFTKDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:03:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40587 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfFTKDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:03:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5KA2Ys8907570
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 Jun 2019 03:02:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5KA2Ys8907570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561024955;
        bh=bgPwE+cj1WLuqcabd/5U76M/J+ulxV4w0+Y/pu+8pVk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gUrIywJXe+ixdQdlYXVtcXH4hiJo6JCSu2WchDqv17yIjVs3OyaRGsz60Zx79/4mD
         MwdjsGwZizDqcALK2ZVfgVxYHOmoSNxqGBsZEl+ZqoXrt3oR9p4t7YPcKX8DaWArzG
         8LJNWKLNw/8Q+7YsqvUiku2k9CFfbW1lnh0HTgogbRipuuH7HwzlCtu69vxodjGZ9S
         tLnPHuqq8yIs+bL8ebx5N7+ONyOB2hMgwyAgh5sjZwp//CK3OheDZbvdBRDLfL8m+K
         M7WE7i0ZV/Il1bobKxhTfowYzc7GEljTmx4eHezwJ44OSaDN57weQQNmjJxru8M9Gq
         jtMJRSDwGlvbw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5KA2Y25907567;
        Thu, 20 Jun 2019 03:02:34 -0700
Date:   Thu, 20 Jun 2019 03:02:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lianbo Jiang <tipbot@zytor.com>
Message-ID: <tip-85784d16c2cf172cf1ebaf2390d6b7c4045d659c@git.kernel.org>
Cc:     mingo@kernel.org, thomas.lendacky@amd.com, tglx@linutronix.de,
        x86@kernel.org, hpa@zytor.com, bp@suse.de, lijiang@redhat.com,
        mingo@redhat.com, brijesh.singh@amd.com,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
          akpm@linux-foundation.org, mingo@redhat.com, lijiang@redhat.com,
          brijesh.singh@amd.com, thomas.lendacky@amd.com, bp@suse.de,
          hpa@zytor.com, x86@kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20190430074421.7852-3-lijiang@redhat.com>
References: <20190430074421.7852-3-lijiang@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/kexec: Set the C-bit in the identity map page
 table when SEV is active
Git-Commit-ID: 85784d16c2cf172cf1ebaf2390d6b7c4045d659c
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

Commit-ID:  85784d16c2cf172cf1ebaf2390d6b7c4045d659c
Gitweb:     https://git.kernel.org/tip/85784d16c2cf172cf1ebaf2390d6b7c4045d659c
Author:     Lianbo Jiang <lijiang@redhat.com>
AuthorDate: Tue, 30 Apr 2019 15:44:20 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 20 Jun 2019 10:07:12 +0200

x86/kexec: Set the C-bit in the identity map page table when SEV is active

When SEV is active, the second kernel image is loaded into encrypted
memory. For that, make sure that when kexec builds the identity mapping
page table, the memory is encrypted (i.e., _PAGE_ENC is set).

 [ bp: Sort local args and OR in _PAGE_ENC for more clarity. ]

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bhe@redhat.com
Cc: dyoung@redhat.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190430074421.7852-3-lijiang@redhat.com
---
 arch/x86/kernel/machine_kexec_64.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3b38449028e0..16c37fe489bc 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -50,12 +50,13 @@ static void free_transition_pgtable(struct kimage *image)
 
 static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 {
+	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
+	unsigned long vaddr, paddr;
+	int result = -ENOMEM;
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long vaddr, paddr;
-	int result = -ENOMEM;
 
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
+		info.page_flag   |= _PAGE_ENC;
+		info.kernpg_flag |= _PAGE_ENC;
+	}
+
 	if (direct_gbpages)
 		info.direct_gbpages = true;
 
