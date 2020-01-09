Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B61C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CA32072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHC4BRtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgAIO6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:58:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21915 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731990AbgAIO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4C6ZGVemG6J37mDpNjuVXzVMZmBhm9r1bGAW/2NgwDc=;
        b=EHC4BRtEb1v9CRxe9Qslmw8XV8vF8vldfKwD2wc37WVygz8142RC7i1Ta5a85CCKblC4G8
        p/LIotaPI9g/cXTnFXuRwUH7rgFwu9m0H7eFqqM3Te3xO6id0+unKmBxxq278UeD4MoVLx
        7Um1VHrLUDbepvUzW6cQ3h7sJYDJzlI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-r-R1ppx5MAejlrnF5L14Fw-1; Thu, 09 Jan 2020 09:57:58 -0500
X-MC-Unique: r-R1ppx5MAejlrnF5L14Fw-1
Received: by mail-qt1-f197.google.com with SMTP id d9so4341009qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4C6ZGVemG6J37mDpNjuVXzVMZmBhm9r1bGAW/2NgwDc=;
        b=USLfSGTi2GCaYDtytRSTTmYtsiQB7+81AlpBoOqD3B1rDA1n47ehBfj4h8sokMjT/A
         wJgeKU6Vb2CIfGKbC22g7UCO+zthSLpGMiuPRnxUxOJ6XBYfLvNGEja/uQjakmL/OEmn
         DrNeshUpbSjmN1/ijFHgJ8o/UqFNXylHRjdxihf14GuqMRX5tLePxBkwemJVwHLEMISh
         xq1vwQf75f4YlaKWItbh9fmRQUUJOVXb38IVZ9tznbzdY0P/1bUGx6PCbe+IahjkIcX3
         XrL03Jaeb+Vag3Nhtug7QgkAvh4XUmKcrOnFVOM1YjNPIoNhXdVn7pNs1fedsusXkApR
         P/nA==
X-Gm-Message-State: APjAAAWmNy/bETSiqH02IapAuwydNXk9cbUOtrXDDwJ3YlZyS8TCe+gn
        4ba890nLD7DHUVwQgC/mg6aJ3Q5DbxwqWrXg0xJhFWU0bfe6G37QH6Pov0pnc/AtYDN248suQfo
        kEyA0oQWB5y/WWzuPp800PbGl
X-Received: by 2002:aed:3f32:: with SMTP id p47mr8522007qtf.374.1578581878243;
        Thu, 09 Jan 2020 06:57:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzlM1ry2WKKrMYHxQEBp9Y5kFIrXOvo1VCZxj91TgHWTVd0cvi099C4YRjI1OhvTkYkH7/USw==
X-Received: by 2002:aed:3f32:: with SMTP id p47mr8521977qtf.374.1578581877922;
        Thu, 09 Jan 2020 06:57:57 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:57:56 -0800 (PST)
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
Subject: [PATCH v3 09/21] KVM: X86: Don't track dirty for KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Date:   Thu,  9 Jan 2020 09:57:17 -0500
Message-Id: <20200109145729.32898-10-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, we have three code paths that can dirty a page without
vcpu context for X86:

  - init_rmode_identity_map
  - init_rmode_tss
  - kvmgt_rw_gpa

init_rmode_identity_map and init_rmode_tss will be setup on
destination VM no matter what (and the guest cannot even see them), so
it does not make sense to track them at all.

To do this, allow __x86_set_memory_region() to return the userspace
address that just allocated to the caller.  Then in both of the
functions we directly write to the userspace address instead of
calling kvm_write_*() APIs.  We need to make sure that we have the
slots_lock held when accessing the userspace address.

Another trivial change is that we don't need to explicitly clear the
identity page table root in init_rmode_identity_map() because no
matter what we'll write to the whole page with 4M huge page entries.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +-
 arch/x86/kvm/svm.c              |  3 +-
 arch/x86/kvm/vmx/vmx.c          | 68 ++++++++++++++++-----------------
 arch/x86/kvm/x86.c              | 18 +++++++--
 4 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index eb6673c7d2e3..f536d139b3d2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1618,7 +1618,8 @@ void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu);
 
 int kvm_is_in_guest(void);
 
-int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size);
+int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size,
+			    unsigned long *uaddr);
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 8f1b715dfde8..03a344ce7b66 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1698,7 +1698,8 @@ static int avic_init_access_page(struct kvm_vcpu *vcpu)
 	ret = __x86_set_memory_region(kvm,
 				      APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
 				      APIC_DEFAULT_PHYS_BASE,
-				      PAGE_SIZE);
+				      PAGE_SIZE,
+				      NULL);
 	if (ret)
 		goto out;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7e3d370209e0..62175a246bcc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3441,34 +3441,28 @@ static bool guest_state_valid(struct kvm_vcpu *vcpu)
 	return true;
 }
 
