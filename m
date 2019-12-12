Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49A5C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B055A2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfLLTK5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:10:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:55346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730355AbfLLTK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:10:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6396B182;
        Thu, 12 Dec 2019 19:10:53 +0000 (UTC)
Date:   Thu, 12 Dec 2019 11:04:27 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>, aneesh.kumar@linux.ibm.com
Subject: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
Message-ID: <20191212190427.ouyohviijf5inhur@linux-p48b>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        aneesh.kumar@linux.ibm.com
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been deadlock reports[1, 2] where put_page is called
from softirq context and this causes trouble with the hugetlb_lock,
as well as potentially the subpool lock.

For such an unlikely scenario, lets not add irq dancing overhead
to the lock+unlock operations, which could incur in expensive
instruction dependencies, particularly when considering hard-irq
safety. For example PUSHF+POPF on x86.

Instead, just use a workqueue and do the free_huge_page() in regular
task context.

[1] https://lore.kernel.org/lkml/20191211194615.18502-1-longman@redhat.com/
[2] https://lore.kernel.org/lkml/20180905112341.21355-1-aneesh.kumar@linux.ibm.com/

Reported-by: Waiman Long <longman@redhat.com>
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---

- Changes from v1: Only use wq when in_interrupt(), otherwise business
    as usual. Also include the proper header file.

- While I have not reproduced this issue, the v1 using wq passes all hugetlb
    related tests in ltp.

 mm/hugetlb.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac65bb5e38ac..f28cf601938d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -27,6 +27,7 @@
 #include <linux/swapops.h>
 #include <linux/jhash.h>
 #include <linux/numa.h>
+#include <linux/workqueue.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -1136,7 +1137,13 @@ static inline void ClearPageHugeTemporary(struct page *page)
 	page[2].mapping = NULL;
 }
 
-void free_huge_page(struct page *page)
+static struct workqueue_struct *hugetlb_free_page_wq;
+struct hugetlb_free_page_work {
+	struct page *page;
+	struct work_struct work;
+};
+
+static void __free_huge_page(struct page *page)
 {
 	/*
 	 * Can't pass hstate in here because it is called from the
@@ -1199,6 +1206,36 @@ void free_huge_page(struct page *page)
 	spin_unlock(&hugetlb_lock);
 }
 
+static void free_huge_page_workfn(struct work_struct *work)
+{
+	struct page *page;
+
+	page = container_of(work, struct hugetlb_free_page_work, work)->page;
+	__free_huge_page(page);
+}
+
+void free_huge_page(struct page *page)
+{
+	if (unlikely(in_interrupt())) {
+		/*
+		 * While uncommon, free_huge_page() can be at least
+		 * called from softirq context, defer freeing such
+		 * that the hugetlb_lock and spool->lock need not have
+		 * to deal with irq dances just for this.
+		 */
+		struct hugetlb_free_page_work work;
+
+		work.page = page;
+		INIT_WORK_ONSTACK(&work.work, free_huge_page_workfn);
+		queue_work(hugetlb_free_page_wq, &work.work);
+
+		/* wait until the huge page freeing is done */
+		flush_work(&work.work);
+		destroy_work_on_stack(&work.work);
+	} else
+		__free_huge_page(page);
+}
+
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
 	INIT_LIST_HEAD(&page->lru);
@@ -2816,6 +2853,12 @@ static int __init hugetlb_init(void)
 
 	for (i = 0; i < num_fault_mutexes; i++)
 		mutex_init(&hugetlb_fault_mutex_table[i]);
+
+	hugetlb_free_page_wq = alloc_workqueue("hugetlb_free_page_wq",
+					       WQ_MEM_RECLAIM, 0);
+	if (!hugetlb_free_page_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 subsys_initcall(hugetlb_init);
--
2.16.4
