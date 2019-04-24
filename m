Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84AAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B2121904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127337;
	bh=k8kZ/rdabEIaL6X3zj89Im8ZfKHj1V0Jp9gUE0tRMgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nqdHNpBYTF5wB9hZoJMiXHXBYid4BQtSZ2aMrPmTNVk3VcqvKfwUTO5jaWzFkLdk1
	 9Sx8Nx3h5JzAg+0iaPp34GuvvygQTKX5xpVmZB8bpmPQhTvkgQbJWqsVTB44bao1+u
	 duCJjW5QUxds4UEmIctzy+Dw3077RrsYdvS2YiwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391935AbfDXRfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391904AbfDXRfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:31 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BCC82054F;
        Wed, 24 Apr 2019 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127329;
        bh=k8kZ/rdabEIaL6X3zj89Im8ZfKHj1V0Jp9gUE0tRMgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fpvh/o34guTa8FMKRdoO4JzMYR+ypsFLAE0bticANix47lNAOJkJY7QmbCtkL8KHM
         F0kzkCo9zM5rXZXHr/qOBziWRWvEiZufSay4H0CKWsr4w2RUUnu48oAdMtS7Pzl1Ea
         OmNhcgBwZ0NKL5/PFY957rQNCAeSIE9DXUnbm5NQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 050/115] KVM: x86: Dont clear EFER during SMM transitions for 32-bit vCPU
Date:   Wed, 24 Apr 2019 19:09:46 +0200
Message-Id: <20190424170927.922593829@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 8f4dc2e77cdfaf7e644ef29693fa229db29ee1de upstream.

Neither AMD nor Intel CPUs have an EFER field in the legacy SMRAM save
state area, i.e. don't save/restore EFER across SMM transitions.  KVM
somewhat models this, e.g. doesn't clear EFER on entry to SMM if the
guest doesn't support long mode.  But during RSM, KVM unconditionally
clears EFER so that it can get back to pure 32-bit mode in order to
start loading CRs with their actual non-SMM values.

Clear EFER only when it will be written when loading the non-SMM state
so as to preserve bits that can theoretically be set on 32-bit vCPUs,
e.g. KVM always emulates EFER_SCE.

And because CR4.PAE is cleared only to play nice with EFER, wrap that
code in the long mode check as well.  Note, this may result in a
compiler warning about cr4 being consumed uninitialized.  Re-read CR4
even though it's technically unnecessary, as doing so allows for more
readable code and RSM emulation is not a performance critical path.

Fixes: 660a5d517aaab ("KVM: x86: save/load state on SMM switch")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/emulate.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2575,15 +2575,13 @@ static int em_rsm(struct x86_emulate_ctx
 	 * CR0/CR3/CR4/EFER.  It's all a bit more complicated if the vCPU
 	 * supports long mode.
 	 */
-	cr4 = ctxt->ops->get_cr(ctxt, 4);
 	if (emulator_has_longmode(ctxt)) {
 		struct desc_struct cs_desc;
 
 		/* Zero CR4.PCIDE before CR0.PG.  */
-		if (cr4 & X86_CR4_PCIDE) {
+		cr4 = ctxt->ops->get_cr(ctxt, 4);
+		if (cr4 & X86_CR4_PCIDE)
 			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
-			cr4 &= ~X86_CR4_PCIDE;
-		}
 
 		/* A 32-bit code segment is required to clear EFER.LMA.  */
 		memset(&cs_desc, 0, sizeof(cs_desc));
@@ -2597,13 +2595,16 @@ static int em_rsm(struct x86_emulate_ctx
 	if (cr0 & X86_CR0_PE)
 		ctxt->ops->set_cr(ctxt, 0, cr0 & ~(X86_CR0_PG | X86_CR0_PE));
 
-	/* Now clear CR4.PAE (which must be done before clearing EFER.LME).  */
-	if (cr4 & X86_CR4_PAE)
-		ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE);
-
-	/* And finally go back to 32-bit mode.  */
-	efer = 0;
-	ctxt->ops->set_msr(ctxt, MSR_EFER, efer);
+	if (emulator_has_longmode(ctxt)) {
+		/* Clear CR4.PAE before clearing EFER.LME. */
+		cr4 = ctxt->ops->get_cr(ctxt, 4);
+		if (cr4 & X86_CR4_PAE)
+			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE);
+
+		/* And finally go back to 32-bit mode.  */
+		efer = 0;
+		ctxt->ops->set_msr(ctxt, MSR_EFER, efer);
+	}
 
 	smbase = ctxt->ops->get_smbase(ctxt);
 


