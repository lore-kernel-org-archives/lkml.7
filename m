Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8483C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC41206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfFMP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbfFMLfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:35:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32CB26EB81;
        Thu, 13 Jun 2019 11:35:06 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EBAC60FAB;
        Thu, 13 Jun 2019 11:35:04 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] KVM: nVMX: use correct clean fields when copying from eVMCS
Date:   Thu, 13 Jun 2019 13:35:02 +0200
Message-Id: <20190613113502.9535-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Jun 2019 11:35:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, a couple of mistakes were made while implementing
Enlightened VMCS support, in particular, wrong clean fields were
used in copy_enlightened_to_vmcs12():
- exception_bitmap is covered by CONTROL_EXCPN;
- vm_exit_controls/pin_based_vm_exec_control/secondary_vm_exec_control
  are covered by CONTROL_GRP1.

Fixes: 945679e301ea0 ("KVM: nVMX: add enlightened VMCS state")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1032f068f0b9..d3940da3d435 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1397,7 +1397,7 @@ static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
 	}
 
 	if (unlikely(!(evmcs->hv_clean_fields &
-		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC))) {
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EXCPN))) {
 		vmcs12->exception_bitmap = evmcs->exception_bitmap;
 	}
 
@@ -1437,7 +1437,7 @@ static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
 	}
 
 	if (unlikely(!(evmcs->hv_clean_fields &
-		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1))) {
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1))) {
 		vmcs12->pin_based_vm_exec_control =
 			evmcs->pin_based_vm_exec_control;
 		vmcs12->vm_exit_controls = evmcs->vm_exit_controls;
-- 
2.20.1

