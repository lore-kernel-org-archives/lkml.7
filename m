Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C33C352AB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9755320872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfI0Dnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:43:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6891 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726145AbfI0Dnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:43:50 -0400
X-UUID: d4b5f999be8148baadc251c1b858fb6c-20190927
X-UUID: d4b5f999be8148baadc251c1b858fb6c-20190927
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1048956367; Fri, 27 Sep 2019 11:43:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 27 Sep 2019 11:43:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Sep 2019 11:43:39 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH] kasan: fix the missing underflow in memmove and memcpy with CONFIG_KASAN_GENERIC=y
Date:   Fri, 27 Sep 2019 11:43:38 +0800
Message-ID: <20190927034338.15813-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmove() and memcpy() have missing underflow issues.
When -7 <= size < 0, then KASAN will miss to catch the underflow issue.
It looks like shadow start address and shadow end address is the same,
so it does not actually check anything.

The following test is indeed not caught by KASAN:

	char *p = kmalloc(64, GFP_KERNEL);
	memset((char *)p, 0, 64);
	memmove((char *)p, (char *)p + 4, -2);
	kfree((char*)p);

It should be checked here:

void *memmove(void *dest, const void *src, size_t len)
{
	check_memory_region((unsigned long)src, len, false, _RET_IP_);
	check_memory_region((unsigned long)dest, len, true, _RET_IP_);

	return __memmove(dest, src, len);
}

We fix the shadow end address which is calculated, then generic KASAN
get the right shadow end address and detect this underflow issue.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=199341

Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
---
 lib/test_kasan.c   | 36 ++++++++++++++++++++++++++++++++++++
 mm/kasan/generic.c |  8 ++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index b63b367a94e8..8bd014852556 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -280,6 +280,40 @@ static noinline void __init kmalloc_oob_in_memset(void)
 	kfree(ptr);
 }
 
+static noinline void __init kmalloc_oob_in_memmove_underflow(void)
+{
+	char *ptr;
+	size_t size = 64;
+
+	pr_info("underflow out-of-bounds in memmove\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	memset((char *)ptr, 0, 64);
+	memmove((char *)ptr, (char *)ptr + 4, -2);
+	kfree(ptr);
+}
+
+static noinline void __init kmalloc_oob_in_memmove_overflow(void)
+{
+	char *ptr;
+	size_t size = 64;
+
+	pr_info("overflow out-of-bounds in memmove\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	memset((char *)ptr, 0, 64);
+	memmove((char *)ptr + size, (char *)ptr, 2);
+	kfree(ptr);
+}
+
 static noinline void __init kmalloc_uaf(void)
 {
 	char *ptr;
@@ -734,6 +768,8 @@ static int __init kmalloc_tests_init(void)
 	kmalloc_oob_memset_4();
 	kmalloc_oob_memset_8();
 	kmalloc_oob_memset_16();
+	kmalloc_oob_in_memmove_underflow();
+	kmalloc_oob_in_memmove_overflow();
 	kmalloc_uaf();
 	kmalloc_uaf_memset();
 	kmalloc_uaf2();
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 616f9dd82d12..34ca23d59e67 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -131,9 +131,13 @@ static __always_inline bool memory_is_poisoned_n(unsigned long addr,
 						size_t size)
 {
 	unsigned long ret;
+	void *shadow_start = kasan_mem_to_shadow((void *)addr);
+	void *shadow_end = kasan_mem_to_shadow((void *)addr + size - 1) + 1;
 
-	ret = memory_is_nonzero(kasan_mem_to_shadow((void *)addr),
-			kasan_mem_to_shadow((void *)addr + size - 1) + 1);
+	if ((long)size < 0)
+		shadow_end = kasan_mem_to_shadow((void *)addr + size);
+
+	ret = memory_is_nonzero(shadow_start, shadow_end);
 
 	if (unlikely(ret)) {
 		unsigned long last_byte = addr + size - 1;
-- 
2.18.0

