Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E000FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0210206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690857;
	bh=vwnWIWlm+60qgmZyuWQzafB4PtIQ8oJruKI4bbm8GNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C/y8Mx3/0YXkp2ihy/LYUj2VmggE4rLU6rplRDQg0Bx3LaIPxewFA5xH+5GipGaML
	 NDY83maf7MmVxjP06CrOByKkMkeew46jpbYF1usIJX/Z6LZN/cuhAZPfD/n95QxdNU
	 MDyr+qhVafOTFLDYy7tG/nuYnPrc4EU4ILcqwCn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfFDXZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfFDXY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA7B20862;
        Tue,  4 Jun 2019 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690696;
        bh=vwnWIWlm+60qgmZyuWQzafB4PtIQ8oJruKI4bbm8GNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwRvjqRK8BFOg9xwOpiV1WXZ/LiaqhDbadLqUduAD0kZFEV37jx8rwWrJQIEvyRXc
         9lN/4t2fKBj3bbrqB0QeJm178Cj4Yl9DKbfQSvyax2xXTlo8nTP+ca3uWlHz/hFdRs
         PZTWBiXSnGxC8oSxSdbiOgHjoo9rKeieYwrNdLRg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/24] KVM: x86/pmu: do not mask the value that is written to fixed PMUs
Date:   Tue,  4 Jun 2019 19:24:14 -0400
Message-Id: <20190604232416.7479-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232416.7479-1-sashal@kernel.org>
References: <20190604232416.7479-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 2924b52117b2812e9633d5ea337333299166d373 ]

According to the SDM, for MSR_IA32_PERFCTR0/1 "the lower-order 32 bits of
each MSR may be written with any value, and the high-order 8 bits are
sign-extended according to the value of bit 31", but the fixed counters
in real hardware are limited to the width of the fixed counters ("bits
beyond the width of the fixed-function counter are reserved and must be
written as zeros").  Fix KVM to do the same.

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/pmu_intel.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
index 5ab4a364348e..2729131fe9bf 100644
--- a/arch/x86/kvm/pmu_intel.c
+++ b/arch/x86/kvm/pmu_intel.c
@@ -235,11 +235,14 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		break;
 	default:
-		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
-		    (pmc = get_fixed_pmc(pmu, msr))) {
-			if (!msr_info->host_initiated)
-				data = (s64)(s32)data;
-			pmc->counter += data - pmc_read_counter(pmc);
+		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0))) {
+			if (msr_info->host_initiated)
+				pmc->counter = data;
+			else
+				pmc->counter = (s32)data;
+			return 0;
+		} else if ((pmc = get_fixed_pmc(pmu, msr))) {
+			pmc->counter = data;
 			return 0;
 		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
 			if (data == pmc->eventsel)
-- 
2.20.1

