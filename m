Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56B9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7172054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155115;
	bh=/NAWNINs/ZiDm75cisGFvgmJKsZU/xvo8YA4eJU5IcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jWt9Yqp4Cu7TD2iSGUQiosFnBqf08mog+5t1BWw68BAS0H72zysvBD3H+XCpHvZXb
	 9ZxRZlu9EkUYwfrmTNXWieBFnSUlX4OWB2NLxPmPmvrfMhItJRghYJdhnEvBIjAqiN
	 EY2+pMt6tKPuuG9imJ6NJp25/GBB2TiNEN5xptIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbfGZPby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388547AbfGZPbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:31:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260D72054F;
        Fri, 26 Jul 2019 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155110;
        bh=/NAWNINs/ZiDm75cisGFvgmJKsZU/xvo8YA4eJU5IcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xLqEWaugJkR1JfKsW8Gmmae0hoSuDVBW7lKXCGuJYYfOReEbOJaQK9/sIMc9ZY5Oc
         0DLupe1gzvsN7A/B6773Qez1N+oQIbiNZA7zAI+n6CykFfieBR7H+Nl6YfBWHxluCA
         eQWtqyi2Cu724u/IUOxIjqrIifJVLFCClvkfA/H0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.1 57/62] KVM: nVMX: do not use dangling shadow VMCS after guest reset
Date:   Fri, 26 Jul 2019 17:25:09 +0200
Message-Id: <20190726152307.970639518@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 88dddc11a8d6b09201b4db9d255b3394d9bc9e57 upstream.

If a KVM guest is reset while running a nested guest, free_nested will
disable the shadow VMCS execution control in the vmcs01.  However,
on the next KVM_RUN vmx_vcpu_run would nevertheless try to sync
the VMCS12 to the shadow VMCS which has since been freed.

This causes a vmptrld of a NULL pointer on my machime, but Jan reports
the host to hang altogether.  Let's see how much this trivial patch fixes.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/nested.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -184,6 +184,7 @@ static void vmx_disable_shadow_vmcs(stru
 {
 	vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL, SECONDARY_EXEC_SHADOW_VMCS);
 	vmcs_write64(VMCS_LINK_POINTER, -1ull);
+	vmx->nested.need_vmcs12_sync = false;
 }
 
 static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
@@ -1328,6 +1329,9 @@ static void copy_shadow_to_vmcs12(struct
 	u64 field_value;
 	struct vmcs *shadow_vmcs = vmx->vmcs01.shadow_vmcs;
 
+	if (WARN_ON(!shadow_vmcs))
+		return;
+
 	preempt_disable();
 
 	vmcs_load(shadow_vmcs);
@@ -1366,6 +1370,9 @@ static void copy_vmcs12_to_shadow(struct
 	u64 field_value = 0;
 	struct vmcs *shadow_vmcs = vmx->vmcs01.shadow_vmcs;
 
+	if (WARN_ON(!shadow_vmcs))
+		return;
+
 	vmcs_load(shadow_vmcs);
 
 	for (q = 0; q < ARRAY_SIZE(fields); q++) {
@@ -4336,7 +4343,6 @@ static inline void nested_release_vmcs12
 		/* copy to memory all shadowed fields in case
 		   they were modified */
 		copy_shadow_to_vmcs12(vmx);
-		vmx->nested.need_vmcs12_sync = false;
 		vmx_disable_shadow_vmcs(vmx);
 	}
 	vmx->nested.posted_intr_nv = -1;


