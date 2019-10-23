Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2719FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76EF2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xv0+h6CS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407163AbfJWQRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:17:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22271 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404543AbfJWQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571847471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9du2o7LJoi4mUo08NF58IYBsimMQv35yAuxjS871Umw=;
        b=Xv0+h6CSONLfwwJLLGF2wUUS/lvjccCbaIK7yHuPaiSaQ2DMDd2gLZle6DErZJthzmAEwl
        G55whMkA3hJX9HwYvbB0y0qjFGd8NHLAvzLijfeCf9OG8WpMIz6proOdaODLrrEjFH1j4x
        dWYngdGzd1Vd130B1jv0zyuyvwSTwPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-yHcMTFKuNrOED8JDKBAnvg-1; Wed, 23 Oct 2019 12:17:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE3B11800D6B;
        Wed, 23 Oct 2019 16:17:43 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 817F85D6D0;
        Wed, 23 Oct 2019 16:17:37 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-3-mhocko@kernel.org>
 <a3510617-fd23-9f90-3c40-700bcb0f353c@redhat.com>
 <20191023161029.GK17610@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <27e2a26d-8c9b-fdb9-782f-8efa678352b3@redhat.com>
Date:   Wed, 23 Oct 2019 12:17:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191023161029.GK17610@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: yHcMTFKuNrOED8JDKBAnvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 12:10 PM, Michal Hocko wrote:
> On Wed 23-10-19 10:56:30, Waiman Long wrote:
>> On 10/23/19 6:27 AM, Michal Hocko wrote:
>>> From: Michal Hocko <mhocko@suse.com>
>>>
>>> pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
>>> This is not really nice because it blocks both any interrupts on that
>>> cpu and the page allocator. On large machines this might even trigger
>>> the hard lockup detector.
>>>
>>> Considering the pagetypeinfo is a debugging tool we do not really need
>>> exact numbers here. The primary reason to look at the outuput is to see
>>> how pageblocks are spread among different migratetypes therefore puttin=
g
>>> a bound on the number of pages on the free_list sounds like a reasonabl=
e
>>> tradeoff.
>>>
>>> The new output will simply tell
>>> [...]
>>> Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >10=
0000  41019  31560  23996  10054   3229    983    648
>>>
>>> instead of
>>> Node    6, zone   Normal, type      Movable 399568 294127 221558 102119=
  41019  31560  23996  10054   3229    983    648
>>>
>>> The limit has been chosen arbitrary and it is a subject of a future
>>> change should there be a need for that.
>>>
>>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>>> ---
>>>  mm/vmstat.c | 19 ++++++++++++++++++-
>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index 4e885ecd44d1..762034fc3b83 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -1386,8 +1386,25 @@ static void pagetypeinfo_showfree_print(struct s=
eq_file *m,
>>> =20
>>>  =09=09=09area =3D &(zone->free_area[order]);
>>> =20
>>> -=09=09=09list_for_each(curr, &area->free_list[mtype])
>>> +=09=09=09list_for_each(curr, &area->free_list[mtype]) {
>>>  =09=09=09=09freecount++;
>>> +=09=09=09=09/*
>>> +=09=09=09=09 * Cap the free_list iteration because it might
>>> +=09=09=09=09 * be really large and we are under a spinlock
>>> +=09=09=09=09 * so a long time spent here could trigger a
>>> +=09=09=09=09 * hard lockup detector. Anyway this is a
>>> +=09=09=09=09 * debugging tool so knowing there is a handful
>>> +=09=09=09=09 * of pages in this order should be more than
>>> +=09=09=09=09 * sufficient
>>> +=09=09=09=09 */
>>> +=09=09=09=09if (freecount > 100000) {
>>> +=09=09=09=09=09seq_printf(m, ">%6lu ", freecount);
>>> +=09=09=09=09=09spin_unlock_irq(&zone->lock);
>>> +=09=09=09=09=09cond_resched();
>>> +=09=09=09=09=09spin_lock_irq(&zone->lock);
>>> +=09=09=09=09=09continue;
>> list_for_each() is a for loop. The continue statement will just iterate
>> the rests with the possibility that curr will be stale. Should we use
>> goto to jump after the seq_print() below?
> You are right. Kinda brown paper back material. Sorry about that. What
> about this on top?
> ---=20
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 762034fc3b83..c156ce24a322 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1383,11 +1383,11 @@ static void pagetypeinfo_showfree_print(struct se=
q_file *m,
>  =09=09=09unsigned long freecount =3D 0;
>  =09=09=09struct free_area *area;
>  =09=09=09struct list_head *curr;
> +=09=09=09bool overflow =3D false;
> =20
>  =09=09=09area =3D &(zone->free_area[order]);
> =20
>  =09=09=09list_for_each(curr, &area->free_list[mtype]) {
> -=09=09=09=09freecount++;
>  =09=09=09=09/*
>  =09=09=09=09 * Cap the free_list iteration because it might
>  =09=09=09=09 * be really large and we are under a spinlock
> @@ -1397,15 +1397,15 @@ static void pagetypeinfo_showfree_print(struct se=
q_file *m,
>  =09=09=09=09 * of pages in this order should be more than
>  =09=09=09=09 * sufficient
>  =09=09=09=09 */
> -=09=09=09=09if (freecount > 100000) {
> -=09=09=09=09=09seq_printf(m, ">%6lu ", freecount);
> +=09=09=09=09if (++freecount >=3D 100000) {
> +=09=09=09=09=09overflow =3D true;
>  =09=09=09=09=09spin_unlock_irq(&zone->lock);
>  =09=09=09=09=09cond_resched();
>  =09=09=09=09=09spin_lock_irq(&zone->lock);
> -=09=09=09=09=09continue;
> +=09=09=09=09=09break;
>  =09=09=09=09}
>  =09=09=09}
> -=09=09=09seq_printf(m, "%6lu ", freecount);
> +=09=09=09seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
>  =09=09}
>  =09=09seq_putc(m, '\n');
>  =09}
>
Yes, that looks good to me. There is still a small chance that the
description will be a bit off if it is exactly 100,000. However, it is
not a big deal and I can live with that.

Thanks,
Longman

