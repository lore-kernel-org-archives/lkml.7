Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9E12072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3RWl4/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbgAIO63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:58:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732078AbgAIO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WdC8RACEBXWXiNKz4cG4gkf1SXOTtLD6gRrHtU5a1W8=;
        b=J3RWl4/Rb7DDMUqMnNbPARdEzBrFcj77e2eJWKhVMvAtfJ48UWs79ivmfzCG7XBXDmTcwE
        7dg4hHf910+XzQOQ1SaLO4ZXT2g2BDblxd5If5Alg0cOQeVm6eXH+/wv1OtjKLoOV3sO0E
        aJNy3I03QZ/YZaUYrJ8SYf9dS2GdBGI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-rbNF--lxMFiFChbSFa4z_Q-1; Thu, 09 Jan 2020 09:58:18 -0500
X-MC-Unique: rbNF--lxMFiFChbSFa4z_Q-1
Received: by mail-qv1-f69.google.com with SMTP id v3so4266959qvm.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdC8RACEBXWXiNKz4cG4gkf1SXOTtLD6gRrHtU5a1W8=;
        b=r3vkDoEu9CLr8FnsFrwex/dCoE+Z+xRn4h0hYtaWCB9zDbBncBwQW7z80UJ1BbiTus
         YAOyZhB2Eipu/8ArWV8lAYVR19tlPB/eylv3CpFNkNkp+ENPvGECw1vb8zJ+fUpmgJla
         YZYSl7BPyc1VlZq5StOvTd3FPKotPvdrNGII2sm4jJ+dSRwGJ5j0Oo6WIY8mgOYm7PSY
         HpX937ENgSnRhaoLBxjuW1g1oOTrYwYkBc0ObrsohffdxVZHkVW+UoJkKhvvFfGAzgi+
         Q0v3gWXb+NbKv9AIk8T0OXqBrwlr97/S2R5FZZcLjzQGTNBzM1WA+x+dfQCcmng/h1i3
         Vrzg==
X-Gm-Message-State: APjAAAU045tYo23HyomCcHKjmSmz7HP11DI1GmBDy6w49HtJWJNO9U3y
        e/28A9rOuRHdNxiK0yxvcQAAGrMAird+TglKQesS+HKHjYI4crDpiAAj2pTMpsQNQQtK1X6cfPP
        Z1R/UI0DPx4GqAX6TEtfa6dgy
X-Received: by 2002:ad4:42d1:: with SMTP id f17mr9221062qvr.30.1578581898161;
        Thu, 09 Jan 2020 06:58:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhpNurUj8GRzeQ3Gop8kY8cTPv8GUJPgwCzaHpfOsS5/4K7kMszLdKdzN4qHQChEOhvWF+YQ==
X-Received: by 2002:ad4:42d1:: with SMTP id f17mr9221042qvr.30.1578581897803;
        Thu, 09 Jan 2020 06:58:17 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:58:17 -0800 (PST)
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
Subject: [PATCH v3 17/21] KVM: selftests: Use a single binary for dirty/clear log test
Date:   Thu,  9 Jan 2020 09:57:25 -0500
Message-Id: <20200109145729.32898-18-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the clear_dirty_log test, instead merge it into the existing
dirty_log_test.  It should be cleaner to use this single binary to do
both tests, also it's a preparation for the upcoming dirty ring test.

The default test will still be the dirty_log test.  To run the clear
dirty log test, we need to specify "-M clear-log".

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   2 -
 .../selftests/kvm/clear_dirty_log_test.c      |   2 -
 tools/testing/selftests/kvm/dirty_log_test.c  | 131 +++++++++++++++---
 3 files changed, 110 insertions(+), 25 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 3138a916574a..130a7b1c7ad6 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -26,11 +26,9 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_dirty_log_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86_64 += x86_64/xss_msr_test
-TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 
-TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 
diff --git a/tools/testing/selftests/kvm/clear_dirty_log_test.c b/tools/testing/selftests/kvm/clear_dirty_log_test.c
deleted file mode 100644
index 749336937d37..000000000000
--- a/tools/testing/selftests/kvm/clear_dirty_log_test.c
+++ /dev/null
@@ -1,2 +0,0 @@
-#define USE_CLEAR_DIRTY_LOG
-#include "dirty_log_test.c"
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 3c0ffd34b3b0..a8ae8c0042a8 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -128,6 +128,66 @@ static uint64_t host_dirty_count;
 static uint64_t host_clear_count;
 static uint64_t host_track_next_count;
 
