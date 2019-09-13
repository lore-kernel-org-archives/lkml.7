Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C763C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628AC208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380366;
	bh=vCB8d08AOZ8EMbQad+wIbniBn9HC5VKjqJsR3Bl01sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ona9m+/NKv467j0MsPw+YRSXZoz0jzwYp3y+dAzTusRlzNTtWXMh1BixKlhVYQTBm
	 EJE++cNqenRdhrts6ApRrUgZZYeo18aK5/B4z92wV+hpwkamcTXRdYVQ1EpeOz7TnK
	 AdGnjnt79jSMap3wtuXdjGECnm6CAKISM0mrN6tE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbfIMNMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389197AbfIMNMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:12:43 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 056D120CC7;
        Fri, 13 Sep 2019 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380362;
        bh=vCB8d08AOZ8EMbQad+wIbniBn9HC5VKjqJsR3Bl01sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xls2qJrZLzQDXXZy/gFxwm36WGAM3wqcwP5NsBAWA210XtXdIhIQgebZD1nRz2WbS
         4BfIf78TUT6fUsb8gI6+Nf1IuDESD9mpQ3T/kLC86DOWHevXaGtZkeOfNfehJI4cNy
         Ic4j//93aRoLZNyegrOVp27GfvCpaD/4XYZtty4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/190] KVM: x86: hyperv: enforce vp_index < KVM_MAX_VCPUS
Date:   Fri, 13 Sep 2019 14:04:55 +0100
Message-Id: <20190913130602.935789529@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



