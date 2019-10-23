Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEACCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFCD205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHUHOAbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbfJWI5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:57:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52638 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390358AbfJWI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571821029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkKzgaRAceltdCXjAdVi52Sq7tr6HYrkJ4MeZudRqlY=;
        b=jHUHOAbp4VMwlYTTmWRfirMHNx/ya7BY6+RdKzVhKE5vn6xWpfvOKdCVMfmNUPohk+usIH
        aOdpERyIlBKf/XECOzBTF0zMzEkRegdgo7FzSUyTgfZeJixraVORSksM9HGwYvQlEKS1hV
        5+Ct1XoagCqG7grYIocQo2frJjX3urc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-EpfqydMAMviJFRoi3y4thw-1; Wed, 23 Oct 2019 04:57:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9888A1005509;
        Wed, 23 Oct 2019 08:57:06 +0000 (UTC)
Received: from [10.36.117.79] (ovpn-117-79.ams2.redhat.com [10.36.117.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B192E5DC18;
        Wed, 23 Oct 2019 08:57:04 +0000 (UTC)
Subject: Re: [PATCH] mm, meminit: Recalculate pcpu batch and high limits after
 init completes -fix
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@intel.com
References: <20191023084705.GD3016@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6fb991f9-5961-92cc-b527-c3ebbeadc351@redhat.com>
Date:   Wed, 23 Oct 2019 10:57:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023084705.GD3016@techsingularity.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: EpfqydMAMviJFRoi3y4thw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.19 10:47, Mel Gorman wrote:
> LKP reported the following build problem from two hunks that did not
> survive the reshuffling of the series reordering.
>=20
>   ld: mm/page_alloc.o: in function `page_alloc_init_late':
>   mm/page_alloc.c:1956: undefined reference to `zone_pcp_update'
>=20
> This is a fix for the mmotm patch
> mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes.pa=
tch
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>   mm/page_alloc.c | 2 --
>   1 file changed, 2 deletions(-)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f9488efff680..12f3ce09d33d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8627,7 +8627,6 @@ void free_contig_range(unsigned long pfn, unsigned =
int nr_pages)
>   =09WARN(count !=3D 0, "%d pages are still in use!\n", count);
>   }
>  =20
> -#ifdef CONFIG_MEMORY_HOTPLUG
>   /*
>    * The zone indicated has a new number of managed_pages; batch sizes an=
d percpu
>    * page high values need to be recalulated.
> @@ -8638,7 +8637,6 @@ void __meminit zone_pcp_update(struct zone *zone)
>   =09__zone_pcp_update(zone);
>   =09mutex_unlock(&pcp_batch_high_lock);
>   }
> -#endif
>  =20
>   void zone_pcp_reset(struct zone *zone)
>   {
>=20

Acked-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

