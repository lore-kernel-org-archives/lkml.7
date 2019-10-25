Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB9CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD36A21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jE1NTew1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504633AbfJYMwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:52:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28512 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2501908AbfJYMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572007959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8i+TCwhs+dWNyEedELhI+i+2i1MD1dNVmQL25FSLho=;
        b=jE1NTew1lG5YZVM3W/f3hVHMophYRDCAOl3HYHcmLL6ec3tWvyQhgd4s8QIPkktxAxniQh
        Fvxo5H0QzxExHWBvDzZHOXUV/msWVmqQeVGx/T72AN+zozJiYa6whu4K/sxIJI8aV+7rfL
        S8K4aM9Qd7eMhEn5zXByD5mXUj0ULLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-T_9r8giqN4iMM0deT0aUtQ-1; Fri, 25 Oct 2019 08:52:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF95A800D41;
        Fri, 25 Oct 2019 12:52:32 +0000 (UTC)
Received: from optiplex-lnx (ovpn-112-25.rdu2.redhat.com [10.10.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E5E10013A1;
        Fri, 25 Oct 2019 12:52:25 +0000 (UTC)
Date:   Fri, 25 Oct 2019 08:52:22 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-ID: <20191025125222.GC4596@optiplex-lnx>
References: <20191025072610.18526-1-mhocko@kernel.org>
 <20191025072610.18526-3-mhocko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191025072610.18526-3-mhocko@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: T_9r8giqN4iMM0deT0aUtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 09:26:10AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>=20
> pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
> This is not really nice because it blocks both any interrupts on that
> cpu and the page allocator. On large machines this might even trigger
> the hard lockup detector.
>=20
> Considering the pagetypeinfo is a debugging tool we do not really need
> exact numbers here. The primary reason to look at the outuput is to see
> how pageblocks are spread among different migratetypes and low number of
> pages is much more interesting therefore putting a bound on the number
> of pages on the free_list sounds like a reasonable tradeoff.
>=20
> The new output will simply tell
> [...]
> Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >1000=
00  41019  31560  23996  10054   3229    983    648
>=20
> instead of
> Node    6, zone   Normal, type      Movable 399568 294127 221558 102119  =
41019  31560  23996  10054   3229    983    648
>=20
> The limit has been chosen arbitrary and it is a subject of a future
> change should there be a need for that.
>=20
> While we are at it, also drop the zone lock after each free_list
> iteration which will help with the IRQ and page allocator responsiveness
> even further as the IRQ lock held time is always bound to those 100k
> pages.
>=20
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmstat.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4e885ecd44d1..ddb89f4e0486 100644
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
> +=09=09=09=09=09break;
> +=09=09=09=09}
> +=09=09=09}
> +=09=09=09seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
> +=09=09=09spin_unlock_irq(&zone->lock);
> +=09=09=09cond_resched();
> +=09=09=09spin_lock_irq(&zone->lock);
>  =09=09}
>  =09=09seq_putc(m, '\n');
>  =09}
> --=20
> 2.20.1
>=20
Acked-by: Rafael Aquini <aquini@redhat.com>

