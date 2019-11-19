Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6666C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B81920730
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwVghIqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfKSMYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:24:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbfKSMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574166240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6C32uts1Uhc4+2A9laxGruBZKmAzLGPWUERpPutUIA=;
        b=iwVghIqJ9HGYxxOhlo+BqeC7KQVXwOvBp/5rrXhU5UFiasJBM2dlg9LEUqa8PL1RyxO1P7
        A9cF1cKXvXWxH+tVuTFX8SK2dkXA5m1opyPMADFTsFJUEcL95ArU7crJy8iUwZbB+lzjsH
        3FYsqHUW2Qwmp+kd6tAsz9xOMCWYIao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-HfaLaDUnOAK8q8zgiYEWmg-1; Tue, 19 Nov 2019 07:23:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B883800686;
        Tue, 19 Nov 2019 12:23:56 +0000 (UTC)
Received: from [10.36.117.126] (ovpn-117-126.ams2.redhat.com [10.36.117.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F4714DA10;
        Tue, 19 Nov 2019 12:23:55 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm/memory-failure.c: PageHuge is handled at the
 beginning of memory_failure
To:     Wei Yang <richardw.yang@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1e61c115-5787-9ef4-a449-2e490c53fca7@redhat.com>
Date:   Tue, 19 Nov 2019 13:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191118082003.26240-1-richardw.yang@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: HfaLaDUnOAK8q8zgiYEWmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.19 09:20, Wei Yang wrote:
> PageHuge is handled by memory_failure_hugetlb(), so this case could be
> removed.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>   mm/memory-failure.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3151c87dff73..392ac277b17d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1359,10 +1359,7 @@ int memory_failure(unsigned long pfn, int flags)
>   =09 * page_remove_rmap() in try_to_unmap_one(). So to determine page st=
atus
>   =09 * correctly, we save a copy of the page flags at this time.
>   =09 */
> -=09if (PageHuge(p))
> -=09=09page_flags =3D hpage->flags;
> -=09else
> -=09=09page_flags =3D p->flags;
> +=09page_flags =3D p->flags;
>  =20
>   =09/*
>   =09 * unpoison always clear PG_hwpoison inside page lock
>=20

I somewhat miss a proper explanation why this is safe to do. We access=20
page flags here, so why is it safe to refer to the ones of the sub-page?

--=20

Thanks,

David / dhildenb

