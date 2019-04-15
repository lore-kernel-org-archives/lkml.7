Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E1EC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378762075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355698;
	bh=LPYxgzrjn3gUx1Pjhl0CVwF+Ip40X+EZsm37eXdbZow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X1Bxe9c7H6YQzAS4xkzrzFBxEwHspZ/SiRWoqYiMBRm9aoLZO4mBel4R7ZKWH5Uea
	 jHh4fp5+1Ce7dxkar+SKo7TsTO5nZNu0I6Q0e1NRWtPn8cEE9GFhC2iCcOHzVz1o3Q
	 0D4k2JE9ppLNUDN/juQ9mrYExawUOfGfPOd3CsnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfDOTO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731765AbfDOTOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B9D2075B;
        Mon, 15 Apr 2019 19:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355672;
        bh=LPYxgzrjn3gUx1Pjhl0CVwF+Ip40X+EZsm37eXdbZow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ft+7RJjBX4wcipEroowCQHYbXRbBa8ld2k5psVKUO6cRd9Q479zyFC0iMYyeWC4rf
         /tpYS+EUNOA+hF6UcvfP0L+4Ewj07USyDQKB2buUqz6qB4aX7PYQVccKTBcyT2aEID
         KAmEOLyfHYa5+Qdd0KU7lLDVx+HX8B5j3BQLGJXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Orr <marcorr@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 116/117] KVM: x86: nVMX: fix x2APIC VTPR read intercept
Date:   Mon, 15 Apr 2019 21:01:26 +0200
Message-Id: <20190415183750.654071873@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
 arch/x86/kvm/vmx/nested.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -578,7 +578,7 @@ static inline bool nested_vmx_prepare_ms
 		nested_vmx_disable_intercept_for_msr(
 			msr_bitmap_l1, msr_bitmap_l0,
 			X2APIC_MSR(APIC_TASKPRI),
-			MSR_TYPE_W);
+			MSR_TYPE_R | MSR_TYPE_W);
 
 		if (nested_cpu_has_vid(vmcs12)) {
 			nested_vmx_disable_intercept_for_msr(


