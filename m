Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC2DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7248321874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103013;
	bh=vkDsvW6YxEClSTHDUNfXZoqYbz0eXMOBlKudZDeaniU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oEARf/DPVmirIYSZSGHRreffyDRHLx124opQyRcNO0Cohn/pSRtRZ42jhtQcPtzuS
	 +guAYLx5AWNE4QbqISvqsgfBLwMq41vRFR1qlOvqhiAF5gjQOY9eqN5GlzaQOXpNT8
	 etEiuVzKKNcomebbSYhvlIO18gVxl6WfUZg9bCDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfH2SQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729845AbfH2SQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42F102189D;
        Thu, 29 Aug 2019 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102603;
        bh=vkDsvW6YxEClSTHDUNfXZoqYbz0eXMOBlKudZDeaniU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2NbKBQZzazUM/CoAfpQJnWhzfUnF6cFc8BekaptQ/ruevqncmyPVBUTYQYGFGUAmJ
         CIeTWePufwXXoylY1akaQV0rbHArKmWfBLEMi28nNS89nLDLhqTmmmAXWB3JbzrPV6
         eDPG7e4gOBb50u3Z9Eya0KLUJVCPJ/bOZIi7SqaI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 38/45] selftests: kvm: fix state save/load on processors without XSAVE
Date:   Thu, 29 Aug 2019 14:15:38 -0400
Message-Id: <20190829181547.8280-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 54577e5018a8c0cb79c9a0fa118a55c68715d398 ]

state_test and smm_test are failing on older processors that do not
have xcr0.  This is because on those processor KVM does provide
support for KVM_GET/SET_XSAVE (to avoid having to rely on the older
KVM_GET/SET_FPU) but not for KVM_GET/SET_XCRS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/lib/x86.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86.c b/tools/testing/selftests/kvm/lib/x86.c
index a3122f1949a8e..4d35eba73dc97 100644
--- a/tools/testing/selftests/kvm/lib/x86.c
+++ b/tools/testing/selftests/kvm/lib/x86.c
@@ -809,9 +809,11 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
         TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_XSAVE, r: %i",
                 r);
 
-	r = ioctl(vcpu->fd, KVM_GET_XCRS, &state->xcrs);
-        TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_XCRS, r: %i",
-                r);
+	if (kvm_check_cap(KVM_CAP_XCRS)) {
+		r = ioctl(vcpu->fd, KVM_GET_XCRS, &state->xcrs);
+		TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_XCRS, r: %i",
+			    r);
+	}
 
 	r = ioctl(vcpu->fd, KVM_GET_SREGS, &state->sregs);
         TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_SREGS, r: %i",
@@ -858,9 +860,11 @@ void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *s
         TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_XSAVE, r: %i",
                 r);
 
-	r = ioctl(vcpu->fd, KVM_SET_XCRS, &state->xcrs);
-        TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_XCRS, r: %i",
-                r);
+	if (kvm_check_cap(KVM_CAP_XCRS)) {
+		r = ioctl(vcpu->fd, KVM_SET_XCRS, &state->xcrs);
+		TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_XCRS, r: %i",
+			    r);
+	}
 
 	r = ioctl(vcpu->fd, KVM_SET_SREGS, &state->sregs);
         TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_SREGS, r: %i",
-- 
2.20.1

