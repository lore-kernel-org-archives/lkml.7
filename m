Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4998CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C676421835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633958AbfJRMs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:48:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56769 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633907AbfJRMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:48:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLRfu-00075o-4O; Fri, 18 Oct 2019 14:48:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A5A981C009C;
        Fri, 18 Oct 2019 14:48:09 +0200 (CEST)
Date:   Fri, 18 Oct 2019 12:48:09 -0000
From:   "tip-bot2 for Yunfeng Ye" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/ring_buffer: Matching the memory allocate and
 free, in rb_alloc()
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, <jolsa@redhat.co>,
        <acme@kernel.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <namhyung@kernel.org>, <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <575c7e8c-90c7-4e3a-b41d-f894d8cdbd7f@huawei.com>
References: <575c7e8c-90c7-4e3a-b41d-f894d8cdbd7f@huawei.com>
MIME-Version: 1.0
Message-ID: <157140288949.29376.10061367480857136332.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d7e78706e43107fa269fe34b1a69e653f5ec9f2c
Gitweb:        https://git.kernel.org/tip/d7e78706e43107fa269fe34b1a69e653f5ec9f2c
Author:        Yunfeng Ye <yeyunfeng@huawei.com>
AuthorDate:    Mon, 14 Oct 2019 16:15:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Oct 2019 21:31:55 +02:00

perf/ring_buffer: Matching the memory allocate and free, in rb_alloc()

Currently perf_mmap_alloc_page() is used to allocate memory in
rb_alloc(), but using free_page() to free memory in the failure path.

It's better to use perf_mmap_free_page() instead.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <jolsa@redhat.co>
Cc: <acme@kernel.org>
Cc: <mingo@redhat.com>
Cc: <mark.rutland@arm.com>
Cc: <namhyung@kernel.org>
Cc: <alexander.shishkin@linux.intel.com>
Link: https://lkml.kernel.org/r/575c7e8c-90c7-4e3a-b41d-f894d8cdbd7f@huawei.com
---
 kernel/events/ring_buffer.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index abc145c..246c83a 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -754,6 +754,14 @@ static void *perf_mmap_alloc_page(int cpu)
 	return page_address(page);
 }
 
+static void perf_mmap_free_page(void *addr)
+{
+	struct page *page = virt_to_page(addr);
+
+	page->mapping = NULL;
+	__free_page(page);
+}
+
 struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 {
 	struct ring_buffer *rb;
@@ -788,9 +796,9 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 
 fail_data_pages:
 	for (i--; i >= 0; i--)
-		free_page((unsigned long)rb->data_pages[i]);
+		perf_mmap_free_page(rb->data_pages[i]);
 
-	free_page((unsigned long)rb->user_page);
+	perf_mmap_free_page(rb->user_page);
 
 fail_user_page:
 	kfree(rb);
@@ -799,14 +807,6 @@ fail:
 	return NULL;
 }
 
-static void perf_mmap_free_page(void *addr)
-{
-	struct page *page = virt_to_page(addr);
-
-	page->mapping = NULL;
-	__free_page(page);
-}
-
 void rb_free(struct ring_buffer *rb)
 {
 	int i;
