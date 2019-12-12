Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40776C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3E32054F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbfLLVck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:32:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:8358 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbfLLVck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:32:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 13:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="216426268"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2019 13:32:39 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DE8C330038C; Thu, 12 Dec 2019 13:32:39 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2] hugetlbfs: Disable softIRQ when taking hugetlb_lock
References: <20191211194615.18502-1-longman@redhat.com>
        <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
        <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
        <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
        <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
Date:   Thu, 12 Dec 2019 13:32:39 -0800
In-Reply-To: <20191212060650.ftqq27ftutxpc5hq@linux-p48b> (Davidlohr Bueso's
        message of "Wed, 11 Dec 2019 22:06:50 -0800")
Message-ID: <871rt99qmg.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso <dave@stgolabs.net> writes:
> +void free_huge_page(struct page *page)
> +{
> +	struct hugetlb_free_page_work work;
> +
> +	work.page = page;
> +	INIT_WORK_ONSTACK(&work.work, free_huge_page_workfn);
> +	queue_work(hugetlb_free_page_wq, &work.work);
> +
> +	/*
> +	 * Wait until free_huge_page is done.
> +	 */
> +	flush_work(&work.work);
> +	destroy_work_on_stack(&work.work);

Does flushing really work in softirq context?

Anyways, waiting seems inefficient over fire'n'forget

You'll need a per cpu pre allocated work item and a queue.
Then take a lock on the the queue and link the page into
it and trigger the work item if it's not already pending.

And add a in_interrupt() check of course.


-Andi
