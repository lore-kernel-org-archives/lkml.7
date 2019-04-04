Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5441E20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyHguTLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfDDUYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:24:09 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:33916 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbfDDUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:24:07 -0400
Received: by mail-vk1-f202.google.com with SMTP id y82so1554328vkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0wnnkWPvsjcCmPpDGZZOltQ8m2/AePhqjWl4B6moFQY=;
        b=LyHguTLzka7Fymtke5wD0vAQz10+1dZFeGH0oVAdNqR7j1DOXQKKK0huAgxhaBkoB7
         I+mudDEJ3pbCi8PQYuaHvYRDIzdU4cB3pAIlB7eLp9sbX23LmYG652GWRUF+afV7Nbbn
         Rr4r0uDb23gG/8fG5xHPgzohfNXZs0S5Lm/pEkzeJEBCTJi6706yQTBUx+XWiWL91mGl
         iYPGcgOhit8eSqpfY/iGpBtuPaUwjZUdi0vD95kr7e/IVNa7jXejH9qipeHA6OkoWbVC
         D8naX3rQARsWVGJMkgNBWeGIRK1BTA4JJU1PbP/4YD2Sqfz2e7hVkpAG/3mIHbmWln6U
         5FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0wnnkWPvsjcCmPpDGZZOltQ8m2/AePhqjWl4B6moFQY=;
        b=EH71k0sANXRuQvyEbc/Riwm2pKeAxQ+ayPxdHFtmlXRq0HPJgtQzKG2gzphTneArCj
         DFRVRCwBSm9lBnJ4x54IGL/1aXTa/TraW0q8KBg2+RvQlO2aES3BUpPOQJOKq+jaW8Da
         KIvmWXFXqvqDvgGK2ttgcrGRlGRi3GPrNXyZOMtjRpc8djtsagJWPKI5/eRIJ2crGlO6
         uO4CbhYR0UnwdllimWTpEiqvrjpUdsVD024d8kzu6FOo9jA/1oJdaxBGNsAZdae0Sy0f
         iquVwFJnsgMu/Ro0xl1cJJ9TXtgN/tMd+Twmt8NQwjzKLuIz2ka7jvEaBzQq2Ws2OUdz
         yHUg==
X-Gm-Message-State: APjAAAVMoUcc/xRywZLPRvGToLUn1F39nUfSwU8v2X/mQd3ArdAeU6sd
        jWkmhmhHtzu8VD5mwfrWs4yiLorc
X-Google-Smtp-Source: APXvYqxfiNOMpTCx2nzD7rpIB+lfL/ESLm0Iwf/QdYpMzwDxx4q+nF/QwKtbz5yLo8mBd7eu7h8eVFZQ
X-Received: by 2002:a1f:9010:: with SMTP id s16mr1018825vkd.12.1554409445741;
 Thu, 04 Apr 2019 13:24:05 -0700 (PDT)
Date:   Thu,  4 Apr 2019 16:23:44 -0400
In-Reply-To: <20190404202345.133553-1-brho@google.com>
Message-Id: <20190404202345.133553-3-brho@google.com>
Mime-Version: 1.0
References: <20190404202345.133553-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 2/3] kvm: Use huge pages for DAX-backed files
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yu.c.zhang@intel.com,
        yi.z.zhang@intel.com
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
 arch/x86/kvm/mmu.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index eee455a8a612..48cbf5553688 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3207,6 +3207,35 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
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
 					gfn_t *gfnp, kvm_pfn_t *pfnp,
 					int *levelp)
@@ -3223,7 +3252,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 	 */
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
 	    level == PT_PAGE_TABLE_LEVEL &&
-	    PageTransCompoundMap(pfn_to_page(pfn)) &&
+	    pfn_is_huge_mapped(vcpu->kvm, gfn, pfn) &&
 	    !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
 		unsigned long mask;
 		/*
@@ -5774,7 +5803,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		 */
 		if (sp->role.direct &&
 			!kvm_is_reserved_pfn(pfn) &&
-			PageTransCompoundMap(pfn_to_page(pfn))) {
+			pfn_is_huge_mapped(kvm, sp->gfn, pfn)) {
 			pte_list_remove(rmap_head, sptep);
 
 			if (kvm_available_flush_tlb_with_range())
-- 
2.21.0.392.gf8f6787159e-goog