+enum log_mode_t {
+	/* Only use KVM_GET_DIRTY_LOG for logging */
+	LOG_MODE_DIRTY_LOG = 0,
+
+	/* Use both KVM_[GET|CLEAR]_DIRTY_LOG for logging */
+	LOG_MODE_CLERA_LOG = 1,
+
+	LOG_MODE_NUM,
+};
+
+/* Mode of logging.  Default is LOG_MODE_DIRTY_LOG */
+static enum log_mode_t host_log_mode;
+
+static void clear_log_create_vm_done(struct kvm_vm *vm)
+{
+	struct kvm_enable_cap cap = {};
+
+	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2)) {
+		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping tests\n");
+		exit(KSFT_SKIP);
+	}
+
+	cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
+	cap.args[0] = 1;
+	vm_enable_cap(vm, &cap);
+}
+
+static void dirty_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
+					  void *bitmap, uint32_t num_pages)
+{
+	kvm_vm_get_dirty_log(vm, slot, bitmap);
+}
+
+static void clear_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
+					  void *bitmap, uint32_t num_pages)
+{
+	kvm_vm_get_dirty_log(vm, slot, bitmap);
+	kvm_vm_clear_dirty_log(vm, slot, bitmap, 0, num_pages);
+}
+
+struct log_mode {
+	const char *name;
+	/* Hook when the vm creation is done (before vcpu creation) */
+	void (*create_vm_done)(struct kvm_vm *vm);
+	/* Hook to collect the dirty pages into the bitmap provided */
+	void (*collect_dirty_pages) (struct kvm_vm *vm, int slot,
+				     void *bitmap, uint32_t num_pages);
+} log_modes[LOG_MODE_NUM] = {
+	{
+		.name = "dirty-log",
+		.create_vm_done = NULL,
+		.collect_dirty_pages = dirty_log_collect_dirty_pages,
+	},
+	{
+		.name = "clear-log",
+		.create_vm_done = clear_log_create_vm_done,
+		.collect_dirty_pages = clear_log_collect_dirty_pages,
+	},
+};
+
 /*
  * We use this bitmap to track some pages that should have its dirty
  * bit set in the _next_ iteration.  For example, if we detected the
@@ -137,6 +197,33 @@ static uint64_t host_track_next_count;
  */
 static unsigned long *host_bmap_track;
 
+static void log_modes_dump(void)
+{
+	int i;
+
+	for (i = 0; i < LOG_MODE_NUM; i++)
+		printf("%s, ", log_modes[i].name);
+	puts("\b\b  \b\b");
+}
+
+static void log_mode_create_vm_done(struct kvm_vm *vm)
+{
+	struct log_mode *mode = &log_modes[host_log_mode];
+
+	if (mode->create_vm_done)
+		mode->create_vm_done(vm);
+}
+
+static void log_mode_collect_dirty_pages(struct kvm_vm *vm, int slot,
+					 void *bitmap, uint32_t num_pages)
+{
+	struct log_mode *mode = &log_modes[host_log_mode];
+
+	TEST_ASSERT(mode->collect_dirty_pages != NULL,
+		    "collect_dirty_pages() is required for any log mode!");
+	mode->collect_dirty_pages(vm, slot, bitmap, num_pages);
+}
+
 static void generate_random_array(uint64_t *guest_array, uint64_t size)
 {
 	uint64_t i;
@@ -257,6 +344,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 #ifdef __x86_64__
 	vm_create_irqchip(vm);
 #endif
+	log_mode_create_vm_done(vm);
 	vm_vcpu_add_default(vm, vcpuid, guest_code);
 	return vm;
 }
@@ -316,14 +404,6 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	bmap = bitmap_alloc(host_num_pages);
 	host_bmap_track = bitmap_alloc(host_num_pages);
 
-#ifdef USE_CLEAR_DIRTY_LOG
-	struct kvm_enable_cap cap = {};
-
-	cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
-	cap.args[0] = 1;
-	vm_enable_cap(vm, &cap);
-#endif
-
 	/* Add an extra memory slot for testing dirty logging */
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
 				    guest_test_phys_mem,
@@ -364,11 +444,8 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	while (iteration < iterations) {
 		/* Give the vcpu thread some time to dirty some pages */
 		usleep(interval * 1000);
-		kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
-#ifdef USE_CLEAR_DIRTY_LOG
-		kvm_vm_clear_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap, 0,
-				       host_num_pages);
-#endif
+		log_mode_collect_dirty_pages(vm, TEST_MEM_SLOT_INDEX,
+					     bmap, host_num_pages);
 		vm_dirty_log_verify(bmap);
 		iteration++;
 		sync_global_to_guest(vm, iteration);
@@ -413,6 +490,9 @@ static void help(char *name)
 	       TEST_HOST_LOOP_INTERVAL);
 	printf(" -p: specify guest physical test memory offset\n"
 	       "     Warning: a low offset can conflict with the loaded test code.\n");
+	printf(" -M: specify the host logging mode "
+	       "(default: log-dirty).  Supported modes: \n\t");
+	log_modes_dump();
 	printf(" -m: specify the guest mode ID to test "
 	       "(default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -437,13 +517,6 @@ int main(int argc, char *argv[])
 	unsigned int host_ipa_limit;
 #endif
 
-#ifdef USE_CLEAR_DIRTY_LOG
-	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2)) {
-		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping tests\n");
-		exit(KSFT_SKIP);
-	}
-#endif
-
 #ifdef __x86_64__
 	vm_guest_mode_params_init(VM_MODE_PXXV48_4K, true, true);
 #endif
@@ -463,7 +536,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hi:I:p:m:")) != -1) {
+	while ((opt = getopt(argc, argv, "hi:I:p:m:M:")) != -1) {
 		switch (opt) {
 		case 'i':
 			iterations = strtol(optarg, NULL, 10);
@@ -485,6 +558,22 @@ int main(int argc, char *argv[])
 				    "Guest mode ID %d too big", mode);
 			vm_guest_mode_params[mode].enabled = true;
 			break;
+		case 'M':
+			for (i = 0; i < LOG_MODE_NUM; i++) {
+				if (!strcmp(optarg, log_modes[i].name)) {
+					DEBUG("Setting log mode to: '%s'\n",
+					      optarg);
+					host_log_mode = i;
+					break;
+				}
+			}
+			if (i == LOG_MODE_NUM) {
+				printf("Log mode '%s' is invalid.  "
+				       "Please choose from: ", optarg);
+				log_modes_dump();
+				exit(-1);
+			}
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
-- 
2.24.1

