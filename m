Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A70C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7681E218D9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962162;
	bh=a/tDOxXZmubAs3j/a20Am9PD6cFX24xUBC6esjBERXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ktmlQLL2G22hU1KPtbl+U6ePbnzuVWflRtW3AxZ0sRup5bcpyga6e6k9KjKMB3/pv
	 ZXI3VidcqFR7Mi7vv1pyOwaYueCyn9zOlwCUw27lsDOm7MRkiA6Bzi70gGX5XEpjvc
	 TMN/3FDktjvEJ6nE3+shS5hPMLF8b8sxr2ehjlVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfDVTml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbfDVTmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BFE218DA;
        Mon, 22 Apr 2019 19:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962157;
        bh=a/tDOxXZmubAs3j/a20Am9PD6cFX24xUBC6esjBERXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkIIlmA3js6Z90kBQG4PBYx4CbDXAsxKaT8kH+G5uX6jmLPqDOKWb6buFyrEvH+BH
         Fz7JmeESmuo/9nFW3kOxuArhmKNxb+bv0VvyYiXEG443wXqQ1Cer+5fGhBWH+kT6MY
         Ms1zzYdsMy5tmO/jT4Sbkz7+M1UaeGuMuYtq0a1Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 5.0 25/98] KVM: arm64: Reset the PMU in preemptible context
Date:   Mon, 22 Apr 2019 15:40:52 -0400
Message-Id: <20190422194205.10404-25-sashal@kernel.org>
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

[ Upstream commit ebff0b0e3d3c862c16c487959db5e0d879632559 ]

We've become very cautious to now always reset the vcpu when nothing
is loaded on the physical CPU. To do so, we now disable preemption
and do a kvm_arch_vcpu_put() to make sure we have all the state
in memory (and that it won't be loaded behind out back).

This now causes issues with resetting the PMU, which calls into perf.
Perf itself uses mutexes, which clashes with the lack of preemption.
It is worth realizing that the PMU is fully emulated, and that
no PMU state is ever loaded on the physical CPU. This means we can
perfectly reset the PMU outside of the non-preemptible section.

Fixes: e761a927bc9a ("KVM: arm/arm64: Reset the VCPU without preemption and vcpu state loaded")
Reported-by: Julien Grall <julien.grall@arm.com>
Tested-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm64/kvm/reset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index f16a5f8ff2b4..e2a0500cd7a2 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -123,6 +123,9 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	int ret = -EINVAL;
 	bool loaded;
 
+	/* Reset PMU outside of the non-preemptible section */
+	kvm_pmu_vcpu_reset(vcpu);
+
 	preempt_disable();
 	loaded = (vcpu->cpu != -1);
 	if (loaded)
@@ -170,9 +173,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		vcpu->arch.reset_state.reset = false;
 	}
 
-	/* Reset PMU */
-	kvm_pmu_vcpu_reset(vcpu);
-
 	/* Default workaround setup is enabled (if supported) */
 	if (kvm_arm_have_ssbd() == KVM_SSBD_KERNEL)
 		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
-- 
2.19.1

