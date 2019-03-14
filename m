Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF28FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EDF2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCNAac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 20:30:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfCNAab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 20:30:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90D0030922E8;
        Thu, 14 Mar 2019 00:30:31 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2FD217CED;
        Thu, 14 Mar 2019 00:30:28 +0000 (UTC)
Date:   Wed, 13 Mar 2019 20:30:28 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Cc:     hch@infradead.org, agk@redhat.com, dm-devel@redhat.com,
        mpatocka@redhat.com, iliastsi@arrikto.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind helpers
Message-ID: <20190314003027.GE4202@redhat.com>
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com>
 <20190313234853.GA7797@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313234853.GA7797@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 14 Mar 2019 00:30:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13 2019 at  7:48pm -0400,
Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
> > On Thu, Dec 20 2018 at  1:06pm -0500,
> > Nikos Tsironis <ntsironis@arrikto.com> wrote:
> > 
> > > Add hlist_bl_add_before/behind helpers to add an element before/after an
> > > existing element in a bl_list.
> > > 
> > > Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
> > > Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
> > > ---
> > >  include/linux/list_bl.h | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> > > index 3fc2cc57ba1b..2fd918e5fd48 100644
> > > --- a/include/linux/list_bl.h
> > > +++ b/include/linux/list_bl.h
> > > @@ -86,6 +86,33 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
> > >  	hlist_bl_set_first(h, n);
> > >  }
> > >  
> > > +static inline void hlist_bl_add_before(struct hlist_bl_node *n,
> > > +				       struct hlist_bl_node *next)
> > > +{
> > > +	struct hlist_bl_node **pprev = next->pprev;
> > > +
> > > +	n->pprev = pprev;
> > > +	n->next = next;
> > > +	next->pprev = &n->next;
> > > +
> > > +	/* pprev may be `first`, so be careful not to lose the lock bit */
> > > +	WRITE_ONCE(*pprev,
> > > +		   (struct hlist_bl_node *)
> > > +			((unsigned long)n |
> > > +			 ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
> 
> A nit, but use of uintptr_t shrinks things a bit:
> 
> +		   (struct hlist_bl_node *)
> +			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
> 
> I am not too concerned about this, though.

I'm fine with folding in your suggestion.

> The WRITE_ONCE() is to handle races with hlist_bl_empty() (which does contain
> the corresponding READ_ONCE()) correct?

Correct.

> > > +}
> > > +
> > > +static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
> > > +				       struct hlist_bl_node *prev)
> > > +{
> > > +	n->next = prev->next;
> > > +	n->pprev = &prev->next;
> > > +	WRITE_ONCE(prev->next, n);
> 
> I don't see what this WRITE_ONCE() is interacting with.  The traversals
> use plain C-language reads, and hlist_bl_empty() can't get here.  All
> uses of hlist_bl_for_each_entry() invoke hlist_bl_lock() before starting
> the traversal, and hlist_bl_for_each_entry_safe() looks to be unused.
> (Perhaps it should be removed?  Or is there some anticipated use?)
> 
> I don't believe that the WRITE_ONCE() is needed.  What am I missing?
> 
> Other than that, looks good.
> 
> 							Thanx, Paul
> 

I'd imagine it was just born out of symmetry with hlist_bl_add_before()
and/or caution.  But let's see what Nikos has to say.

Thanks,
Mike
