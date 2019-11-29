Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E808C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B73206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i53wn7wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfK2VgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:36:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36944 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387405AbfK2Vf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575063328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZpdoO8QRbjuY5mDRDtcxZHO4nZtgRquhpHelnraUvg=;
        b=i53wn7wdTD0e/vR3OZCmvHao8VxRCcbylVBRTIw2AET+akbtZTykzO49SOXGH1ELSoD/Ol
        IUb7X9+6xyvNqLeW8j6kMp6O8N+huIVM3gc6cUkJeboBMS6ULItOJkuHJErwrNC8+8zqW8
        v3gNFA5babMMiaClTxJE3LdWUlmKQAA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-w_nI1TWKOaiivWYy8cKQHQ-1; Fri, 29 Nov 2019 16:35:25 -0500
Received: by mail-qt1-f199.google.com with SMTP id x21so19719725qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPDpRSfU7OJDvK+Jv1HyG5MKUTN9E4L4yVGOfnatozs=;
        b=YjslOylXOvo2oqb55HVGKYOEoQmL5htEcs5fL4mbzwHbcXTnS+D6VZee/AFt+jN6WF
         VmQV+7lQA44M5fVvtd5890A82aT8O4c5vGs/eHnYdALVTWYZXe5b4xbVr7m7ERlrm6TS
         caSF0Ba1gMXgTsv8HtSlPCla9lc4/Gu7UUu4fowohdL9nIhuWOLNsE13g05UPscp76R5
         L1ueLNcGO6895HMWiwD/eEIf6Z20Rs3DHLVrQFNONG4vrm9Us5aGXouNXzs8LtbX7KRC
         q4p2z8d9V8Sliu1WZeJetB4qxqUb0F+XFE7OtgNb7B+Nu88m1IJO///pgQ0syTxD98N2
         OTxg==
X-Gm-Message-State: APjAAAW623NWelMSlvfYMnLCXQ0ouzy7729Z2eoG4BWap6tvvURPTd9E
        IFq4o2w/c6Um6BtTLkmQ/fGhbbDnkwARyIytjfJGbEi/7JhSpsAx76bW1tGvAC4v5TFqx2dWeT4
        pyDy+8V3Hu350ICfmus3/HSJs
X-Received: by 2002:aed:24e4:: with SMTP id u33mr54423800qtc.259.1575063323862;
        Fri, 29 Nov 2019 13:35:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8f1cm2E9EATQGs2NbJnhtjkcM3Mr1wBhqvHx80R6fUIyhQEakj9JIIhVHAr3mSX4XrMGYWg==
X-Received: by 2002:aed:24e4:: with SMTP id u33mr54423779qtc.259.1575063323647;
        Fri, 29 Nov 2019 13:35:23 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h186sm10679046qkf.64.2019.11.29.13.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:35:22 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 09/15] KVM: selftests: Sync uapi/linux/kvm.h to tools/
Date:   Fri, 29 Nov 2019 16:34:59 -0500
Message-Id: <20191129213505.18472-10-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: w_nI1TWKOaiivWYy8cKQHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be needed to extend the kvm selftest program.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.=
h
index 52641d8ca9e8..0b88d76d6215 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -235,6 +235,8 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
+#define KVM_EXIT_ARM_NISV         28
+#define KVM_EXIT_DIRTY_RING_FULL  29
=20
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -246,6 +248,11 @@ struct kvm_hyperv_exit {
 /* Encounter unexpected vm-exit reason */
 #define KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON=094
=20
+struct kvm_dirty_ring_indexes {
+=09__u32 avail_index; /* set by kernel */
+=09__u32 fetch_index; /* set by userspace */
+};
+
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=3D0) */
 struct kvm_run {
 =09/* in */
@@ -394,6 +401,11 @@ struct kvm_run {
 =09=09} eoi;
 =09=09/* KVM_EXIT_HYPERV */
 =09=09struct kvm_hyperv_exit hyperv;
+=09=09/* KVM_EXIT_ARM_NISV */
+=09=09struct {
+=09=09=09__u64 esr_iss;
+=09=09=09__u64 fault_ipa;
+=09=09} arm_nisv;
 =09=09/* Fix the size of the union. */
 =09=09char padding[256];
 =09};
@@ -415,6 +427,13 @@ struct kvm_run {
 =09=09struct kvm_sync_regs regs;
 =09=09char padding[SYNC_REGS_SIZE_BYTES];
 =09} s;
+
+=09struct kvm_dirty_ring_indexes vcpu_ring_indexes;
+};
+
+/* Returned by mmap(kvm->fd, offset=3D0) */
+struct kvm_vm_run {
+=09struct kvm_dirty_ring_indexes vm_ring_indexes;
 };
=20
 /* for KVM_REGISTER_COALESCED_MMIO / KVM_UNREGISTER_COALESCED_MMIO */
@@ -1000,6 +1019,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PMU_EVENT_FILTER 173
 #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
 #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
+#define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
+#define KVM_CAP_ARM_NISV_TO_USER 177
+#define KVM_CAP_ARM_INJECT_EXT_DABT 178
+#define KVM_CAP_DIRTY_LOG_RING 179
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1227,6 +1250,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_ITS=09KVM_DEV_TYPE_ARM_VGIC_ITS
 =09KVM_DEV_TYPE_XIVE,
 #define KVM_DEV_TYPE_XIVE=09=09KVM_DEV_TYPE_XIVE
+=09KVM_DEV_TYPE_ARM_PV_TIME,
+#define KVM_DEV_TYPE_ARM_PV_TIME=09KVM_DEV_TYPE_ARM_PV_TIME
 =09KVM_DEV_TYPE_MAX,
 };
=20
@@ -1461,6 +1486,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE=09  _IOW(KVMIO,  0xc2, int)
=20
+/* Available with KVM_CAP_DIRTY_LOG_RING */
+#define KVM_RESET_DIRTY_RINGS     _IO(KVMIO, 0xc3)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 =09/* Guest initialization commands */
@@ -1611,4 +1639,23 @@ struct kvm_hyperv_eventfd {
 #define KVM_HYPERV_CONN_ID_MASK=09=090x00ffffff
 #define KVM_HYPERV_EVENTFD_DEASSIGN=09(1 << 0)
=20
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
+=09__u32 pad;
+=09__u32 slot;
+=09__u64 offset;
+};
+
 #endif /* __LINUX_KVM_H */
--=20
2.21.0

