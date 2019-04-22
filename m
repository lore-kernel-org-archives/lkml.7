Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F50EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5589217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962278;
	bh=Wlb29ro/DiaP2u5L+KTeA2jOByJ/ULlqQoqPNhGLjgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ia+yRfu+DIuvdXuctAlrCLWaxVoUSorcO2VIKCg93Ixtl1oQ8ZfBLCgVy6oG7xpva
	 SuGphfUQLRK0OvX7M5eR0GO8sf/EjdnIgrpEL0UQ9VOU45RTNtdkHebjYPQWoPst9o
	 ESOscB2BhkinmNNbTDxUt9spqm/evN6x5G6p97JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfDVToh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbfDVTof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E62218B0;
        Mon, 22 Apr 2019 19:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962275;
        bh=Wlb29ro/DiaP2u5L+KTeA2jOByJ/ULlqQoqPNhGLjgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQVgjpPxPyLiu4C3bfcwk6kB41FzX8mZI2Faw7QyngVi6uQMRY9Qt1FhlUhvW7OsI
         knIIcMkBhadFTFGoDoFG1xzC39iD/aKXqf/D4be2MbppAAqsz7UCL4vrjwSz69a8wS
         5F9RrRGnMSjhdIqOKSYqne3v8fMBbZ/IMclxUthQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 81/98] kvm/x86: Move MSR_IA32_ARCH_CAPABILITIES to array emulated_msrs
Date:   Mon, 22 Apr 2019 15:41:48 -0400
Message-Id: <20190422194205.10404-81-sashal@kernel.org>
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

From: Xiaoyao Li <xiaoyao.li@linux.intel.com>

[ Upstream commit 2bdb76c015df7125783d8394d6339d181cb5bc30 ]

Since MSR_IA32_ARCH_CAPABILITIES is emualted unconditionally even if
host doesn't suppot it. We should move it to array emulated_msrs from
arry msrs_to_save, to report to userspace that guest support this msr.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7ee802a92bc8..8748789b9540 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1125,7 +1125,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_SPEC_CTRL,
 	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
 	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
 	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
@@ -1158,6 +1158,7 @@ static u32 emulated_msrs[] = {
 
 	MSR_IA32_TSC_ADJUST,
 	MSR_IA32_TSCDEADLINE,
+	MSR_IA32_ARCH_CAPABILITIES,
 	MSR_IA32_MISC_ENABLE,
 	MSR_IA32_MCG_STATUS,
 	MSR_IA32_MCG_CTL,
-- 
2.19.1