-static int init_rmode_tss(struct kvm *kvm)
+static int init_rmode_tss(struct kvm *kvm, unsigned long *uaddr)
 {
-	gfn_t fn;
+	const void *zero_page = (const void *) __va(page_to_phys(ZERO_PAGE(0)));
 	u16 data = 0;
 	int idx, r;
 
-	idx = srcu_read_lock(&kvm->srcu);
-	fn = to_kvm_vmx(kvm)->tss_addr >> PAGE_SHIFT;
-	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
-	if (r < 0)
-		goto out;
+	for (idx = 0; idx < 3; idx++) {
+		r = __copy_to_user((void __user *)uaddr + PAGE_SIZE * idx,
+				   zero_page, PAGE_SIZE);
+		if (r)
+			return -EFAULT;
+	}
+
 	data = TSS_BASE_SIZE + TSS_REDIRECTION_SIZE;
-	r = kvm_write_guest_page(kvm, fn++, &data,
-			TSS_IOPB_BASE_OFFSET, sizeof(u16));
-	if (r < 0)
-		goto out;
-	r = kvm_clear_guest_page(kvm, fn++, 0, PAGE_SIZE);
-	if (r < 0)
-		goto out;
-	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
-	if (r < 0)
-		goto out;
+	r = __copy_to_user((void __user *)uaddr + TSS_IOPB_BASE_OFFSET,
+			   &data, sizeof(data));
+	if (r)
+		return -EFAULT;
+
 	data = ~0;
-	r = kvm_write_guest_page(kvm, fn, &data,
-				 RMODE_TSS_SIZE - 2 * PAGE_SIZE - 1,
-				 sizeof(u8));
-out:
-	srcu_read_unlock(&kvm->srcu, idx);
+	r = __copy_to_user((void __user *)uaddr - 1, &data, sizeof(data));
+
 	return r;
 }
 
@@ -3478,6 +3472,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	int i, r = 0;
 	kvm_pfn_t identity_map_pfn;
 	u32 tmp;
+	unsigned long *uaddr = NULL;
 
 	/* Protect kvm_vmx->ept_identity_pagetable_done. */
 	mutex_lock(&kvm->slots_lock);
@@ -3490,21 +3485,21 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	identity_map_pfn = kvm_vmx->ept_identity_map_addr >> PAGE_SHIFT;
 
 	r = __x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
-				    kvm_vmx->ept_identity_map_addr, PAGE_SIZE);
+				    kvm_vmx->ept_identity_map_addr, PAGE_SIZE,
+				    uaddr);
 	if (r < 0)
 		goto out;
 
-	r = kvm_clear_guest_page(kvm, identity_map_pfn, 0, PAGE_SIZE);
-	if (r < 0)
-		goto out;
 	/* Set up identity-mapping pagetable for EPT in real mode */
 	for (i = 0; i < PT32_ENT_PER_PAGE; i++) {
 		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
-		r = kvm_write_guest_page(kvm, identity_map_pfn,
-				&tmp, i * sizeof(tmp), sizeof(tmp));
-		if (r < 0)
+		r = __copy_to_user((void __user *)uaddr + i * sizeof(tmp),
+				   &tmp, sizeof(tmp));
+		if (r) {
+			r = -EFAULT;
 			goto out;
+		}
 	}
 	kvm_vmx->ept_identity_pagetable_done = true;
 
@@ -3537,7 +3532,7 @@ static int alloc_apic_access_page(struct kvm *kvm)
 	if (kvm->arch.apic_access_page_done)
 		goto out;
 	r = __x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
-				    APIC_DEFAULT_PHYS_BASE, PAGE_SIZE);
+				    APIC_DEFAULT_PHYS_BASE, PAGE_SIZE, NULL);
 	if (r)
 		goto out;
 
@@ -4478,19 +4473,22 @@ static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
 static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 {
 	int ret;
+	unsigned long *uaddr = NULL;
 
 	if (enable_unrestricted_guest)
 		return 0;
 
 	mutex_lock(&kvm->slots_lock);
 	ret = __x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, addr,
-				      PAGE_SIZE * 3);
-	mutex_unlock(&kvm->slots_lock);
-
+				      PAGE_SIZE * 3, uaddr);
 	if (ret)
-		return ret;
+		goto out;
+
 	to_kvm_vmx(kvm)->tss_addr = addr;
-	return init_rmode_tss(kvm);
+	ret = init_rmode_tss(kvm, uaddr);
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return ret;
 }
 
 static int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c4d3972dcd14..ff97782b3919 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9584,7 +9584,15 @@ void kvm_arch_sync_events(struct kvm *kvm)
 	kvm_free_pit(kvm);
 }
 
-int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
+/*
+ * If `uaddr' is specified, `*uaddr' will be returned with the
+ * userspace address that was just allocated.  `uaddr' is only
+ * meaningful if the function returns zero, and `uaddr' will only be
+ * valid when with either the slots_lock or with the SRCU read lock
+ * held.  After we release the lock, the returned `uaddr' will be invalid.
+ */
+int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size,
+			    unsigned long *uaddr)
 {
 	int i, r;
 	unsigned long hva;
@@ -9608,6 +9616,8 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
 			      MAP_SHARED | MAP_ANONYMOUS, 0);
 		if (IS_ERR((void *)hva))
 			return PTR_ERR((void *)hva);
+		if (uaddr)
+			*uaddr = hva;
 	} else {
 		if (!slot->npages)
 			return 0;
@@ -9651,10 +9661,10 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		 */
 		mutex_lock(&kvm->slots_lock);
 		__x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
-					0, 0);
+					0, 0, NULL);
 		__x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
-					0, 0);
-		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
+					0, 0, NULL);
+		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0, NULL);
 		mutex_unlock(&kvm->slots_lock);
 	}
 	if (kvm_x86_ops->vm_destroy)
-- 
2.24.1

