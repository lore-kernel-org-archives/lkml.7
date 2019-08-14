Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB4C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE7E20843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749069;
	bh=5T9m9kIHdtEA3c1wGjE0pou36IeEAMPgIbQzEGkvXfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1KxUn8nbV179azF6zxwoQ62YgXrRZt7RVFgfogE0VfqqY8OXhGBQubVEBqr2RKr8Y
	 I/GAVpANBPEAt5TWixjrp6yzzeMetYwuysDVbRVBRuRgYO1sLk2+B8V8m+opC5W+rU
	 MkPQvuZDquUEZCZ1UzaeWY+MK/SsQmWyiPltN+7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfHNCRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbfHNCRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:17:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DCE82085A;
        Wed, 14 Aug 2019 02:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749057;
        bh=5T9m9kIHdtEA3c1wGjE0pou36IeEAMPgIbQzEGkvXfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXzshmpQMrA2t2rAp8CKwzIg8YgEI8iH8gJ3Hi+V/6kxMqeD1dFDervGu+E9T0ppu
         YVT3jxREoSIGYg0POqOlpy9lML9MRSYHPtgPWTz0J0V0lXRP+azJ7HhRz2A0VAXZiM
         ompl6bdmdInVNzVvmnklb72LRyI20+g/FyIiACec=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 4.19 67/68] KVM: arm: Don't write junk to CP15 registers on reset
Date:   Tue, 13 Aug 2019 22:15:45 -0400
Message-Id: <20190814021548.16001-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021548.16001-1-sashal@kernel.org>
References: <20190814021548.16001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit c69509c70aa45a8c4954c88c629a64acf4ee4a36 ]

At the moment, the way we reset CP15 registers is mildly insane:
We write junk to them, call the reset functions, and then check that
we have something else in them.

The "fun" thing is that this can happen while the guest is running
(PSCI, for example). If anything in KVM has to evaluate the state
of a CP15 register while junk is in there, bad thing may happen.

Let's stop doing that. Instead, we track that we have called a
reset function for that register, and assume that the reset
function has done something.

In the end, the very need of this reset check is pretty dubious,
as it doesn't check everything (a lot of the CP15 reg leave outside
of the cp15_regs[] array). It may well be axed in the near future.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kvm/coproc.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index fd6cde23bb5d0..871fa50a09f19 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -658,13 +658,22 @@ int kvm_handle_cp14_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
 }
 
 static void reset_coproc_regs(struct kvm_vcpu *vcpu,
-			      const struct coproc_reg *table, size_t num)
+			      const struct coproc_reg *table, size_t num,
+			      unsigned long *bmap)
 {
 	unsigned long i;
 
 	for (i = 0; i < num; i++)
-		if (table[i].reset)
+		if (table[i].reset) {
+			int reg = table[i].reg;
+
 			table[i].reset(vcpu, &table[i]);
+			if (reg > 0 && reg < NR_CP15_REGS) {
+				set_bit(reg, bmap);
+				if (table[i].is_64bit)
+					set_bit(reg + 1, bmap);
+			}
+		}
 }
 
 static struct coproc_params decode_32bit_hsr(struct kvm_vcpu *vcpu)
@@ -1439,17 +1448,15 @@ void kvm_reset_coprocs(struct kvm_vcpu *vcpu)
 {
 	size_t num;
 	const struct coproc_reg *table;
-
-	/* Catch someone adding a register without putting in reset entry. */
-	memset(vcpu->arch.ctxt.cp15, 0x42, sizeof(vcpu->arch.ctxt.cp15));
+	DECLARE_BITMAP(bmap, NR_CP15_REGS) = { 0, };
 
 	/* Generic chip reset first (so target could override). */
-	reset_coproc_regs(vcpu, cp15_regs, ARRAY_SIZE(cp15_regs));
+	reset_coproc_regs(vcpu, cp15_regs, ARRAY_SIZE(cp15_regs), bmap);
 
 	table = get_target_table(vcpu->arch.target, &num);
-	reset_coproc_regs(vcpu, table, num);
+	reset_coproc_regs(vcpu, table, num, bmap);
 
 	for (num = 1; num < NR_CP15_REGS; num++)
-		WARN(vcpu_cp15(vcpu, num) == 0x42424242,
+		WARN(!test_bit(num, bmap),
 		     "Didn't reset vcpu_cp15(vcpu, %zi)", num);
 }
-- 
2.20.1

