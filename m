Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AB4C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75357216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811129;
	bh=xzmBgJ22017BcCzc+hucSVt6pT8/FR8VIxfZOMT914w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0M4MnS1Wdoti00ZyauGN793ifjUE499aagprkhK1UUdiaSKWlAKhJpCQxgteksKf/
	 H6+2rmXSMIMwX5Eh9ojBVXnNO/okt65aF2HrQEHG2o/qqtDnETFWs1GgotXoGNew6j
	 K8hkmHOgeR04EDEIopOcrQxexiZh36l6vbowt4g4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfEBPcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfEBPcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:32:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A7B21670;
        Thu,  2 May 2019 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811124;
        bh=xzmBgJ22017BcCzc+hucSVt6pT8/FR8VIxfZOMT914w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHmgV8xRaWN2AtLfsX+Fek81mSLkDEBsicBSGm5IOIajJosCEDwYNih/rzSkDAKum
         53KF79pbcJAd+ArP38g+IJdx+J2ot9orAB73yjlb2EkPNBbhpGcyeU8gqoNYb5ITT8
         yOKUGiW5MUxl3ttpLyTN3w5QRwR0mOBGOUklqVlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 084/101] kvm/x86: Move MSR_IA32_ARCH_CAPABILITIES to array emulated_msrs
Date:   Thu,  2 May 2019 17:21:26 +0200
Message-Id: <20190502143345.487137167@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 2db58067bb59..8c9fb6453b2f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1127,7 +1127,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_SPEC_CTRL,
 	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
 	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
 	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
@@ -1160,6 +1160,7 @@ static u32 emulated_msrs[] = {
 
 	MSR_IA32_TSC_ADJUST,
 	MSR_IA32_TSCDEADLINE,
+	MSR_IA32_ARCH_CAPABILITIES,
 	MSR_IA32_MISC_ENABLE,
 	MSR_IA32_MCG_STATUS,
 	MSR_IA32_MCG_CTL,
-- 
2.19.1



