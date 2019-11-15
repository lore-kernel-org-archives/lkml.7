Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66988C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2FB2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798971;
	bh=mkLJIs9ecrxNE7DnRoualZWks1FmwOQshK2BMx4ylBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n1izzol4ke1n+qT+xU7L3ALDTwaRlo/7fvMswnprNkO91ukUENCjtfPXLy+ZZAXhV
	 CfoyqaFFCQ6fjK8ltt6SwVYTqc7RdMe2PMdCp5LjhaKt2ZET+U5o1VNXALwYakXcxr
	 lW3GKSaPDk/LDqwhd+n74QMShJ1ZVy9oz2naWM54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfKOGWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbfKOGWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:22:47 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D90320740;
        Fri, 15 Nov 2019 06:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798966;
        bh=mkLJIs9ecrxNE7DnRoualZWks1FmwOQshK2BMx4ylBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GA/qNxovIkfj0z+lW5Gn/kYLYWrORilK167UQpqVnTqVo3fQ0k+W/btJMM+jgc0D4
         +JtzR/Lk7cV+Qad1T4V/99lmLaFN0CgsV37/OlgptIGymUQjlEvS5886GOtPsjH5gS
         S5zTNjpEeYBWuBKL9Zs9n/a2Pt8PoUYNycFG4Vvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 25/31] KVM: vmx, svm: always run with EFER.NXE=1 when shadow paging is active
Date:   Fri, 15 Nov 2019 14:20:54 +0800
Message-Id: <20191115062018.977683813@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
References: <20191115062009.813108457@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 9167ab79936206118cc60e47dcb926c3489f3bd5 upstream.

VMX already does so if the host has SMEP, in order to support the combination of
CR0.WP=1 and CR4.SMEP=1.  However, it is perfectly safe to always do so, and in
fact VMX already ends up running with EFER.NXE=1 on old processors that lack the
"load EFER" controls, because it may help avoiding a slow MSR write.  Removing
all the conditionals simplifies the code.

SVM does not have similar code, but it should since recent AMD processors do
support SMEP.  So this patch also makes the code for the two vendors more similar
while fixing NPT=0, CR0.WP=1 and CR4.SMEP=1 on AMD processors.

Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 4.9: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |   10 ++++++++--
 arch/x86/kvm/vmx.c |   14 +++-----------
 2 files changed, 11 insertions(+), 13 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -590,8 +590,14 @@ static int get_npt_level(void)
 static void svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	vcpu->arch.efer = efer;
-	if (!npt_enabled && !(efer & EFER_LMA))
-		efer &= ~EFER_LME;
+
+	if (!npt_enabled) {
+		/* Shadow paging assumes NX to be available.  */
+		efer |= EFER_NX;
+
+		if (!(efer & EFER_LMA))
+			efer &= ~EFER_LME;
+	}
 
 	to_svm(vcpu)->vmcb->save.efer = efer | EFER_SVME;
 	mark_dirty(to_svm(vcpu)->vmcb, VMCB_CR);
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2219,17 +2219,9 @@ static bool update_transition_efer(struc
 	u64 guest_efer = vmx->vcpu.arch.efer;
 	u64 ignore_bits = 0;
 
-	if (!enable_ept) {
-		/*
-		 * NX is needed to handle CR0.WP=1, CR4.SMEP=1.  Testing
-		 * host CPUID is more efficient than testing guest CPUID
-		 * or CR4.  Host SMEP is anyway a requirement for guest SMEP.
-		 */
-		if (boot_cpu_has(X86_FEATURE_SMEP))
-			guest_efer |= EFER_NX;
-		else if (!(guest_efer & EFER_NX))
-			ignore_bits |= EFER_NX;
-	}
+	/* Shadow paging assumes NX to be available.  */
+	if (!enable_ept)
+		guest_efer |= EFER_NX;
 
 	/*
 	 * LMA and LME handled by hardware; SCE meaningless outside long mode.


