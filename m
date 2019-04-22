Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C641DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A83217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962280;
	bh=7jr2rVQ8BVU2S8eQ8euHS9gWs2uTkqHllr08uHkPquw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sc7c7sapIaEA/R+VQiMV9elWpS0BLqOsGgM1ZyjgxRquzHfgRsjeTJ3vxPjN/903H
	 LOE/NdBUgUxYgMzBZeVEBuq1/lufUOsyez7xdg7rXeHKv7Rt0N2upWQwh+xpRy/72J
	 WVWAEvKFEh9yIb7o7oCfPwhHny+5uS52R0UWQbw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfDVToj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729532AbfDVToh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD2B218D9;
        Mon, 22 Apr 2019 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962276;
        bh=7jr2rVQ8BVU2S8eQ8euHS9gWs2uTkqHllr08uHkPquw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvG8LecZJEtZC5tca6SpGEMQT3gnIKzFuUD00aLDis4F+AFZ98Dh2tHub46gakwxJ
         lNw6MpcqpHtJYaWWNnCdmxgFXpYyc9XP/2Jfy1H1n6LBUNejsANdJI6h26nXdOm1k4
         lGfrfTWmUN0WlDFkyyVfy5dhCx2rIRwtdx0rUBe0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 82/98] x86/kvm/hyper-v: avoid spurious pending stimer on vCPU init
Date:   Mon, 22 Apr 2019 15:41:49 -0400
Message-Id: <20190422194205.10404-82-sashal@kernel.org>
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

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 013cc6ebbf41496ce4badedd71ea6d4a6d198c14 ]

When userspace initializes guest vCPUs it may want to zero all supported
MSRs including Hyper-V related ones including HV_X64_MSR_STIMERn_CONFIG/
HV_X64_MSR_STIMERn_COUNT. With commit f3b138c5d89a ("kvm/x86: Update SynIC
timers on guest entry only") we began doing stimer_mark_pending()
unconditionally on every config change.

The issue I'm observing manifests itself as following:
- Qemu writes 0 to STIMERn_{CONFIG,COUNT} MSRs and marks all stimers as
  pending in stimer_pending_bitmap, arms KVM_REQ_HV_STIMER;
- kvm_hv_has_stimer_pending() starts returning true;
- kvm_vcpu_has_events() starts returning true;
- kvm_arch_vcpu_runnable() starts returning true;
- when kvm_arch_vcpu_ioctl_run() gets into
  (vcpu->arch.mp_state == KVM_MP_STATE_UNINITIALIZED) case:
  - kvm_vcpu_block() gets in 'kvm_vcpu_check_block(vcpu) < 0' and returns
    immediately, avoiding normal wait path;
  - -EAGAIN is returned from kvm_arch_vcpu_ioctl_run() immediately forcing
    userspace to retry.

So instead of normal wait path we get a busy loop on all secondary vCPUs
before they get INIT signal. This seems to be undesirable, especially given
that this happens even when Hyper-V extensions are not used.

Generally, it seems to be pointless to mark an stimer as pending in
stimer_pending_bitmap and arm KVM_REQ_HV_STIMER as the only thing
kvm_hv_process_stimers() will do is clear the corresponding bit. We may
just not mark disabled timers as pending instead.

Fixes: f3b138c5d89a ("kvm/x86: Update SynIC timers on guest entry only")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/x86/kvm/hyperv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 89d20ed1d2e8..371c669696d7 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -526,7 +526,9 @@ static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
 		new_config.enable = 0;
 	stimer->config.as_uint64 = new_config.as_uint64;
 
-	stimer_mark_pending(stimer, false);
+	if (stimer->config.enable)
+		stimer_mark_pending(stimer, false);
+
 	return 0;
 }
 
@@ -542,7 +544,10 @@ static int stimer_set_count(struct kvm_vcpu_hv_stimer *stimer, u64 count,
 		stimer->config.enable = 0;
 	else if (stimer->config.auto_enable)
 		stimer->config.enable = 1;
-	stimer_mark_pending(stimer, false);
+
+	if (stimer->config.enable)
+		stimer_mark_pending(stimer, false);
+
 	return 0;
 }
 
-- 
2.19.1

