Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0D8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5883920651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356378;
	bh=m27+std3nGEjoEfWY8130YdlrwBcOKx0ogHcBRyzlwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nHJzP349Y5D8oFAm4FEZFe47oeV9v6/t4+8IgeH4dMVyx0H2m6p3sLjH5wsWs3QAO
	 fTIbrSVF6cSm2n2oLneTojqOmB8qpG5qn6OjnJEPjkk7cJ4kRIIPat6CJuz4xK1O5o
	 ggS0v/Y4poi6t2y7TYoKeXyltFionXOHUE9NYhwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfDOT0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbfDOTEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CB22218D3;
        Mon, 15 Apr 2019 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355090;
        bh=m27+std3nGEjoEfWY8130YdlrwBcOKx0ogHcBRyzlwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpXMYi2vb+wPW5Boec40JcaAB1xPpkkNwx3RX+ObG1koqjmVEJQsc5YGZ3dPra7Uj
         QxndVc011sOBDq8Irg2LyvYrkfX+v+w1Cbx+3oX76EqERS7x01JuRQEWY9WEsXPSI+
         qW9vf0WDPEQS+VVQO/UcSXnPfS+aoLj5uiB0FjuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 001/101] kvm: nVMX: NMI-window and interrupt-window exiting should wake L2 from HLT
Date:   Mon, 15 Apr 2019 20:57:59 +0200
Message-Id: <20190415183740.416561639@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9ebdfe5230f2e50e3ba05c57723a06e90946815a ]

According to the SDM, "NMI-window exiting" VM-exits wake a logical
processor from the same inactive states as would an NMI and
"interrupt-window exiting" VM-exits wake a logical processor from the
same inactive states as would an external interrupt. Specifically, they
wake a logical processor from the shutdown state and from the states
entered using the HLT and MWAIT instructions.

Fixes: 6dfacadd5858 ("KVM: nVMX: Add support for activity state HLT")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
[Squashed comments of two Jim's patches and used the simplified code
 hunk provided by Sean. - Radim]
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f99f59625da5..e61ac229a6c1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12836,11 +12836,15 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	nested_cache_shadow_vmcs12(vcpu, vmcs12);
 
 	/*
-	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be woken
-	 * by event injection, halt vcpu.
+	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be
+	 * awakened by event injection or by an NMI-window VM-exit or
+	 * by an interrupt-window VM-exit, halt the vcpu.
 	 */
 	if ((vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) &&
-	    !(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK)) {
+	    !(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK) &&
+	    !(vmcs12->cpu_based_vm_exec_control & CPU_BASED_VIRTUAL_NMI_PENDING) &&
+	    !((vmcs12->cpu_based_vm_exec_control & CPU_BASED_VIRTUAL_INTR_PENDING) &&
+	      (vmcs12->guest_rflags & X86_EFLAGS_IF))) {
 		vmx->nested.nested_run_pending = 0;
 		return kvm_vcpu_halt(vcpu);
 	}
-- 
2.19.1



