Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596FFC49EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284FD20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSx8KjZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbfKEJuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:50:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31186 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730571AbfKEJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572947413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGggv342lFx1tfwwl12Nk/iZ58G5iqriqTxQgLV8zo8=;
        b=RSx8KjZD9qbSpR/+JE5qNDBrcu+zkk5Gg3CwxGUhx3aKFvVTTYZQiTzpZw0kmH320VnJwj
        b65Z8Pwuo07SJ2YJoVeEuAl/tsgQ3aJnocQ+QynGIjeniT/C1q9p00yjdg0pDT3ecVEKjQ
        TDTT1ibtGPS+n+AImWA+q1Clq797hh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-SL926ai3PRGUG_s0dpBfZA-1; Tue, 05 Nov 2019 04:50:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 261A0800C73;
        Tue,  5 Nov 2019 09:50:10 +0000 (UTC)
Received: from [10.36.117.253] (ovpn-117-253.ams2.redhat.com [10.36.117.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B83D060CDA;
        Tue,  5 Nov 2019 09:50:08 +0000 (UTC)
Subject: Re: [PATCH v2] mm/memory-failure.c: replace with page_shift() in
 add_to_kill()
To:     Yunfeng Ye <yeyunfeng@huawei.com>, n-horiguchi@ah.jp.nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <543d8bc9-f2e7-3023-7c35-2e7ed67c0e82@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ff090004-2cf7-9c77-9c9e-7fc5aff90d35@redhat.com>
Date:   Tue, 5 Nov 2019 10:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <543d8bc9-f2e7-3023-7c35-2e7ed67c0e82@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: SL926ai3PRGUG_s0dpBfZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.19 10:38, Yunfeng Ye wrote:
> The function page_shift() is supported after the commit 94ad9338109f
> ("mm: introduce page_shift()").
>=20
> So replace with page_shift() in add_to_kill() for readability.
>=20
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
> v1 -> v2:
>   - add Reviewed-by and Acked-by

Note for the future: No need to resend if there were no=20
code/documentation changes. Andrew will apply the tags when picking up=20
the patch.

>=20
>   mm/memory-failure.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3151c87dff73..e48c50cac889 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -326,7 +326,7 @@ static void add_to_kill(struct task_struct *tsk, stru=
ct page *p,
>   =09if (is_zone_device_page(p))
>   =09=09tk->size_shift =3D dev_pagemap_mapping_shift(p, vma);
>   =09else
> -=09=09tk->size_shift =3D compound_order(compound_head(p)) + PAGE_SHIFT;
> +=09=09tk->size_shift =3D page_shift(compound_head(p));
>=20
>   =09/*
>   =09 * Send SIGKILL if "tk->addr =3D=3D -EFAULT". Also, as
>=20


--=20

Thanks,

David / dhildenb

