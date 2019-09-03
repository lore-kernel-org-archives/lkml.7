Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71498C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8302339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528765;
	bh=XrNnbLr9bHij3PQYDFs3z2nmGwg3/XIHzeadN+sRjEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ruGRzGeHL8SvmPHM7/uGpl+VLi/Eco4goa6DLJf5efQ1HxLBh5FxbGJbJhlGE1Tsj
	 qlIVw0VtJ+s9xKkDRJgqFSgra7Vej3CdE1f/2EnHwz9XokWIjr01Ej0R5Rhmv2kV8Q
	 lSmb5k9r38aJ6Y9IuxYR7MGooBF1NilK15MjOfCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfICQjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbfICQZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:25:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B20D23774;
        Tue,  3 Sep 2019 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527943;
        bh=XrNnbLr9bHij3PQYDFs3z2nmGwg3/XIHzeadN+sRjEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKX2hBuwO9wX5KMxb8ZFJW42JWWAkA7uYWw9ZcVvcmp2G6xcr7k1e/TXh2ghbwULO
         1iaHsEBq7DpcGdKdLxbS0k1RvbMTNxy5o1eg5Tps/AV9uq/o/FZQi5mVwxKBI7VGqP
         b+t/LN9Jsdg5dSscNqJVY0BFUSBCXn+aW5NkgnLM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 011/167] KVM: x86: hyperv: enforce vp_index < KVM_MAX_VCPUS
Date:   Tue,  3 Sep 2019 12:22:43 -0400
Message-Id: <20190903162519.7136-11-sashal@kernel.org>
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

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 9170200ec0ebad70e5b9902bc93e2b1b11456a3b ]

Hyper-V TLFS (5.0b) states:

> Virtual processors are identified by using an index (VP index). The
> maximum number of virtual processors per partition supported by the
> current implementation of the hypervisor can be obtained through CPUID
> leaf 0x40000005. A virtual processor index must be less than the
> maximum number of virtual processors per partition.

Forbid userspace to set VP_INDEX above KVM_MAX_VCPUS. get_vcpu_by_vpidx()
can now be optimized to bail early when supplied vpidx is >= KVM_MAX_VCPUS.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/hyperv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 229d996051653..73fa074b9089a 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -132,8 +132,10 @@ static struct kvm_vcpu *get_vcpu_by_vpidx(struct kvm *kvm, u32 vpidx)
 	struct kvm_vcpu *vcpu = NULL;
 	int i;
 
-	if (vpidx < KVM_MAX_VCPUS)
-		vcpu = kvm_get_vcpu(kvm, vpidx);
+	if (vpidx >= KVM_MAX_VCPUS)
+		return NULL;
+
+	vcpu = kvm_get_vcpu(kvm, vpidx);
 	if (vcpu && vcpu_to_hv_vcpu(vcpu)->vp_index == vpidx)
 		return vcpu;
 	kvm_for_each_vcpu(i, vcpu, kvm)
@@ -1044,7 +1046,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 
 	switch (msr) {
 	case HV_X64_MSR_VP_INDEX:
-		if (!host)
+		if (!host || (u32)data >= KVM_MAX_VCPUS)
 			return 1;
 		hv->vp_index = (u32)data;
 		break;
-- 
2.20.1

