Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796F0CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7BC21925
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6XOxHcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406625AbfJWPVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:21:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406602AbfJWPVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571844068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93aeFP5T+vRMcJvg4/fDd9Eq3JQGr3j/oyGTUsAl3c8=;
        b=X6XOxHcsPUVkExbGbppmroJ8efNJVeE0cdUS9YOlHlJu/G8iKuYc05J+kYS4KVQE/mzqq8
        r/wPdp+YrIFs+u1kLr3mEgEgWqIr2z+MWEKs06KbLOZdc7fxLpdbGV+P1ahgkkRNsnXEYS
        IDYtdBLh7nt8KFLPx56l4PGGssBVOqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-3MTVpcEMNnCZYTLXuZa83Q-1; Wed, 23 Oct 2019 11:21:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB7A1107AFA9;
        Wed, 23 Oct 2019 15:21:02 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3036A1001B20;
        Wed, 23 Oct 2019 15:21:01 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
From:   Waiman Long <longman@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-3-mhocko@kernel.org>
 <a3510617-fd23-9f90-3c40-700bcb0f353c@redhat.com>
Organization: Red Hat
Message-ID: <c5d19ad0-db65-e592-490a-3ba73f81296b@redhat.com>
Date:   Wed, 23 Oct 2019 11:21:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a3510617-fd23-9f90-3c40-700bcb0f353c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3MTVpcEMNnCZYTLXuZa83Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 10:56 AM, Waiman Long wrote:
> On 10/23/19 6:27 AM, Michal Hocko wrote:
>> From: Michal Hocko <mhocko@suse.com>
>>
>> pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
>> This is not really nice because it blocks both any interrupts on that
>> cpu and the page allocator. On large machines this might even trigger
>> the hard lockup detector.
>>
>> Considering the pagetypeinfo is a debugging tool we do not really need
>> exact numbers here. The primary reason to look at the outuput is to see
>> how pageblocks are spread among different migratetypes therefore putting
>> a bound on the number of pages on the free_list sounds like a reasonable
>> tradeoff.
>>
>> The new output will simply tell
>> [...]
>> Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100=
000  41019  31560  23996  10054   3229    983    648
>>
>> instead of
>> Node    6, zone   Normal, type      Movable 399568 294127 221558 102119 =
 41019  31560  23996  10054   3229    983    648
>>
>> The limit has been chosen arbitrary and it is a subject of a future
>> change should there be a need for that.
>>
>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>> ---
>>  mm/vmstat.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 4e885ecd44d1..762034fc3b83 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1386,8 +1386,25 @@ static void pagetypeinfo_showfree_print(struct se=
q_file *m,
>> =20
>>  =09=09=09area =3D &(zone->free_area[order]);
>> =20
>> -=09=09=09list_for_each(curr, &area->free_list[mtype])
>> +=09=09=09list_for_each(curr, &area->free_list[mtype]) {
>>  =09=09=09=09freecount++;
>> +=09=09=09=09/*
>> +=09=09=09=09 * Cap the free_list iteration because it might
>> +=09=09=09=09 * be really large and we are under a spinlock
>> +=09=09=09=09 * so a long time spent here could trigger a
>> +=09=09=09=09 * hard lockup detector. Anyway this is a
>> +=09=09=09=09 * debugging tool so knowing there is a handful
>> +=09=09=09=09 * of pages in this order should be more than
>> +=09=09=09=09 * sufficient
>> +=09=09=09=09 */
>> +=09=09=09=09if (freecount > 100000) {
>> +=09=09=09=09=09seq_printf(m, ">%6lu ", freecount);

It will print ">100001" which seems a bit awk and will be incorrect if
it is exactly 100001. Could you just hardcode ">100000" into seq_printf()?

Cheers,
Longman


