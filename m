Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD9C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A827F2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFL7SkAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLPQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:17:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52801 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726742AbfLPQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576513029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGboJs7KZvOzsfpiuzionVG44ptHGHTF9gI/gQLgP/M=;
        b=bFL7SkATnD15pNSF1PQxRGfzC0GmDj8v4YL3cDOxhh8aAEaqebWZmPig8bb4npfuqkN9he
        pmVZvX6iSsJQ+3nFxugz9kwhQ2DCw4j7syuYEuGvlRguCDyTqi4HyLRO+Eiiqgv9T8PA/g
        UyPF9Kw7AIZFzqb8zRlmGbRYylqL+V8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-9fKLxG4SPxSMLifbOpgTLg-1; Mon, 16 Dec 2019 11:17:04 -0500
X-MC-Unique: 9fKLxG4SPxSMLifbOpgTLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72125800C79;
        Mon, 16 Dec 2019 16:17:02 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5438D5D9C9;
        Mon, 16 Dec 2019 16:17:01 +0000 (UTC)
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
To:     Michal Hocko <mhocko@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a8235536-23c9-225a-f788-f9bebd744aef@redhat.com>
Date:   Mon, 16 Dec 2019 11:17:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191216133711.GH30281@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 8:37 AM, Michal Hocko wrote:
> On Thu 12-12-19 11:04:27, Davidlohr Bueso wrote:
>> There have been deadlock reports[1, 2] where put_page is called
>> from softirq context and this causes trouble with the hugetlb_lock,
>> as well as potentially the subpool lock.
>>
>> For such an unlikely scenario, lets not add irq dancing overhead
>> to the lock+unlock operations, which could incur in expensive
>> instruction dependencies, particularly when considering hard-irq
>> safety. For example PUSHF+POPF on x86.
>>
>> Instead, just use a workqueue and do the free_huge_page() in regular
>> task context.
> I am afraid that work_struct is too large to be stuffed into the struct
> page array (because of the lockdep part).
>
> I think that it would be just safer to make hugetlb_lock irq safe. Are
> there any other locks that would require the same?

Currently, free_huge_page() can be called from the softIRQ context. The
hugetlb_lock will be acquired during that call. The subpool lock may
conditionally be acquired as well.

I am still torn between converting both locks to be irq-safe or
deferring the freeing to a workqueue.

Cheers,
Longman

