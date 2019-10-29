Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689D72087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMhNukff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfJ2LJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:09:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727791AbfJ2LJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572347370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxjLgsc8qA8QS5AMJrptlvxMj6UiaLdFsNtqMQqPbhA=;
        b=eMhNukffaBa+E9VaO7hLzAuFanke9kC2WbeFX8Tky+0LqdEModNPZwfujJilS2A1K0/UCG
        +53KxxN4pZNOCV68RCDaaOLLBwY2fvy5p9rQ+mhvyV0RxOlHxnjxNAeZLMNUMGvwxy2VtS
        exroBFwZ1uhrPYzAqyee3wUkrvoIn3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-_kvQpE-QM9W83HYDPmpjEA-1; Tue, 29 Oct 2019 07:09:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B375800C80;
        Tue, 29 Oct 2019 11:09:26 +0000 (UTC)
Received: from [10.36.117.183] (ovpn-117-183.ams2.redhat.com [10.36.117.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3DFC5D6C3;
        Tue, 29 Oct 2019 11:09:24 +0000 (UTC)
Subject: Re: [PATCH] mm/sparse.c: mark populate_section_memmap as __meminit
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191028165549.14478-1-iii@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6e845b02-9601-5c9d-3f99-c8a439df07ae@redhat.com>
Date:   Tue, 29 Oct 2019 12:09:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028165549.14478-1-iii@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _kvQpE-QM9W83HYDPmpjEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.19 17:55, Ilya Leoshkevich wrote:
> Building the kernel on s390 with -Og produces the following warning:
>=20
> WARNING: vmlinux.o(.text+0x28dabe): Section mismatch in reference from th=
e function populate_section_memmap() to the function .meminit.text:__popula=
te_section_memmap()
> The function populate_section_memmap() references
> the function __meminit __populate_section_memmap().
> This is often because populate_section_memmap lacks a __meminit
> annotation or the annotation of __populate_section_memmap is wrong.
>=20
> While -Og is not supported, in theory this might still happen with
> another compiler or on another architecture. So fix this by using the
> correct section annotations.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   mm/sparse.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6891c1992b1..0f1f36443a96 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -448,7 +448,7 @@ static unsigned long __init section_map_size(void)
>   =09return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
>   }
>  =20
> -struct page __init *__populate_section_memmap(unsigned long pfn,
> +struct page __meminit *__populate_section_memmap(unsigned long pfn,
>   =09=09unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>   {
>   =09unsigned long size =3D section_map_size();
> @@ -647,7 +647,7 @@ void offline_mem_sections(unsigned long start_pfn, un=
signed long end_pfn)
>   #endif
>  =20
>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -static struct page *populate_section_memmap(unsigned long pfn,
> +static struct page * __meminit populate_section_memmap(unsigned long pfn=
,
>   =09=09unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>   {
>   =09return __populate_section_memmap(pfn, nr_pages, nid, altmap);
> @@ -669,7 +669,7 @@ static void free_map_bootmem(struct page *memmap)
>   =09vmemmap_free(start, end, NULL);
>   }
>   #else
> -struct page *populate_section_memmap(unsigned long pfn,
> +struct page * __meminit populate_section_memmap(unsigned long pfn,
>   =09=09unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>   {
>   =09struct page *page, *ret;
>=20

So mm/sparse-vmemmap.c:__populate_section_memmap() already has this=20
annotation. I guess it's the right thing to do as=20
populate_section_memmap() is called from

static struct page * __meminit section_activate()

Acked-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

