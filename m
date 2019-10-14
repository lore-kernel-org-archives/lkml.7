Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10864ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D625B2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfJNIPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:15:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728883AbfJNIPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:15:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 157D8BF304DC5C62F497;
        Mon, 14 Oct 2019 16:15:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 16:15:13 +0800
Subject: [PATCH 1/2] perf/ring_buffer: Modify the parameter type of
 perf_mmap_free_page()
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.co>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <4d308608-54e2-05fa-5a1a-9cb7b4986bd1@huawei.com>
Message-ID: <e6ae3f0c-d04c-50f9-544a-aee3b30330cd@huawei.com>
Date:   Mon, 14 Oct 2019 16:14:59 +0800
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

In perf_mmap_free_page(), the unsigned long type is converted to the
pointer type, but where the call is made, the pointer type is converted
to the unsigned long type. There is no need to do these operations.

Modify the parameter type of perf_mmap_free_page() to pointer type.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/events/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index ffb59a4..abc145c 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -799,9 +799,9 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	return NULL;
 }

-static void perf_mmap_free_page(unsigned long addr)
+static void perf_mmap_free_page(void *addr)
 {
-	struct page *page = virt_to_page((void *)addr);
+	struct page *page = virt_to_page(addr);

 	page->mapping = NULL;
 	__free_page(page);
@@ -811,9 +811,9 @@ void rb_free(struct ring_buffer *rb)
 {
 	int i;

-	perf_mmap_free_page((unsigned long)rb->user_page);
+	perf_mmap_free_page(rb->user_page);
 	for (i = 0; i < rb->nr_pages; i++)
-		perf_mmap_free_page((unsigned long)rb->data_pages[i]);
+		perf_mmap_free_page(rb->data_pages[i]);
 	kfree(rb);
 }

-- 
2.7.4

