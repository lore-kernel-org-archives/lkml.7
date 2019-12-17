Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066BBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79582082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLQTCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:02:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:48962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfLQTCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:02:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4361EAD93;
        Tue, 17 Dec 2019 19:02:31 +0000 (UTC)
Date:   Tue, 17 Dec 2019 10:55:57 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH v3] mm/hugetlb: Defer freeing of huge pages if in
 non-task context
Message-ID: <20191217185557.tgtsvaad24j745gf@linux-p48b>
Mail-Followup-To: Waiman Long <longman@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
References: <20191217170331.30893-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217170331.30893-1-longman@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019, Waiman Long wrote:
>Both the hugetbl_lock and the subpool lock can be acquired in
>free_huge_page(). One way to solve the problem is to make both locks
>irq-safe. However, Mike Kravetz had learned that the hugetlb_lock is
>held for a linear scan of ALL hugetlb pages during a cgroup reparentling
>operation. So it is just too long to have irq disabled unless we can
>break hugetbl_lock down into finer-grained locks with shorter lock
>hold times.
>
>Another alternative is to defer the freeing to a workqueue job.  This
>patch implements the deferred freeing by adding a free_hpage_workfn()
>work function to do the actual freeing. The free_huge_page() call in
>a non-task context saves the page to be freed in the hpage_freelist
>linked list in a lockless manner using the llist APIs.
>
>The generic workqueue is used to process the work, but a dedicated
>workqueue can be used instead if it is desirable to have the huge page
>freed ASAP.
>
>Thanks to Kirill Tkhai <ktkhai@virtuozzo.com> for suggesting the use
>of llist APIs which simplfy the code.
>
> [v2: Add more comment & remove unneeded racing check]
> [v3: Update commit log, remove pr_debug & use llist APIs]

Very creative reusing the mapping pointer, along with the llist api,
this solves the problem nicely (temporarily at least).

Two small nits below.

Acked-by: Davidlohr Bueso <dbueso@suse.de>

>Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>Signed-off-by: Waiman Long <longman@redhat.com>
>---
> mm/hugetlb.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 50 insertions(+), 1 deletion(-)
>
>diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>+static LLIST_HEAD(hpage_freelist);
>+
>+static void free_hpage_workfn(struct work_struct *work)
>+{
>+	struct llist_node *node;
>+	struct page *page;
>+
>+	node = llist_del_all(&hpage_freelist);
>+
>+	while (node) {
>+		page = container_of((struct address_space **)node,
>+				     struct page, mapping);
>+		node = node->next;

llist_next()

>+		__free_huge_page(page);
>+	}
>+}
>+static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>+
>+void free_huge_page(struct page *page)
>+{
>+	/*
>+	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
>+	 */
>+	if (!in_task()) {

unlikely()?

Thanks,
Davidlohr
