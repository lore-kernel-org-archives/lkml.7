Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B1BC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15E521851
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595729;
	bh=fpOF9X+K6MX51S2lgAmlVhrDgGS7QuhMNiVq3/Zuy0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FRtwQFPvzR8jW8qUO7TC+lookfu7vC8U0+6/dVTFPspmnrF6UPFvjV6CsSChGfUlB
	 1ZYu2SzfCWMrK2mTaXB0GZ8iGyWgTSP90Bi4rwVHxvfEyuAKzW9jZwSrpGNZ5g1Xr9
	 8KCoYv3gtlnxm2xJoaNusHVAEYgYY/k9ClSp5UCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfF0Af1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfF0Af0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:35:26 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E40217F4;
        Thu, 27 Jun 2019 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595725;
        bh=fpOF9X+K6MX51S2lgAmlVhrDgGS7QuhMNiVq3/Zuy0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnMtstHAOnK/+cYq3j/SygXW6dTPlCktQVE/4TRnwFzA1IQE/u00bggRs+ttYmiQ7
         c55GIMHbAe+zBaJLhtkB6h2YcNOOTG19ydgWKxoiD+lHqtBJeD+GObNonx4CV5OOvY
         jYQp+OZu7/K65vijQtfgmCtxAPNjQypIhk5Jg1Xc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 5.1 93/95] KVM: arm/arm64: Fix emulated ptimer irq injection
Date:   Wed, 26 Jun 2019 20:30:18 -0400
Message-Id: <20190627003021.19867-93-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jones <drjones@redhat.com>

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

