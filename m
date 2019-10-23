Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D576CCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F2E21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bObtdQc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfJWQrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:47:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31357 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726259AbfJWQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571849261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6sHK0m/qIFaZRohYYX2LLPiOCsi+t/0BBZ8S4RpimWo=;
        b=bObtdQc24UXuTehQR/3xk0ZSmfCtuTA2M/I4mCy7nrX9GMJ7yuW4hYu4K0uZfYUqKXA0Xb
        sSGP+OtaOTumedChdlPSJpQuLaWPEA4wMxOMp06zEtnvNjRtjsgSEDtN4HNrHa0sPF/vxE
        iRtG4vG5Dq/vhTYFkuEE3MNpf98m32k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-mX9lat8RPpSBjZcQRJWnhQ-1; Wed, 23 Oct 2019 12:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E86C0476;
        Wed, 23 Oct 2019 16:47:35 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40A3360BE1;
        Wed, 23 Oct 2019 16:47:34 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-3-mhocko@kernel.org>
 <20191023164145.GL17610@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c971e3ef-384c-b96d-0a1b-e3bb42fee9ac@redhat.com>
Date:   Wed, 23 Oct 2019 12:47:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191023164145.GL17610@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: mX9lat8RPpSBjZcQRJWnhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 12:41 PM, Michal Hocko wrote:
> With a brown paper bag bug fixed. I have also added a note about low
> number of pages being more important as per Vlastimil's feedback
>
> From 0282f604144a5c06fdf3cf0bb2df532411e7f8c9 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Wed, 23 Oct 2019 12:13:02 +0200
> Subject: [PATCH] mm, vmstat: reduce zone->lock holding time by
>  /proc/pagetypeinfo
>
> pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
> This is not really nice because it blocks both any interrupts on that
> cpu and the page allocator. On large machines this might even trigger
> the hard lockup detector.
>
> Considering the pagetypeinfo is a debugging tool we do not really need
> exact numbers here. The primary reason to look at the outuput is to see
> how pageblocks are spread among different migratetypes and low number of
> pages is much more interesting therefore putting a bound on the number
> of pages on the free_list sounds like a reasonable tradeoff.
>
> The new output will simply tell
> [...]
> Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >1000=
00  41019  31560  23996  10054   3229    983    648
>
> instead of
> Node    6, zone   Normal, type      Movable 399568 294127 221558 102119  =
41019  31560  23996  10054   3229    983    648
>
> The limit has been chosen arbitrary and it is a subject of a future
> change should there be a need for that.
>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmstat.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4e885ecd44d1..c156ce24a322 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1383,12 +1383,29 @@ static void pagetypeinfo_showfree_print(struct se=
q_file *m,
>  =09=09=09unsigned long freecount =3D 0;
>  =09=09=09struct free_area *area;
>  =09=09=09struct list_head *curr;
> +=09=09=09bool overflow =3D false;
> =20
>  =09=09=09area =3D &(zone->free_area[order]);
> =20
> -=09=09=09list_for_each(curr, &area->free_list[mtype])
> -=09=09=09=09freecount++;
> -=09=09=09seq_printf(m, "%6lu ", freecount);
> +=09=09=09list_for_each(curr, &area->free_list[mtype]) {
> +=09=09=09=09/*
> +=09=09=09=09 * Cap the free_list iteration because it might
> +=09=09=09=09 * be really large and we are under a spinlock
> +=09=09=09=09 * so a long time spent here could trigger a
> +=09=09=09=09 * hard lockup detector. Anyway this is a
> +=09=09=09=09 * debugging tool so knowing there is a handful
> +=09=09=09=09 * of pages in this order should be more than
> +=09=09=09=09 * sufficient
> +=09=09=09=09 */
> +=09=09=09=09if (++freecount >=3D 100000) {
> +=09=09=09=09=09overflow =3D true;
> +=09=09=09=09=09spin_unlock_irq(&zone->lock);
> +=09=09=09=09=09cond_resched();
> +=09=09=09=09=09spin_lock_irq(&zone->lock);
> +=09=09=09=09=09break;
> +=09=09=09=09}
> +=09=09=09}
> +=09=09=09seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
>  =09=09}
>  =09=09seq_putc(m, '\n');
>  =09}

Reviewed-by: Waiman Long <longman@redhat.com>

