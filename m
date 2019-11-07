Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6D9C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F9321D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTyvXilm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfKGWrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:47:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48988 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725992AbfKGWrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573166873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0hSEf7cZiNsB/Oanv82zNpB8/hYX3vB1FUXpV/eRis=;
        b=FTyvXilmNG0dDFZQn/xsVJ9UkDLG6zSb02aRe4wDTNUAFFACTAoZsR/sGumhD+q7HHL0qb
        17cm0MKAAGm+eoDHGDQnE2hNP1ZsZgXBM1mdrkMrBeiBpI2TV+RicUsi39qR56c2BHlHDP
        O/pczSyRRpmGeofycdY0qJyu5jyXC9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-MJr50gAhPPqZCNT2ZuYxrA-1; Thu, 07 Nov 2019 17:47:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75F821800D6B;
        Thu,  7 Nov 2019 22:47:49 +0000 (UTC)
Received: from [10.36.116.80] (ovpn-116-80.ams2.redhat.com [10.36.116.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 461B65D9E5;
        Thu,  7 Nov 2019 22:47:48 +0000 (UTC)
Subject: Re: [PATCH] mm/memory_hotplug: move definitions of
 {set,clear}_zone_contiguous
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191106123911.7435-1-ben.dooks@codethink.co.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a8bd4219-ed0d-dead-f326-6a68e44864e0@redhat.com>
Date:   Thu, 7 Nov 2019 23:47:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106123911.7435-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: MJr50gAhPPqZCNT2ZuYxrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.19 13:39, Ben Dooks (Codethink) wrote:
> The {set,clear}_zone_contiguous are built whatever the
> configuraiton so move the definitions outside the current
> ifdef to avoid the following compiler warnings:
>=20
> mm/page_alloc.c:1550:6: warning: no previous prototype for =C3=A2set_zone=
_contiguous=C3=A2 [-Wmissing-prototypes]
> mm/page_alloc.c:1571:6: warning: no previous prototype for =C3=A2clear_zo=
ne_contiguous=C3=A2 [-Wmissing-prototypes]
>=20
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   include/linux/memory_hotplug.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
> index f46ea71b4ffd..6a6456040802 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -229,9 +229,6 @@ void put_online_mems(void);
>   void mem_hotplug_begin(void);
>   void mem_hotplug_done(void);
>  =20
> -extern void set_zone_contiguous(struct zone *zone);
> -extern void clear_zone_contiguous(struct zone *zone);
> -
>   #else /* ! CONFIG_MEMORY_HOTPLUG */
>   #define pfn_to_online_page(pfn)=09=09=09\
>   ({=09=09=09=09=09=09\
> @@ -339,6 +336,9 @@ static inline int remove_memory(int nid, u64 start, u=
64 size)
>   static inline void __remove_memory(int nid, u64 start, u64 size) {}
>   #endif /* CONFIG_MEMORY_HOTREMOVE */
>  =20
> +extern void set_zone_contiguous(struct zone *zone);
> +extern void clear_zone_contiguous(struct zone *zone);
> +
>   extern void __ref free_area_init_core_hotplug(int nid);
>   extern int __add_memory(int nid, u64 start, u64 size);
>   extern int add_memory(int nid, u64 start, u64 size);
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

