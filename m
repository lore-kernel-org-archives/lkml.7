Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C8DC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8942073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gM/mm74K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfKOM6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:58:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24400 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727223AbfKOM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573822694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=u5KXcGCEMZfiigcHpMQdUQ5I3O0+rZRjoxr5UASBB8A=;
        b=gM/mm74KAIhxEGMi6OYvScLQ4J6R4rq+y0C9jYzAMl7kwoyQP4R3iEcwn3u6f/3/qKwk45
        2FOVxglFUUKQ02NsUbT1qrZiFoc760pZoxSTSjLBrrhhGHmIw+K+Kni0j+ILJhHBtWwHJe
        hxSxo6rh10Un3WwfJolIpD8b+ChC4As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-S9QpeGMtP9WKFGt1sQgWIA-1; Fri, 15 Nov 2019 07:58:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD703802682;
        Fri, 15 Nov 2019 12:58:08 +0000 (UTC)
Received: from [10.36.118.87] (unknown [10.36.118.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B5A45ED3B;
        Fri, 15 Nov 2019 12:58:03 +0000 (UTC)
Subject: Re: [PATCH] mm: get rid of odd jump label in find_mergeable_anon_vma
To:     linmiaohe <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, sfr@canb.auug.org.au,
        rppt@linux.ibm.com, jannh@google.com, steve.capper@arm.com,
        catalin.marinas@arm.com, aarcange@redhat.com,
        chenjianhong2@huawei.com, walken@google.com,
        dave.hansen@linux.intel.com, tiny.windzz@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1573799768-15650-1-git-send-email-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <5277de34-ecb3-831e-c697-1fd3f66b45ba@redhat.com>
Date:   Fri, 15 Nov 2019 13:58:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573799768-15650-1-git-send-email-linmiaohe@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: S9QpeGMtP9WKFGt1sQgWIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.19 07:36, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>

I'm pro removing unnecessary jump labels.

Subject: "mm: get rid of jump labels in find_mergeable_anon_vma()"

>=20
> The odd jump label try_prev and none is not really need

s/odd jump label/jump labels/

s/is/are/

> in func find_mergeable_anon_vma, eliminate them to
> improve readability.
>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/mmap.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4d4db76a07da..ab980d468a10 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1276,25 +1276,21 @@ static struct anon_vma *reusable_anon_vma(struct =
vm_area_struct *old, struct vm_
>   */
>  struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
>  {
> -=09struct anon_vma *anon_vma;
> +=09struct anon_vma *anon_vma =3D NULL;
>  =09struct vm_area_struct *near;
> =20
>  =09near =3D vma->vm_next;
> -=09if (!near)
> -=09=09goto try_prev;
> -
> -=09anon_vma =3D reusable_anon_vma(near, vma, near);
> +=09if (near)
> +=09=09anon_vma =3D reusable_anon_vma(near, vma, near);>  =09if (anon_vma=
)
>  =09=09return anon_vma;

Let me suggest the following instead:

/* Try next first */
near =3D vma->vm_next;
if (near) {
=09anon_vma =3D reusable_anon_vma(near, vma, near);
=09if (anon_vma)
=09=09return anon_vma;
}
/* Try prev next */
near =3D vma->vm_prev;
if (near) {
=09anon_vma =3D reusable_anon_vma(near, vma, near);
=09if (anon_vma)
=09=09return anon_vma;
}

> -try_prev:
> -=09near =3D vma->vm_prev;
> -=09if (!near)
> -=09=09goto none;
> =20
> -=09anon_vma =3D reusable_anon_vma(near, near, vma);
> +=09near =3D vma->vm_prev;
> +=09if (near)
> +=09=09anon_vma =3D reusable_anon_vma(near, near, vma);
>  =09if (anon_vma)
>  =09=09return anon_vma;
> -none:
> +
>  =09/*
>  =09 * There's no absolute need to look only at touching neighbours:
>  =09 * we could search further afield for "compatible" anon_vmas.
>=20


--=20

Thanks,

David / dhildenb

