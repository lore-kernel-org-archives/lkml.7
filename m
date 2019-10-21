Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AC3CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFC6217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIjNdgp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfJUJo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:44:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58300 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726987AbfJUJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571651066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Bv9eBgQEb7HJVfEzfT6QuC1WXe26mg6vGbFTeUwq3g=;
        b=CIjNdgp6I7x//WnaDDSzZ78mPy7CjqHthMZqIwWuxU2cBZWrUUlj/YLyNSALwzgTxXbWjL
        ZNymcoCL/5smMh67BX3DrkoIvsTWUiSa+O5A0U+VWTwoPCnYoMJukvLXtQ3ZQVRLDhPYR0
        l3ZPreppa5vEq/bjKoIqFXDlfTIhVpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-t83UrnCzO4uzxfiGOtzskg-1; Mon, 21 Oct 2019 05:44:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79385107AD31;
        Mon, 21 Oct 2019 09:44:21 +0000 (UTC)
Received: from [10.36.116.198] (ovpn-116-198.ams2.redhat.com [10.36.116.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63E83608C0;
        Mon, 21 Oct 2019 09:44:20 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
 <20191010002619.GB3585@hori.linux.bs1.fc.nec.co.jp>
 <134d4f03-a40a-fe62-fb93-53d209a91d2e@redhat.com>
 <20191018190531.975b70fabdce5f7e5d6b27df@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <15e0a869-4edf-a5c4-64b1-5ed25a6ff720@redhat.com>
Date:   Mon, 21 Oct 2019 11:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018190531.975b70fabdce5f7e5d6b27df@linux-foundation.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: t83UrnCzO4uzxfiGOtzskg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.19 04:05, Andrew Morton wrote:
> On Thu, 10 Oct 2019 09:17:42 +0200 David Hildenbrand <david@redhat.com> w=
rote:
>=20
>>>> -=09pgmap =3D get_dev_pagemap(pfn, NULL);
>>>> -=09if (pgmap)
>>>> -=09=09return memory_failure_dev_pagemap(pfn, flags, pgmap);
>>>> -
>>>> -=09p =3D pfn_to_page(pfn);
>>>
>>> This change seems to assume that memory_failure_dev_pagemap() is never
>>> called for online pages. Is it an intended behavior?
>>> Or the concept "online pages" is not applicable to zone device pages?
>>
>> Yes, that's the real culprit. ZONE_DEVICE/devmem pages are never online
>> (SECTION_IS_ONLINE). The terminology "online" only applies to pages that
>> were given to the buddy. And as we support sup-section hotadd for
>> devmem, we cannot easily make use of the section flag it. I already
>> proposed somewhere to convert SECTION_IS_ONLINE to a subsection bitmap
>> and call it something like pfn_active().
>>
>> pfn_online() would then be "pfn_active() && zone !=3D ZONE_DEVICE". And =
we
>> could use pfn_active() everywhere to test for initialized memmaps (well,
>> besides some special cases like device reserved memory that does not
>> span full sub-sections). Until now, nobody volunteered and I have other
>> things to do.
>=20
> Is it worth a code comment or two to make this clearer?

You mean something like

/* Only pages managed by the buddy are online (not ZONE_DEVICE). */

?

--=20

Thanks,

David / dhildenb

