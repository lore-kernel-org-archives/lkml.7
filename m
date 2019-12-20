Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93505C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677492146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ms9ETk0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfLTVQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:16:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58549 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727580AbfLTVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576876603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQjPBgffYJmUdXwhQa7UpTs/UC7BUPavY9NeRZmBhog=;
        b=Ms9ETk0DtHstc6oAa8gnPImbt6V8Zxi6nhB6sjsUF5/Br4mbXq4F3ibFPxQwl8WG4aNdvd
        AHjOKzdIrv8AlZkVekxZNBs/gEADTdfYJjNdOxfSD0EOGwudw2jg28sVX+OHrQ8TSAFrDO
        Vp+/+Vf9WyNo8AIkhL076fOGV1TNjPw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-PAVwBwm-Nh2IzM28SJPGyg-1; Fri, 20 Dec 2019 16:16:42 -0500
X-MC-Unique: PAVwBwm-Nh2IzM28SJPGyg-1
Received: by mail-qv1-f69.google.com with SMTP id di5so1687418qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQjPBgffYJmUdXwhQa7UpTs/UC7BUPavY9NeRZmBhog=;
        b=KXiJ9YVMcVviNevc2MGxgDQYSxVtAfBGSZyi7a2S544Df7/xl00n4oj9+0BQcD0tCf
         Gjk08WX1Pbc12n/YMI5G7B1oAcOhSAoaNOHqDHKEyymfXlxihr4oRA/8HsQHqwLN8id4
         i6ltidOFCzL4mGWS+S/IOMuHTkKVjWembXzaH0uSeuVa7lU+K7OLOBEcVxV1G4cqaP9Y
         6l69YKRQhgb+W1VzZaE9cnxb1TtHFOfLLyfvpaGJGcJL74kE+6fDopA5qRDHzbUTJHsq
         0GXdDCAnFztN2NzESBnMyFJlwvrdgGra8hvz1LVZr66aJX9LXQ3COLi7Bu15sjQO6ddo
         WE1A==
X-Gm-Message-State: APjAAAWxI42owNNHA2LubmXdn+vk8UledmUu8q0ruBmR+h8aTUNwg1NM
        YVlTNFOAQocErTSpbl+Z6n1KOFW3MbE+5KtUGDwhw/oMnhjJoeeEUkHOjpb0gYjWZsWtW+0ueSk
        ryKdrKlM49FtSfa5PUJP8n169
X-Received: by 2002:ac8:5156:: with SMTP id h22mr13290487qtn.290.1576876602232;
        Fri, 20 Dec 2019 13:16:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJXHzeoOlhlvKFll19FXnbdmNOPE0rw1Pf9S2sFsM90/BGgSjXHMrjQKLJZOPNjX8gExcc4A==
X-Received: by 2002:ac8:5156:: with SMTP id h22mr13290474qtn.290.1576876601947;
        Fri, 20 Dec 2019 13:16:41 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id d25sm3385231qtq.11.2019.12.20.13.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:16:41 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v2 03/17] KVM: X86: Don't track dirty for KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Date:   Fri, 20 Dec 2019 16:16:20 -0500
Message-Id: <20191220211634.51231-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220211634.51231-1-peterx@redhat.com>
References: <20191220211634.51231-1-peterx@redhat.com>
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

To do this, a new parameter is added to kvm_[write|clear]_guest_page()
to show whether we would like to track dirty bits for the operations.
With that, pass in "false" to this new parameter for any guest memory
write of the ioctls (KVM_SET_TSS_ADDR, KVM_SET_IDENTITY_MAP_ADDR).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c   | 18 ++++++++++--------
 include/linux/kvm_host.h |  5 +++--
 virt/kvm/kvm_main.c      | 25 ++++++++++++++++---------
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 04a8212704c1..1ff5a428f489 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3452,24 +3452,24 @@ static int init_rmode_tss(struct kvm *kvm)
 
 	idx = srcu_read_lock(&kvm->srcu);
 	fn = to_kvm_vmx(kvm)->tss_addr >> PAGE_SHIFT;
-	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
+	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE, false);
 	if (r < 0)
 		goto out;
 	data = TSS_BASE_SIZE + TSS_REDIRECTION_SIZE;
 	r = kvm_write_guest_page(kvm, fn++, &data,
-			TSS_IOPB_BASE_OFFSET, sizeof(u16));
+				 TSS_IOPB_BASE_OFFSET, sizeof(u16), false);
 	if (r < 0)
 		goto out;
