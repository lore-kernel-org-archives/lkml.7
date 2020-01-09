Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2505C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD892072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWqJk9p3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgAIO6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:58:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55664 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731975AbgAIO56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lpz/17PtQ4/jo6RMA0hys9EClp6/SYcaGKe9OUWI9XM=;
        b=ZWqJk9p3j4Nqz+4yGezcqL56XcH58XPlGS992FG3eA9XNWp9rzYUiCHmBFikUEm2EtB0lS
        8Rc+frqxZrjYEoljLXjfppAsCHtNuY2RZj6n7wqT6YdmVZPT7pDKN2Nf0S1vArsTlqBLRU
        wA2KxK7dDPLMcndv6vrhPGsve6TxnPM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190--H-5RPCeOeOdfDSVLaseRA-1; Thu, 09 Jan 2020 09:57:56 -0500
X-MC-Unique: -H-5RPCeOeOdfDSVLaseRA-1
Received: by mail-qv1-f69.google.com with SMTP id e14so4273930qvr.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lpz/17PtQ4/jo6RMA0hys9EClp6/SYcaGKe9OUWI9XM=;
        b=Gqr83ETqDOWVTsQB95xzWw5Rg8y++3lNPdy33Y0nPqvld/OPbtc+acPnLG/KHFNPND
         DhveAcLfWjNIR+ra7vlnRJOyLNYe7f/M2aL9gmniNwOIsQMNUpgaVTmd4rKf5kvHH1V8
         MEnE8CHpItd+6HB6fujcq2HnTR3OKgip0jUOrm18JWO/3zdK0mFVmDL0AsLsSayTyFUS
         6kiJKhQVn3ZVAb1/Ln7I8v8Ppwc0HCcfLvKItw4KRylGj6HUsFjHgMdF45Obm2kV4Vqt
         GSxx5MmdMlDRoXB51vTD7JTWFrgln0hxBEdr2sJttg+I2DLXRd+pdVK/s0eGp1fiVw+K
         1Cpw==
X-Gm-Message-State: APjAAAUfqycHvsGn22rz844BWphC30J/LQpodfNS02zNg5M3ZyYOcOB+
        ZGMGoDl7DbqmKqV93hu/TIpkOwaPILZUbol3XP4Bs1t7vi1kBmMk9OrKNkPhC2jcFUuGEt8cq/+
        ySuOQn5dVVUrkuu+vx0o/3rPt
X-Received: by 2002:a37:c24b:: with SMTP id j11mr9504202qkm.57.1578581875658;
        Thu, 09 Jan 2020 06:57:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfkz13asTRa6kA2E83DYCU0f8pOkw4MCnJqXEqAOZ8Ss3NtGdYvm9Ysn6NhuOv0a4mxrMWfQ==
X-Received: by 2002:a37:c24b:: with SMTP id j11mr9504175qkm.57.1578581875412;
        Thu, 09 Jan 2020 06:57:55 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:57:54 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, peterx@redhat.com,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v3 08/21] KVM: X86: Drop x86_set_memory_region()
Date:   Thu,  9 Jan 2020 09:57:16 -0500
Message-Id: <20200109145729.32898-9-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper x86_set_memory_region() is only used in vmx_set_tss_addr()
and kvm_arch_destroy_vm().  Push the lock upper in both cases.  With
that, drop x86_set_memory_region().

This prepares to allow __x86_set_memory_region() to return a HVA
mapped, because the HVA will need to be protected by the lock too even
after __x86_set_memory_region() returns.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/vmx/vmx.c          |  7 +++++--
 arch/x86/kvm/x86.c              | 22 +++++++---------------
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 159a28512e4c..eb6673c7d2e3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1619,7 +1619,6 @@ void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu);
 int kvm_is_in_guest(void);
 
 int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size);
-int x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size);
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7add2fc8d8e9..7e3d370209e0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4482,8 +4482,11 @@ static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 	if (enable_unrestricted_guest)
 		return 0;
 
-	ret = x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, addr,
-				    PAGE_SIZE * 3);
+	mutex_lock(&kvm->slots_lock);
+	ret = __x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, addr,
+				      PAGE_SIZE * 3);
+	mutex_unlock(&kvm->slots_lock);
+
 	if (ret)
 		return ret;
 	to_kvm_vmx(kvm)->tss_addr = addr;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 93bbbce67a03..c4d3972dcd14 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9636,18 +9636,6 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
 }
 EXPORT_SYMBOL_GPL(__x86_set_memory_region);
 
-int x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
-{
-	int r;
-
-	mutex_lock(&kvm->slots_lock);
-	r = __x86_set_memory_region(kvm, id, gpa, size);
-	mutex_unlock(&kvm->slots_lock);
-
-	return r;
-}
-EXPORT_SYMBOL_GPL(x86_set_memory_region);
-
 void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 {
 	kvm_mmu_pre_destroy_vm(kvm);
@@ -9661,9 +9649,13 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		 * unless the the memory map has changed due to process exit
 		 * or fd copying.
 		 */
-		x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT, 0, 0);
-		x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT, 0, 0);
-		x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
+		mutex_lock(&kvm->slots_lock);
+		__x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
+					0, 0);
+		__x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
+					0, 0);
+		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
+		mutex_unlock(&kvm->slots_lock);
 	}
 	if (kvm_x86_ops->vm_destroy)
 		kvm_x86_ops->vm_destroy(kvm);
-- 
2.24.1

