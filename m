Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F21CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38782214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeQuMJwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfJUPyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:54:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57718 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729395AbfJUPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571673282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYYBigk1mBDQOVv3cRmHPXRlvdDEVLUfmEpCEsjnHaA=;
        b=SeQuMJwbCc7deMnQJKd20wRpIjF76vWpSebuL3vB3uKwiqWujW69KUPbsgT5SSuoGdMavY
        0USG3UszCXGCyvWf6RwD4FeIaytC08bNitg/aUAkMCx/4YTknZzvBoaNXoq3EJ4GcWbjzC
        SqX6kYZ+agtUeLfV09vDF4ZiKkcv6lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-zBapdSUgNuSypj5z_X7zRQ-1; Mon, 21 Oct 2019 11:54:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D5AC80183E;
        Mon, 21 Oct 2019 15:54:38 +0000 (UTC)
Received: from [10.36.118.81] (unknown [10.36.118.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E38E360126;
        Mon, 21 Oct 2019 15:54:35 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <91ecb9b7-4271-a3a7-2342-b0afd4c41606@redhat.com>
Date:   Mon, 21 Oct 2019 17:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021154712.GW9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zBapdSUgNuSypj5z_X7zRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.19 17:47, Michal Hocko wrote:
> On Mon 21-10-19 17:39:36, David Hildenbrand wrote:
>> On 21.10.19 16:43, Michal Hocko wrote:
> [...]
>>> We still set PageReserved before onlining pages and that one should be
>>> good to go as well (memmap_init_zone).
>>> Thanks!
>>
>> memmap_init_zone() is called when onlining memory. There, set all pages =
to
>> reserved right now (on context =3D=3D MEMMAP_HOTPLUG). We clear PG_reser=
ved when
>> onlining a page to the buddy (e.g., generic_online_page). If we would on=
line
>> a memory block with holes, we would want to keep all such pages
>> (!pfn_valid()) set to reserved. Also, there might be other side effects.
>=20
> Isn't it sufficient to have those pages in a poisoned state? They are
> not onlined so their state is basically undefined anyway. I do not see
> how PageReserved makes this any better.

It is what people have been using for a long time. Memory hole ->=20
PG_reserved. The memmap is valid, but people want to tell "this here is=20
crap, don't look at it".

>=20
> Also is the hole inside a hotplugable memory something we really have to
> care about. Has anybody actually seen a platform to require that?

That's what I was asking. I can see "support" for this was added=20
basically right from the beginning. I'd say we rip that out and=20
cleanup/simplify. I am not aware of a platform that requires this.=20
Especially, memory holes on DIMMs (detected during boot) seem like an=20
unlikely thing.


--=20

Thanks,

David / dhildenb

