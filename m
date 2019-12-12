Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56119C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256A321556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG5sfO8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfLLUwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:52:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55528 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730749AbfLLUw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576183948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYpVIcZ3LzTLwRBpT4fAV1Hkx80XBvpXZ1v+QRjBd+s=;
        b=DG5sfO8EziKkF4AQGF+7vz1hfLWuZ+OF2KnvnnIvICSyl0BrZ/E7SCDabqQJ5H0VvztEEX
        Z2c2orOU6J074pA+zUKDQu97VtGc3OhVybj2NgwUqxZivb6G6SeHX/d5l7oOAq9kDxRXMS
        RvUJLZuDwIZOYzklHsa0kDm8yz7+AzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-1mky1049M6eAFc4CCVO0aA-1; Thu, 12 Dec 2019 15:52:24 -0500
X-MC-Unique: 1mky1049M6eAFc4CCVO0aA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8048D1858E71;
        Thu, 12 Dec 2019 20:52:21 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4AC65D9CA;
        Thu, 12 Dec 2019 20:52:20 +0000 (UTC)
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>, aneesh.kumar@linux.ibm.com
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <79d3a7e1-384b-b759-cd84-56253fb9ed40@redhat.com>
Date:   Thu, 12 Dec 2019 15:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 2:22 PM, Mike Kravetz wrote:
> On 12/12/19 11:04 AM, Davidlohr Bueso wrote:
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
>>
>> [1] https://lore.kernel.org/lkml/20191211194615.18502-1-longman@redhat.com/
>> [2] https://lore.kernel.org/lkml/20180905112341.21355-1-aneesh.kumar@linux.ibm.com/
>>
>> Reported-by: Waiman Long <longman@redhat.com>
>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> Thank you Davidlohr.
>
> The patch does seem fairly simple and straight forward.  I need to brush up
> on my workqueue knowledge to provide a full review.
>
> Longman,
> Do you have a test to reproduce the issue?  If so, can you try running with
> this patch.

Yes, I do have a test that can reproduce the issue. I will run it with
the patch and report the status tomorrow.

-Longman

