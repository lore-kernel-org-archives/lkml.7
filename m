Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5EDCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F7C20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H91MSlad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfJ3NcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:32:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726119AbfJ3Nb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572442318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0I0c5NVjrpNTNl/OL6Kn2k5U+xaEtyxd7H2PQP2aE10=;
        b=H91MSladHKiN8YjvpE88iyRfR0jPzFKgvOOPVk7/COzSM3P9zh6Bl2VH5FrYsuY3BF5kcD
        rr9ib5vIdtKwq7dbH73m4wX198vGgiaUxVFD46sQGqaatvnmRlFQg/FmUtltadBngWFXpa
        FyUSHpCNpA7xrQB6UtKhC9jo84qrhJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-GWuHbDW4NgOX4yFTEvnp5A-1; Wed, 30 Oct 2019 09:31:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F0B1800D55;
        Wed, 30 Oct 2019 13:31:51 +0000 (UTC)
Received: from [10.36.116.222] (ovpn-116-222.ams2.redhat.com [10.36.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF8CE600C6;
        Wed, 30 Oct 2019 13:31:49 +0000 (UTC)
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        akpm@linux-foundation.org
Cc:     osalvador@suse.de, mhocko@suse.com, pasha.tatashin@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <eb5dbddd-afb6-2473-fa76-a4fabf62fb89@redhat.com>
Date:   Wed, 30 Oct 2019 14:31:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191030131122.8256-1-vincent.whitchurch@axis.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GWuHbDW4NgOX4yFTEvnp5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.19 14:11, Vincent Whitchurch wrote:
> sparsemem without VMEMMAP has two allocation paths to allocate the
> memory needed for its memmap (done in sparse_mem_map_populate()).
>=20
> In one allocation path (sparse_buffer_alloc() succeeds), the memory is
> not zeroed (since it was previously allocated with
> memblock_alloc_try_nid_raw()).
>=20
> In the other allocation path (sparse_buffer_alloc() fails and
> sparse_mem_map_populate() falls back to memblock_alloc_try_nid()), the
> memory is zeroed.
>=20
> AFAICS this difference does not appear to be on purpose.  If the code is
> supposed to work with non-initialized memory (__init_single_page() takes
> care of zeroing the struct pages which are actually used), we should
> consistently not zero the memory, to avoid masking bugs.

I agree

Acked-by: David Hildenbrand <david@redhat.com>

>=20
> (I noticed this because on my ARM64 platform, with 1 GiB of memory the
>   first [and only] section is allocated from the zeroing path while with
>   2 GiB of memory the first 1 GiB section is allocated from the
>   non-zeroing path.)
>=20
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>   mm/sparse.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6891c1992b1..01e467adc219 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -458,7 +458,7 @@ struct page __init *__populate_section_memmap(unsigne=
d long pfn,
>   =09if (map)
>   =09=09return map;
>  =20
> -=09map =3D memblock_alloc_try_nid(size,
> +=09map =3D memblock_alloc_try_nid_raw(size,
>   =09=09=09=09=09  PAGE_SIZE, addr,
>   =09=09=09=09=09  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>   =09if (!map)
>=20


--=20

Thanks,

David / dhildenb