-	r = kvm_clear_guest_page(kvm, fn++, 0, PAGE_SIZE);
+	r = kvm_clear_guest_page(kvm, fn++, 0, PAGE_SIZE, false);
 	if (r < 0)
 		goto out;
-	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
+	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE, false);
 	if (r < 0)
 		goto out;
 	data = ~0;
 	r = kvm_write_guest_page(kvm, fn, &data,
 				 RMODE_TSS_SIZE - 2 * PAGE_SIZE - 1,
-				 sizeof(u8));
+				 sizeof(u8), false);
 out:
 	srcu_read_unlock(&kvm->srcu, idx);
 	return r;
@@ -3498,7 +3498,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 		goto out2;
 
 	idx = srcu_read_lock(&kvm->srcu);
-	r = kvm_clear_guest_page(kvm, identity_map_pfn, 0, PAGE_SIZE);
+	r = kvm_clear_guest_page(kvm, identity_map_pfn, 0, PAGE_SIZE, false);
 	if (r < 0)
 		goto out;
 	/* Set up identity-mapping pagetable for EPT in real mode */
@@ -3506,7 +3506,8 @@ static int init_rmode_identity_map(struct kvm *kvm)
 		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
 		r = kvm_write_guest_page(kvm, identity_map_pfn,
-				&tmp, i * sizeof(tmp), sizeof(tmp));
+					 &tmp, i * sizeof(tmp),
+					 sizeof(tmp), false);
 		if (r < 0)
 			goto out;
 	}
@@ -7265,7 +7266,8 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 		dst = vmcs12->pml_address + sizeof(u64) * vmcs12->guest_pml_index;
 
 		if (kvm_write_guest_page(vcpu->kvm, gpa_to_gfn(dst), &gpa,
-					 offset_in_page(dst), sizeof(gpa)))
+					 offset_in_page(dst), sizeof(gpa),
+					 false))
 			return 0;
 
 		vmcs12->guest_pml_index--;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2ea1ea79befd..4e34cf97ca90 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -734,7 +734,7 @@ int kvm_read_guest(struct kvm *kvm, gpa_t gpa, void *data, unsigned long len);
 int kvm_read_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			   void *data, unsigned long len);
 int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn, const void *data,
-			 int offset, int len);
+			 int offset, int len, bool track_dirty);
 int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 		    unsigned long len);
 int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
@@ -744,7 +744,8 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 				  unsigned long len);
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len);
-int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len);
+int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len,
+			 bool track_dirty);
 int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len);
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
 bool kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7ee28af9eb48..b1047173d78e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2051,7 +2051,8 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
 
 static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
-			          const void *data, int offset, int len)
+			          const void *data, int offset, int len,
+				  bool track_dirty)
 {
 	int r;
 	unsigned long addr;
@@ -2062,16 +2063,19 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 	r = __copy_to_user((void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(memslot, gfn);
+	if (track_dirty)
+		mark_page_dirty_in_slot(memslot, gfn);
 	return 0;
 }
 
 int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
-			 const void *data, int offset, int len)
+			 const void *data, int offset, int len,
+			 bool track_dirty)
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(slot, gfn, data, offset, len,
+				      track_dirty);
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest_page);
 
@@ -2080,7 +2084,8 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(slot, gfn, data, offset,
+				      len, true);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest_page);
 
@@ -2093,7 +2098,7 @@ int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 	int ret;
 
 	while ((seg = next_segment(len, offset)) != 0) {
-		ret = kvm_write_guest_page(kvm, gfn, data, offset, seg);
+		ret = kvm_write_guest_page(kvm, gfn, data, offset, seg, true);
 		if (ret < 0)
 			return ret;
 		offset = 0;
@@ -2232,11 +2237,13 @@ int kvm_read_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 }
 EXPORT_SYMBOL_GPL(kvm_read_guest_cached);
 
-int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len)
+int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len,
+			 bool track_dirty)
 {
 	const void *zero_page = (const void *) __va(page_to_phys(ZERO_PAGE(0)));
 
-	return kvm_write_guest_page(kvm, gfn, zero_page, offset, len);
+	return kvm_write_guest_page(kvm, gfn, zero_page, offset, len,
+				    track_dirty);
 }
 EXPORT_SYMBOL_GPL(kvm_clear_guest_page);
 
@@ -2248,7 +2255,7 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 	int ret;
 
 	while ((seg = next_segment(len, offset)) != 0) {
-		ret = kvm_clear_guest_page(kvm, gfn, offset, seg);
+		ret = kvm_clear_guest_page(kvm, gfn, offset, seg, true);
 		if (ret < 0)
 			return ret;
 		offset = 0;
-- 
2.24.1

