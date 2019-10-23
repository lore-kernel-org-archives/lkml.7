Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD18CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CA920640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571837846;
	bh=hDMyjlrpKjkucux9xQPGLNbcZu8m4xAJC3hW0CQY8DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bFaHhdJJpAH+unexklGSuRmA41BQFgiEFoI/WQAgOD6pPlJkwylJvsXWzUrUrlv5N
	 +kG/lEjLlEqXx4Z8WV9l0Zg1RPI5PJZjfLJckuyTjHqW1NqOG2sVzB5XdWuiMaDwD1
	 379pwO0k3alTBQowqW+vkbNKnrpFXxCO8FvqgmHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392054AbfJWNhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:37:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390204AbfJWNhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:37:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84699B59E;
        Wed, 23 Oct 2019 13:37:22 +0000 (UTC)
Date:   Wed, 23 Oct 2019 15:37:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-ID: <20191023133720.GA17610@dhcp22.suse.cz>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-3-mhocko@kernel.org>
 <30211965-8ad0-416d-0fe1-113270bd1ea8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30211965-8ad0-416d-0fe1-113270bd1ea8@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 15:32:05, Vlastimil Babka wrote:
> On 10/23/19 12:27 PM, Michal Hocko wrote:
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
> 
> Hmm dunno, I would rather e.g. hide the file behind some config or boot
> option than do this. Or move it to /sys/kernel/debug ?

But those wouldn't really help to prevent from the lockup, right?
Besides that who would enable that config and how much of a difference
would root only vs. debugfs make?

Is the incomplete value a real problem?

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
> > +				}
> > +			}
> >  			seq_printf(m, "%6lu ", freecount);
> >  		}
> >  		seq_putc(m, '\n');
> > 

-- 
Michal Hocko
SUSE Labs
