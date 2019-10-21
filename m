Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC772CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A1B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsGzK6In"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfJUPjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:39:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44814 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729525AbfJUPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571672385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNM74lKwor++3p/QkpWqlSPILubN2KPghaH2BaE3A2s=;
        b=RsGzK6In6llShLdog5mTL5jcK+/0oUbNpZUgvwSfpnqVZexWwridc/w+CviQq/a7AGTuxk
        jhJQKToPmrf+Bwu1mziYzegsNbj/egx8zrISsIuFM8P7LtIE854HGUtcpfSkkGK+Pu4F5j
        8m5QNnY1FUcGDgLwVIfRkhR7gOXgkJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-87RuL3t6OnmdiKWVp34qag-1; Mon, 21 Oct 2019 11:39:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F01A1800D79;
        Mon, 21 Oct 2019 15:39:39 +0000 (UTC)
Received: from [10.36.118.81] (unknown [10.36.118.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FC1C60126;
        Mon, 21 Oct 2019 15:39:36 +0000 (UTC)
Subject: Re: [PATCH v1 1/2] mm/page_alloc.c: Don't set pages PageReserved()
 when offlining
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>
References: <20191021141927.10252-1-david@redhat.com>
 <20191021141927.10252-2-david@redhat.com>
 <20191021144345.GT9379@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b6a392c9-1cb8-321e-b7ba-d483d928a3cc@redhat.com>
Date:   Mon, 21 Oct 2019 17:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021144345.GT9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 87RuL3t6OnmdiKWVp34qag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.19 16:43, Michal Hocko wrote:
> On Mon 21-10-19 16:19:25, David Hildenbrand wrote:
>> We call __offline_isolated_pages() from __offline_pages() after all
>> pages were isolated and are either free (PageBuddy()) or PageHWPoison.
>> Nothing can stop us from offlining memory at this point.
>>
>> In __offline_isolated_pages() we first set all affected memory sections
>> offline (offline_mem_sections(pfn, end_pfn)), to mark the memmap as
>> invalid (pfn_to_online_page() will no longer succeed), and then walk ove=
r
>> all pages to pull the free pages from the free lists (to the isolated
>> free lists, to be precise).
>>
>> Note that re-onlining a memory block will result in the whole memmap
>> getting reinitialized, overwriting any old state. We already poision the
>> memmap when offlining is complete to find any access to
>> stale/uninitialized memmaps.
>>
>> So, setting the pages PageReserved() is not helpful. The memap is marked
>> offline and all pageblocks are isolated. As soon as offline, the memmap
>> is stale either way.
>>
>> This looks like a leftover from ancient times where we initialized the
>> memmap when adding memory and not when onlining it (the pages were set
>> PageReserved so re-onling would work as expected).
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Wei Yang <richard.weiyang@gmail.com>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
> Acked-by: Michal Hocko <mhocko@suse.com>
>=20
> We still set PageReserved before onlining pages and that one should be
> good to go as well (memmap_init_zone).
> Thanks!

memmap_init_zone() is called when onlining memory. There, set all pages=20
to reserved right now (on context =3D=3D MEMMAP_HOTPLUG). We clear=20
PG_reserved when onlining a page to the buddy (e.g.,=20
generic_online_page). If we would online a memory block with holes, we=20
would want to keep all such pages (!pfn_valid()) set to reserved. Also,=20
there might be other side effects.

So it might not be that easy to remove. A cleanup that I have on my list=20
is to disallow offlining memory blocks with holes. This implies that we=20
will never online memory blocks with holes. This allows for some=20
cleanups in the onlining/offlining code. For example, it would allow to=20
get rid of this PG_reserved initialization.

I don't think that we have to support offlining memory blocks with=20
holes. This can only be bootmem (never hotplugged memory), where the=20
chance for this to work is in my opinion already not too good.

What's your opinion on this?

>=20
> There is a comment above offline_isolated_pages_cb that should be
> removed as well.

Right, I'll convert that comment

"Mark all sections offline and remove all free pages from the buddy."

Thanks!


--=20

Thanks,

David / dhildenb

