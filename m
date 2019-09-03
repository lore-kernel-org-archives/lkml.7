Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64669C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A53F2343A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528190;
	bh=mIWbGUdjvLUSWtsFuJdn5JZh9DqkmnUUxnlmJ5dx0ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SKxdRnS4eu5BiSt1doBael3k74MbQFazZlSD4kAPVUdxWzoNIVlQ0hc/L0GID945Q
	 VrxuKq52p+paWe8LvhrU5QBbAXpdCcWwdGfULb5mWlu+lhepPNQVk2LW6ilEDAO5e5
	 0V9OA+RVS3qXjr9CYuRIIF3K8YqrNhrBHeDjw0ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfICQ3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730770AbfICQ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:29:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C18E238CE;
        Tue,  3 Sep 2019 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528148;
        bh=mIWbGUdjvLUSWtsFuJdn5JZh9DqkmnUUxnlmJ5dx0ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0ZPEqMv7s+F44QLMcpSo0NSYuQ0RGsEuPl+hDTHJU+L5ZuMBxLgkEGQjfz8rZz/L
         hemNhZGcDkKuqdG/b5ExbgW9XOdibtHk9uDvhH72EWzKLlKVpJLlwxUmpwxUxt/UHk
         7xRHFdM30YFwKs1d2U10flpA1GPrY+DCpNVzNnsk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Neuling <mikey@neuling.org>,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 137/167] KVM: PPC: Book3S HV: Fix CR0 setting in TM emulation
Date:   Tue,  3 Sep 2019 12:24:49 -0400
Message-Id: <20190903162519.7136-137-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Neuling <mikey@neuling.org>

[ Upstream commit 3fefd1cd95df04da67c83c1cb93b663f04b3324f ]

When emulating tsr, treclaim and trechkpt, we incorrectly set CR0. The
code currently sets:
    CR0 <- 00 || MSR[TS]
but according to the ISA it should be:
    CR0 <-  0 || MSR[TS] || 0

This fixes the bit shift to put the bits in the correct location.

This is a data integrity issue as CR0 is corrupted.

Fixes: 4bb3c7a0208f ("KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9")
Cc: stable@vger.kernel.org # v4.17+
Tested-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_tm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_tm.c b/arch/powerpc/kvm/book3s_hv_tm.c
index 888e2609e3f15..31cd0f327c8a2 100644
--- a/arch/powerpc/kvm/book3s_hv_tm.c
+++ b/arch/powerpc/kvm/book3s_hv_tm.c
@@ -131,7 +131,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 		}
 		/* Set CR0 to indicate previous transactional state */
 		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
-			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
+			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
 		/* L=1 => tresume, L=0 => tsuspend */
 		if (instr & (1 << 21)) {
 			if (MSR_TM_SUSPENDED(msr))
@@ -175,7 +175,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 
 		/* Set CR0 to indicate previous transactional state */
 		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
-			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
+			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
 		vcpu->arch.shregs.msr &= ~MSR_TS_MASK;
 		return RESUME_GUEST;
 
@@ -205,7 +205,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 
 		/* Set CR0 to indicate previous transactional state */
 		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
-			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
+			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
 		vcpu->arch.shregs.msr = msr | MSR_TS_S;
 		return RESUME_GUEST;
 	}
-- 
2.20.1

