Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343A8C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CFD22CE9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfHSQOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:14:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfHSQOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:14:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6D44344;
        Mon, 19 Aug 2019 09:14:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1B653F718;
        Mon, 19 Aug 2019 09:14:52 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCHv2] lib/test_kasan: add roundtrip tests
Date:   Mon, 19 Aug 2019 17:14:49 +0100
Message-Id: <20190819161449.30248-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In several places we need to be able to operate on pointers which have
gone via a roundtrip:

	virt -> {phys,page} -> virt

With KASAN_SW_TAGS, we can't preserve the tag for SLUB objects, and the
{phys,page} -> virt conversion will use KASAN_TAG_KERNEL.

This patch adds tests to ensure that this works as expected, without
false positives which have recently been spotted [1,2] in testing.

[1] https://lore.kernel.org/linux-arm-kernel/20190819114420.2535-1-walter-zh.wu@mediatek.com/
[2] https://lore.kernel.org/linux-arm-kernel/20190819132347.GB9927@lakrids.cambridge.arm.com/

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 lib/test_kasan.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

Since v1:
* Spin as a separate patch
* Fix typo
* Note examples in commit message.

Mark.

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index b63b367a94e8..cf7b93f0d90c 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -19,6 +19,8 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 
+#include <asm/page.h>
+
 /*
  * Note: test functions are marked noinline so that their names appear in
  * reports.
@@ -337,6 +339,42 @@ static noinline void __init kmalloc_uaf2(void)
 	kfree(ptr2);
 }
 
+static noinline void __init kfree_via_page(void)
+{
+	char *ptr;
+	size_t size = 8;
+	struct page *page;
+	unsigned long offset;
+
+	pr_info("invalid-free false positive (via page)\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	page = virt_to_page(ptr);
+	offset = offset_in_page(ptr);
+	kfree(page_address(page) + offset);
+}
+
+static noinline void __init kfree_via_phys(void)
+{
+	char *ptr;
+	size_t size = 8;
+	phys_addr_t phys;
+
+	pr_info("invalid-free false positive (via phys)\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	phys = virt_to_phys(ptr);
+	kfree(phys_to_virt(phys));
+}
+
 static noinline void __init kmem_cache_oob(void)
 {
 	char *p;
@@ -737,6 +775,8 @@ static int __init kmalloc_tests_init(void)
 	kmalloc_uaf();
 	kmalloc_uaf_memset();
 	kmalloc_uaf2();
+	kfree_via_page();
+	kfree_via_phys();
 	kmem_cache_oob();
 	memcg_accounted_kmem_cache();
 	kasan_stack_oob();
-- 
2.11.0

