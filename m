Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C5EC49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E01F2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405411AbfIJPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfIJPSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:18:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55E0810DCC80;
        Tue, 10 Sep 2019 15:18:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70E3619C58;
        Tue, 10 Sep 2019 15:18:48 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 1/2] x86/kdump: Split some code out of reserve_crashkernel
Date:   Tue, 10 Sep 2019 23:13:40 +0800
Message-Id: <20190910151341.14986-2-kasong@redhat.com>
In-Reply-To: <20190910151341.14986-1-kasong@redhat.com>
References: <20190910151341.14986-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Tue, 10 Sep 2019 15:18:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out the code related to finding suitable region for kdump out of
reserve_crashkernel, clean up and refactor for further change, no feature
change.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/setup.c | 92 +++++++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bbe35bf879f5..71f20bb18cb0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -526,6 +526,63 @@ static int __init reserve_crashkernel_low(void)
 	return 0;
 }
 
+static int __init crashkernel_find_region(unsigned long long *crash_base,
+					  unsigned long long *crash_size,
+					  bool high)
+{
+	unsigned long long base, size;
+
+	base = *crash_base;
+	size = *crash_size;
+
+	/*
+	 * base == 0 means: find the address automatically, else just
+	 * verify the region is useable
+	 */
+	if (base) {
+		unsigned long long start;
+
+		start = memblock_find_in_range(base, base + size,
+					       size, 1 << 20);
+		if (start != base) {
+			pr_info("crashkernel reservation failed - memory is in use.\n");
+			return -1;
+		}
+		return 0;
+	}
+
+	/*
+	 * crashkernel=x,high reserves memory over 4G, also allocates
+	 * 256M extra low memory for DMA buffers and swiotlb.
+	 * But the extra memory is not required for all machines.
+	 * So try low memory first and fall back to high memory
+	 * unless "crashkernel=size[KMG],high" is specified.
+	 */
+	if (high)
+		goto high_reserve;
+
+	base = memblock_find_in_range(CRASH_ALIGN,
+				      CRASH_ADDR_LOW_MAX, size,
+				      CRASH_ALIGN);
+	if (base)
+		goto found;
+
+high_reserve:
+	/* Try high reserve */
+	base = memblock_find_in_range(CRASH_ALIGN,
+				      CRASH_ADDR_HIGH_MAX, size,
+				      CRASH_ALIGN);
+	if (base)
+		goto found;
+
+	pr_info("crashkernel reservation failed - No suitable area found.\n");
+	return -1;
+found:
+	*crash_base = base;
+	*crash_size = size;
+	return 0;
+}
+
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base, total_mem;
@@ -550,39 +607,10 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	/* 0 means: find the address automatically */
-	if (!crash_base) {
-		/*
-		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over 4G, also allocates
-		 * 256M extra low memory for DMA buffers and swiotlb.
-		 * But the extra memory is not required for all machines.
-		 * So try low memory first and fall back to high memory
-		 * unless "crashkernel=size[KMG],high" is specified.
-		 */
-		if (!high)
-			crash_base = memblock_find_in_range(CRASH_ALIGN,
-						CRASH_ADDR_LOW_MAX,
-						crash_size, CRASH_ALIGN);
-		if (!crash_base)
-			crash_base = memblock_find_in_range(CRASH_ALIGN,
-						CRASH_ADDR_HIGH_MAX,
-						crash_size, CRASH_ALIGN);
-		if (!crash_base) {
-			pr_info("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else {
-		unsigned long long start;
+	ret = crashkernel_find_region(&crash_base, &crash_size, high);
+	if (ret)
+		return;
 
-		start = memblock_find_in_range(crash_base,
-					       crash_base + crash_size,
-					       crash_size, 1 << 20);
-		if (start != crash_base) {
-			pr_info("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-	}
 	ret = memblock_reserve(crash_base, crash_size);
 	if (ret) {
 		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
-- 
2.21.0

