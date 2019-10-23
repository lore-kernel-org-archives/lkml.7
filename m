Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234A0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27A421906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPrLsCcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406662AbfJWPYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:24:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24573 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390590AbfJWPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571844248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jlAqwY1DoUj3l8xIvGXzOfATYX2z8pPp+glzgICdTM=;
        b=EPrLsCcvPBxIpOAqzGSxYKS5O2T71Iu+VU5VTqBIg0B6CQ3Bpny/x6DYvk8pzLrQ8cP//f
        rYpd+VVq9H/cpBauji5Ay8Vqn1HG9ilPsXJjOvykNIpAcXavYOIco9RKo/BBiyv+Yeq3Us
        QhlBb0EGf8hM89X5EqJNk8KgieULDW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338--kW7jU84OTaOu23gY0sHaQ-1; Wed, 23 Oct 2019 11:23:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2A54100551D;
        Wed, 23 Oct 2019 15:03:39 +0000 (UTC)
Received: from optiplex-lnx (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B9D5DD78;
        Wed, 23 Oct 2019 15:03:21 +0000 (UTC)
Date:   Wed, 23 Oct 2019 11:03:19 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
Message-ID: <20191023150319.GD22601@optiplex-lnx>
References: <20191022162156.17316-1-longman@redhat.com>
 <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
 <2236495a-ead0-e08e-3fb6-f3ab906b75b6@redhat.com>
 <1571842093.5937.84.camel@lca.pw>
MIME-Version: 1.0
In-Reply-To: <1571842093.5937.84.camel@lca.pw>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -kW7jU84OTaOu23gY0sHaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 10:48:13AM -0400, Qian Cai wrote:
> On Wed, 2019-10-23 at 10:30 -0400, Waiman Long wrote:
> > On 10/22/19 5:59 PM, Andrew Morton wrote:
> > > On Tue, 22 Oct 2019 12:21:56 -0400 Waiman Long <longman@redhat.com> w=
rote:
> > >=20
> > > > The pagetypeinfo_showfree_print() function prints out the number of
> > > > free blocks for each of the page orders and migrate types. The curr=
ent
> > > > code just iterates the each of the free lists to get counts.  There=
 are
> > > > bug reports about hard lockup panics when reading the /proc/pagetye=
info
> > > > file just because it look too long to iterate all the free lists wi=
thin
> > > > a zone while holing the zone lock with irq disabled.
> > > >=20
> > > > Given the fact that /proc/pagetypeinfo is readable by all, the poss=
iblity
> > > > of crashing a system by the simple act of reading /proc/pagetypeinf=
o
> > > > by any user is a security problem that needs to be addressed.
> > >=20
> > > Yes.
> > >=20
> > > > There is a free_area structure associated with each page order. The=
re
> > > > is also a nr_free count within the free_area for all the different
> > > > migration types combined. Tracking the number of free list entries
> > > > for each migration type will probably add some overhead to the fast
> > > > paths like moving pages from one migration type to another which ma=
y
> > > > not be desirable.
> > > >=20
> > > > we can actually skip iterating the list of one of the migration typ=
es
> > > > and used nr_free to compute the missing count. Since MIGRATE_MOVABL=
E
> > > > is usually the largest one on large memory systems, this is the one
> > > > to be skipped. Since the printing order is migration-type =3D> orde=
r, we
> > > > will have to store the counts in an internal 2D array before printi=
ng
> > > > them out.
> > > >=20
> > > > Even by skipping the MIGRATE_MOVABLE pages, we may still be holding=
 the
> > > > zone lock for too long blocking out other zone lock waiters from be=
ing
> > > > run. This can be problematic for systems with large amount of memor=
y.
> > > > So a check is added to temporarily release the lock and reschedule =
if
> > > > more than 64k of list entries have been iterated for each order. Wi=
th
> > > > a MAX_ORDER of 11, the worst case will be iterating about 700k of l=
ist
> > > > entries before releasing the lock.
> > > >=20
> > > > ...
> > > >=20
> > > > --- a/mm/vmstat.c
> > > > +++ b/mm/vmstat.c
> > > > @@ -1373,23 +1373,54 @@ static void pagetypeinfo_showfree_print(str=
uct seq_file *m,
> > > >  =09=09=09=09=09pg_data_t *pgdat, struct zone *zone)
> > > >  {
> > > >  =09int order, mtype;
> > > > +=09unsigned long nfree[MAX_ORDER][MIGRATE_TYPES];
> > >=20
> > > 600+ bytes is a bit much.  I guess it's OK in this situation.
> > >=20
> >=20
> > This function is called by reading /proc/pagetypeinfo. The call stack i=
s
> > rather shallow:
> >=20
> > PID: 58188=A0 TASK: ffff938a4d4f1fa0=A0 CPU: 2=A0=A0 COMMAND: "sosrepor=
t"
> > =A0#0 [ffff9483bf488e48] crash_nmi_callback at ffffffffb8c551d7
> > =A0#1 [ffff9483bf488e58] nmi_handle at ffffffffb931d8cc
> > =A0#2 [ffff9483bf488eb0] do_nmi at ffffffffb931dba8
> > =A0#3 [ffff9483bf488ef0] end_repeat_nmi at ffffffffb931cd69
> > =A0=A0=A0 [exception RIP: pagetypeinfo_showfree_print+0x73]
> > =A0=A0=A0 RIP: ffffffffb8db7173=A0 RSP: ffff938b9fcbfda0=A0 RFLAGS: 000=
00006
> > =A0=A0=A0 RAX: fffff0c9946d7020=A0 RBX: ffff96073ffd5528=A0 RCX: 000000=
0000000000
> > =A0=A0=A0 RDX: 00000000001c7764=A0 RSI: ffffffffb9676ab1=A0 RDI: 000000=
0000000000
> > =A0=A0=A0 RBP: ffff938b9fcbfdd0=A0=A0 R8: 000000000000000a=A0=A0 R9: 00=
000000fffffffe
> > =A0=A0=A0 R10: 0000000000000000=A0 R11: ffff938b9fcbfc36=A0 R12: ffff94=
2b97758240
> > =A0=A0=A0 R13: ffffffffb942f730=A0 R14: ffff96073ffd5000=A0 R15: ffff96=
073ffd5180
> > =A0=A0=A0 ORIG_RAX: ffffffffffffffff=A0 CS: 0010=A0 SS: 0018
> > --- <NMI exception stack> ---
> > =A0#4 [ffff938b9fcbfda0] pagetypeinfo_showfree_print at ffffffffb8db717=
3
> > =A0#5 [ffff938b9fcbfdd8] walk_zones_in_node at ffffffffb8db74df
> > =A0#6 [ffff938b9fcbfe20] pagetypeinfo_show at ffffffffb8db7a29
> > =A0#7 [ffff938b9fcbfe48] seq_read at ffffffffb8e45c3c
> > =A0#8 [ffff938b9fcbfeb8] proc_reg_read at ffffffffb8e95070
> > =A0#9 [ffff938b9fcbfed8] vfs_read at ffffffffb8e1f2af
> > #10 [ffff938b9fcbff08] sys_read at ffffffffb8e2017f
> > #11 [ffff938b9fcbff50] system_call_fastpath at ffffffffb932579b
> >=20
> > So we should not be in any risk of overflowing the stack.
> >=20
> > > > -=09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
> > > > -=09=09seq_printf(m, "Node %4d, zone %8s, type %12s ",
> > > > -=09=09=09=09=09pgdat->node_id,
> > > > -=09=09=09=09=09zone->name,
> > > > -=09=09=09=09=09migratetype_names[mtype]);
> > > > -=09=09for (order =3D 0; order < MAX_ORDER; ++order) {
> > > > +=09lockdep_assert_held(&zone->lock);
> > > > +=09lockdep_assert_irqs_disabled();
> > > > +
> > > > +=09/*
> > > > +=09 * MIGRATE_MOVABLE is usually the largest one in large memory
> > > > +=09 * systems. We skip iterating that list. Instead, we compute it=
 by
> > > > +=09 * subtracting the total of the rests from free_area->nr_free.
> > > > +=09 */
> > > > +=09for (order =3D 0; order < MAX_ORDER; ++order) {
> > > > +=09=09unsigned long nr_total =3D 0;
> > > > +=09=09struct free_area *area =3D &(zone->free_area[order]);
> > > > +
> > > > +=09=09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
> > > >  =09=09=09unsigned long freecount =3D 0;
> > > > -=09=09=09struct free_area *area;
> > > >  =09=09=09struct list_head *curr;
> > > > =20
> > > > -=09=09=09area =3D &(zone->free_area[order]);
> > > > -
> > > > +=09=09=09if (mtype =3D=3D MIGRATE_MOVABLE)
> > > > +=09=09=09=09continue;
> > > >  =09=09=09list_for_each(curr, &area->free_list[mtype])
> > > >  =09=09=09=09freecount++;
> > > > -=09=09=09seq_printf(m, "%6lu ", freecount);
> > > > +=09=09=09nfree[order][mtype] =3D freecount;
> > > > +=09=09=09nr_total +=3D freecount;
> > > >  =09=09}
> > > > +=09=09nfree[order][MIGRATE_MOVABLE] =3D area->nr_free - nr_total;
> > > > +
> > > > +=09=09/*
> > > > +=09=09 * If we have already iterated more than 64k of list
> > > > +=09=09 * entries, we might have hold the zone lock for too long.
> > > > +=09=09 * Temporarily release the lock and reschedule before
> > > > +=09=09 * continuing so that other lock waiters have a chance
> > > > +=09=09 * to run.
> > > > +=09=09 */
> > > > +=09=09if (nr_total > (1 << 16)) {
> > > > +=09=09=09spin_unlock_irq(&zone->lock);
> > > > +=09=09=09cond_resched();
> > > > +=09=09=09spin_lock_irq(&zone->lock);
> > > > +=09=09}
> > > > +=09}
> > > > +
> > > > +=09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
> > > > +=09=09seq_printf(m, "Node %4d, zone %8s, type %12s ",
> > > > +=09=09=09=09=09pgdat->node_id,
> > > > +=09=09=09=09=09zone->name,
> > > > +=09=09=09=09=09migratetype_names[mtype]);
> > > > +=09=09for (order =3D 0; order < MAX_ORDER; ++order)
> > > > +=09=09=09seq_printf(m, "%6lu ", nfree[order][mtype]);
> > > >  =09=09seq_putc(m, '\n');
> > >=20
> > > This is not exactly a thing of beauty :( Presumably there might still
> > > be situations where the irq-off times remain excessive.
> >=20
> > Yes, that is still possible.
> > >=20
> > > Why are we actually holding zone->lock so much?  Can we get away with
> > > holding it across the list_for_each() loop and nothing else?  If so,
> >=20
> > We can certainly do that with the risk that the counts will be less
> > reliable for a given order. I can send a v2 patch if you think this is
> > safer.
> >=20
> >=20
> > > this still isn't a bulletproof fix.  Maybe just terminate the list
> > > walk if freecount reaches 1024.  Would anyone really care?
> > >=20
> > > Sigh.  I wonder if anyone really uses this thing for anything
> > > important.  Can we just remove it all?
> > >=20
> >=20
> > Removing it will be a breakage of kernel API.
>=20
> Who cares about breaking this part of the API that essentially nobody wil=
l use
> this file?
>

Seems that _some_ are using it, aren't they? Otherwise we wouldn't be
seeing complaints. Moving it out of /proc to /sys/kernel/debug looks=20
like a reasonable compromise with those that care about the interface.

