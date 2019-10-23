Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B6FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7EA2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hW8rjnMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406115AbfJWOan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:30:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24168 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403845AbfJWOan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571841041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJHao8kPiRsd3Mtcj407xdZ7Kz+GOgkvEb6Cy2YqoVQ=;
        b=hW8rjnMHxXLjHnQ6xB9CHhmKiV+ROwhwfNNXGS3aNtdWrFwC6Km9Y6pJ+3sFLftW7nHEeZ
        sGlmbra2ZO+RYuJimSOQpKoVx2lAByVb0PIUO+ujHS/Mvwjw7r88f/NoWNxIEaJwMbbTqV
        mx3G2VluPQNIusCHTPO4woqyfkxyWN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-7lIMO7akMiyALgaC7ohTqA-1; Wed, 23 Oct 2019 10:30:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70DEB1800D79;
        Wed, 23 Oct 2019 14:30:36 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A423B1001B07;
        Wed, 23 Oct 2019 14:30:30 +0000 (UTC)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2236495a-ead0-e08e-3fb6-f3ab906b75b6@redhat.com>
Date:   Wed, 23 Oct 2019 10:30:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7lIMO7akMiyALgaC7ohTqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/19 5:59 PM, Andrew Morton wrote:
> On Tue, 22 Oct 2019 12:21:56 -0400 Waiman Long <longman@redhat.com> wrote=
:
>
>> The pagetypeinfo_showfree_print() function prints out the number of
>> free blocks for each of the page orders and migrate types. The current
>> code just iterates the each of the free lists to get counts.  There are
>> bug reports about hard lockup panics when reading the /proc/pagetyeinfo
>> file just because it look too long to iterate all the free lists within
>> a zone while holing the zone lock with irq disabled.
>>
>> Given the fact that /proc/pagetypeinfo is readable by all, the possiblit=
y
>> of crashing a system by the simple act of reading /proc/pagetypeinfo
>> by any user is a security problem that needs to be addressed.
> Yes.
>
>> There is a free_area structure associated with each page order. There
>> is also a nr_free count within the free_area for all the different
>> migration types combined. Tracking the number of free list entries
>> for each migration type will probably add some overhead to the fast
>> paths like moving pages from one migration type to another which may
>> not be desirable.
>>
>> we can actually skip iterating the list of one of the migration types
>> and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
>> is usually the largest one on large memory systems, this is the one
>> to be skipped. Since the printing order is migration-type =3D> order, we
>> will have to store the counts in an internal 2D array before printing
>> them out.
>>
>> Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
>> zone lock for too long blocking out other zone lock waiters from being
>> run. This can be problematic for systems with large amount of memory.
>> So a check is added to temporarily release the lock and reschedule if
>> more than 64k of list entries have been iterated for each order. With
>> a MAX_ORDER of 11, the worst case will be iterating about 700k of list
>> entries before releasing the lock.
>>
>> ...
>>
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1373,23 +1373,54 @@ static void pagetypeinfo_showfree_print(struct s=
eq_file *m,
>>  =09=09=09=09=09pg_data_t *pgdat, struct zone *zone)
>>  {
>>  =09int order, mtype;
>> +=09unsigned long nfree[MAX_ORDER][MIGRATE_TYPES];
> 600+ bytes is a bit much.  I guess it's OK in this situation.
>
This function is called by reading /proc/pagetypeinfo. The call stack is
rather shallow:

PID: 58188=C2=A0 TASK: ffff938a4d4f1fa0=C2=A0 CPU: 2=C2=A0=C2=A0 COMMAND: "=
sosreport"
=C2=A0#0 [ffff9483bf488e48] crash_nmi_callback at ffffffffb8c551d7
=C2=A0#1 [ffff9483bf488e58] nmi_handle at ffffffffb931d8cc
=C2=A0#2 [ffff9483bf488eb0] do_nmi at ffffffffb931dba8
=C2=A0#3 [ffff9483bf488ef0] end_repeat_nmi at ffffffffb931cd69
=C2=A0=C2=A0=C2=A0 [exception RIP: pagetypeinfo_showfree_print+0x73]
=C2=A0=C2=A0=C2=A0 RIP: ffffffffb8db7173=C2=A0 RSP: ffff938b9fcbfda0=C2=A0 =
RFLAGS: 00000006
=C2=A0=C2=A0=C2=A0 RAX: fffff0c9946d7020=C2=A0 RBX: ffff96073ffd5528=C2=A0 =
RCX: 0000000000000000
=C2=A0=C2=A0=C2=A0 RDX: 00000000001c7764=C2=A0 RSI: ffffffffb9676ab1=C2=A0 =
RDI: 0000000000000000
=C2=A0=C2=A0=C2=A0 RBP: ffff938b9fcbfdd0=C2=A0=C2=A0 R8: 000000000000000a=
=C2=A0=C2=A0 R9: 00000000fffffffe
=C2=A0=C2=A0=C2=A0 R10: 0000000000000000=C2=A0 R11: ffff938b9fcbfc36=C2=A0 =
R12: ffff942b97758240
=C2=A0=C2=A0=C2=A0 R13: ffffffffb942f730=C2=A0 R14: ffff96073ffd5000=C2=A0 =
R15: ffff96073ffd5180
=C2=A0=C2=A0=C2=A0 ORIG_RAX: ffffffffffffffff=C2=A0 CS: 0010=C2=A0 SS: 0018
--- <NMI exception stack> ---
=C2=A0#4 [ffff938b9fcbfda0] pagetypeinfo_showfree_print at ffffffffb8db7173
=C2=A0#5 [ffff938b9fcbfdd8] walk_zones_in_node at ffffffffb8db74df
=C2=A0#6 [ffff938b9fcbfe20] pagetypeinfo_show at ffffffffb8db7a29
=C2=A0#7 [ffff938b9fcbfe48] seq_read at ffffffffb8e45c3c
=C2=A0#8 [ffff938b9fcbfeb8] proc_reg_read at ffffffffb8e95070
=C2=A0#9 [ffff938b9fcbfed8] vfs_read at ffffffffb8e1f2af
#10 [ffff938b9fcbff08] sys_read at ffffffffb8e2017f
#11 [ffff938b9fcbff50] system_call_fastpath at ffffffffb932579b

So we should not be in any risk of overflowing the stack.

>> -=09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
>> -=09=09seq_printf(m, "Node %4d, zone %8s, type %12s ",
>> -=09=09=09=09=09pgdat->node_id,
>> -=09=09=09=09=09zone->name,
>> -=09=09=09=09=09migratetype_names[mtype]);
>> -=09=09for (order =3D 0; order < MAX_ORDER; ++order) {
>> +=09lockdep_assert_held(&zone->lock);
>> +=09lockdep_assert_irqs_disabled();
>> +
>> +=09/*
>> +=09 * MIGRATE_MOVABLE is usually the largest one in large memory
>> +=09 * systems. We skip iterating that list. Instead, we compute it by
>> +=09 * subtracting the total of the rests from free_area->nr_free.
>> +=09 */
>> +=09for (order =3D 0; order < MAX_ORDER; ++order) {
>> +=09=09unsigned long nr_total =3D 0;
>> +=09=09struct free_area *area =3D &(zone->free_area[order]);
>> +
>> +=09=09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
>>  =09=09=09unsigned long freecount =3D 0;
>> -=09=09=09struct free_area *area;
>>  =09=09=09struct list_head *curr;
>> =20
>> -=09=09=09area =3D &(zone->free_area[order]);
>> -
>> +=09=09=09if (mtype =3D=3D MIGRATE_MOVABLE)
>> +=09=09=09=09continue;
>>  =09=09=09list_for_each(curr, &area->free_list[mtype])
>>  =09=09=09=09freecount++;
>> -=09=09=09seq_printf(m, "%6lu ", freecount);
>> +=09=09=09nfree[order][mtype] =3D freecount;
>> +=09=09=09nr_total +=3D freecount;
>>  =09=09}
>> +=09=09nfree[order][MIGRATE_MOVABLE] =3D area->nr_free - nr_total;
>> +
>> +=09=09/*
>> +=09=09 * If we have already iterated more than 64k of list
>> +=09=09 * entries, we might have hold the zone lock for too long.
>> +=09=09 * Temporarily release the lock and reschedule before
>> +=09=09 * continuing so that other lock waiters have a chance
>> +=09=09 * to run.
>> +=09=09 */
>> +=09=09if (nr_total > (1 << 16)) {
>> +=09=09=09spin_unlock_irq(&zone->lock);
>> +=09=09=09cond_resched();
>> +=09=09=09spin_lock_irq(&zone->lock);
>> +=09=09}
>> +=09}
>> +
>> +=09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
>> +=09=09seq_printf(m, "Node %4d, zone %8s, type %12s ",
>> +=09=09=09=09=09pgdat->node_id,
>> +=09=09=09=09=09zone->name,
>> +=09=09=09=09=09migratetype_names[mtype]);
>> +=09=09for (order =3D 0; order < MAX_ORDER; ++order)
>> +=09=09=09seq_printf(m, "%6lu ", nfree[order][mtype]);
>>  =09=09seq_putc(m, '\n');
> This is not exactly a thing of beauty :( Presumably there might still
> be situations where the irq-off times remain excessive.
Yes, that is still possible.
>
> Why are we actually holding zone->lock so much?  Can we get away with
> holding it across the list_for_each() loop and nothing else?  If so,

We can certainly do that with the risk that the counts will be less
reliable for a given order. I can send a v2 patch if you think this is
safer.


> this still isn't a bulletproof fix.  Maybe just terminate the list
> walk if freecount reaches 1024.  Would anyone really care?
>
> Sigh.  I wonder if anyone really uses this thing for anything
> important.  Can we just remove it all?
>
Removing it will be a breakage of kernel API.

Another alternative is to mark the migration type in the page structure
so that we can do per-migration type nr_free tracking. That will be a
major change to the mm code.

I consider this patch lesser of the two evils.=C2=A0

Cheers,
Longman

