Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2BACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4A21928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVvPfItp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407207AbfJWQVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:21:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404850AbfJWQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571847677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yb+CfoGFjOsF490dmtrlU6UWPLSnL/PL/inTpFxT+eg=;
        b=MVvPfItpPKrUKCiMDHSXW4H60wAfAxs0Kyp5Dzx1clLM2UM2tcx/1ZuyUNOvXbSkXs/9PW
        bp2y77KYibPGOlRFbi9xsia3k+wdjbiTQZrn5TnkVYAqLWeWeh3yjFD0MpjB1SUjRXVRej
        bJHTq9dNcsGsaTZW5GPbWnKEBhyAXkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-FsNnKaJeOJa4ZPGFg-Gqxg-1; Wed, 23 Oct 2019 12:21:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2111A107AD31;
        Wed, 23 Oct 2019 16:21:12 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5555060126;
        Wed, 23 Oct 2019 16:21:06 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
From:   Waiman Long <longman@redhat.com>
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
 <27e2a26d-8c9b-fdb9-782f-8efa678352b3@redhat.com>
Organization: Red Hat
Message-ID: <015ef5b2-7e11-02a5-6cf3-2e45f6657910@redhat.com>
Date:   Wed, 23 Oct 2019 12:21:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <27e2a26d-8c9b-fdb9-782f-8efa678352b3@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FsNnKaJeOJa4ZPGFg-Gqxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 12:17 PM, Waiman Long wrote:
> On 10/23/19 12:10 PM, Michal Hocko wrote:
>> On Wed 23-10-19 10:56:30, Waiman Long wrote:
>>> On 10/23/19 6:27 AM, Michal Hocko wrote:
>>>> From: Michal Hocko <mhocko@suse.com>
>>>>
>>>> pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
>>>> This is not really nice because it blocks both any interrupts on that
>>>> cpu and the page allocator. On large machines this might even trigger
>>>> the hard lockup detector.
>>>>
>>>> Considering the pagetypeinfo is a debugging tool we do not really need
>>>> exact numbers here. The primary reason to look at the outuput is to se=
e
>>>> how pageblocks are spread among different migratetypes therefore putti=
ng
>>>> a bound on the number of pages on the free_list sounds like a reasonab=
le
>>>> tradeoff.
>>>>
>>>> The new output will simply tell
>>>> [...]
>>>> Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >1=
00000  41019  31560  23996  10054   3229    983    648
>>>>
>>>> instead of
>>>> Node    6, zone   Normal, type      Movable 399568 294127 221558 10211=
9  41019  31560  23996  10054   3229    983    648
>>>>
>>>> The limit has been chosen arbitrary and it is a subject of a future
>>>> change should there be a need for that.
>>>>
>>>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>>>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>>>> ---
>>>>  mm/vmstat.c | 19 ++++++++++++++++++-
>>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>>> index 4e885ecd44d1..762034fc3b83 100644
>>>> --- a/mm/vmstat.c
>>>> +++ b/mm/vmstat.c
>>>> @@ -1386,8 +1386,25 @@ static void pagetypeinfo_showfree_print(struct =
seq_file *m,
>>>> =20
>>>>  =09=09=09area =3D &(zone->free_area[order]);
>>>> =20
>>>> -=09=09=09list_for_each(curr, &area->free_list[mtype])
>>>> +=09=09=09list_for_each(curr, &area->free_list[mtype]) {
>>>>  =09=09=09=09freecount++;
>>>> +=09=09=09=09/*
>>>> +=09=09=09=09 * Cap the free_list iteration because it might
>>>> +=09=09=09=09 * be really large and we are under a spinlock
>>>> +=09=09=09=09 * so a long time spent here could trigger a
>>>> +=09=09=09=09 * hard lockup detector. Anyway this is a
>>>> +=09=09=09=09 * debugging tool so knowing there is a handful
>>>> +=09=09=09=09 * of pages in this order should be more than
>>>> +=09=09=09=09 * sufficient
>>>> +=09=09=09=09 */
>>>> +=09=09=09=09if (freecount > 100000) {
>>>> +=09=09=09=09=09seq_printf(m, ">%6lu ", freecount);
>>>> +=09=09=09=09=09spin_unlock_irq(&zone->lock);
>>>> +=09=09=09=09=09cond_resched();
>>>> +=09=09=09=09=09spin_lock_irq(&zone->lock);
>>>> +=09=09=09=09=09continue;
>>> list_for_each() is a for loop. The continue statement will just iterate
>>> the rests with the possibility that curr will be stale. Should we use
>>> goto to jump after the seq_print() below?
>> You are right. Kinda brown paper back material. Sorry about that. What
>> about this on top?
>> ---=20
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 762034fc3b83..c156ce24a322 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1383,11 +1383,11 @@ static void pagetypeinfo_showfree_print(struct s=
eq_file *m,
>>  =09=09=09unsigned long freecount =3D 0;
>>  =09=09=09struct free_area *area;
>>  =09=09=09struct list_head *curr;
>> +=09=09=09bool overflow =3D false;
>> =20
>>  =09=09=09area =3D &(zone->free_area[order]);
>> =20
>>  =09=09=09list_for_each(curr, &area->free_list[mtype]) {
>> -=09=09=09=09freecount++;
>>  =09=09=09=09/*
>>  =09=09=09=09 * Cap the free_list iteration because it might
>>  =09=09=09=09 * be really large and we are under a spinlock
>> @@ -1397,15 +1397,15 @@ static void pagetypeinfo_showfree_print(struct s=
eq_file *m,
>>  =09=09=09=09 * of pages in this order should be more than
>>  =09=09=09=09 * sufficient
>>  =09=09=09=09 */
>> -=09=09=09=09if (freecount > 100000) {
>> -=09=09=09=09=09seq_printf(m, ">%6lu ", freecount);
>> +=09=09=09=09if (++freecount >=3D 100000) {
>> +=09=09=09=09=09overflow =3D true;
>>  =09=09=09=09=09spin_unlock_irq(&zone->lock);
>>  =09=09=09=09=09cond_resched();
>>  =09=09=09=09=09spin_lock_irq(&zone->lock);
>> -=09=09=09=09=09continue;
>> +=09=09=09=09=09break;
>>  =09=09=09=09}
>>  =09=09=09}
>> -=09=09=09seq_printf(m, "%6lu ", freecount);
>> +=09=09=09seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
>>  =09=09}
>>  =09=09seq_putc(m, '\n');
>>  =09}
>>
> Yes, that looks good to me. There is still a small chance that the
> description will be a bit off if it is exactly 100,000. However, it is
> not a big deal and I can live with that.

Alternatively, you can do

if (++freecount > 100000) {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 :
=C2=A0=C2=A0=C2=A0 freecount--;
=C2=A0=C2=A0=C2=A0 break;
}

Cheers,
Longman

