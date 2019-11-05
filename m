Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB46C49EAA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F5C2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUwGCZQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfKEI6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:58:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28892 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727925AbfKEI6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572944286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5Y8efObvDU60RISxdiJngQGMPQkFpy+gNbh+IZW5yM=;
        b=WUwGCZQ4ymPoiNakObeAqFDC5XbVUKkxF0AWleOEp2Y5UUMpFK9Z51e13C8Bn5W50hvGQZ
        GA2E2WKZNTP89vTaCzFJbLMUjNyZaNZK/Eh8JH542p58UdR5ldC5X2SmMXSYbvzeZdSPbu
        BkqaM9zSaD/PH0Fy3paTd5Eer02FRJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-16T4VLGAMFeiFaZDGSE4Vg-1; Tue, 05 Nov 2019 03:58:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CE9D107ACC2;
        Tue,  5 Nov 2019 08:58:02 +0000 (UTC)
Received: from [10.36.117.253] (ovpn-117-253.ams2.redhat.com [10.36.117.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D90FE608B5;
        Tue,  5 Nov 2019 08:58:00 +0000 (UTC)
Subject: Re: [PATCH] mm/memory-failure.c: replace with page_shift() in
 add_to_kill()
To:     Yunfeng Ye <yeyunfeng@huawei.com>, n-horiguchi@ah.jp.nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <7bc9d610-728c-37b0-d175-dba21dc0dfff@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ad7d1d04-a734-6e9e-1222-215e1329cc98@redhat.com>
Date:   Tue, 5 Nov 2019 09:57:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7bc9d610-728c-37b0-d175-dba21dc0dfff@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 16T4VLGAMFeiFaZDGSE4Vg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.19 09:21, Yunfeng Ye wrote:
> The function page_shift() is supported after the commit 94ad9338109f
> ("mm: introduce page_shift()").
>=20
> So replace with page_shift() in add_to_kill() for readability.
>=20
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
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

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

