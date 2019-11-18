Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C479B206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mih6Qaa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKRJpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:45:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29656 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbfKRJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574070321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRCkhLeYkd/VfpebpKrWifzijPdiIM77KJWFLi2G8ao=;
        b=Mih6Qaa2gFaJ6Ncd5pn52ipRiBD/5A43lqWq+83nRFrsBNQe7miIGPU7ta/TaCqwCVV334
        8Z0lYfbUHKfvL12AHOvNdsurmXkhJ7KvF8ft66OjNR9R4qRidj+RuvfRaMSPutOTjKFRje
        C/s6Oj2nE+qFF1/akxPVHsfAweDcPCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-4pE2t8omPqm6BV13ZIpVIQ-1; Mon, 18 Nov 2019 04:45:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B8BB802690;
        Mon, 18 Nov 2019 09:45:15 +0000 (UTC)
Received: from [10.36.118.85] (unknown [10.36.118.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 479F117D34;
        Mon, 18 Nov 2019 09:45:11 +0000 (UTC)
Subject: Re: [PATCH v3] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
To:     linmiaohe <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, sfr@canb.auug.org.au,
        rppt@linux.ibm.com, jannh@google.com, steve.capper@arm.com,
        catalin.marinas@arm.com, aarcange@redhat.com,
        chenjianhong2@huawei.com, walken@google.com,
        dave.hansen@linux.intel.com, tiny.windzz@gmail.com,
        jhubbard@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1574059147-13678-1-git-send-email-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8b5f515f-307b-1e73-249f-f69a4b8c4318@redhat.com>
Date:   Mon, 18 Nov 2019 10:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574059147-13678-1-git-send-email-linmiaohe@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4pE2t8omPqm6BV13ZIpVIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.19 07:39, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>=20
> The jump labels try_prev and none are not really needed
> in find_mergeable_anon_vma(), eliminate them to improve
> readability.
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> -v2:
> =09Fix commit descriptions and further simplify the code
> =09as suggested by David Hildenbrand and John Hubbard.
> -v3:
> =09Rewrite patch version info. Don't show this in commit log.
> ---
>   mm/mmap.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4d4db76a07da..ff02c23fd375 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1276,26 +1276,25 @@ static struct anon_vma *reusable_anon_vma(struct =
vm_area_struct *old, struct vm_
>    */
>   struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
>   {
> -=09struct anon_vma *anon_vma;
> +=09struct anon_vma *anon_vma =3D NULL;
>   =09struct vm_area_struct *near;
>  =20
> +=09/* Try next first. */
>   =09near =3D vma->vm_next;
> -=09if (!near)
> -=09=09goto try_prev;
> +=09if (near) {
> +=09=09anon_vma =3D reusable_anon_vma(near, vma, near);
> +=09=09if (anon_vma)
> +=09=09=09return anon_vma;
> +=09}

I think you can get rid of near completely as well

=09if (vma->vm_next) {
=09=09anon_vma =3D reusable_anon_vma(near, vma, vma->vm_next);
=09=09if (anon_vma)
=09=09=09return anon_vma;
=09}

...

Apart from  that looks good to me.

>  =20
> -=09anon_vma =3D reusable_anon_vma(near, vma, near);
> -=09if (anon_vma)
> -=09=09return anon_vma;
> -try_prev:
> +=09/* Try prev next. */
>   =09near =3D vma->vm_prev;
> -=09if (!near)
> -=09=09goto none;
> +=09if (near)
> +=09=09anon_vma =3D reusable_anon_vma(near, near, vma);
>  =20
> -=09anon_vma =3D reusable_anon_vma(near, near, vma);
> -=09if (anon_vma)
> -=09=09return anon_vma;
> -none:
>   =09/*
> +=09 * We might reach here with anon_vma =3D=3D NULL if we can't find
> +=09 * any reusable anon_vma.
>   =09 * There's no absolute need to look only at touching neighbours:
>   =09 * we could search further afield for "compatible" anon_vmas.
>   =09 * But it would probably just be a waste of time searching,
> @@ -1303,7 +1302,7 @@ struct anon_vma *find_mergeable_anon_vma(struct vm_=
area_struct *vma)
>   =09 * We're trying to allow mprotect remerging later on,
>   =09 * not trying to minimize memory used for anon_vmas.
>   =09 */
> -=09return NULL;
> +=09return anon_vma;
>   }
>  =20
>   /*
>=20


--=20

Thanks,

David / dhildenb

