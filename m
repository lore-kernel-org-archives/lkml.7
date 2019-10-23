Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333F1C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07008205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571847035;
	bh=ueMGX3zUjSmWxI3rEGuXDUt3LEls0hEweJa1cUzWht4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZVXmabWbD/EQtSeIrbnygT1px6bghcdfqnYvjBUGeEj6choxr3YYTCL2L27HeJOdx
	 DBpBy5PilS018SReP05WtZlqiDTtDDlaDd/OXsoYauqLpIZiyHfiHbWiWdWnEeYoIZ
	 ccby0UmuPx1GjAoNMe1c8tbLT4I2UaxtIh+rxJDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407058AbfJWQKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:10:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:37366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404582AbfJWQKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:10:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F75BB1C1;
        Wed, 23 Oct 2019 16:10:31 +0000 (UTC)
Date:   Wed, 23 Oct 2019 18:10:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-ID: <20191023161029.GK17610@dhcp22.suse.cz>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-3-mhocko@kernel.org>
 <a3510617-fd23-9f90-3c40-700bcb0f353c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3510617-fd23-9f90-3c40-700bcb0f353c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 10:56:30, Waiman Long wrote:
> On 10/23/19 6:27 AM, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> >
> > pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
> > This is not really nice because it blocks both any interrupts on that
> > cpu and the page allocator. On large machines this might even trigger
> > the hard lockup detector.
> >
> > Considering the pagetypeinfo is a debugging tool we do not really need
> > exact numbers here. The primary reason to look at the outuput is to see
> > how pageblocks are spread among different migratetypes therefore putting
> > a bound on the number of pages on the free_list sounds like a reasonable
> > tradeoff.
> >
> > The new output will simply tell
> > [...]
> > Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648
> >
> > instead of
> > Node    6, zone   Normal, type      Movable 399568 294127 221558 102119  41019  31560  23996  10054   3229    983    648
> >
> > The limit has been chosen arbitrary and it is a subject of a future
> > change should there be a need for that.
> >
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/vmstat.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 4e885ecd44d1..762034fc3b83 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1386,8 +1386,25 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
> >  
> >  			area = &(zone->free_area[order]);
> >  
> > -			list_for_each(curr, &area->free_list[mtype])
> > +			list_for_each(curr, &area->free_list[mtype]) {
> >  				freecount++;
> > +				/*
> > +				 * Cap the free_list iteration because it might
> > +				 * be really large and we are under a spinlock
> > +				 * so a long time spent here could trigger a
> > +				 * hard lockup detector. Anyway this is a
> > +				 * debugging tool so knowing there is a handful
> > +				 * of pages in this order should be more than
> > +				 * sufficient
> > +				 */
> > +				if (freecount > 100000) {
> > +					seq_printf(m, ">%6lu ", freecount);
> > +					spin_unlock_irq(&zone->lock);
> > +					cond_resched();
> > +					spin_lock_irq(&zone->lock);
> > +					continue;
> list_for_each() is a for loop. The continue statement will just iterate
> the rests with the possibility that curr will be stale. Should we use
> goto to jump after the seq_print() below?

You are right. Kinda brown paper back material. Sorry about that. What
about this on top?
--- 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 762034fc3b83..c156ce24a322 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1383,11 +1383,11 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 			unsigned long freecount = 0;
 			struct free_area *area;
 			struct list_head *curr;
+			bool overflow = false;
 
 			area = &(zone->free_area[order]);
 
 			list_for_each(curr, &area->free_list[mtype]) {
-				freecount++;
 				/*
 				 * Cap the free_list iteration because it might
 				 * be really large and we are under a spinlock
@@ -1397,15 +1397,15 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 				 * of pages in this order should be more than
 				 * sufficient
 				 */
-				if (freecount > 100000) {
-					seq_printf(m, ">%6lu ", freecount);
+				if (++freecount >= 100000) {
+					overflow = true;
 					spin_unlock_irq(&zone->lock);
 					cond_resched();
 					spin_lock_irq(&zone->lock);
-					continue;
+					break;
 				}
 			}
-			seq_printf(m, "%6lu ", freecount);
+			seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
 		}
 		seq_putc(m, '\n');
 	}

-- 
Michal Hocko
SUSE Labs
