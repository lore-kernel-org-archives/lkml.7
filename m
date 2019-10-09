Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4018DECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BC820B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642088;
	bh=zHC/CwO7czA+UKxu9cJtG5vRyrd6jOR5KC9dhv/MTi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kdrs3nce1NdANLR5DYhTcTWnaHa4xsoFKhocc/hisRj9WB1RATgdV0X9xRzbXfyl1
	 vqCf9Wim9flDcfnuBaIN3DkOp6w/iyr/3gOWZtcZbpwdmIj/zX8Z0zwtMOHWOACJ68
	 kKobKJPvhLKZGESymeRV6dRSqE/3Mq+6dfyIGTkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbfJIR2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732125AbfJIRY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:26 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8326E21D56;
        Wed,  9 Oct 2019 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641865;
        bh=zHC/CwO7czA+UKxu9cJtG5vRyrd6jOR5KC9dhv/MTi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwHxRP91fX6e5SLXxvRAUh72a+vcU+w8ljnd4xCEFvBJ4HelDP5KzZ8PDUBt0ZSHL
         Cku6a1Xia/7n0G0Bpbyqt6h8NH69vWw5Vqk2B0MrRW5a3AcCgg6Kw5X+LL/f7TzbMK
         bdXwM0nJENeEs/m4nSEmifOMOnMbD7njsQTa7oXk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Marc Orr <marcorr@google.com>,
        Peter Shier <pshier@google.com>,
        Jacob Xu <jacobhxu@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/21] kvm: x86: Use AMD CPUID semantics for AMD vCPUs
Date:   Wed,  9 Oct 2019 13:06:00 -0400
Message-Id: <20191009170615.32750-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170615.32750-1-sashal@kernel.org>
References: <20191009170615.32750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

[ Upstream commit 5f41a37b151f6459e0b650a2f4d1d59b6c02d1ab ]

When the guest CPUID information represents an AMD vCPU, return all
zeroes for queries of undefined CPUID leaves, whether or not they are
in range.

Signed-off-by: Jim Mattson <jmattson@google.com>
Fixes: bd22f5cfcfe8f6 ("KVM: move and fix substitue search for missing CPUID entries")
Reviewed-by: Marc Orr <marcorr@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Reviewed-by: Jacob Xu <jacobhxu@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/cpuid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f3c49dc423895..3d480ec143284 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -893,9 +893,11 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 	/*
 	 * Intel CPUID semantics treats any query for an out-of-range
 	 * leaf as if the highest basic leaf (i.e. CPUID.0H:EAX) were
-	 * requested.
+	 * requested. AMD CPUID semantics returns all zeroes for any
+	 * undefined leaf, whether or not the leaf is in range.
 	 */
-	if (!entry && check_limit && !cpuid_function_in_range(vcpu, function)) {
+	if (!entry && check_limit && !guest_cpuid_is_amd(vcpu) &&
+	    !cpuid_function_in_range(vcpu, function)) {
 		max = kvm_find_cpuid_entry(vcpu, 0, 0);
 		if (max) {
 			function = max->eax;
-- 
2.20.1

