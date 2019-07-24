Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EABC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2093A214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998335;
	bh=B5lV7H+VYdRscgK66XEcHYrTZuvSYkuM/YfZm2Pz5GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xfBsS3DHs7fyiqB/OCePFuLasHpiQvpq9/etZD8SgXlhGNSVGF81PuzUq+b9JLLX1
	 OrrhMN/21u5DP0IPyj2+sIVl8YP8ZIkIuI+3wpzJGycYA6QT5x4eM7mNGXwRD2FQg/
	 di0+lZhrSuXLIEWGSEOPO8I9/Vwy9Umn1xPBNc3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405042AbfGXT6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404614AbfGXT6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:58:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3CB22ADC;
        Wed, 24 Jul 2019 19:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998324;
        bh=B5lV7H+VYdRscgK66XEcHYrTZuvSYkuM/YfZm2Pz5GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOTim199QQT4rd1vyivsEWNYyYyvWPXov3ayabU1cd5UKJwJSePeH/vOKOy1tdnGe
         aE5po0WKzr31PUpvbTklOYygn8AoHTXd7II10+Lw9K1UqIlLFipKei9yYlzqWx0Gx7
         Jl78Vdlh3bJ1i62xc+FP73NtQX2IqgAxGmYh8Jzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.1 299/371] KVM: nVMX: Always sync GUEST_BNDCFGS when it comes from vmcs01
Date:   Wed, 24 Jul 2019 21:20:51 +0200
Message-Id: <20190724191746.796720364@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 3b013a2972d5bc344d6eaa8f24fdfe268211e45f upstream.

If L1 does not set VM_ENTRY_LOAD_BNDCFGS, then L1's BNDCFGS value must
be propagated to vmcs02 since KVM always runs with VM_ENTRY_LOAD_BNDCFGS
when MPX is supported.  Because the value effectively comes from vmcs01,
vmcs02 must be updated even if vmcs12 is clean.

Fixes: 62cf9bd8118c4 ("KVM: nVMX: Fix emulation of VM_ENTRY_LOAD_BNDCFGS")
Cc: stable@vger.kernel.org
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/nested.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2243,13 +2243,9 @@ static void prepare_vmcs02_full(struct v
 
 	set_cr4_guest_host_mask(vmx);
 
-	if (kvm_mpx_supported()) {
-		if (vmx->nested.nested_run_pending &&
-			(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
-			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
-		else
-			vmcs_write64(GUEST_BNDCFGS, vmx->nested.vmcs01_guest_bndcfgs);
-	}
+	if (kvm_mpx_supported() && vmx->nested.nested_run_pending &&
+	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
+		vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
 }
 
 /*
@@ -2292,6 +2288,9 @@ static int prepare_vmcs02(struct kvm_vcp
 		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.vmcs01_debugctl);
 	}
+	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
+	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
+		vmcs_write64(GUEST_BNDCFGS, vmx->nested.vmcs01_guest_bndcfgs);
 	vmx_set_rflags(vcpu, vmcs12->guest_rflags);
 
 	/* EXCEPTION_BITMAP and CR0_GUEST_HOST_MASK should basically be the


