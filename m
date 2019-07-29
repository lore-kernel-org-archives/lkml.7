Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A53C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421A1206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429097;
	bh=rzK8yFcGfbKCpoDsOUVJ4omD30vq1XPdn/iIvLzLvw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zYW8H1IB0jZdPpE2Yo5lPaM4JOMM0HQL5rneg8yenzD6DmwPwkIj87D4DbIsJl7Q5
	 +T+mGL1emxtjciv7Qkx6zEEgz+YqppOIEvml6tOOj6BEGZNubxzrbM7m5jr7cqUPgJ
	 7+JItlVHmnYXaFqGR0iv+Li2x1q1v05jAzMSCGK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfG2TiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388136AbfG2TiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:38:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C0E206DD;
        Mon, 29 Jul 2019 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429090;
        bh=rzK8yFcGfbKCpoDsOUVJ4omD30vq1XPdn/iIvLzLvw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAwncUoP3cJnIhnAcKy+uKBkNYlPGc7jVVQ1isK4SSkVuqAA67zQXLwEFudFxD2K2
         qf9hXi00xDIdQNr/V2qszEc16IK4XASGEAmz9Hoft9HIFvA4Pk2xORw8YeijpD9+2b
         NbDpMlaDwoaZg7TM3jQe7J/d5/3jy538uQAuaVCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 282/293] KVM: nVMX: do not use dangling shadow VMCS after guest reset
Date:   Mon, 29 Jul 2019 21:22:53 +0200
Message-Id: <20190729190845.859639288@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
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
 arch/x86/kvm/vmx.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7694,6 +7694,7 @@ static void vmx_disable_shadow_vmcs(stru
 {
 	vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL, SECONDARY_EXEC_SHADOW_VMCS);
 	vmcs_write64(VMCS_LINK_POINTER, -1ull);
+	vmx->nested.sync_shadow_vmcs = false;
 }
 
 static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
@@ -7705,7 +7706,6 @@ static inline void nested_release_vmcs12
 		/* copy to memory all shadowed fields in case
 		   they were modified */
 		copy_shadow_to_vmcs12(vmx);
-		vmx->nested.sync_shadow_vmcs = false;
 		vmx_disable_shadow_vmcs(vmx);
 	}
 	vmx->nested.posted_intr_nv = -1;
@@ -7891,6 +7891,9 @@ static void copy_shadow_to_vmcs12(struct
 	const unsigned long *fields = shadow_read_write_fields;
 	const int num_fields = max_shadow_read_write_fields;
 
+	if (WARN_ON(!shadow_vmcs))
+		return;
+
 	preempt_disable();
 
 	vmcs_load(shadow_vmcs);
@@ -7938,6 +7941,9 @@ static void copy_vmcs12_to_shadow(struct
 	u64 field_value = 0;
 	struct vmcs *shadow_vmcs = vmx->vmcs01.shadow_vmcs;
 
+	if (WARN_ON(!shadow_vmcs))
+		return;
+
 	vmcs_load(shadow_vmcs);
 
 	for (q = 0; q < ARRAY_SIZE(fields); q++) {


