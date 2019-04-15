Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A8C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C74820880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355366;
	bh=ZPfbinaIDSBXj26kC+wKkpVdB2e8FkA6XhD9b6yiN04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sz9XYZXk5jg1ZFv/+r5/2VmvVw6xtSCj/gQdHuErRImKvMcD0Sh4hMU2HRtA7jgrU
	 ks35bX/DNmpNmXdGJ0sHfoo0r/d1ppe3TgS2pBo03fvU39bg6595Q+YnFknXw1PTHh
	 G+mt1LMt2kABUdBRcSygspaE38Fuqb5xBcaf1O/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfDOTJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbfDOTJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B92D9218D3;
        Mon, 15 Apr 2019 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355361;
        bh=ZPfbinaIDSBXj26kC+wKkpVdB2e8FkA6XhD9b6yiN04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZanAqjPdbwkoDMGLExRAhbKb8Uctx+c3c/NUw5MIMdtD82rRMc1oXQACvCPj6KwVD
         F1YE5CN5BDyWYBsaEd7zLhK/kmbKD/NIt6DKqNrf/T2qGcz7olAupaRXoLMVSah80B
         X/9xtE0F0zatEWwAbd+HnQosTDGtq9VP1yqRiKtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Orr <marcorr@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 101/101] KVM: x86: nVMX: fix x2APIC VTPR read intercept
Date:   Mon, 15 Apr 2019 20:59:39 +0200
Message-Id: <20190415183745.696894660@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Orr <marcorr@google.com>

commit c73f4c998e1fd4249b9edfa39e23f4fda2b9b041 upstream.

Referring to the "VIRTUALIZING MSR-BASED APIC ACCESSES" chapter of the
SDM, when "virtualize x2APIC mode" is 1 and "APIC-register
virtualization" is 0, a RDMSR of 808H should return the VTPR from the
virtual APIC page.

However, for nested, KVM currently fails to disable the read intercept
for this MSR. This means that a RDMSR exit takes precedence over
"virtualize x2APIC mode", and KVM passes through L1's TPR to L2,
instead of sourcing the value from L2's virtual APIC page.

This patch fixes the issue by disabling the read intercept, in VMCS02,
for the VTPR when "APIC-register virtualization" is 0.

The issue described above and fix prescribed here, were verified with
a related patch in kvm-unit-tests titled "Test VMX's virtualize x2APIC
mode w/ nested".

Signed-off-by: Marc Orr <marcorr@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Fixes: c992384bde84f ("KVM: vmx: speed up MSR bitmap merge")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11660,7 +11660,7 @@ static inline bool nested_vmx_prepare_ms
 		nested_vmx_disable_intercept_for_msr(
 			msr_bitmap_l1, msr_bitmap_l0,
 			X2APIC_MSR(APIC_TASKPRI),
-			MSR_TYPE_W);
+			MSR_TYPE_R | MSR_TYPE_W);
 
 		if (nested_cpu_has_vid(vmcs12)) {
 			nested_vmx_disable_intercept_for_msr(


