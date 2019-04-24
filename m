Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4426CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1260D205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126665;
	bh=Js63P6283bQZ1GDzWnyHynaDhARSouKK6KxHoWOmuWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1j/0CTPPrULxx9L5gQ65nnOztijtXZYu7vM3FDkUYNaYRc9fZQ9NE84DLJTcpXZJH
	 fDLdCJhIMaQDKiBs2arN2Pj6vDwWeIuk51zeFCGjD9o+u0RXtj/xmdsynjTd4PyC/T
	 r7x+/RMT5IY7L6X9qlS4KMFVk85DCKt3Hz214VPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbfDXRYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389844AbfDXRYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:24:21 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8C512054F;
        Wed, 24 Apr 2019 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126660;
        bh=Js63P6283bQZ1GDzWnyHynaDhARSouKK6KxHoWOmuWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hl60v8dVAvajdZosfaDadj/jvcPWqcb0+QVlcN3CTgocRkTzmkUBJ136/HjlSLKR5
         51UeXmqQr2HMF+6yVd13Ijax9B8VDkyBd3Q6BNWfecrIxD+5wqsvx8vhaayuBaFi/Q
         b3R7PKtOh/ZgJg+08EMCq4nShj/HQQD4QPjuxvSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 17/44] KVM: x86: Dont clear EFER during SMM transitions for 32-bit vCPU
Date:   Wed, 24 Apr 2019 19:09:55 +0200
Message-Id: <20190424170851.949127745@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
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
@@ -2579,15 +2579,13 @@ static int em_rsm(struct x86_emulate_ctx
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
@@ -2601,13 +2599,16 @@ static int em_rsm(struct x86_emulate_ctx
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
 	if (emulator_has_longmode(ctxt))


