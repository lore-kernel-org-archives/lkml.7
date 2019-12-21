Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238CAC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE75120716
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 02:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHVIxQ1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfLUCEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 21:04:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28833 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726571AbfLUCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 21:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576893891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulPWf8Brzg5F7en4DnY+b2FP2/4bB7SIlRQb5Tezjhk=;
        b=fHVIxQ1Uycaj+Aghw1sN0tnQgesDhD65L51e4BfqVlblAkuH+5htWrzCsD8RGgXonoBPel
        BiOyTgx/6geJDmvUlavVDRzSxBUdnJZTBZywQMegAhjpfPuNeKsU95K4+o/H+uP2AZSSaQ
        wVDjseisiNG0ldqhWvNvzkneB/Mfbvk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-8CYEvmRjNM-_on7pYiJ-dA-1; Fri, 20 Dec 2019 21:04:49 -0500
X-MC-Unique: 8CYEvmRjNM-_on7pYiJ-dA-1
Received: by mail-qt1-f200.google.com with SMTP id l1so7175632qtp.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 18:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulPWf8Brzg5F7en4DnY+b2FP2/4bB7SIlRQb5Tezjhk=;
        b=QFlW3pkxlD67xUW39eJtOJlNdL2NR17JctVlWXYgz2bEaZV1CwcDU6Ec4Qf6jj9QaD
         /1VwdlI/0RyHliFmBOxBOc2vKSGooD+Viu1uszl6ZdegXWiKTrfHmP9WknPo/9lbGK2r
         6GQOeBB0WyUwxDLkHKZn+GHAjOZXMeIbpjW6cCJJe5sXQwk+9I/N4xF0Je0D2nWmwu28
         oM6HdUcns4UhXpGDJzhsx3tPOeM3fctZZt/7mwUUg/La38uK2WkgsWy7KdI3rtUq4alK
         dLzOUusZxgPCyGowd0p83yfI4IVspCxDNZFLEJC27pAksyFzekKlqPxDippiseAoCMUV
         Nz3A==
X-Gm-Message-State: APjAAAVP5LX/fqBXlLohCkPTfQUD51S+HNMMdlkS+GkTocyLBDcWTIbT
        57zNLARWlNE3eXQbE8V7SWZsZfAxkDHvhPCfhpErGDuqQyXwtdGHipQT0pc/1CL87LIP72JN5VI
        RDUGiSOzDHmId5F3VV5KoQlvK
X-Received: by 2002:a37:a70c:: with SMTP id q12mr4993677qke.484.1576893889516;
        Fri, 20 Dec 2019 18:04:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwi6EpBxyuC1AaxbuV0H2bPRBVFZGuE77abXFYffswUMBxwuwWHioRNl3ysylFXmR1QHzb/VQ==
X-Received: by 2002:a37:a70c:: with SMTP id q12mr4993661qke.484.1576893889274;
        Fri, 20 Dec 2019 18:04:49 -0800 (PST)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id t7sm3400114qkm.136.2019.12.20.18.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 18:04:48 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dr David Alan Gilbert <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RESEND v2 12/17] KVM: selftests: Sync uapi/linux/kvm.h to tools/
Date:   Fri, 20 Dec 2019 21:04:40 -0500
Message-Id: <20191221020445.60476-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221014938.58831-1-peterx@redhat.com>
References: <20191221020445.60476-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be needed to extend the kvm selftest program.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 52641d8ca9e8..17df0de21cce 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -235,6 +235,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
+#define KVM_EXIT_DIRTY_RING_FULL  28
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -246,6 +247,11 @@ struct kvm_hyperv_exit {
 /* Encounter unexpected vm-exit reason */
 #define KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON	4
 
+struct kvm_dirty_ring_indices {
+	__u32 avail_index; /* set by kernel */
+	__u32 fetch_index; /* set by userspace */
+};
+
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
 	/* in */
@@ -415,6 +421,13 @@ struct kvm_run {
 		struct kvm_sync_regs regs;
 		char padding[SYNC_REGS_SIZE_BYTES];
 	} s;
+
+	struct kvm_dirty_ring_indices vcpu_ring_indices;
+};
+
+/* Returned by mmap(kvm->fd, offset=0) */
+struct kvm_vm_run {
+	struct kvm_dirty_ring_indices vm_ring_indices;
 };
 
 /* for KVM_REGISTER_COALESCED_MMIO / KVM_UNREGISTER_COALESCED_MMIO */
@@ -1000,6 +1013,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PMU_EVENT_FILTER 173
 #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
 #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
+#define KVM_CAP_DIRTY_LOG_RING 176
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1461,6 +1475,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
 
+/* Available with KVM_CAP_DIRTY_LOG_RING */
+#define KVM_RESET_DIRTY_RINGS     _IO(KVMIO, 0xc3)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1611,4 +1628,23 @@ struct kvm_hyperv_eventfd {
 #define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
 #define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
 
+/*
+ * The following are the requirements for supporting dirty log ring
+ * (by enabling KVM_DIRTY_LOG_PAGE_OFFSET).
+ *
+ * 1. Memory accesses by KVM should call kvm_vcpu_write_* instead
+ *    of kvm_write_* so that the global dirty ring is not filled up
+ *    too quickly.
+ * 2. kvm_arch_mmu_enable_log_dirty_pt_masked should be defined for
+ *    enabling dirty logging.
+ * 3. There should not be a separate step to synchronize hardware
+ *    dirty bitmap with KVM's.
+ */
+
+struct kvm_dirty_gfn {
+	__u32 pad;
+	__u32 slot;
+	__u64 offset;
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.24.1

