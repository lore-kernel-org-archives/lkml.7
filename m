Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79253C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4AA20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558007133;
	bh=OA6R3iu7JBUXC9yXdeUmfUgtGcgdbZm40IF8v11gb0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VK3QdszzBlV3lIjS6AaKtVC7Rqu5FHEyfIsU3/rqKvvqlsBM4jwHpETs87weKE0KA
	 e4ghLH8Lp13ALrWYlpZeR33stIahELJvlA9bSMVw2w8fIbgkpRY0U4tVuCVp7G/2jg
	 lsHQ87EgT9S90A965Uh31hIxkX++dIHJTXCZWmAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfEPLkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfEPLks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:40:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 609C12087E;
        Thu, 16 May 2019 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006848;
        bh=OA6R3iu7JBUXC9yXdeUmfUgtGcgdbZm40IF8v11gb0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIXB/naSHEYe9Maib831LdZDmNonX+xKO3dmXAXqrP1vw91uVm3oVZ8HLzf4Do9P7
         kE8yz5kuuc76QT+Q8TEKQCHakLez3PcGe6+N77C+3YxVpTC/SrDZOgGdQxkkbHn80D
         XRWH6qDiVnwQfAsP93/pmKkmy55hb3qtmXFwS0sM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 4.19 16/25] KVM: arm/arm64: Ensure vcpu target is unset on reset failure
Date:   Thu, 16 May 2019 07:40:19 -0400
Message-Id: <20190516114029.8682-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516114029.8682-1-sashal@kernel.org>
References: <20190516114029.8682-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jones <drjones@redhat.com>

[ Upstream commit 811328fc3222f7b55846de0cd0404339e2e1e6d7 ]

A failed KVM_ARM_VCPU_INIT should not set the vcpu target,
as the vcpu target is used by kvm_vcpu_initialized() to
determine if other vcpu ioctls may proceed. We need to set
the target before calling kvm_reset_vcpu(), but if that call
fails, we should then unset it and clear the feature bitmap
while we're at it.

Signed-off-by: Andrew Jones <drjones@redhat.com>
[maz: Simplified patch, completed commit message]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/arm/arm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 1415e36fed3db..fef3527af3bd7 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -949,7 +949,7 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 			       const struct kvm_vcpu_init *init)
 {
-	unsigned int i;
+	unsigned int i, ret;
 	int phys_target = kvm_target_cpu();
 
 	if (init->target != phys_target)
@@ -984,9 +984,14 @@ static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 	vcpu->arch.target = phys_target;
 
 	/* Now we know what it is, we can reset it. */
-	return kvm_reset_vcpu(vcpu);
-}
+	ret = kvm_reset_vcpu(vcpu);
+	if (ret) {
+		vcpu->arch.target = -1;
+		bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
+	}
 
+	return ret;
+}
 
 static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 					 struct kvm_vcpu_init *init)
-- 
2.20.1

