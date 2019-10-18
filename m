Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77532CA9EA4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6EA222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633985AbfJRMse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:48:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56788 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633960AbfJRMsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:48:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLRfu-00075p-B8; Fri, 18 Oct 2019 14:48:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E224A1C03AB;
        Fri, 18 Oct 2019 14:48:09 +0200 (CEST)
Date:   Fri, 18 Oct 2019 12:48:09 -0000
From:   "tip-bot2 for Yunfeng Ye" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/ring_buffer: Modify the parameter type of
 perf_mmap_free_page()
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, <jolsa@redhat.co>,
        <acme@kernel.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <namhyung@kernel.org>, <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <e6ae3f0c-d04c-50f9-544a-aee3b30330cd@huawei.com>
References: <e6ae3f0c-d04c-50f9-544a-aee3b30330cd@huawei.com>
MIME-Version: 1.0
Message-ID: <157140288978.29376.16956109153818084888.tip-bot2@tip-bot2>
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

Commit-ID:     8a9f91c51ea72b126864e0db616b1bac12261200
Gitweb:        https://git.kernel.org/tip/8a9f91c51ea72b126864e0db616b1bac12261200
Author:        Yunfeng Ye <yeyunfeng@huawei.com>
AuthorDate:    Mon, 14 Oct 2019 16:14:59 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Oct 2019 21:31:55 +02:00

perf/ring_buffer: Modify the parameter type of perf_mmap_free_page()

In perf_mmap_free_page(), the unsigned long type is converted to the
pointer type, but where the call is made, the pointer type is converted
to the unsigned long type. There is no need to do these operations.

Modify the parameter type of perf_mmap_free_page() to pointer type.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <jolsa@redhat.co>
Cc: <acme@kernel.org>
Cc: <mingo@redhat.com>
Cc: <mark.rutland@arm.com>
Cc: <namhyung@kernel.org>
Cc: <alexander.shishkin@linux.intel.com>
Link: https://lkml.kernel.org/r/e6ae3f0c-d04c-50f9-544a-aee3b30330cd@huawei.com
---
 kernel/events/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index ffb59a4..abc145c 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -799,9 +799,9 @@ fail:
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
 
