Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD27C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3293E22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjkB4hQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLKVca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:32:30 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:32884 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLKVc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:32:29 -0500
Received: by mail-ua1-f73.google.com with SMTP id u20so1545uap.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cpnhXnLglixPPYBVn7HgN2if2evOi/FjwLYbdxu/Tg4=;
        b=BjkB4hQuCzNvgDg1hIM+zGyYK1u8CTBOSJ20PWcYUmmzJm0EEozkJ9Q1YxNVhZbr/H
         giphN6cCCXbh58OitPnHXjObIa6Lisbnnsvi3GVkeLZDzoZtLarfyhvxTCAT5FC1bQn/
         ABMbYqeYtHThYG5cKkpxH4rsuDwQQYbSC5IR8WViXW4NXf5GbkrJH0PqNj87OVn+HzCx
         wv3VAMzPpJ9mH4AeUf1vyZP60dMKx7RiDbRa3LFMKTxz2A61K7XqIDr8FG353vLUY1pP
         mooYYKMADxjb8XPiPdZTRxvh/hp+RiCzYIWeKWEuaT29+ds4KLwo96ik7QNi4n675Sop
         aasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cpnhXnLglixPPYBVn7HgN2if2evOi/FjwLYbdxu/Tg4=;
        b=OWNa1L6iHm0tm3XZ6YrQtfWG+q5BmzYBPqlC3SCGBjxS016nlz6Mjz/5OXAELBqt9z
         qeb/Lqq3vrC3UdWD3+eJ60YkJWtfs+F9XqMp7fl23HiT5V0Jf3y2GTRDR6VQ/wwMmtlc
         f//eJZ6aKd6fPa+RiC3hiqk0rWTq8NakSI+Kd5SSsN5LJ5ifv/6l77TcRBsdD/IjTcn7
         6R4jeLj2KdbGhq9yGrKcwsz01T5NWrQY+rP1iEP1HCoZrpdHaMO6a3AnFa0Ha4KimGe0
         39ZnT2ZIRR7eSMXrYbBjRY1epTPiS53x3JhFXib1S0WzHXCFpaOB/X//j/LkeKJA64/F
         WpRA==
X-Gm-Message-State: APjAAAV0qmMymPNBB1Ggs8DTB4x6pfHdNU4dwhkNXVPRoz27dOemT+J/
        yRcBwqI7xtvbPWub5s3DDXeQPwIf
X-Google-Smtp-Source: APXvYqz6qNfUF/2RBgQj1i0wA7WRKTT/3zMghj8ls7WH3mm9ABUYccruj1nHyEp3pYmgO7zVmf0M+JNp
X-Received: by 2002:a1f:ac57:: with SMTP id v84mr5840002vke.90.1576099948361;
 Wed, 11 Dec 2019 13:32:28 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:32:07 -0500
In-Reply-To: <20191211213207.215936-1-brho@google.com>
Message-Id: <20191211213207.215936-3-brho@google.com>
Mime-Version: 1.0
References: <20191211213207.215936-1-brho@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows KVM to map DAX-backed files made of huge pages with
huge mappings in the EPT/TDP.

DAX pages are not PageTransCompound.  The existing check is trying to
determine if the mapping for the pfn is a huge mapping or not.  For
non-DAX maps, e.g. hugetlbfs, that means checking PageTransCompound.
For DAX, we can check the page table itself.

Note that KVM already faulted in the page (or huge page) in the host's
page table, and we hold the KVM mmu spinlock.  We grabbed that lock in
kvm_mmu_notifier_invalidate_range_end, before checking the mmu seq.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6f92b40d798c..cd07bc4e595f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3384,6 +3384,35 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	return -EFAULT;
 }
 
+static bool pfn_is_huge_mapped(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+	unsigned long hva;
+
+	if (!is_zone_device_page(page))
+		return PageTransCompoundMap(page);
+
+	/*
+	 * DAX pages do not use compound pages.  The page should have already
+	 * been mapped into the host-side page table during try_async_pf(), so
+	 * we can check the page tables directly.
+	 */
+	hva = gfn_to_hva(kvm, gfn);
+	if (kvm_is_error_hva(hva))
+		return false;
+
+	/*
+	 * Our caller grabbed the KVM mmu_lock with a successful
+	 * mmu_notifier_retry, so we're safe to walk the page table.
+	 */
+	switch (dev_pagemap_mapping_shift(hva, current->mm)) {
+	case PMD_SHIFT:
+	case PUD_SIZE:
+		return true;
+	}
+	return false;
+}
+
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 					gfn_t gfn, kvm_pfn_t *pfnp,
 					int *levelp)
@@ -3398,8 +3427,8 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 	 * here.
 	 */
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
-	    !kvm_is_zone_device_pfn(pfn) && level == PT_PAGE_TABLE_LEVEL &&
-	    PageTransCompoundMap(pfn_to_page(pfn)) &&
+	    level == PT_PAGE_TABLE_LEVEL &&
+	    pfn_is_huge_mapped(vcpu->kvm, gfn, pfn) &&
 	    !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
 		unsigned long mask;
 		/*
@@ -6015,8 +6044,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		 * mapping if the indirect sp has level = 1.
 		 */
 		if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
-		    !kvm_is_zone_device_pfn(pfn) &&
-		    PageTransCompoundMap(pfn_to_page(pfn))) {
+		    pfn_is_huge_mapped(kvm, sp->gfn, pfn)) {
 			pte_list_remove(rmap_head, sptep);
 
 			if (kvm_available_flush_tlb_with_range())
-- 
2.24.0.525.g8f36a354ae-goog

