Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0437C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C64206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbfHOPMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:12:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:25322 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732464AbfHOPMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:12:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 08:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="171139099"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2019 08:12:29 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Willamson <alex.williamson@redhat.com>
Subject: [PATCH] KVM: x86/MMU: Zap all when removing memslot if VM has assigned device
Date:   Thu, 15 Aug 2019 08:12:28 -0700
Message-Id: <20190815151228.32242-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <1565855169-29491-1-git-send-email-pbonzini@redhat.com>
References: <1565855169-29491-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson reported regressions with device assignment when KVM
changed its memslot removal logic to zap only the SPTEs for the memslot
being removed.  The source of the bug is unknown at this time, and root
causing the issue will likely be a slow process.  In the short term, fix
the regression by zapping all SPTEs when removing a memslot from a VM
with assigned device(s).

Fixes: 4e103134b862 ("KVM: x86/mmu: Zap only the relevant pages when removing a memslot", 2019-02-05)
Reported-by: Alex Willamson <alex.williamson@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

An alternative idea to a full revert.  I assume this would be easy to
backport, and also easy to revert or quirk depending on where the bug
is hiding.

 arch/x86/kvm/mmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 8f72526e2f68..358b93882ac6 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5659,6 +5659,17 @@ static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
 	bool flush;
 	gfn_t gfn;
 
+	/*
+	 * Zapping only the removed memslot introduced regressions for VMs with
+	 * assigned devices.  It is unknown what piece of code is buggy.  Until
+	 * the source of the bug is identified, zap everything if the VM has an
+	 * assigned device.
+	 */
+	if (kvm_arch_has_assigned_device(kvm)) {
+		kvm_mmu_zap_all(kvm);
+		return;
+	}
+
 	spin_lock(&kvm->mmu_lock);
 
 	if (list_empty(&kvm->arch.active_mmu_pages))
-- 
2.22.0

