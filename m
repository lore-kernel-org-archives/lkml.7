Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5205C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADE0207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576533074;
	bh=dTlq4UrRX+WzctKsCGMfNSVDjj96gEsT6b8myF4j8us=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0vl8dDYgTGl/+wLZrFzzhEtUhtACDx0iPynXK3ZvrJdq7UgsceWhG1v/Bdn2C+dI1
	 ixss8kr32WyHIrVOK5SdwPfJuP62tmbWlwbV2LBV5M+3riFtDcABLzoMF44Qyzi0Dk
	 LrJK41g5WsRaELnNz/Kf2a+t8WYtahtLxrN1NOww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLPVvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLPVvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:51:13 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65DF2072B;
        Mon, 16 Dec 2019 21:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576533071;
        bh=dTlq4UrRX+WzctKsCGMfNSVDjj96gEsT6b8myF4j8us=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pIXhRRKhZvjN4Q8ibxVdfOsYEd1SSg2tUVXFVwP9hWciLx5eMY9MFi15CkDooJhW9
         aZUJdlIFmXLYKRDRzufoD4Kdxs7BRnRW+kiIrg1VLdZ0FKMUTfzQejSAXs2J6TggW/
         lGprYXeE6ukLhccdsBMF5YB5FbIcmMxczjDy3CKQ=
Date:   Mon, 16 Dec 2019 13:51:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
Message-Id: <20191216135110.b6fb283ba5551c8cfb22494e@linux-foundation.org>
In-Reply-To: <20191216182739.26880-1-longman@redhat.com>
References: <20191216182739.26880-1-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 13:27:39 -0500 Waiman Long <longman@redhat.com> wrote:

> The following lockdep splat was observed when a certain hugetlbfs test
> was run:
> 
> ...
> 
> Both the hugetbl_lock and the subpool lock can be acquired in
> free_huge_page(). One way to solve the problem is to make both locks
> irq-safe. Another alternative is to defer the freeing to a workqueue job.
> 
> This patch implements the deferred freeing by adding a
> free_hpage_workfn() work function to do the actual freeing. The
> free_huge_page() call in a non-task context saves the page to be freed
> in the hpage_freelist linked list in a lockless manner.
> 
> The generic workqueue is used to process the work, but a dedicated
> workqueue can be used instead if it is desirable to have the huge page
> freed ASAP.
>
> ...
>
> @@ -1199,6 +1199,73 @@ void free_huge_page(struct page *page)
>  	spin_unlock(&hugetlb_lock);
>  }
>  
> +/*
> + * As free_huge_page() can be called from a non-task context, we have
> + * to defer the actual freeing in a workqueue to prevent potential
> + * hugetlb_lock deadlock.
> + *
> + * free_hpage_workfn() locklessly retrieves the linked list of pages to
> + * be freed and frees them one-by-one. As the page->mapping pointer is
> + * going to be cleared in __free_huge_page() anyway, it is reused as the
> + * next pointer of a singly linked list of huge pages to be freed.
> + */
> +#define NEXT_PENDING	((struct page *)-1)
> +static struct page *hpage_freelist;
> +
> +static void free_hpage_workfn(struct work_struct *work)
> +{
> +	struct page *curr, *next;
> +	int cnt = 0;
> +
> +	do {
> +		curr = xchg(&hpage_freelist, NULL);
> +		if (!curr)
> +			break;
> +
> +		while (curr) {
> +			next = (struct page *)READ_ONCE(curr->mapping);
> +			if (next == NEXT_PENDING) {
> +				cpu_relax();
> +				continue;
> +			}
> +			__free_huge_page(curr);
> +			curr = next;
> +			cnt++;
> +		}
> +	} while (!READ_ONCE(hpage_freelist));
> +
> +	if (!cnt)
> +		return;
> +	pr_debug("HugeTLB: free_hpage_workfn() frees %d huge page(s)\n", cnt);
> +}
> +static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> +
> +void free_huge_page(struct page *page)
> +{
> +	/*
> +	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> +	 */
> +	if (!in_task()) {
> +		struct page *next;
> +
> +		page->mapping = (struct address_space *)NEXT_PENDING;
> +		next = xchg(&hpage_freelist, page);
> +		WRITE_ONCE(page->mapping, (struct address_space *)next);

The NEXT_PENDING stuff could do with come commenting, I think.  It's
reasonably obvious, but not obvious enough.  For example, why does the
second write to page->mapping use WRITE_ONCE() but the first does not. 
Please spell out the design, fully.

> +		schedule_work(&free_hpage_work);
> +		return;
> +	}
> +
> +	/*
> +	 * Racing may prevent some deferred huge pages in hpage_freelist
> +	 * from being freed. Check here and call schedule_work() if that
> +	 * is the case.
> +	 */
> +	if (unlikely(hpage_freelist && !work_pending(&free_hpage_work)))
> +		schedule_work(&free_hpage_work);
> +
> +	__free_huge_page(page);
> +}
> +
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
>  	INIT_LIST_HEAD(&page->lru);

Otherwise it looks OK to me.  Deferring freeing in this way is
generally lame and gives rise to concerns about memory exhaustion in
strange situations, and to concerns about various memory accounting
stats being logically wrong for short periods.  But we already do this
in (too) many places, so fingers crossed :(
