Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB31C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D63218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfB1Vew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:34:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbfB1Vew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:34:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C4E33145730;
        Thu, 28 Feb 2019 21:34:52 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A23D75DD74;
        Thu, 28 Feb 2019 21:34:49 +0000 (UTC)
Date:   Thu, 28 Feb 2019 16:34:48 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, hch@infradead.org,
        Nikos Tsironis <ntsironis@arrikto.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, mpatocka@redhat.com,
        iliastsi@arrikto.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind helpers
Message-ID: <20190228213448.GG23527@redhat.com>
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228213201.GB23527@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 28 Feb 2019 21:34:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28 2019 at  4:32pm -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, Dec 20 2018 at  1:06pm -0500,
> Nikos Tsironis <ntsironis@arrikto.com> wrote:
> 
> > Add hlist_bl_add_before/behind helpers to add an element before/after an
> > existing element in a bl_list.
> > 
> > Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
> > Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
> > ---
> >  include/linux/list_bl.h | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> > index 3fc2cc57ba1b..2fd918e5fd48 100644
> > --- a/include/linux/list_bl.h
> > +++ b/include/linux/list_bl.h
> > @@ -86,6 +86,33 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
> >  	hlist_bl_set_first(h, n);
> >  }
> >  
> > +static inline void hlist_bl_add_before(struct hlist_bl_node *n,
> > +				       struct hlist_bl_node *next)
> > +{
> > +	struct hlist_bl_node **pprev = next->pprev;
> > +
> > +	n->pprev = pprev;
> > +	n->next = next;
> > +	next->pprev = &n->next;
> > +
> > +	/* pprev may be `first`, so be careful not to lose the lock bit */
> > +	WRITE_ONCE(*pprev,
> > +		   (struct hlist_bl_node *)
> > +			((unsigned long)n |
> > +			 ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
> > +}
> > +
> > +static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
> > +				       struct hlist_bl_node *prev)
> > +{
> > +	n->next = prev->next;
> > +	n->pprev = &prev->next;
> > +	WRITE_ONCE(prev->next, n);
> > +
> > +	if (n->next)
> > +		n->next->pprev = &n->next;
> > +}
> > +
> >  static inline void __hlist_bl_del(struct hlist_bl_node *n)
> >  {
> >  	struct hlist_bl_node *next = n->next;
> > -- 
> > 2.11.0
> 
> Hi Paul and Christoph,
> 
> You've added your Signed-off-by to include/linux/list_bl.h commits in
> the past.  I'm not sure how this proposed patch should be handled.
> 
> These new hlist_bl_add_{before,behind} changes are a prereq for
> dm-snapshot changes that Nikos has proposed, please see:
> https://patchwork.kernel.org/patch/10739265/
> 
> Any assistance/review you, or others on LKML, might be able to provide
> would be appreciated.

I should've clarified that: I'm asking for the purpose of getting these
changes staged for Linux 5.2.

Mike
