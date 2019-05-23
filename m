Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A1C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E30217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfEWKfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:35:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43174 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730692AbfEWKfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:35:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7757115AB;
        Thu, 23 May 2019 03:35:51 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A9793F718;
        Thu, 23 May 2019 03:35:49 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 13/15] KVM: arm64: enable SPE support
Date:   Thu, 23 May 2019 11:35:00 +0100
Message-Id: <20190523103502.25925-14-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523103502.25925-1-sudeep.holla@arm.com>
References: <20190523103502.25925-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have all the bits and pieces to enable SPE for guest in place, so
lets enable it.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 virt/kvm/arm/arm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index c5b711ef1cf8..935e2ed02b2e 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -577,6 +577,10 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 		return ret;
 
 	ret = kvm_arm_pmu_v3_enable(vcpu);
+	if (ret)
+		return ret;
+
+	ret = kvm_arm_spe_v1_enable(vcpu);
 
 	return ret;
 }
-- 
2.17.1

