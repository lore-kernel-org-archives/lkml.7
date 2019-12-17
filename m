Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3529C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66B12176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emS66htb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfLQO1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:27:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27013 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728903AbfLQO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576592828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1CBiShanVJNYbVwb0LcjMZgLZHPIdkMBclPmlJ8SwI=;
        b=emS66htbOUvll71uA4ObaQykPQXS0IwkGdoI/M+qoIBe35E3yxTMxAVODd8CEcsFCtFpwk
        31y3WSD7+5ggCTcvQPnjADejnxvK87HRyKTC64Mrce6gZXulnka55e3B/lYQ/tb7YocWeQ
        HvfNh91udVBfk1ZoOL/QJCXJrFm9gQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-fQXo3f4lPZOALOjDdo5WHQ-1; Tue, 17 Dec 2019 09:27:05 -0500
X-MC-Unique: fQXo3f4lPZOALOjDdo5WHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B1F7CF98F;
        Tue, 17 Dec 2019 14:27:03 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-81.rdu2.redhat.com [10.10.123.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B97F95D9E1;
        Tue, 17 Dec 2019 14:27:01 +0000 (UTC)
Subject: Re: [PATCH v2] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>
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
 <99caa26d-e14d-ed38-f56a-e6aee203251a@virtuozzo.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <64f74cba-c5b3-0cea-8713-70e408f6a495@redhat.com>
Date:   Tue, 17 Dec 2019 09:27:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <99caa26d-e14d-ed38-f56a-e6aee203251a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 9:13 AM, Kirill Tkhai wrote:
> On 17.12.2019 17:00, Waiman Long wrote:
>> On 12/17/19 5:50 AM, Kirill Tkhai wrote:
>>> On 17.12.2019 12:31, Michal Hocko wrote:
>>>> On Mon 16-12-19 20:25:08, Waiman Long wrote:
>>>> [...]
>>>>> Both the hugetbl_lock and the subpool lock can be acquired in
>>>>> free_huge_page(). One way to solve the problem is to make both locks
>>>>> irq-safe.
>>>> Please document why we do not take this, quite natural path and instead
>>>> we have to come up with an elaborate way instead. I believe the primary
>>>> motivation is that some operations under those locks are quite
>>>> expensive. Please add that to the changelog and ideally to the code as
>>>> well. We probably want to fix those anyway and then this would be a
>>>> temporary workaround.
>>>>
>>>>> Another alternative is to defer the freeing to a workqueue job.
>>>>>
>>>>> This patch implements the deferred freeing by adding a
>>>>> free_hpage_workfn() work function to do the actual freeing. The
>>>>> free_huge_page() call in a non-task context saves the page to be freed
>>>>> in the hpage_freelist linked list in a lockless manner.
>>>> Do we need to over complicate this (presumably) rare event by a lockless
>>>> algorithm? Why cannot we use a dedicated spin lock for for the linked
>>>> list manipulation? This should be really a trivial code without an
>>>> additional burden of all the lockless subtleties.
>>> Why not llist_add()/llist_del_all() ?
>>>
>> The llist_add() and llist_del_all() are just simple helpers. Because
>> this lockless case involve synchronization of two variables, the llist
>> helpers do not directly apply here. So the rests cannot be used. It will
>> look awkward it is partially converted to use the helpers. If we convert
>> to use a lock as suggested by Michal, using the helpers will be an
>> overkill as xchg() will not be needed.
> I don't understand you. What are two variables?
>
> Why can't you simply do the below?
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ac65bb5e38ac..e8ec753f3d92 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1136,7 +1136,7 @@ static inline void ClearPageHugeTemporary(struct page *page)
>  	page[2].mapping = NULL;
>  }
>  
> -void free_huge_page(struct page *page)
> +static void __free_huge_page(struct page *page)
>  {
>  	/*
>  	 * Can't pass hstate in here because it is called from the
> @@ -1199,6 +1199,35 @@ void free_huge_page(struct page *page)
>  	spin_unlock(&hugetlb_lock);
>  }
>  
> +static struct llist_head hpage_freelist = LLIST_HEAD_INIT;
> +
> +static void free_hpage_workfn(struct work_struct *work)
> +{
> +	struct llist_node *node;
> +	struct page *page;
> +
> +	node = llist_del_all(&hpage_freelist);
> +
> +	while (node) {
> +		page = container_of(node, struct page, mapping);
> +		node = node->next;
> +		__free_huge_page(page);
> +	}
> +}
> +
> +static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> +
> +void free_huge_page(struct page *page)
> +{
> +	if (!in_task()) {
> +		if (llist_add((struct llist_node *)&page->mapping, &hpage_freelist))
> +			schedule_work(&free_hpage_work);
> +		return;
> +	}
> +
> +	__free_huge_page(page);
> +}
> +
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
>  	INIT_LIST_HEAD(&page->lru);
>
You are right. That should work. I was not aware of the llist before so
I haven't fully grasped its capability. Thanks for the suggestion.

Cheers,
Longman

