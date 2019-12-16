Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE21C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3E824673
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4XYDQWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfLPVjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:39:17 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36389 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfLPVjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:39:14 -0500
Received: by mail-pg1-f201.google.com with SMTP id i8so202826pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Cb2Ll4QXvvxKS0ilQTgclxRvuIG8oGi9ZpuJq+AVeGI=;
        b=g4XYDQWfuDZf2trAxFnCU73GU+Yj6ctN3yfvsb9reOXRBlqT11TmjtBjhCq4udB06C
         1rgR4JmeznePN7W21+ltGzYwvJZmbek8Cksi6kl0UhhlAQTBbzQPCNEfG9zr2EyfETL9
         F6g9+Z99DwK67RzKhdsFSx7tXEav7pmzxKKluBHp5BbyOadP4EOh1sjhZ3e/qYQf0g1e
         YFPPasxp+V9JwvrG2wOy6h2oeTg9MJNI2fskJrusXQ7I6lpq+81S2JcOgXvYMUFGWcg7
         exBT7gUaEGJPfNN+hjn39cWc5Lw4ht/9qJ5bzNPp91DdN4JfWAMFnZmNWHV2Ad9xl+y3
         Rs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cb2Ll4QXvvxKS0ilQTgclxRvuIG8oGi9ZpuJq+AVeGI=;
        b=QYYczhcqfB4U4kxH1Nd7p5Bj83XHTIgcWr8DJaFsIkeuhXsRXdxB4O9WIhMMnpb3k/
         gIhysbpW+PiyeRLFol7oy11jdBWAsOJA5vmbhjXRE9VePBb0HumRvx7tiHtzv8p5yGtj
         fq9NiBCRC1f3zxT0VgF2c0tMflxK0iDcxFDa8sIAq8d3uXiWiDsmnYMBfs1Z87GPSA8K
         rEq+R8ZTN7EyBftMp2Z+eRLMDZxda/EMo0Va2eeA8nVVCckDNkAXA0FMTvrvdp+f8T8P
         K/hzFxp62yfO8W952cuj9tUqTELpw29z4TJ4RXKFXaym9LtEcizkM/tc0ykLvJp041PF
         yqcw==
X-Gm-Message-State: APjAAAWva2aEX+oRGtqCNyG30d4AAbrN7+Ps0+PovDyHUHxxu/DEjtCu
        CGLbHnGrhmV5QwZwotNUVUOLgZ1NPs6T0v2td6VY++I3pskdEo7BhTgLSt7or78EmLzj9iwiKTE
        nH8jheCbECnarIsWobG4dfW2IOsYGTGIkTgqYAmtPkQopnSQNh3xY0nfsVTuT2REmDnt4HPi6
X-Google-Smtp-Source: APXvYqyYGvF0JGmKhrzZ8qT6+zoNtfD1MP73Z2ZHYZDbiaM1nMIKJvUUautjOVH1eBm1WAvXQ0BzT58IzMsi
X-Received: by 2002:a63:2a06:: with SMTP id q6mr20169428pgq.92.1576532353732;
 Mon, 16 Dec 2019 13:39:13 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:38:57 -0800
In-Reply-To: <20191216213901.106941-1-bgardon@google.com>
Message-Id: <20191216213901.106941-5-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 4/8] KVM: selftests: Add memory size parameter to the
 demand paging test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an argument to allow the demand paging test to work on larger and
smaller guest sizes.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 56 ++++++++++++-------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 11de5b58995fb..4aa90a3fce99c 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -32,6 +32,8 @@
 /* Default guest test virtual memory offset */
 #define DEFAULT_GUEST_TEST_MEM		0xc0000000
 
