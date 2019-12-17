Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0647C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22C421739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfLQOOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:14:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:46658 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728695AbfLQOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:14:14 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihDbP-0005Tm-9c; Tue, 17 Dec 2019 17:13:31 +0300
Subject: Re: [PATCH v2] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20191217012508.31495-1-longman@redhat.com>
 <20191217093143.GC31063@dhcp22.suse.cz>
 <87c2ff49-999e-3196-791f-36e3d42ad79c@virtuozzo.com>
 <0b8a59a0-517f-1387-ad00-cb47fb5fc50c@redhat.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <99caa26d-e14d-ed38-f56a-e6aee203251a@virtuozzo.com>
Date:   Tue, 17 Dec 2019 17:13:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0b8a59a0-517f-1387-ad00-cb47fb5fc50c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.2019 17:00, Waiman Long wrote:
> On 12/17/19 5:50 AM, Kirill Tkhai wrote:
>> On 17.12.2019 12:31, Michal Hocko wrote:
>>> On Mon 16-12-19 20:25:08, Waiman Long wrote:
>>> [...]
>>>> Both the hugetbl_lock and the subpool lock can be acquired in
>>>> free_huge_page(). One way to solve the problem is to make both locks
>>>> irq-safe.
>>> Please document why we do not take this, quite natural path and instead
>>> we have to come up with an elaborate way instead. I believe the primary
>>> motivation is that some operations under those locks are quite
>>> expensive. Please add that to the changelog and ideally to the code as
>>> well. We probably want to fix those anyway and then this would be a
>>> temporary workaround.
>>>
>>>> Another alternative is to defer the freeing to a workqueue job.
>>>>
>>>> This patch implements the deferred freeing by adding a
>>>> free_hpage_workfn() work function to do the actual freeing. The
>>>> free_huge_page() call in a non-task context saves the page to be freed
>>>> in the hpage_freelist linked list in a lockless manner.
>>> Do we need to over complicate this (presumably) rare event by a lockless
>>> algorithm? Why cannot we use a dedicated spin lock for for the linked
>>> list manipulation? This should be really a trivial code without an
>>> additional burden of all the lockless subtleties.
>> Why not llist_add()/llist_del_all() ?
>>
> The llist_add() and llist_del_all() are just simple helpers. Because
> this lockless case involve synchronization of two variables, the llist
> helpers do not directly apply here. So the rests cannot be used. It will
> look awkward it is partially converted to use the helpers. If we convert
> to use a lock as suggested by Michal, using the helpers will be an
> overkill as xchg() will not be needed.

I don't understand you. What are two variables?

Why can't you simply do the below?

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac65bb5e38ac..e8ec753f3d92 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1136,7 +1136,7 @@ static inline void ClearPageHugeTemporary(struct page *page)
 	page[2].mapping = NULL;
 }
 
-void free_huge_page(struct page *page)
+static void __free_huge_page(struct page *page)
 {
 	/*
 	 * Can't pass hstate in here because it is called from the
@@ -1199,6 +1199,35 @@ void free_huge_page(struct page *page)
 	spin_unlock(&hugetlb_lock);
 }
 
+static struct llist_head hpage_freelist = LLIST_HEAD_INIT;
+
+static void free_hpage_workfn(struct work_struct *work)
+{
+	struct llist_node *node;
+	struct page *page;
+
+	node = llist_del_all(&hpage_freelist);
+
+	while (node) {
+		page = container_of(node, struct page, mapping);
+		node = node->next;
+		__free_huge_page(page);
+	}
+}
+
+static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
+
+void free_huge_page(struct page *page)
+{
+	if (!in_task()) {
+		if (llist_add((struct llist_node *)&page->mapping, &hpage_freelist))
+			schedule_work(&free_hpage_work);
+		return;
+	}
+
+	__free_huge_page(page);
+}
+
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
 	INIT_LIST_HEAD(&page->lru);

