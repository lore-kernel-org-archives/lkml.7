Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEE8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B099021BE5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJwBmDHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbfJVJDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:03:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388369AbfJVJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571735027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eZieN+odWwHjupD49AwC2GeI99hGWRlvRBh+1n3nBk=;
        b=VJwBmDHtQuAZI8eZzqjwxvf9nGe61br04i+orzX343xU36S1WbNzB88TQRfsS7+Z7cpaPM
        yGpkWxaRqyjjFpH8h0LGgqY13qlC2jAfzEoyKXj4+YLWqZtWMIn5vLg5JgIk3otikpPCJq
        ZIBaA+iavyLg9lwlVo1PgomS73lPdew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-ZMvGEbjtOR2VkPB8XQNvqg-1; Tue, 22 Oct 2019 05:03:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8047E107AD31;
        Tue, 22 Oct 2019 09:03:40 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0028460856;
        Tue, 22 Oct 2019 09:03:37 +0000 (UTC)
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
 <c9517b78-c38f-4e1b-f8cb-8df67bf106ec@redhat.com>
 <20191022085851.GF9379@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <147fa325-16e3-d2e6-af5c-4cef258c120f@redhat.com>
Date:   Tue, 22 Oct 2019 11:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022085851.GF9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZMvGEbjtOR2VkPB8XQNvqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> - and I remember that PG_reserved on memory holes is relevant to
>> detect MMIO pages. (e.g., looking at KVM code ...)
>=20
> I can see kvm_is_reserved_pfn() which checks both pfn_valid and
> PageReserved. How does this help to detect memory holes though?
> Any driver might be setting the page reserved.

See my other mail. This is mostly to not touch MMIO pages and=20
ZONE_DEVICE pages ... well and /dev/mem mapped pages.

>  =20
>>>>> Also is the hole inside a hotplugable memory something we really have=
 to
>>>>> care about. Has anybody actually seen a platform to require that?
>>>>
>>>> That's what I was asking. I can see "support" for this was added basic=
ally
>>>> right from the beginning. I'd say we rip that out and cleanup/simplify=
. I am
>>>> not aware of a platform that requires this. Especially, memory holes o=
n
>>>> DIMMs (detected during boot) seem like an unlikely thing.
>>>
>>> The thing is that the hotplug development shows ad-hoc decisions
>>> throughout the code. It is even worse that it is hard to guess whether
>>> some hludges are a result of a careful design or ad-hoc trial and
>>> failure approach on setups that never were production. Building on top
>>> of that be preserving hacks is not going to improve the situation. So I
>>> am perfectly fine to focus on making the most straightforward setups
>>> work reliably. Even when there is a risk of breaking some odd setups. W=
e
>>> can fix them up later but we would have at least a specific example and
>>> document it.
>>>
>>
>> Alright, I'll prepare a simple patch that rejects offlining memory with
>=20
> Is offlining an interesting path? I would expect onlining to be much
> more interesting one.

If you can't offline memory with holes, you can also not online memory=20
with holes AFAIKS :)

Bootmem is online, and memory you can hotplug (initially offline) cannot=20
have any holes.

--=20

Thanks,

David / dhildenb

