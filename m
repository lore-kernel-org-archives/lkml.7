Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A48C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E54218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962284;
	bh=92cIZLzRdJ+R1hUq9Og/ly7udWBQBq7Lxs6dI+y0rNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I+GrpAZFu45VkoiKXpnWFdfTwxDO57ArJ+3zsM+3zJCeuEyUC5F36oQAosBjNy5+I
	 y+DJCfjod8qD7zkHPyRq2SUbpYkgRNHjgN8Tuexvvpe8baRBHb760GRWRkxfzRAPOU
	 Eh+aRL3695VrlcXvZnJuDK406keZpeZ59mY1wM0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfDVTon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbfDVTom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33880204EC;
        Mon, 22 Apr 2019 19:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962281;
        bh=92cIZLzRdJ+R1hUq9Og/ly7udWBQBq7Lxs6dI+y0rNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0uGv7QjQqzjjBO1HhIImZTImc/5wKLLnRfOgdCBk9SqUPGkcYjLmy3wGvYS32rxQ
         +rpG6ML2SOqWYXDgvZFguskrsijA2u8Yb/vB2tUBbG8NCUHFzdJIkpL1FGo3nMjSJU
         nuBoLui27G2OwNzBc1rn+lMmMQ7JRGPAFmsDAPpQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wei Huang <wei@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 83/98] KVM: selftests: assert on exit reason in CR4/cpuid sync test
Date:   Mon, 22 Apr 2019 15:41:50 -0400
Message-Id: <20190422194205.10404-83-sashal@kernel.org>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

[ Upstream commit 8df98ae0ab2ead9a02228756eec26f8d7b17f499 ]

...so that the test doesn't end up in an infinite loop if it fails for
whatever reason, e.g. SHUTDOWN due to gcc inserting stack canary code
into ucall() and attempting to derefence a null segment.

Fixes: ca359066889f7 ("kvm: selftests: add cr4_cpuid_sync_test")
Cc: Wei Huang <wei@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 .../kvm/x86_64/cr4_cpuid_sync_test.c          | 35 ++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index d503a51fad30..7c2c4d4055a8 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -87,22 +87,25 @@ int main(int argc, char *argv[])
 	while (1) {
 		rc = _vcpu_run(vm, VCPU_ID);
 
-		if (run->exit_reason == KVM_EXIT_IO) {
-			switch (get_ucall(vm, VCPU_ID, &uc)) {
-			case UCALL_SYNC:
-				/* emulate hypervisor clearing CR4.OSXSAVE */
-				vcpu_sregs_get(vm, VCPU_ID, &sregs);
-				sregs.cr4 &= ~X86_CR4_OSXSAVE;
-				vcpu_sregs_set(vm, VCPU_ID, &sregs);
-				break;
-			case UCALL_ABORT:
-				TEST_ASSERT(false, "Guest CR4 bit (OSXSAVE) unsynchronized with CPUID bit.");
-				break;
-			case UCALL_DONE:
-				goto done;
-			default:
-				TEST_ASSERT(false, "Unknown ucall 0x%x.", uc.cmd);
-			}
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+			    "Unexpected exit reason: %u (%s),\n",
+			    run->exit_reason,
+			    exit_reason_str(run->exit_reason));
+
+		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		case UCALL_SYNC:
+			/* emulate hypervisor clearing CR4.OSXSAVE */
+			vcpu_sregs_get(vm, VCPU_ID, &sregs);
+			sregs.cr4 &= ~X86_CR4_OSXSAVE;
+			vcpu_sregs_set(vm, VCPU_ID, &sregs);
+			break;
+		case UCALL_ABORT:
+			TEST_ASSERT(false, "Guest CR4 bit (OSXSAVE) unsynchronized with CPUID bit.");
+			break;
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_ASSERT(false, "Unknown ucall 0x%x.", uc.cmd);
 		}
 	}
 
-- 
2.19.1

