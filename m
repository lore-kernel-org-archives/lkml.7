Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA33FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB12820885
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsT18B4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfKTPEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:04:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22755 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728864AbfKTPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574262291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IBz9KyuYNKXB4FibFKzT3JjYfAQ+VtzUD0zVZBCTZ40=;
        b=JsT18B4kMlTqN4rnBbFt2iHtjsVXJMA5gk08ZZ30Y+BWQFcmg7x0JSISaSEYnC6fEBukTc
        udIpa7du8NwEe/2HT6aAFQeFBMCX8W7h5RXG5CAg7oJzA88995+C+eT9kbvZY0PrMCCZ+P
        TBkMnMshJdd7Q5XPL7Gm5NN147TH78c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-lytrAqQxMHW7Fx7hfEbx3g-1; Wed, 20 Nov 2019 10:04:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DB586EE19;
        Wed, 20 Nov 2019 15:04:46 +0000 (UTC)
Received: from [10.36.118.126] (unknown [10.36.118.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 224E85ED2D;
        Wed, 20 Nov 2019 15:04:44 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm/memory-failure.c: PageHuge is handled at the
 beginning of memory_failure
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
 <1e61c115-5787-9ef4-a449-2e490c53fca7@redhat.com>
 <20191120004620.GB11061@richard>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a85053b7-9298-9dd3-3826-e63cf8c7bd81@redhat.com>
Date:   Wed, 20 Nov 2019 16:04:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120004620.GB11061@richard>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: lytrAqQxMHW7Fx7hfEbx3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.19 01:46, Wei Yang wrote:
> On Tue, Nov 19, 2019 at 01:23:54PM +0100, David Hildenbrand wrote:
>> On 18.11.19 09:20, Wei Yang wrote:
>>> PageHuge is handled by memory_failure_hugetlb(), so this case could be
>>> removed.
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> ---
>>>    mm/memory-failure.c | 5 +----
>>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index 3151c87dff73..392ac277b17d 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -1359,10 +1359,7 @@ int memory_failure(unsigned long pfn, int flags)
>>>    =09 * page_remove_rmap() in try_to_unmap_one(). So to determine page=
 status
>>>    =09 * correctly, we save a copy of the page flags at this time.
>>>    =09 */
>>> -=09if (PageHuge(p))
>>> -=09=09page_flags =3D hpage->flags;
>>> -=09else
>>> -=09=09page_flags =3D p->flags;
>>> +=09page_flags =3D p->flags;
>>>    =09/*
>>>    =09 * unpoison always clear PG_hwpoison inside page lock
>>>
>>
>> I somewhat miss a proper explanation why this is safe to do. We access p=
age
>> flags here, so why is it safe to refer to the ones of the sub-page?
>>
>=20
> Hi, David
>=20
> I think your comment is on this line:
>=20
> =09page_flags =3D p->flags;
>=20
> Maybe we need to use this:
>=20
> =09page_flags =3D hpage->flags;
>=20
> And use hpage in the following or even the whole function?
>=20
> While one thing interesting is not all "compound page" is PageCompound. F=
or
> some sub-page, we can't get the correct head. This means we may just chec=
k on
> the sub-page.

Oh wait, I think I missed the check right at the beginning of this=20
function, sorry :/

Sooo, memory_failure_hugetlb() was introduced by

commit 761ad8d7c7b5485bb66fd5bccb58a891fe784544
Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date:   Mon Jul 10 15:47:47 2017 -0700

     mm: hwpoison: introduce memory_failure_hugetlb()

and essentially ripped out all PageHuge() checks *except* this check.=20
This check was introduced in

commit 7258ae5c5a2ce2f5969e8b18b881be40ab55433d
Author: James Morse <james.morse@arm.com>
Date:   Fri Jun 16 14:02:29 2017 -0700

     mm/memory-failure.c: use compound_head() flags for huge pages


Maybe that was just a merge oddity as both commits are only ~1month=20
apart. IOW, I think Naoya's patch forgot to rip it out.


Can we make this clear in the patch description like "This is dead code=20
that cannot be reached after commit 761ad8d7c7b5 ("mm: hwpoison:=20
introduce memory_failure_hugetlb()")"

I assume Andrew can fix up when applying

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

