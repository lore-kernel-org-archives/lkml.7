Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A5DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBB121851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639113;
	bh=DuOmr3PJqdUA6uHfS2m2GxoEp90IkVIbIqMtz+phuZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d2L0oY7cgD5u0mEXEly+8ExdLWmV93UVEFN0Zv/dKHPGGppSP/3cAkQxu6v9nynDY
	 ucfen+/fnCWkfyqm+7nuZcN0xGHwKiznLmIUm2mqv3SW29ZUkvlo+OedqvJI11ah5J
	 0T+aumtt9FJdY7Phn/kIvdQWYbcr2epob0zwT4G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389652AbfEWTSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388847AbfEWTSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:18:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2601217D9;
        Thu, 23 May 2019 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639110;
        bh=DuOmr3PJqdUA6uHfS2m2GxoEp90IkVIbIqMtz+phuZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVCcuP0A+ANHnmJM2klLocThgdzpphID5w1UpRYqywDKmwhGgz79CTEpydDRM7une
         1y2j7Mjsb44buAJmN4log93QHcQAjfsiFiSNXmJOYGJh+Hx6W+zmLUN/3qSrdHNdv5
         3vZrRauR7fW+urGHxwrd1DMmT8tIcY5CJqfyJni8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 098/114] KVM: arm/arm64: Ensure vcpu target is unset on reset failure
Date:   Thu, 23 May 2019 21:06:37 +0200
Message-Id: <20190523181740.125067227@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



