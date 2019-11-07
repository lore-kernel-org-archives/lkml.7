Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96810C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612042187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKBmKNmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfKGV10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:27:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52734 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGV10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573162044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LLb8ODlrE2DcLQV25lHkIdJt8ldk3ozlStqtuMJM5vA=;
        b=dKBmKNmuszT83w7OWLqYTxenYjbllb41mOsqKVxwmOieDgjgidiAEZnEbv+MtVdjigHTia
        1NylWB61FOjjAVHdYrS/o7o8nScmXbAHQZv2X8g4VmZ0RmCCKM4xDP0zXbq+zXdWhkMTCp
        148aNNFKspDPj81NBIZQQvPlhbWgyPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-m8ORxfZJNDW2Vk3fzUHgUg-1; Thu, 07 Nov 2019 16:27:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3001D8017DD;
        Thu,  7 Nov 2019 21:27:21 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21962608B3;
        Thu,  7 Nov 2019 21:27:18 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
References: <20191107190628.22667-1-longman@redhat.com>
 <20191107195441.GF11823@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ba7a97a5-0ca2-2ff6-0b0c-08ed19bfc1fe@redhat.com>
Date:   Thu, 7 Nov 2019 16:27:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191107195441.GF11823@bombadil.infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: m8ORxfZJNDW2Vk3fzUHgUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 2:54 PM, Matthew Wilcox wrote:
> On Thu, Nov 07, 2019 at 02:06:28PM -0500, Waiman Long wrote:
>> A customer with large SMP systems (up to 16 sockets) with application
>> that uses large amount of static hugepages (~500-1500GB) are experiencin=
g
>> random multisecond delays. These delays was caused by the long time it
>> took to scan the VMA interval tree with mmap_sem held.
>>
>> The sharing of huge PMD does not require changes to the i_mmap at all.
>> As a result, we can just take the read lock and let other threads
>> searching for the right VMA to share in parallel. Once the right
>> VMA is found, either the PMD lock (2M huge page for x86-64) or the
>> mm->page_table_lock will be acquired to perform the actual PMD sharing.
>>
>> Lock contention, if present, will happen in the spinlock. That is much
>> better than contention in the rwsem where the time needed to scan the
>> the interval tree is indeterminate.
> I don't think this description really explains the contention argument
> well.  There are _more_ PMD locks than there are i_mmap_sem locks, so
> processes accessing different parts of the same file can work in parallel=
.

I am sorry for not being clear enough. PMD lock contention here means 2
or more tasks that happens to touch the same PMD. Because of the use of
PMD lock, modification of the same PMD cannot happen in parallel. If
they touch different PMDs, they can do that in parallel. Previously,
they are contending the same rwsem write lock and hence have to be done
serially.

> Are there other current users of the write lock that could use a read loc=
k?
> At first blush, it would seem that unmap_ref_private() also only needs
> a read lock on the i_mmap tree.  I don't think hugetlb_change_protection(=
)
> needs the write lock either.  Nor retract_page_tables().

It is possible that other locking sites can be converted to use read
lock, but it is outside the scope of this patch.

Cheers,
Longman

