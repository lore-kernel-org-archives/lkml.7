Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0DAC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76E221726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfH3Bgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbfH3Bgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:36:51 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DF557FDEE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:36:50 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id a40so3097943pla.15
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 18:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wO2GMpLb1bdxi4bwIo0mHdhRTE5FQJFDOzBJpObz9Ms=;
        b=C0Y0Im4XYRjxUwRLH+AE763/u3JIfE8aPJsrEoIXtiSsVxcrj29KTl5l1bQhkXaXsj
         QvuaNeqAVUX0ALP8KeGTzb3oSNmuYObZg5LmUhB7zru15RD2CzOb4tueCPhRwjvuRVDK
         oGE131cXHYrEV+LWOMSKtqAfxz5otUzlwU3CIbnICIBUpt4Eb1GK54GLQGljRz424gP1
         BfBuquvpPAp+p+fsmDgaW6FNWlUQC2F5ZiMwzzsPVQiBse0uG1Qkd9joEd3/VcuioCRq
         46d+0R+8yYTGb348sv31Xa7sbZCo6bvWhgnuvXiQ0xCdL2h7S8FqvM99mGENnK3eAZAC
         pZyQ==
X-Gm-Message-State: APjAAAUrat6RRbKWiTflelBr4SXhvgv+uWg90Jmz66cDtKOEOFTNacq9
        TnINiTtpdDj7RVLx20WahPKYNYTA7+adzvnIE5W2/cYnt+Ytfk3sIg4KCfsFwJsdVpeXD88U1hy
        XgrJ21b/xJF9FZkcH+/J/wjEr
X-Received: by 2002:a62:4e05:: with SMTP id c5mr15114400pfb.66.1567129009610;
        Thu, 29 Aug 2019 18:36:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxaqylATIJy8c3slsQVqewhoSYe10uh4TIWa/vhS9CJbzx7epJD9YpbPR2k2cd0sISm1WeEg==
X-Received: by 2002:a62:4e05:: with SMTP id c5mr15114380pfb.66.1567129009365;
        Thu, 29 Aug 2019 18:36:49 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l3sm3426323pjq.24.2019.08.29.18.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 18:36:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 4/4] KVM: selftests: Remove duplicate guest mode handling
Date:   Fri, 30 Aug 2019 09:36:19 +0800
Message-Id: <20190830013619.18867-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830013619.18867-1-peterx@redhat.com>
References: <20190830013619.18867-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the duplication code in run_test() of dirty_log_test because
after some reordering of functions now we can directly use the outcome
of vm_create().

Meanwhile, with the new VM_MODE_PXXV48_4K, we can safely revert
b442324b58 too where we stick the x86_64 PA width to 39 bits for
dirty_log_test.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c  | 52 ++-----------------
 .../testing/selftests/kvm/include/kvm_util.h  |  4 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 17 ++++++
 3 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index c86f83cb33e5..89fac11733a5 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -234,10 +234,8 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 		     unsigned long interval, uint64_t phys_offset)
 {
-	unsigned int guest_pa_bits, guest_page_shift;
 	pthread_t vcpu_thread;
 	struct kvm_vm *vm;
-	uint64_t max_gfn;
 	unsigned long *bmap;
 
 	/*
@@ -252,60 +250,20 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 		       2ul << (DIRTY_MEM_BITS - PAGE_SHIFT_4K),
 		       guest_code);
 
-	switch (mode) {
-	case VM_MODE_P52V48_4K:
-	case VM_MODE_PXXV48_4K:
-		guest_pa_bits = 52;
-		guest_page_shift = 12;
-		break;
-	case VM_MODE_P52V48_64K:
-		guest_pa_bits = 52;
-		guest_page_shift = 16;
-		break;
-	case VM_MODE_P48V48_4K:
-		guest_pa_bits = 48;
-		guest_page_shift = 12;
-		break;
-	case VM_MODE_P48V48_64K:
-		guest_pa_bits = 48;
-		guest_page_shift = 16;
-		break;
-	case VM_MODE_P40V48_4K:
-		guest_pa_bits = 40;
-		guest_page_shift = 12;
-		break;
-	case VM_MODE_P40V48_64K:
-		guest_pa_bits = 40;
-		guest_page_shift = 16;
-		break;
-	default:
-		TEST_ASSERT(false, "Unknown guest mode, mode: 0x%x", mode);
-	}
-
-	DEBUG("Testing guest mode: %s\n", vm_guest_mode_string(mode));
-
-#ifdef __x86_64__
-	/*
-	 * FIXME
-	 * The x86_64 kvm selftests framework currently only supports a
-	 * single PML4 which restricts the number of physical address
-	 * bits we can change to 39.
-	 */
-	guest_pa_bits = 39;
-#endif
-	max_gfn = (1ul << (guest_pa_bits - guest_page_shift)) - 1;
-	guest_page_size = (1ul << guest_page_shift);
+	guest_page_size = vm_get_page_size(vm);
 	/*
 	 * A little more than 1G of guest page sized pages.  Cover the
 	 * case where the size is not aligned to 64 pages.
 	 */
-	guest_num_pages = (1ul << (DIRTY_MEM_BITS - guest_page_shift)) + 16;
+	guest_num_pages = (1ul << (DIRTY_MEM_BITS -
+				   vm_get_page_shift(vm))) + 16;
 	host_page_size = getpagesize();
 	host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
 			 !!((guest_num_pages * guest_page_size) % host_page_size);
 
 	if (!phys_offset) {
-		guest_test_phys_mem = (max_gfn - guest_num_pages) * guest_page_size;
+		guest_test_phys_mem = (vm_get_max_gfn(vm) -
+				       guest_num_pages) * guest_page_size;
 		guest_test_phys_mem &= ~(host_page_size - 1);
 	} else {
 		guest_test_phys_mem = phys_offset;
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 8c71ec886aab..e7ee55853616 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -154,6 +154,10 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code);
 
 bool vm_is_unrestricted_guest(struct kvm_vm *vm);
 
+unsigned int vm_get_page_size(struct kvm_vm *vm);
+unsigned int vm_get_page_shift(struct kvm_vm *vm);
+unsigned int vm_get_max_gfn(struct kvm_vm *vm);
+
 struct kvm_userspace_memory_region *
 kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 				 uint64_t end);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index bb8f993b25fb..80a338b5403c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -136,6 +136,8 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 {
 	struct kvm_vm *vm;
 
+	DEBUG("Testing guest mode: %s\n", vm_guest_mode_string(mode));
+
 	vm = calloc(1, sizeof(*vm));
 	TEST_ASSERT(vm != NULL, "Insufficient Memory");
 
@@ -1650,3 +1652,18 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 
 	return val == 'Y';
 }
+
+unsigned int vm_get_page_size(struct kvm_vm *vm)
+{
+	return vm->page_size;
+}
+
+unsigned int vm_get_page_shift(struct kvm_vm *vm)
+{
+	return vm->page_shift;
+}
+
+unsigned int vm_get_max_gfn(struct kvm_vm *vm)
+{
+	return vm->max_gfn;
+}
-- 
2.21.0

