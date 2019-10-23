Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28310CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B242084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V65XfQ9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391021AbfJWKEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:04:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390361AbfJWKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571825044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6lSdzoaa0n+6w843OleSIn3qypoeQbbwBSChxn+qqI=;
        b=V65XfQ9Re2u3zHhTP8SDJdvBZjHajTs+shGOwRIH/lsBTtjx9nfEC80+6qzfQQtlIknQ/A
        GHJ3XeuN4MCwJNyscVY5j9uekPtBM6KEzG6wQPI0n7hMO1KD6KLByRPKBtvEIXVMXRHGAm
        kYjYYtPQBM6oU8NFObDZ4I6z6QDrgx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-3kLTzBU8Pru_Lon8ETvXGg-1; Wed, 23 Oct 2019 06:04:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31F2A1800D6B;
        Wed, 23 Oct 2019 10:03:58 +0000 (UTC)
Received: from [10.36.117.79] (ovpn-117-79.ams2.redhat.com [10.36.117.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB205C1B2;
        Wed, 23 Oct 2019 10:03:51 +0000 (UTC)
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
 a reference count of 0
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <20191016114321.GX317@dhcp22.suse.cz>
 <36fef317-78e3-0500-43ba-f537f9a6fea4@redhat.com>
 <20191016140350.GD317@dhcp22.suse.cz>
 <7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
 <20191018081524.GD5017@dhcp22.suse.cz>
 <83d0a961-952d-21e4-74df-267912b7b6fa@redhat.com>
 <20191018111843.GH5017@dhcp22.suse.cz>
 <709d39aa-a7ba-97aa-e66b-e2fec2fdf3c4@redhat.com>
 <20191022122326.GL9379@dhcp22.suse.cz>
 <b4be42a4-cbfc-8706-cc94-26211ddcbe4a@redhat.com>
 <20191023094345.GL754@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ad2aef12-61ac-f019-90d1-59637255f9e3@redhat.com>
Date:   Wed, 23 Oct 2019 12:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023094345.GL754@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 3kLTzBU8Pru_Lon8ETvXGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.19 11:43, Michal Hocko wrote:
> On Tue 22-10-19 16:02:09, David Hildenbrand wrote:
> [...]
>>>>> MEM_CANCEL_OFFLINE could gain the reference back to balance the
>>>>> MEM_GOING_OFFLINE step.
>>>>
>>>> The pages are already unisolated and could be used by the buddy. But a=
gain,
>>>> I think you have an idea that tries to avoid putting pages to the budd=
y.
>>>
>>> Yeah, set_page_count(page, 0) if you do not want to release that page
>>> from the notifier context to reflect that the page is ok to be offlined
>>> with the rest.
>>>   =20
>>
>> I neither see how you deal with __test_page_isolated_in_pageblock() nor =
with
>> __offline_isolated_pages(). Sorry, but what I read is incomplete and you
>> probably have a full proposal in your head. Please read below how I thin=
k
>> you want to solve it.
>=20
> Yeah, sorry that I am throwing incomplete ideas at you. I am just trying
> to really nail down how to deal with reference counting here because it
> is an important aspect.

I think we collected all the missing pieces now :) Thanks!

[...]

>>
>> I was reading
>>
>> include/linux/mm_types.h:
>>
>> "If you want to use the refcount field, it must be used in such a way
>>   that other CPUs temporarily incrementing and then decrementing the
>>   refcount does not cause problems"
>>
>> And that made me think "anybody can go ahead and try get_page_unless_zer=
o()".
>>
>> If I am missing something here and this can indeed not happen (e.g.,
>> because PageOffline() pages are never mapped to user space), then I'll
>> happily remove this code.
>=20
> The point is that if the owner of the page is holding the only reference
> to the page then it is clear that nothing like that's happened.

Right, and I think the race I described won't happen in practice. Nobody=20
should be trying to do a get_page_unless_zero() on random pages that are=20
not even mapped to user space. I was (as so often) very careful :)

>> Let's recap what I suggest:
>>
>> "PageOffline() pages that have a reference count of 0 will be treated
>>   like free pages when offlining pages, allowing the containing memory
>>   block to get offlined. In case a driver wants to revive such a page, i=
t
>>   has to synchronize against memory onlining/offlining (e.g., using memo=
ry
>>   notifiers) while incrementing the reference count. Also, a driver that
>>   relies in this feature is aware that re-onlining the memory will requi=
re
>>   to re-set the pages PageOffline() - e.g., via the online_page_callback=
_t."
>=20
> OK
>=20
> [...]
>> d) __put_page() is modified to not return pages to the buddy in any
>>     case as a safety net. We might be able to get rid of that.
>=20
> I do not like exactly this part

Yeah, and I think I can drop it from this patch.

>  =20
>> What I think you suggest:
>>
>> a) has_unmovable_pages() skips over all PageOffline() pages.
>>     This results in a lot of false negatives when trying to offline. Mig=
ht be ok.
>>
>> b) The driver decrements the reference count of the PageOffline pages
>>     in MEM_GOING_OFFLINE.
>=20
> Well, driver should make the page unreferenced or fail. What is done
> really depends on the specific driver
>=20
>> c) The driver increments the reference count of the PageOffline pages
>>     in MEM_CANCEL_OFFLINE. One issue might be that the pages are no long=
er
>>     isolated once we get that call. Might be ok.
>=20
> Only previous PageBuddy pages are returned to the allocator IIRC. Mostly
> because of MovablePage()
>=20
>> d) How to make __test_page_isolated_in_pageblock() succeed?
>>     Like I propose in this patch (PageOffline() + refcount =3D=3D 0)?
>=20
> Yep
>=20
>> e) How to make __offline_isolated_pages() succeed?
>>     Like I propose in this patch (PageOffline() + refcount =3D=3D 0)?
>=20
> Simply skip over PageOffline pages. Reference count should never be !=3D =
0
> at this stage.

Right, that should be guaranteed by d). (as long as people play by the=20
rules) Same applies to my current patch.

>  =20
>> In summary, is what you suggest simply delaying setting the reference co=
unt to 0
>> in MEM_GOING_OFFLINE instead of right away when the driver unpluggs the =
pages?
>=20
> Yes
>=20
>> What's the big benefit you see and I fail to see?
>=20
> Aparat from no hooks into __put_page it is also an explicit control over
> the page via reference counting. Do you see any downsides?

The only downside I see is that we get more false negatives on=20
has_unmovable_pages(), eventually resulting in the offlining stage after=20
isolation to loop forever (as some PageOffline() pages are not movable=20
(especially, XEN balloon, HyperV balloon), there won't be progress).

I somewhat don't like forcing everybody that uses PageOffline()=20
(especially all users of balloon compaction) to implement memory=20
notifiers just to avoid that. Maybe, we even want to use PageOffline()=20
in the future in the core (e.g., for memory holes instead of PG_reserved=20
or similar).

Thanks!

--=20

Thanks,

David / dhildenb

