Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E39AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D925218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDXEl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:41:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfDXEl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:41:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 292B69D7AFA4C9779A00;
        Wed, 24 Apr 2019 12:41:55 +0800 (CST)
Received: from localhost.localdomain (10.143.28.91) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 12:41:48 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <zhengxiang9@huawei.com>
Subject: [PATCH] KVM: arm/arm64: inject an async abort to host if SEA handling failed
Date:   Wed, 24 Apr 2019 12:41:47 +0800
Message-ID: <1556080907-25158-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.91]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If host failed to handle the SEA, KVM should inject an async abort
to guest for both SEA data and instruction abort, but it currently
only handles the data abort, so correct it.

Cc: James Morse <james.morse@arm.com>
Cc: Xiang Zheng <zhengxiang9@huawei.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 virt/kvm/arm/mmu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 27c9583..5882516 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1924,14 +1924,13 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		/*
 		 * For RAS the host kernel may handle this abort.
 		 * There is no need to pass the error into the guest.
+		 * If host failed to handle it, inject an async abort
+		 * to guest.
 		 */
-		if (!kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
-			return 1;
-
-		if (unlikely(!is_iabt)) {
+		if (kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
 			kvm_inject_vabt(vcpu);
-			return 1;
-		}
+
+		return 1;
 	}
 
 	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_hsr(vcpu),
-- 
2.7.4

