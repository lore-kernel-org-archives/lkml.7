Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A21C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2719D20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwJ4hMk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLPTNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:13:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbfLPTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576523627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IDJvDD38IDnwBTnAlisdN2mPCEFyvjHW7+IKs5mzFg=;
        b=TwJ4hMk7ldDA8xt+lAwkWXCpCmMhSiPldrfQmqPGT4W36qsjm47GLOpDZH5dopvnQraNcY
        OorcPQcytG1dCseO8FjOBVjlTDVbV/5lQ6WM1HBUY4Hv5m74G6XJ//qmN359i9PKITfrtJ
        y+UvQsa4/bBig4hvq117fZ/9AaIcCDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-cOXcvRs-MLyw4hRyP0UnrA-1; Mon, 16 Dec 2019 14:13:44 -0500
X-MC-Unique: cOXcvRs-MLyw4hRyP0UnrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DE10800D41;
        Mon, 16 Dec 2019 19:13:42 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 476C260933;
        Mon, 16 Dec 2019 19:13:41 +0000 (UTC)
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <20191216133711.GH30281@dhcp22.suse.cz>
 <20191216161748.tgi2oictlfqy6azi@linux-p48b>
 <68d466cc-2cbd-ae49-7d89-e7476c5a9c24@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <17e326a7-093a-dbd3-8e6e-232ec9b81b9e@redhat.com>
Date:   Mon, 16 Dec 2019 14:13:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <68d466cc-2cbd-ae49-7d89-e7476c5a9c24@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 2:08 PM, Mike Kravetz wrote:
> On 12/16/19 8:17 AM, Davidlohr Bueso wrote:
>> On Mon, 16 Dec 2019, Michal Hocko wrote:
>>> I am afraid that work_struct is too large to be stuffed into the struct
>>> page array (because of the lockdep part).
>> Yeah, this needs to be done without touching struct page.
>>
>> Which is why I had done the stack allocated way in this patch, but we
>> cannot wait for it to complete in irq, so that's out the window. Andi
>> had suggested percpu allocated work items, but having played with the
>> idea over the weekend, I don't see how we can prevent another page being
>> freed on the same cpu before previous work on the same cpu is complete
>> (cpu0 wants to free pageA, schedules the work, in the mean time cpu0
>> wants to free pageB and workerfn for pageA still hasn't been called).
>>
>>> I think that it would be just safer to make hugetlb_lock irq safe. Are
>>> there any other locks that would require the same?
>> It would be simpler. Any performance issues that arise would probably
>> be only seen in microbenchmarks, assuming we want to have full irq safety.
>> If we don't need to worry about hardirq, then even better.
>>
>> The subpool lock would also need to be irq safe.
> I do think we need to worry about hardirq.  There are no restruictions that
> put_page can not be called from hardirq context. 
>
> I am concerned about the latency of making hugetlb_lock (and potentially
> subpool lock) hardirq safe.  When these locks were introduced (before my
> time) the concept of making them irq safe was not considered.  Recently,
> I learned that the hugetlb_lock is held for a linear scan of ALL hugetlb
> pages during a cgroup reparentling operation.  That is just too long.
>
> If there is no viable work queue solution, then I think we would like to
> restructure the hugetlb locking before a change to just make hugetlb_lock
> irq safe.  The idea would be to split the scope of what is done under
> hugetlb_lock.  Most of it would never be executed in irq context.  Then
> have a small/limited set of functionality that really needs to be irq
> safe protected by an irq safe lock.
>
Please take a look at my recently posted patch to see if that is an
acceptable workqueue based solution.

Thanks,
Longman

