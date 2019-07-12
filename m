Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09CBC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41B121019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934536;
	bh=uZ6LwPsp/KCDy/oucGPOKyVCGfUM2ptFOLsDxSTVslQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ye97iW2R8nywIqVsHLCbaD0nQxC3VqVNw9A24L7ZLV/Brrh5ejRTzs73D1fU2wcBs
	 oRiGvwC/F5lTLH97LOI53ZcjoendZobKrjf78MyCkCSIIZFczZN/nB5fQPQbySohbj
	 QtYnnTT84sLHdBJA3Gd+bc5SYoSUDkP4pBsEJ7l0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfGLM2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbfGLM2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:28:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9387821707;
        Fri, 12 Jul 2019 12:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934528;
        bh=uZ6LwPsp/KCDy/oucGPOKyVCGfUM2ptFOLsDxSTVslQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wq0WcIpc0RwVaWIzl+JtReiab80LR990sfy36jTclBMtEkk9ra80hzWmYuYkDI3B9
         gSevVjKfnWAGAwiUMq+9COHOhmU+sz2unRCXRTlsc8RVXmFbtRzk0ECmVrdI8589oy
         sRb0FHn3cQPQkU676Q40uM7ur6m1iutgu42bCmnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 086/138] KVM: arm/arm64: Fix emulated ptimer irq injection
Date:   Fri, 12 Jul 2019 14:19:10 +0200
Message-Id: <20190712121632.043617479@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e4e5a865e9a9e8e47ac1959b629e9f3ae3b062f2 ]

The emulated ptimer needs to track the level changes, otherwise the
the interrupt will never get deasserted, resulting in the guest getting
stuck in an interrupt storm if it enables ptimer interrupts. This was
found with kvm-unit-tests; the ptimer tests hung as soon as interrupts
were enabled. Typical Linux guests don't have a problem as they prefer
using the virtual timer.

Fixes: bee038a674875 ("KVM: arm/arm64: Rework the timer code to use a timer_map")
Signed-off-by: Andrew Jones <drjones@redhat.com>
[Simplified the patch to res we only care about emulated timers here]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/arm/arch_timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 7fc272ecae16..1b1c449ceaf4 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -321,14 +321,15 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
 	}
 }
 
+/* Only called for a fully emulated timer */
 static void timer_emulate(struct arch_timer_context *ctx)
 {
 	bool should_fire = kvm_timer_should_fire(ctx);
 
 	trace_kvm_timer_emulate(ctx, should_fire);
 
-	if (should_fire) {
-		kvm_timer_update_irq(ctx->vcpu, true, ctx);
+	if (should_fire != ctx->irq.level) {
+		kvm_timer_update_irq(ctx->vcpu, should_fire, ctx);
 		return;
 	}
 
-- 
2.20.1



