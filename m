Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C5C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCE72064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963824;
	bh=tqK+R6rlTVH9d6Ht/tYIxodCwnmmz3yGQULYjgYFRUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ns1YLXSw8SpdIksPMfZnVzj5Etu3cMTRHpiGM0ZyLPx3ANLrR1i4Wifu9hFbaxg++
	 ohSwpcydsHqGkX2ZN/8EuKFQwUCtLSWIq1+Yt3Mc9A6rmbZFDlwPYn1iMlaerZAQ2i
	 47U1WfcKaSJSn7HELfnWXuI1xUlRO0PXGQ+nlxeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbfDVUKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfDVTmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 014982175B;
        Mon, 22 Apr 2019 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962162;
        bh=tqK+R6rlTVH9d6Ht/tYIxodCwnmmz3yGQULYjgYFRUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqqSRRnyYRdc7DKXtwPHMsbJm4EfLhmFgpuUovlbonf3gaBnTe+DAaHfroUOACinm
         tskk9AE6qC3HXs0VCUNzhJ84OfiV6SU58JJNa7cA5e/UJJ9II0Hvh2NU9FS6pIy8xY
         rJ8huhjOX1AYBpKgxo/sA1sGEzAQMIHYL8pglKRY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 5.0 26/98] arm64: KVM: Always set ICH_HCR_EL2.EN if GICv4 is enabled
Date:   Mon, 22 Apr 2019 15:40:53 -0400
Message-Id: <20190422194205.10404-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit ca71228b42a96908eca7658861eafacd227856c9 ]

The normal interrupt flow is not to enable the vgic when no virtual
interrupt is to be injected (i.e. the LRs are empty). But when a guest
is likely to use GICv4 for LPIs, we absolutely need to switch it on
at all times. Otherwise, VLPIs only get delivered when there is something
in the LRs, which doesn't happen very often.

Reported-by: Nianyao Tang <tangnianyao@huawei.com>
Tested-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 virt/kvm/arm/hyp/vgic-v3-sr.c |  4 ++--
 virt/kvm/arm/vgic/vgic.c      | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index 9652c453480f..3c3f7cda95c7 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -222,7 +222,7 @@ void __hyp_text __vgic_v3_save_state(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (used_lrs) {
+	if (used_lrs || cpu_if->its_vpe.its_vm) {
 		int i;
 		u32 elrsr;
 
@@ -247,7 +247,7 @@ void __hyp_text __vgic_v3_restore_state(struct kvm_vcpu *vcpu)
 	u64 used_lrs = vcpu->arch.vgic_cpu.used_lrs;
 	int i;
 
-	if (used_lrs) {
+	if (used_lrs || cpu_if->its_vpe.its_vm) {
 		write_gicreg(cpu_if->vgic_hcr, ICH_HCR_EL2);
 
 		for (i = 0; i < used_lrs; i++)
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index abd9c7352677..3af69f2a3866 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -867,15 +867,21 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 	 * either observe the new interrupt before or after doing this check,
 	 * and introducing additional synchronization mechanism doesn't change
 	 * this.
+	 *
+	 * Note that we still need to go through the whole thing if anything
+	 * can be directly injected (GICv4).
 	 */
-	if (list_empty(&vcpu->arch.vgic_cpu.ap_list_head))
+	if (list_empty(&vcpu->arch.vgic_cpu.ap_list_head) &&
+	    !vgic_supports_direct_msis(vcpu->kvm))
 		return;
 
 	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
-	raw_spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
-	vgic_flush_lr_state(vcpu);
-	raw_spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	if (!list_empty(&vcpu->arch.vgic_cpu.ap_list_head)) {
+		raw_spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
+		vgic_flush_lr_state(vcpu);
+		raw_spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
+	}
 
 	if (can_access_vgic_from_kernel())
 		vgic_restore_state(vcpu);
-- 
2.19.1

