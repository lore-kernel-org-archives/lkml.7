Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75493C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA5A2465E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ/Yv5n2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfLQA3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:29:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31838 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727657AbfLQA3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576542581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=antzMkYf/U0vXbAJGf3csWT6K+Y56PQIgS/aq/+uEbg=;
        b=DQ/Yv5n2RT07rGBlxHixCZmkMxKErKzYv65kA4CMx/1B7HmnGoW4FRtCIi5Y/T11RUlGMC
        HujK2mQ0889BZp1/afHrOh+dbrSTqQXBLywwuwQ05s3tcNVw4nViVYSJauVxGrtyXSnfmf
        MzoR8fPIto1LsgddYSvQ7ME3U0gvHMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-0djIX59hMCiRz7MXIGJkRg-1; Mon, 16 Dec 2019 19:29:35 -0500
X-MC-Unique: 0djIX59hMCiRz7MXIGJkRg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 586E9800D41;
        Tue, 17 Dec 2019 00:29:34 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-151.rdu2.redhat.com [10.10.120.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 679C4100032E;
        Tue, 17 Dec 2019 00:29:33 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
From:   Waiman Long <longman@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20191216182739.26880-1-longman@redhat.com>
 <530afa00-4da9-61cd-d1f3-66803bcd30e6@oracle.com>
 <2d7c31f9-371d-9a46-96c4-c37dd761c28d@redhat.com>
Organization: Red Hat
Message-ID: <c7adfa62-c517-4c1e-ab69-1acc66a413e0@redhat.com>
Date:   Mon, 16 Dec 2019 19:29:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2d7c31f9-371d-9a46-96c4-c37dd761c28d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 6:20 PM, Waiman Long wrote:
>>> +
>>> +	/*
>>> +	 * Racing may prevent some deferred huge pages in hpage_freelist
>>> +	 * from being freed. Check here and call schedule_work() if that
>>> +	 * is the case.
>>> +	 */
>>> +	if (unlikely(hpage_freelist && !work_pending(&free_hpage_work)))
>>> +		schedule_work(&free_hpage_work);
>> Can you describe the race which would leave deferred huge pages on
>> hpage_freelist?  I am having a hard time determining how that can happen.
> I am being cautious here. It is related how the workqueue works. Whether
> a call to schedule_work() has any effect depends on the pending bit in
> the workqueue structure. I suppose that it is cleared once the work is
> done. So depending on when the bit is cleared, there may be a small
> timing window where free_hpage_workfn() is done but the bit has not been
> cleared yet. A concurrent softIRQ task may update hpage_freelist and
> call schedule_work() without actually queuing it. Perhaps I can check
> the return status of schedule_work() and wait for a while there until
> the queuing is successfully or the free list is changed. I will need to
> look more carefully at the workqueue code to see how big this timing
> window is.
>> And, if this indeed can happen then I would have to ask what happens if
>> a page is 'stuck' and we do not call free_huge_page?  Do we need to take
>> that case into account?
> As said above, there may be way to reduce the racing window or eliminate
> it altogether. I need a bit more time to investigate that. If there is
> no way to eliminate the racing window, it is possible that a huge page
> may get stuck in the free list for a while.

My mistake. The pending bit is actually cleared before calling the
workfn. That shows I don't fully understand the work queue
functionality. In this case, there should be no race. I will remove the
unnecessary check.

Cheers,
Longman

