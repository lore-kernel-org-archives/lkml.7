Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ACFC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A187C20878
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNd2nCm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKSKEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:04:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26072 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbfKSKEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574157844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lc80Uf6smt772vejp9UrgjLMfO5FXtq+Y7G0y3CH83E=;
        b=FNd2nCm4ZaBrJd1fl4YS5+j2ynfZE50LUpMSSofwNpeB6OFIcfX3Ip8E+7eUQ6dwNpCiUL
        ezXwT4ZB2VhcbusxyQ91+dcqoQM7d2z4fmYw31O1MECfd/tkqwi2cUdJNlFZP2IF21LjS2
        2ETBVWi0iQQem+chOaEyA6C1c4C+lP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-69l8T8tiPG6xj2cJUKyDAA-1; Tue, 19 Nov 2019 05:04:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6819B801E5B;
        Tue, 19 Nov 2019 10:04:01 +0000 (UTC)
Received: from [10.36.117.126] (ovpn-117-126.ams2.redhat.com [10.36.117.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA1B35E24D;
        Tue, 19 Nov 2019 10:03:59 +0000 (UTC)
Subject: Re: [PATCH] mm, sparse: do not waste pre allocated memmap space
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Oscar Salvador <OSalvador@suse.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20191119092642.31799-1-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <def84c96-a7d0-1026-a890-a8eca2e6a458@redhat.com>
Date:   Tue, 19 Nov 2019 11:03:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119092642.31799-1-mhocko@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 69l8T8tiPG6xj2cJUKyDAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.19 10:26, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>=20
> Vincent has noticed [1] that there is something unusual with the memmap
> allocations going on on his platform
> : I noticed this because on my ARM64 platform, with 1 GiB of memory the
> : first [and only] section is allocated from the zeroing path while with
> : 2 GiB of memory the first 1 GiB section is allocated from the
> : non-zeroing path.
>=20
> The underlying problem is that although sparse_buffer_init allocates enou=
gh
> memory for all sections on the node sparse_buffer_alloc is not able to
> consume them due to mismatch in the expected allocation alignement.
> While sparse_buffer_init preallocation uses the PAGE_SIZE alignment the
> real memmap has to be aligned to section_map_size() this results in a
> wasted initial chunk of the preallocated memmap and unnecessary fallback
> allocation for a section.
>=20
> While we are at it also change __populate_section_memmap to align to the
> requested size because at least VMEMMAP has constrains to have memmap
> properly aligned.
>=20
> [1] http://lkml.kernel.org/r/20191030131122.8256-1-vincent.whitchurch@axi=
s.com
> Reported-and-debugged-by: Vincent Whitchurch <vincent.whitchurch@axis.com=
>
> Fixes: 35fd1eb1e821 ("mm/sparse: abstract sparse buffer allocations")
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>   mm/sparse.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6891c1992b1..079f3e3c4cab 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -458,8 +458,7 @@ struct page __init *__populate_section_memmap(unsigne=
d long pfn,
>   =09if (map)
>   =09=09return map;
>  =20
> -=09map =3D memblock_alloc_try_nid(size,
> -=09=09=09=09=09  PAGE_SIZE, addr,
> +=09map =3D memblock_alloc_try_nid(size, size, addr,
>   =09=09=09=09=09  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>   =09if (!map)
>   =09=09panic("%s: Failed to allocate %lu bytes align=3D0x%lx nid=3D%d fr=
om=3D%pa\n",
> @@ -482,8 +481,13 @@ static void __init sparse_buffer_init(unsigned long =
size, int nid)
>   {
>   =09phys_addr_t addr =3D __pa(MAX_DMA_ADDRESS);
>   =09WARN_ON(sparsemap_buf);=09/* forgot to call sparse_buffer_fini()? */
> +=09/*
> +=09 * Pre-allocated buffer is mainly used by __populate_section_memmap
> +=09 * and we want it to be properly aligned to the section size - this i=
s
> +=09 * especially the case for VMEMMAP which maps memmap to PMDs
> +=09 */
>   =09sparsemap_buf =3D
> -=09=09memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> +=09=09memblock_alloc_try_nid_raw(size, section_map_size(),
>   =09=09=09=09=09=09addr,
>   =09=09=09=09=09=09MEMBLOCK_ALLOC_ACCESSIBLE, nid);

Wow, that alignment/layout gives me nightmares  ^

None of your business, though :)

>   =09sparsemap_buf_end =3D sparsemap_buf + size;
>=20

Acked-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

