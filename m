Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51583CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2065E21906
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZN72Ey8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbfJVSkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:40:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20581 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729666AbfJVSkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571769617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBqFTHigo1FB9xwoqXhjVaLlLB8M7eFR2otQiW7RMsY=;
        b=ZN72Ey8pGADHedkBGrWCOqSjaOY6X9MuYkQngNK9jArnzb6vcoVhC9wewsDD1oW0NY1fHR
        uEgIgavEBOh4sEyRO2pgDdRpJ8j7amvbcCQNMn6WJCTQgZO/FzvHWeny0ym/qdo38GUFVD
        9n8vEg2r4VLldoU/OP9yY9kNwqmhJag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-1-eL6FxLOQO0i-XaU-vsxA-1; Tue, 22 Oct 2019 14:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98567800D49;
        Tue, 22 Oct 2019 18:40:09 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E990260C5D;
        Tue, 22 Oct 2019 18:40:04 +0000 (UTC)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
From:   Waiman Long <longman@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, Mel Gorman <mgorman@suse.de>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022165745.GT9379@dhcp22.suse.cz>
 <0b206255-5c62-18f5-d751-a5576a6c0e8f@redhat.com>
Organization: Red Hat
Message-ID: <e272f2e0-153d-4194-f2d6-a15610be4dce@redhat.com>
Date:   Tue, 22 Oct 2019 14:40:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0b206255-5c62-18f5-d751-a5576a6c0e8f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1-eL6FxLOQO0i-XaU-vsxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/19 2:00 PM, Waiman Long wrote:
> On 10/22/19 12:57 PM, Michal Hocko wrote:
>
>>> and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
>>> is usually the largest one on large memory systems, this is the one
>>> to be skipped. Since the printing order is migration-type =3D> order, w=
e
>>> will have to store the counts in an internal 2D array before printing
>>> them out.
>>>
>>> Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
>>> zone lock for too long blocking out other zone lock waiters from being
>>> run. This can be problematic for systems with large amount of memory.
>>> So a check is added to temporarily release the lock and reschedule if
>>> more than 64k of list entries have been iterated for each order. With
>>> a MAX_ORDER of 11, the worst case will be iterating about 700k of list
>>> entries before releasing the lock.
>> But you are still iterating through the whole free_list at once so if it
>> gets really large then this is still possible. I think it would be
>> preferable to use per migratetype nr_free if it doesn't cause any
>> regressions.
>>
> Yes, it is still theoretically possible. I will take a further look at
> having per-migrate type nr_free. BTW, there is one more place where the
> free lists are being iterated with zone lock held - mark_free_pages().

Looking deeper into the code, the exact migration type is not stored in
the page itself. An initial movable page can be stolen to be put into
another migration type. So in a delete or move from free_area, we don't
know exactly what migration type the page is coming from. IOW, it is
hard to get accurate counts of the number of entries in each lists.

I am not saying this is impossible, but doing it may require stealing
some bits from the page structure to store this information which is
probably not worth the benefit we can get from it. So if you have any
good suggestion of how to do it without too much cost, please let me
know about it. Otherwise, I will probably stay with the current patch.

Cheers,
Longman


