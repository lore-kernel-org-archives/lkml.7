Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEDAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF5B2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLaGrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 01:47:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:16543 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfLaGq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 01:46:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2019 22:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,378,1571727600"; 
   d="scan'208";a="224368504"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com) ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 30 Dec 2019 22:46:54 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com, Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v10 08/10] mmu: spp: Handle SPP protected pages when VM memory changes
Date:   Tue, 31 Dec 2019 14:50:41 +0800
Message-Id: <20191231065043.2209-9-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191231065043.2209-1-weijiang.yang@intel.com>
References: <20191231065043.2209-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host page swapping/migration may change the translation in
EPT leaf entry, if the target page is SPP protected,
re-enable SPP protection in MMU notifier. If SPPT shadow
page is reclaimed, the level1 pages don't have rmap to clear.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aada0a3552b2..3fcc6ee71f15 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1913,6 +1913,19 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			new_spte &= ~PT_WRITABLE_MASK;
 			new_spte &= ~SPTE_HOST_WRITEABLE;
 
+			/*
+			 * if it's EPT leaf entry and the physical page is
+			 * SPP protected, then re-enable SPP protection for
+			 * the page.
+			 */
+			if (kvm->arch.spp_active &&
+			    level == PT_PAGE_TABLE_LEVEL) {
+				u32 *access = gfn_to_subpage_wp_info(slot, gfn);
+
+				if (access && *access != FULL_SPP_ACCESS)
+					new_spte |= PT_SPP_MASK;
+			}
+
 			new_spte = mark_spte_for_access_track(new_spte);
 
 			mmu_spte_clear_track_bits(sptep);
@@ -2763,6 +2776,10 @@ static bool mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	pte = *spte;
 	if (is_shadow_present_pte(pte)) {
 		if (is_last_spte(pte, sp->role.level)) {
+			/* SPPT leaf entries don't have rmaps*/
+			if (sp->role.level == PT_PAGE_TABLE_LEVEL &&
+			    is_spp_spte(sp))
+				return true;
 			drop_spte(kvm, spte);
 			if (is_large_pte(pte))
 				--kvm->stat.lpages;
-- 
2.17.2

