Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4EFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8199920684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBzndCD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfJVIXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:23:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47154 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388011AbfJVIXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571732626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrUeBCrSy1rpGB4XosjgjFYUmBasj3OjbX7rli4aJko=;
        b=cBzndCD7Km3J9t9Js4BdaCWw7a8mzdHHioRfWsH2XEGxGpZXzBSuQDhDpw/9s4NRHCman4
        uFAe59u/iIhAUdV+JBWoq8s5XuOANkasH0K7Ve/nJ2Dj7m71tGzGDPqzEPd4NS2FnHaMtr
        Mxaykaknl30P4Rt+SU2jGNxG4harYBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-KflmPS0KNZuP19NIR3W1Vg-1; Tue, 22 Oct 2019 04:23:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA0B107AD31;
        Tue, 22 Oct 2019 08:23:41 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C32A85D6A5;
        Tue, 22 Oct 2019 08:23:38 +0000 (UTC)
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
 <b6a392c9-1cb8-321e-b7ba-d483d928a3cc@redhat.com>
 <20191021154712.GW9379@dhcp22.suse.cz>
 <91ecb9b7-4271-a3a7-2342-b0afd4c41606@redhat.com>
 <20191022082053.GB9379@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c9517b78-c38f-4e1b-f8cb-8df67bf106ec@redhat.com>
Date:   Tue, 22 Oct 2019 10:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022082053.GB9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: KflmPS0KNZuP19NIR3W1Vg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.19 10:20, Michal Hocko wrote:
> On Mon 21-10-19 17:54:35, David Hildenbrand wrote:
>> On 21.10.19 17:47, Michal Hocko wrote:
>>> On Mon 21-10-19 17:39:36, David Hildenbrand wrote:
>>>> On 21.10.19 16:43, Michal Hocko wrote:
>>> [...]
>>>>> We still set PageReserved before onlining pages and that one should b=
e
>>>>> good to go as well (memmap_init_zone).
>>>>> Thanks!
>>>>
>>>> memmap_init_zone() is called when onlining memory. There, set all page=
s to
>>>> reserved right now (on context =3D=3D MEMMAP_HOTPLUG). We clear PG_res=
erved when
>>>> onlining a page to the buddy (e.g., generic_online_page). If we would =
online
>>>> a memory block with holes, we would want to keep all such pages
>>>> (!pfn_valid()) set to reserved. Also, there might be other side effect=
s.
>>>
>>> Isn't it sufficient to have those pages in a poisoned state? They are
>>> not onlined so their state is basically undefined anyway. I do not see
>>> how PageReserved makes this any better.
>>
>> It is what people have been using for a long time. Memory hole ->
>> PG_reserved. The memmap is valid, but people want to tell "this here is
>> crap, don't look at it".
>=20
> The page is poisoned, right? If yes then setting the reserved bit
> doesn't make any sense.

No it's not poisoned AFAIK. It should be initialized - and I remember=20
that PG_reserved on memory holes is relevant to detect MMIO pages.=20
(e.g., looking at KVM code ...)

>=20
>>> Also is the hole inside a hotplugable memory something we really have t=
o
>>> care about. Has anybody actually seen a platform to require that?
>>
>> That's what I was asking. I can see "support" for this was added basical=
ly
>> right from the beginning. I'd say we rip that out and cleanup/simplify. =
I am
>> not aware of a platform that requires this. Especially, memory holes on
>> DIMMs (detected during boot) seem like an unlikely thing.
>=20
> The thing is that the hotplug development shows ad-hoc decisions
> throughout the code. It is even worse that it is hard to guess whether
> some hludges are a result of a careful design or ad-hoc trial and
> failure approach on setups that never were production. Building on top
> of that be preserving hacks is not going to improve the situation. So I
> am perfectly fine to focus on making the most straightforward setups
> work reliably. Even when there is a risk of breaking some odd setups. We
> can fix them up later but we would have at least a specific example and
> document it.
>=20

Alright, I'll prepare a simple patch that rejects offlining memory with=20
memory holes. We can apply that and see if anybody screams out loud. If=20
not, we can clean up that crap.

--=20

Thanks,

David / dhildenb

