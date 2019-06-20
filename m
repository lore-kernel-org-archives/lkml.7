Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41EAC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8891A20656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055137;
	bh=dNlhZXcSxapq/pBxruiZXHFae5wUZKQT88NMHvsonGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJppWUcFkTpL1h0Bo0KW/5AoJ43d0UkTOVOVWH5RR1GV9/gSNJvWuyjqXNFK9rie2
	 jHwcAlmLBPF34Q5Ds0MKmUYBVSD7zcl2i79Wq9IRaKO4ug+VlcDPN8eUpTzAlTOmbZ
	 zTsey+vuBO757W1kwKUDZO23sD+SMgYAHy6ob6DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfFTSHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfFTSHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:07:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70E72070B;
        Thu, 20 Jun 2019 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054024;
        bh=dNlhZXcSxapq/pBxruiZXHFae5wUZKQT88NMHvsonGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sO9qidqvI5fdFPdbvKf5cBbodadh9rAnJirHJmrmfRvK6dKrfPhpw8J+f7set5SNy
         vlWQU5BWi07zMQSxFOxI6KsxuawHhCgEr85HatpFkzpZoCF0S8nqmta5ILYnQlg7LQ
         2S+I1D0FJ0bhdBcA165SVQoI9ljiQf5aIiXeLcpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 079/117] KVM: x86/pmu: do not mask the value that is written to fixed PMUs
Date:   Thu, 20 Jun 2019 19:56:53 +0200
Message-Id: <20190620174357.130820494@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



