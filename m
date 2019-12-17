Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A9C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8856D21775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRtcZHMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfLQOGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:06:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52373 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbfLQOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576591598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQ1VJJyR0fM6YEJQp8p0uOYw5xwcBVp/Fl4tPeamlLo=;
        b=WRtcZHMemCxWShq2STgpuz/o5NlaAWACOdgixKJmHYRIljihyB4PqYWfisGa4gaOzTBmzi
        bY/Xs6/GxDgobEnS4krK6JBmwnmgrk3FKniG3h26ZowH2lOJVwdlRSuhq/6kzNW+RWiYDs
        Qs7cLD7iSzNYrMM4bna/R/d3JZhho54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-wx6UWhcWNXy-WfpXQjk71w-1; Tue, 17 Dec 2019 09:06:35 -0500
X-MC-Unique: wx6UWhcWNXy-WfpXQjk71w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D36628DFF1B;
        Tue, 17 Dec 2019 14:06:33 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-81.rdu2.redhat.com [10.10.123.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E62805C545;
        Tue, 17 Dec 2019 14:06:32 +0000 (UTC)
Subject: Re: [PATCH v2] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20191217012508.31495-1-longman@redhat.com>
 <20191217093143.GC31063@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4bb217ac-d80a-12b8-839f-2db9ced2636b@redhat.com>
Date:   Tue, 17 Dec 2019 09:06:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191217093143.GC31063@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 4:31 AM, Michal Hocko wrote:
> On Mon 16-12-19 20:25:08, Waiman Long wrote:
> [...]
>> Both the hugetbl_lock and the subpool lock can be acquired in
>> free_huge_page(). One way to solve the problem is to make both locks
>> irq-safe.
> Please document why we do not take this, quite natural path and instead
> we have to come up with an elaborate way instead. I believe the primary
> motivation is that some operations under those locks are quite
> expensive. Please add that to the changelog and ideally to the code as
> well. We probably want to fix those anyway and then this would be a
> temporary workaround.
>
Fair enough, I will include data from Mike about some use cases where
hugetlb_lock will be held for a long time.


>> Another alternative is to defer the freeing to a workqueue job.
>>
>> This patch implements the deferred freeing by adding a
>> free_hpage_workfn() work function to do the actual freeing. The
>> free_huge_page() call in a non-task context saves the page to be freed
>> in the hpage_freelist linked list in a lockless manner.
> Do we need to over complicate this (presumably) rare event by a lockless
> algorithm? Why cannot we use a dedicated spin lock for for the linked
> list manipulation? This should be really a trivial code without an
> additional burden of all the lockless subtleties.

Right, I can use an irq-safe raw spinlock instead. I am fine doing that.


>
>> +	pr_debug("HugeTLB: free_hpage_workfn() frees %d huge page(s)\n", cnt);
> Why do we need the debugging message here?

It is there just to verify that the workfn is properly activated and
frees the huge page. This message won't be printed by default. I can
remove it if you guys don't really want a debug statement here.

Cheers,
Longman

