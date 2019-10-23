Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2100CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AD32173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRUBgccV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406105AbfJWNqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:46:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42714 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729191AbfJWNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571838396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=580cpyTZn31Tsw5lMtWLo7PXKcx4eNMbv5larOIYwnY=;
        b=dRUBgccVcuJCmFQ8WF4IqNlYta0SpjjDTABJu3i4ug77Iux62v8IKs5wQX2FQJh7lWMHSv
        cigKnyS2jdzVDVLkWFPGc3MB2SYiNYVCk6zOjI4G1xs8+Oyr+1xzl9IiX/Y18A92zyaDYN
        sa9AcneI/MI8Aaspm13rI05Z/tEVUJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-HjTE_xT0PXuakUoiGj67-g-1; Wed, 23 Oct 2019 09:46:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DF81800D49;
        Wed, 23 Oct 2019 13:46:32 +0000 (UTC)
Received: from optiplex-lnx (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 245C319C77;
        Wed, 23 Oct 2019 13:46:24 +0000 (UTC)
Date:   Wed, 23 Oct 2019 09:46:22 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-ID: <20191023134622.GA22601@optiplex-lnx>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-3-mhocko@kernel.org>
 <30211965-8ad0-416d-0fe1-113270bd1ea8@suse.cz>
MIME-Version: 1.0
In-Reply-To: <30211965-8ad0-416d-0fe1-113270bd1ea8@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HjTE_xT0PXuakUoiGj67-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:32:05PM +0200, Vlastimil Babka wrote:
> On 10/23/19 12:27 PM, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> >=20
> > pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
> > This is not really nice because it blocks both any interrupts on that
> > cpu and the page allocator. On large machines this might even trigger
> > the hard lockup detector.
> >=20
> > Considering the pagetypeinfo is a debugging tool we do not really need
> > exact numbers here. The primary reason to look at the outuput is to see
> > how pageblocks are spread among different migratetypes therefore puttin=
g
> > a bound on the number of pages on the free_list sounds like a reasonabl=
e
> > tradeoff.
> >=20
> > The new output will simply tell
> > [...]
> > Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >10=
0000  41019  31560  23996  10054   3229    983    648
> >=20
> > instead of
> > Node    6, zone   Normal, type      Movable 399568 294127 221558 102119=
  41019  31560  23996  10054   3229    983    648
> >=20
> > The limit has been chosen arbitrary and it is a subject of a future
> > change should there be a need for that.
> >=20
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
>=20
> Hmm dunno, I would rather e.g. hide the file behind some config or boot
> option than do this. Or move it to /sys/kernel/debug ?
>

You beat me to it. I was going to suggest moving it to debug, as well.


=20
> > ---
> >  mm/vmstat.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 4e885ecd44d1..762034fc3b83 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1386,8 +1386,25 @@ static void pagetypeinfo_showfree_print(struct s=
eq_file *m,
> > =20
> >  =09=09=09area =3D &(zone->free_area[order]);
> > =20
> > -=09=09=09list_for_each(curr, &area->free_list[mtype])
> > +=09=09=09list_for_each(curr, &area->free_list[mtype]) {
> >  =09=09=09=09freecount++;
> > +=09=09=09=09/*
> > +=09=09=09=09 * Cap the free_list iteration because it might
> > +=09=09=09=09 * be really large and we are under a spinlock
> > +=09=09=09=09 * so a long time spent here could trigger a
> > +=09=09=09=09 * hard lockup detector. Anyway this is a
> > +=09=09=09=09 * debugging tool so knowing there is a handful
> > +=09=09=09=09 * of pages in this order should be more than
> > +=09=09=09=09 * sufficient
> > +=09=09=09=09 */
> > +=09=09=09=09if (freecount > 100000) {
> > +=09=09=09=09=09seq_printf(m, ">%6lu ", freecount);
> > +=09=09=09=09=09spin_unlock_irq(&zone->lock);
> > +=09=09=09=09=09cond_resched();
> > +=09=09=09=09=09spin_lock_irq(&zone->lock);
> > +=09=09=09=09=09continue;
> > +=09=09=09=09}
> > +=09=09=09}
> >  =09=09=09seq_printf(m, "%6lu ", freecount);
> >  =09=09}
> >  =09=09seq_putc(m, '\n');
> >=20
>=20