+#define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
+
 /*
  * Guest/Host shared variables. Ensure addr_gva2hva() and/or
  * sync_global_to/from_guest() are used when accessing from
@@ -264,11 +266,10 @@ static int setup_demand_paging(struct kvm_vm *vm,
 	return 0;
 }
 
-#define GUEST_MEM_SHIFT 30 /* 1G */
 #define PAGE_SHIFT_4K  12
 
 static void run_test(enum vm_guest_mode mode, bool use_uffd,
-		     useconds_t uffd_delay)
+		     useconds_t uffd_delay, uint64_t guest_memory_bytes)
 {
 	pthread_t vcpu_thread;
 	pthread_t uffd_handler_thread;
@@ -276,33 +277,40 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	int r;
 
 	/*
-	 * We reserve page table for 2 times of extra dirty mem which
-	 * will definitely cover the original (1G+) test range.  Here
-	 * we do the calculation with 4K page size which is the
-	 * smallest so the page number will be enough for all archs
-	 * (e.g., 64K page size guest will need even less memory for
-	 * page tables).
+	 * We reserve page table for twice the ammount of memory we intend
+	 * to use in the test region for demand paging. Here we do the
+	 * calculation with 4K page size which is the smallest so the page
+	 * number will be enough for all archs. (e.g., 64K page size guest
+	 * will need even less memory for page tables).
 	 */
 	vm = create_vm(mode, VCPU_ID,
-		       2ul << (GUEST_MEM_SHIFT - PAGE_SHIFT_4K),
+		       (2 * guest_memory_bytes) >> PAGE_SHIFT_4K,
 		       guest_code);
 
 	guest_page_size = vm_get_page_size(vm);
-	/*
-	 * A little more than 1G of guest page sized pages.  Cover the
-	 * case where the size is not aligned to 64 pages.
-	 */
-	guest_num_pages = (1ul << (GUEST_MEM_SHIFT -
-				   vm_get_page_shift(vm))) + 16;
+
+	TEST_ASSERT(guest_memory_bytes % guest_page_size == 0,
+		    "Guest memory size is not guest page size aligned.");
+
+	guest_num_pages = guest_memory_bytes / guest_page_size;
+
 #ifdef __s390x__
 	/* Round up to multiple of 1M (segment size) */
 	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
 #endif
+	/*
+	 * If there should be more memory in the guest test region than there
+	 * can be pages in the guest, it will definitely cause problems.
+	 */
+	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
+		    "Requested more guest memory than address space allows.\n"
+		    "    guest pages: %lx max gfn: %lx\n",
+		    guest_num_pages, vm_get_max_gfn(vm));
 
 	host_page_size = getpagesize();
-	host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
-			 !!((guest_num_pages * guest_page_size) %
-			    host_page_size);
+	TEST_ASSERT(guest_memory_bytes % host_page_size == 0,
+		    "Guest memory size is not host page size aligned.");
+	host_num_pages = guest_memory_bytes / host_page_size;
 
 	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
 			      guest_page_size;
@@ -381,7 +389,8 @@ static void help(char *name)
 	int i;
 
 	puts("");
-	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n", name);
+	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
+	       "          [-b bytes test memory]\n", name);
 	printf(" -m: specify the guest mode ID to test\n"
 	       "     (default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -395,6 +404,8 @@ static void help(char *name)
 	printf(" -d: add a delay in usec to the User Fault\n"
 	       "     FD handler to simulate demand paging\n"
 	       "     overheads. Ignored without -u.\n");
+	printf(" -b: specify the number of bytes of memory which should be\n"
+	       "     allocated to the guest.\n");
 	puts("");
 	exit(0);
 }
@@ -402,6 +413,7 @@ static void help(char *name)
 int main(int argc, char *argv[])
 {
 	bool mode_selected = false;
+	uint64_t guest_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
 	unsigned int mode;
 	int opt, i;
 	bool use_uffd = false;
@@ -414,7 +426,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hm:ud:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:ud:b:")) != -1) {
 		switch (opt) {
 		case 'm':
 			if (!mode_selected) {
@@ -435,6 +447,8 @@ int main(int argc, char *argv[])
 			TEST_ASSERT(uffd_delay >= 0,
 				    "A negative UFFD delay is not supported.");
 			break;
+		case 'b':
+			guest_memory_bytes = strtoull(optarg, NULL, 0);
 		case 'h':
 		default:
 			help(argv[0]);
@@ -448,7 +462,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, use_uffd, uffd_delay);
+		run_test(i, use_uffd, uffd_delay, guest_memory_bytes);
 	}
 
 	return 0;
-- 
2.24.1.735.g03f4e72817-goog

