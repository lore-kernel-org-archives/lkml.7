Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E70CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85D821872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCi7rsWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407437AbfJYITP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405453AbfJYITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571991553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PrSSF3wO1cJpdgdh+GJt9lzgrmCJZ2ZadeLy2HGxrQ=;
        b=RCi7rsWT3PMcQrGSU9USOTxMBYjxTGW/RyuQbu0Gs5AbKZqB6zZdmW04EStS5zXQJoLZxg
        0UDqmS3UcCurprBFlfQvUjVjtrCvs2+/xR6RH5NNSFi9Zel1Zgiex/Cf0Lyw8YwHn8bLd2
        5t6KGBS/C9e7avoZk8RqCU6usnVzQMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-EJRcQS6kM0S5C-o7lah5hQ-1; Fri, 25 Oct 2019 04:19:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98FCD800D41;
        Fri, 25 Oct 2019 08:19:07 +0000 (UTC)
Received: from [10.36.116.205] (ovpn-116-205.ams2.redhat.com [10.36.116.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F2C51001B28;
        Fri, 25 Oct 2019 08:18:59 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm, vmstat: hide /proc/pagetypeinfo from normal users
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
References: <20191025072610.18526-1-mhocko@kernel.org>
 <20191025072610.18526-2-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f51a7b6f-cb6c-3392-230b-136814523a32@redhat.com>
Date:   Fri, 25 Oct 2019 10:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025072610.18526-2-mhocko@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: EJRcQS6kM0S5C-o7lah5hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.10.19 09:26, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>=20
> /proc/pagetypeinfo is a debugging tool to examine internal page
> allocator state wrt to fragmentation. It is not very useful for
> any other use so normal users really do not need to read this file.
>=20
> Waiman Long has noticed that reading this file can have negative side
> effects because zone->lock is necessary for gathering data and that
> a) interferes with the page allocator and its users and b) can lead to
> hard lockups on large machines which have very long free_list.
>=20
> Reduce both issues by simply not exporting the file to regular users.
>=20
> Reported-by: Waiman Long <longman@redhat.com>
> Cc: stable
> Fixes: 467c996c1e19 ("Print out statistics in relation to fragmentation a=
voidance to /proc/pagetypeinfo")
> Acked-by: Mel Gorman <mgorman@suse.de>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Waiman Long <longman@redhat.com>
> Acked-by: Rafael Aquini <aquini@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>   mm/vmstat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 6afc892a148a..4e885ecd44d1 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1972,7 +1972,7 @@ void __init init_mm_internals(void)
>   #endif
>   #ifdef CONFIG_PROC_FS
>   =09proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
> -=09proc_create_seq("pagetypeinfo", 0444, NULL, &pagetypeinfo_op);
> +=09proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
>   =09proc_create_seq("vmstat", 0444, NULL, &vmstat_op);
>   =09proc_create_seq("zoneinfo", 0444, NULL, &zoneinfo_op);
>   #endif
>=20

Looks good too me (the ack list is already long enough :) )

--=20

Thanks,

David / dhildenb

