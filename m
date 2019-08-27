Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C959C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7F92077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfH0NKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36845 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbfH0NKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:10:38 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D14222A09D0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:10:37 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id s21so11996293plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 06:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RumdDPuxAxQEARVf3xy6WP1uSjlOuenkB+TPs1KNIZM=;
        b=goKtEPv3G9arffzyaY4g7aJGu//bLsmJ0v8uJHKD3Jko75mtz9yBL1HFgZC1Pub8a4
         sxYTbxzu2UnUF4kcU/C8zJ6Sykcj5KGU2x+sQBqL2OaTwQW0IFGSmg5k6nEyk+78NEtB
         nfOEI76JMbrIX6g1JxuQjv8cbzW98phyguWwy8Q9pVlUH0Ih9D0B5RlA9cZRoX44PI6i
         WwQ+1CaxVtfpaCB15S4nwaL+x1SK5VkqeJPZ6IKEMKj6l4j2GrJL3zywSaPFFdy86+ZB
         ppVjdU3ne1nMdMbEn601Akm0P0yHEUYRdDlCf8iwmdIh5+uC7aykJ0Q4zDokTGKl2Wy5
         XNFw==
X-Gm-Message-State: APjAAAUBVIB1bSfGgJ8CkinAmsg7NmqEMMvPUbCJc60lEKmbSO4cpH6j
        bqxVId1hWGtqa3tYYWVxoImhi7WdqoA+XmfEMKmTlEbl0qSCaLsCpuRbFftwjEys5cx/Wh2kiWs
        IR31TpaOTAczze+IxMgijTUjw
X-Received: by 2002:a65:5c02:: with SMTP id u2mr21287743pgr.367.1566911436705;
        Tue, 27 Aug 2019 06:10:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpiuICQQesdWajJ50Fpm3xB5i4rNDY8EzOzGh/Ist8c1rnt9lIIJ2tiNAhzjDg7f4qxKrmrA==
X-Received: by 2002:a65:5c02:: with SMTP id u2mr21287718pgr.367.1566911436384;
        Tue, 27 Aug 2019 06:10:36 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o67sm24393050pfb.39.2019.08.27.06.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 06:10:35 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>, peterx@redhat.com
Subject: [PATCH 2/4] KVM: selftests: Create VM earlier for dirty log test
Date:   Tue, 27 Aug 2019 21:10:13 +0800
Message-Id: <20190827131015.21691-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827131015.21691-1-peterx@redhat.com>
References: <20190827131015.21691-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we've just removed the dependency of vm type in previous patch,
now we can create the vm much earlier.  Note that to move it earlier
we used an approximation of number of extra pages but it should be
fine.

This prepares for the follow up patches to finally remove the
duplication of guest mode parsings.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 424efcf8c734..040952f3d4ad 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -264,6 +264,9 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 	return vm;
 }
 
+#define DIRTY_MEM_BITS 30 /* 1G */
+#define PAGE_SHIFT_4K  12
+
 static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 		     unsigned long interval, uint64_t phys_offset)
 {
@@ -273,6 +276,18 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	uint64_t max_gfn;
 	unsigned long *bmap;
 
+	/*
+	 * We reserve page table for 2 times of extra dirty mem which
+	 * will definitely cover the original (1G+) test range.  Here
+	 * we do the calculation with 4K page size which is the
+	 * smallest so the page number will be enough for all archs
+	 * (e.g., 64K page size guest will need even less memory for
+	 * page tables).
+	 */
+	vm = create_vm(mode, VCPU_ID,
+		       2ul << (DIRTY_MEM_BITS - PAGE_SHIFT_4K),
+		       guest_code);
+
 	switch (mode) {
 	case VM_MODE_P52V48_4K:
 		guest_pa_bits = 52;
@@ -319,7 +334,7 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	 * A little more than 1G of guest page sized pages.  Cover the
 	 * case where the size is not aligned to 64 pages.
 	 */
-	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
+	guest_num_pages = (1ul << (DIRTY_MEM_BITS - guest_page_shift)) + 16;
 #ifdef __s390x__
 	/* Round up to multiple of 1M (segment size) */
 	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
@@ -345,8 +360,6 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	bmap = bitmap_alloc(host_num_pages);
 	host_bmap_track = bitmap_alloc(host_num_pages);
 
-	vm = create_vm(mode, VCPU_ID, guest_num_pages, guest_code);
-
 #ifdef USE_CLEAR_DIRTY_LOG
 	struct kvm_enable_cap cap = {};
 
-- 
2.21.0

