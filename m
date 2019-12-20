Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E43C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7969206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hD9JYI86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfLTVQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:16:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39633 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727630AbfLTVQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576876608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pol5PWFpYE9QDZtFO4p/0Ih4s1j3WxPFfstxyW/mAdA=;
        b=hD9JYI86fO43MPUoFfO0wKa4b9+iMBKTvLD2r9EthjKs14Az43a0M5SMJb32icBj485hsN
        0f4LtePr+L2H/vOFv16QIHe+qC9PYEeKYuo1b7LkDA/9jJkIeU5RRBGZfyAiqa3KAMz35x
        C+N9vrnOOwfVAr4223d/4P4DFl5X7vM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212--pdUiUCMO3uRu2--kGWVnA-1; Fri, 20 Dec 2019 16:16:47 -0500
X-MC-Unique: -pdUiUCMO3uRu2--kGWVnA-1
Received: by mail-qv1-f71.google.com with SMTP id c22so6769181qvc.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pol5PWFpYE9QDZtFO4p/0Ih4s1j3WxPFfstxyW/mAdA=;
        b=il9ANfA/zARf1934ServPlOoDBShzC/1njztOSR4gMI33wyFxFuGJbJ+1sj5C91SVN
         S7CvSmliIwSaGSevsh8FamnLnyAQeJtbOsd/wpPknxE3PLWlLs3h2RZqYfiSF3Jvih0f
         dFR3elrQ0x5IraQUoQekr9mq725OEucSjk4jPcgvSukN+amzBy19gnLvT2Q/MdlxRmrl
         kX+yIJbfsx6hXOh/d51wk9gJEsjPzo1nXj2e7K68fyyCk3thleNxQjKehUcKeeyAn/ko
         tqVf1nrvlNpg0As+mGHLMq7E4V9sk1BOIExYNLLCVv9osM75WlG7VJc2yXm2JCdyN2fy
         VzSQ==
X-Gm-Message-State: APjAAAU3yyvSYLKwq39DZ6Jft+o+vxVgUnCvIs+AUekKteXlt7TsQZdu
        IYrziVOH6YEY5N7n5dyzTRvxZnrZKvia288/b57A237U57uGUegKFEt7LFJtnOvzu/AC10h0VNC
        94qdc8kwhYVk2bDe32zS/fhSA
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr13203049qtr.142.1576876606785;
        Fri, 20 Dec 2019 13:16:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzNym5p3t8R3aAuwzdPCLNwWO1VoH4b45iDYzDaeWWsmzp0D8R3vZGPxt/vm34Ap2UdpnYSjQ==
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr13203032qtr.142.1576876606597;
        Fri, 20 Dec 2019 13:16:46 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id d25sm3385231qtq.11.2019.12.20.13.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:16:46 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v2 06/17] KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
Date:   Fri, 20 Dec 2019 16:16:23 -0500
Message-Id: <20191220211634.51231-7-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220211634.51231-1-peterx@redhat.com>
References: <20191220211634.51231-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The context will be needed to implement the kvm dirty ring.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c80a363831ae..17969cf110dd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -144,7 +144,9 @@ static void hardware_disable_all(void);
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
 
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot, gfn_t gfn);
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+				    struct kvm_memory_slot *memslot,
+				    gfn_t gfn);
 
 __visible bool kvm_rebooting;
 EXPORT_SYMBOL_GPL(kvm_rebooting);
@@ -2053,8 +2055,9 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
 
-static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
-			          const void *data, int offset, int len,
+static int __kvm_write_guest_page(struct kvm *kvm,
+				  struct kvm_memory_slot *memslot, gfn_t gfn,
+				  const void *data, int offset, int len,
 				  bool track_dirty)
 {
 	int r;
@@ -2067,7 +2070,7 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 	if (r)
 		return -EFAULT;
 	if (track_dirty)
-		mark_page_dirty_in_slot(memslot, gfn);
+		mark_page_dirty_in_slot(kvm, memslot, gfn);
 	return 0;
 }
 
@@ -2077,7 +2080,7 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len,
+	return __kvm_write_guest_page(kvm, slot, gfn, data, offset, len,
 				      track_dirty);
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest_page);
@@ -2087,7 +2090,7 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset,
+	return __kvm_write_guest_page(vcpu->kvm, slot, gfn, data, offset,
 				      len, true);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest_page);
@@ -2202,7 +2205,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
+	mark_page_dirty_in_slot(kvm, ghc->memslot, gpa >> PAGE_SHIFT);
 
 	return 0;
 }
@@ -2269,7 +2272,8 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 }
 EXPORT_SYMBOL_GPL(kvm_clear_guest);
 
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot,
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
 	if (memslot && memslot->dirty_bitmap) {
@@ -2284,7 +2288,7 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = gfn_to_memslot(kvm, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(mark_page_dirty);
 
@@ -2293,7 +2297,7 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(vcpu->kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_mark_page_dirty);
 
-- 
2.24.1

