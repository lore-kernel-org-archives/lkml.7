Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66440C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A42521D7D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fpQ2xygm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfLPWlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:41:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37494 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfLPWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:41:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGMY7F5085443;
        Mon, 16 Dec 2019 22:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=utHCjfqt2C6hjz6GKGBiHdj8ODiq5ltxzbVwQ8evxhE=;
 b=fpQ2xygmJhFW6M1fivA5ceukacwOJRe3dsaprlTZzIGO0yZKyauj+7IU4Da/2P6KoXKg
 kWXb73NLHdiDOrqm4Cgiht72ifB2iueMGpgNVjyazURXyENGtXfN4VEyJSZjZsuT4OtG
 TSjIGYCFpb5iYP5bBjsQ75Y0+oSGeb16lmOnpchQ2ufr71WiqqYB9SKuPYnWv6yFaNtt
 1xg6zUk0HnAMG93mdV7+/xxQVGoBFdxh2erSmVN3h0xi0k68Hyi8EI0eN+UQa+yoRwbt
 ieBEHJsGKJgDAoDEVMc9hxSXWtj0ZX5O5YBFX/zJx53unKn6nvaevvkITxs01olsvire Dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wvqpq2n86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 22:40:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGMdHGn042093;
        Mon, 16 Dec 2019 22:40:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ww98tpv13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 22:40:27 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBGMeNRW003056;
        Mon, 16 Dec 2019 22:40:23 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Dec 2019 14:40:23 -0800
Subject: Re: [PATCH] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20191216182739.26880-1-longman@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <530afa00-4da9-61cd-d1f3-66803bcd30e6@oracle.com>
Date:   Mon, 16 Dec 2019 14:40:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216182739.26880-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912160189
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912160189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 10:27 AM, Waiman Long wrote:
> The following lockdep splat was observed when a certain hugetlbfs test
> was run:
<snip>
> This patch implements the deferred freeing by adding a
> free_hpage_workfn() work function to do the actual freeing. The
> free_huge_page() call in a non-task context saves the page to be freed
> in the hpage_freelist linked list in a lockless manner.
> 
> The generic workqueue is used to process the work, but a dedicated
> workqueue can be used instead if it is desirable to have the huge page
> freed ASAP.
> 
<snip>
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
> +		schedule_work(&free_hpage_work);
> +		return;
> +	}

As Andrew mentioned, the design for the lockless queueing could use more
explanation.  I had to draw some diagrams before I felt relatively confident
in the design.

> +
> +	/*
> +	 * Racing may prevent some deferred huge pages in hpage_freelist
> +	 * from being freed. Check here and call schedule_work() if that
> +	 * is the case.
> +	 */
> +	if (unlikely(hpage_freelist && !work_pending(&free_hpage_work)))
> +		schedule_work(&free_hpage_work);

Can you describe the race which would leave deferred huge pages on
hpage_freelist?  I am having a hard time determining how that can happen.

And, if this indeed can happen then I would have to ask what happens if
a page is 'stuck' and we do not call free_huge_page?  Do we need to take
that case into account?

Overall, I like the design and hope this will work.  I have been testing
a 'modified' version of the patch to always do the deferred freeing.  The
modification is simply to stress the code.   So far, I have not found any
issues in any of my testing.
-- 
Mike Kravetz
