Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6544EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B5E20675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811327;
	bh=ENEOq8ymi8u9HzFnaKNC83uaP7dAPwUmnYmnsnS2nFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FOL8rafu5Xu/jS3cpnshMRTHvXEJCXLPgxBez8pskNbYnKA8+gZcHPocl2Sha8tmY
	 zLJDjdYMs228Ca6U8QyVzBsQKYDIkeLlLGLRXZlFO/ZDiLXjtHkj+qbjAIOrDMYpRl
	 Os1NPJfTq5RHXHGZcn7UdUie7LjwpL1Bvm4ExFSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfEBPb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfEBPb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:31:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B7A20C01;
        Thu,  2 May 2019 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811085;
        bh=ENEOq8ymi8u9HzFnaKNC83uaP7dAPwUmnYmnsnS2nFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVbn7jOyvTmVD2w/6gJLHf5OlS/Nu0s3TISoHp8Uovio0UxgaH5vr0mgBaCdq6YzQ
         aLPuY5XDw4A9nW8+gZBxF2nMGldVVScNrd7EK3DcV7ZBScPA+jzuArxULUq/jKFCdd
         nk4h86bPAPh+TiXm4eeZwqg5Jdcprav7CxD8LIUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nianyao Tang <tangnianyao@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 032/101] arm64: KVM: Always set ICH_HCR_EL2.EN if GICv4 is enabled
Date:   Thu,  2 May 2019 17:20:34 +0200
Message-Id: <20190502143341.783223402@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



