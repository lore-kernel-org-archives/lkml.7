Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B16FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DF52072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QApgU3+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbgAIO6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:58:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55976 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732032AbgAIO6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkI6h8xSN7v+a4eMQahKlRzNqUClc6kri5FkEiWNSSA=;
        b=QApgU3+BKXSIIzpsfnHfNqtIW0nY2BldtgSGuXmyIbFy0wvl0XE/l9E+CLUrgHVDhjs6D4
        HzSdQ49TxB7u8PhJdsjyfNmY55p4092/GsjAUzvHIqgHObdipcwsEMAQV6py/ZL28GO+na
        SnDmrx7TXzYGnA4fU9D/BNVzrmSOMPM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-UV17Z2qVND6_q8UyWmv_0Q-1; Thu, 09 Jan 2020 09:58:17 -0500
X-MC-Unique: UV17Z2qVND6_q8UyWmv_0Q-1
Received: by mail-qv1-f72.google.com with SMTP id g15so4237997qvq.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkI6h8xSN7v+a4eMQahKlRzNqUClc6kri5FkEiWNSSA=;
        b=R21y32gxCahLIqF887i+Qhms2HtnA/hcnsXfIMswybaZofZMInjJyxouqbyoaUJN5A
         GJKT9NJgMTGhRuGOgFXYVL8cfqQhEtWAjgbZsvvdQJyO/CPT4HwIMQjjt2qdYn2fAgRD
         6u33EBPbV0RvdRecmTO/FTElkaTwo9FJ68nqSQz7Uuc8CTsHc+1mJ3ab5+1P46buRTCH
         OXRtxTcV04bfsTJPhOkjBnp3i0QjguE+8vG9wZ1pzHqWOh13yuAKp+Qb33fIn/xbk7C7
         9PsLBlQoYSTpOtfywRfswf62q7qqtB9v9umbTtYE+uipJmuHk0qlByT3SiFV+a8QbFfs
         Ejww==
X-Gm-Message-State: APjAAAXmbQ4/77enZAGdrjzxqGBRuV4FbWlZoEtjE7c10T5gRjzihHIT
        /RTAft0axqlz6puEI1ESntPNeQj7BC/DHFAc8exOswkF0qJ8ZjEHz6SLj6Y7Y9bQK3/je7cZvFQ
        EgyiM/LRNLjHifne1/P5YeEWJ
X-Received: by 2002:ae9:f442:: with SMTP id z2mr10150766qkl.130.1578581896686;
        Thu, 09 Jan 2020 06:58:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBAarLMa55uVokrirkTNLb6eELDuIHQGq/dU1S1sfC9y2eLW5K4vaMv9gn/0Ij3PCki0kUlw==
X-Received: by 2002:ae9:f442:: with SMTP id z2mr10150744qkl.130.1578581896459;
        Thu, 09 Jan 2020 06:58:16 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:58:16 -0800 (PST)
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
Subject: [PATCH v3 16/21] KVM: selftests: Sync uapi/linux/kvm.h to tools/
Date:   Thu,  9 Jan 2020 09:57:24 -0500
Message-Id: <20200109145729.32898-17-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be needed to extend the kvm selftest program.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index f0a16b4adbbd..d2300a3cfbf0 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -236,6 +236,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
 #define KVM_EXIT_ARM_NISV         28
+#define KVM_EXIT_DIRTY_RING_FULL  29
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -247,6 +248,13 @@ struct kvm_hyperv_exit {
 /* Encounter unexpected vm-exit reason */
 #define KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON	4
 
+struct kvm_dirty_ring_indices {
+	__u32 avail_index; /* set by kernel */
+	__u32 padding1;
+	__u32 fetch_index; /* set by userspace */
+	__u32 padding2;
+};
+
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
 	/* in */
@@ -421,6 +429,13 @@ struct kvm_run {
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
@@ -1009,6 +1024,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
+#define KVM_CAP_DIRTY_LOG_RING 179
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1473,6 +1489,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
 
+/* Available with KVM_CAP_DIRTY_LOG_RING */
+#define KVM_RESET_DIRTY_RINGS     _IO(KVMIO, 0xc3)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1623,4 +1642,23 @@ struct kvm_hyperv_eventfd {
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

