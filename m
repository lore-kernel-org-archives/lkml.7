Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E7CCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253BD2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHw2XtXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfJUPFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:05:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54471 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726289AbfJUPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571670301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3BfVv34fW0s+KkLvwZNYYapPq9uHXB2pFFeBbUFt3o=;
        b=QHw2XtXlEx7Rffj6kXA2jbfp9Yar1x2Zt5ZcXoeYBvaPX+hc1G8aq1GkcvEEmklznAb0Ee
        pnWxy1EXVykfaMZh+va5IKsbc3QKW/x1+YV3YQc8eJ6mTcUzPh2C2vRm3AYi4B+Zr0/Fu3
        enCZ48+iH/ud78kQHUdxmTzvX8EjJk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-lD2VJkQrNuejKQQJMKdfKQ-1; Mon, 21 Oct 2019 11:04:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDC091005500;
        Mon, 21 Oct 2019 15:04:53 +0000 (UTC)
Received: from [10.36.118.81] (unknown [10.36.118.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A40E60C83;
        Mon, 21 Oct 2019 15:04:50 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] mm/page_isolation.c: Convert SKIP_HWPOISON to
 MEMORY_OFFLINE
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <20191021141927.10252-1-david@redhat.com>
 <20191021141927.10252-3-david@redhat.com>
 <20191021150237.GU9379@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <bed9336d-3bff-b7e3-dfba-42506a274858@redhat.com>
Date:   Mon, 21 Oct 2019 17:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021150237.GU9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: lD2VJkQrNuejKQQJMKdfKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.19 17:02, Michal Hocko wrote:
> On Mon 21-10-19 16:19:26, David Hildenbrand wrote:
>> We have two types of users of page isolation:
>> 1. Memory offlining: Offline memory so it can be unplugged. Memory won't
>> =09=09     be touched.
>> 2. Memory allocation: Allocate memory (e.g., alloc_contig_range()) to
>> =09=09      become the owner of the memory and make use of it.
>>
>> For example, in case we want to offline memory, we can ignore (skip over=
)
>> PageHWPoison() pages, as the memory won't get used. We can allow to
>> offline memory. In contrast, we don't want to allow to allocate such
>> memory.
>>
>> Let's generalize the approach so we can special case other types of
>> pages we want to skip over in case we offline memory. While at it, also
>> pass the same flags to test_pages_isolated().
>>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Pingfan Liu <kernelfans@gmail.com>
>> Cc: Qian Cai <cai@lca.pw>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
> Yes, a highlevel flag makes more sense than requesting specific types of
> pages to skip over.
>=20
> Acked-by: Michal Hocko <mhocko@suse.com>
>=20
> Please make the code easier to follow ...
>> ---
>>   include/linux/page-isolation.h |  4 ++--
>>   mm/memory_hotplug.c            |  8 +++++---
>>   mm/page_alloc.c                |  4 ++--
>>   mm/page_isolation.c            | 12 ++++++------
>>   4 files changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index bf6b21f02154..b44712c7fdd7 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8270,7 +8270,7 @@ bool has_unmovable_pages(struct zone *zone, struct=
 page *page, int count,
>>   =09=09 * The HWPoisoned page may be not in buddy system, and
>>   =09=09 * page_count() is not 0.
>>   =09=09 */
>> -=09=09if ((flags & SKIP_HWPOISON) && PageHWPoison(page))
>> +=09=09if (flags & MEMORY_OFFLINE && PageHWPoison(page))
>>   =09=09=09continue;
>>  =20
>>   =09=09if (__PageMovable(page))
> [...]
>> @@ -257,7 +258,7 @@ void undo_isolate_page_range(unsigned long start_pfn=
, unsigned long end_pfn,
>>    */
>>   static unsigned long
>>   __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end=
_pfn,
>> -=09=09=09=09  bool skip_hwpoisoned_pages)
>> +=09=09=09=09  int flags)
>>   {
>>   =09struct page *page;
>>  =20
>> @@ -274,7 +275,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn,=
 unsigned long end_pfn,
>>   =09=09=09 * simple way to verify that as VM_BUG_ON(), though.
>>   =09=09=09 */
>>   =09=09=09pfn +=3D 1 << page_order(page);
>> -=09=09else if (skip_hwpoisoned_pages && PageHWPoison(page))
>> +=09=09else if (flags & MEMORY_OFFLINE && PageHWPoison(page))
>>   =09=09=09/* A HWPoisoned page cannot be also PageBuddy */
>>   =09=09=09pfn++;
>>   =09=09else
>=20
> .. and use parentheses for the flag check.
>=20

Can do if you prefer :)

Thanks!

I'll resend both patches.

--=20

Thanks,

David / dhildenb

