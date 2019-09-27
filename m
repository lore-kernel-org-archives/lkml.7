Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A396EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77290217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfI0IYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:24:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfI0IYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:24:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A038A687A6A0D46E8C97;
        Fri, 27 Sep 2019 16:24:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Sep 2019
 16:24:50 +0800
Subject: [PATCH 2/2] perf/ring_buffer: Matching the memory allocate and free,
 in rb_alloc()
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.co>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <4d308608-54e2-05fa-5a1a-9cb7b4986bd1@huawei.com>
Message-ID: <68211803-de9a-cae1-2627-6a5e5ae0853b@huawei.com>
Date:   Fri, 27 Sep 2019 16:24:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4d308608-54e2-05fa-5a1a-9cb7b4986bd1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf_mmap_alloc_page() is used to allocate memory in
rb_alloc(), but using free_page() to free memory in the failure path.

It's better to use perf_mmap_free_page() instead.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
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
@@ -799,14 +807,6 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
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
-- 
2.7.4

