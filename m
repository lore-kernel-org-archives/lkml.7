Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC94C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980AA24672
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPWZh1O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfLPVgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:36:02 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36960 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfLPVgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:36:00 -0500
Received: by mail-pf1-f202.google.com with SMTP id 13so7725391pfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Cb2Ll4QXvvxKS0ilQTgclxRvuIG8oGi9ZpuJq+AVeGI=;
        b=EPWZh1O0XCBJyJ0wGj490hmGpvf5WjDFT++hLao6jaqUiD0e/6ruMhH68MpdqURHHT
         XCEzJHF7EDvZ2NcBPiPZccawHLx9Z2egtesQFs18fuRGGrkRF5kKcT6fnXCY7P+y5Erf
         UeAJnZ9SEG0UpIM791DopdmdeuGUI0UNVN/pWVXCqaB/6Y2HZlPO+4zNGeJHoajSELPW
         e0DYcqnbcgL0OpyoqYZfa15GqcGGsn35F6A63RhGY2pfSBFh6b/tJXNxIkIAuaEkXcZW
         uWxxR7JsaN6VeyVQkBAq6PAHnpnKKbn7qJeUrpX5mONnthjoUhVRukT5l4KElZTCxB66
         pkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cb2Ll4QXvvxKS0ilQTgclxRvuIG8oGi9ZpuJq+AVeGI=;
        b=aGnpuJuKZ92GB/IjxSXCBeDUGMY3zBdABWO4QoUKcCe0Q2FiQhnydqMm10Z5jrsSp9
         72utaoTAAaieVyZMCSMI7iOAXIRUiM94ye42E7AhCqe1j6mLKKldc6ogLLCqtnNuYqkX
         HoNsUIIERAYLh+wF6jndgzcGdIP7UnAfB0U8+11pBqXrQtzTrspsBDIaPy1p09a42dTX
         /ABpbpc4yfLiv5WMoAFwg7/Iqzw17vj1c7FkBUXHiyaogH5S9+zD00DY5Jecn5mcugsZ
         w3o143pCfYOe1dtyebH8zbBNyRQSwO7etB3DO2HI1G/Dhp/LItH8hU01gb2gDAglW+Lh
         kNKw==
X-Gm-Message-State: APjAAAUldYGdFwpbFdNOKOq3IfGBOfaki25TF1agAHweYITvtcfO6F2b
        G6SjsMZQ19YGY5Kddnwnb6fCzPlJDO9seQPjQVWFhPDyjpmXbPojDTauRVPQcJDJtn3gmMJnXQS
        g4V6/fyDr4v5KJbsfkt0jSunQw/LmCvTxNDPA/pMKpqjwBIEf14Qr3K/fXcrRn6vL6zXTdwnH
X-Google-Smtp-Source: APXvYqz9+YLSTfAT+LH74TqRajXvWv9WO9UqCRKdEncBViMQD/uziJGjUllVSzRrUyVxqH+qg+XJ2YfwMb40
X-Received: by 2002:a63:9548:: with SMTP id t8mr8993392pgn.205.1576532157902;
 Mon, 16 Dec 2019 13:35:57 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:35:27 -0800
In-Reply-To: <20191216213532.91237-1-bgardon@google.com>
Message-Id: <20191216213532.91237-5-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213532.91237-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 4/8] KVM: selftests: Add memory size parameter to the
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

