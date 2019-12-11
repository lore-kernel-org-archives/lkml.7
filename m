Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE0C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F794206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576105962;
	bh=zIr4wfCzPm70JepTVSen7DkYLaPuuCoE5VaW7velGx8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mrB35PVEDIS/RqevQE73p0tlNLNQusUAZB5NQ4DM8AapGbWipQcfLVVStKFzCvdaV
	 Bl6BccOJK3xpeoqpTxmayOMkhklxC4x4aO7j4fdTCU8AzA2CIBZlRuI2O2iX2dObaC
	 i3pphhkJK+atFfk84Bpjt2LQ9RPjCttijNqe/KPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLKXMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:12:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfLKXMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:12:40 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2777206A5;
        Wed, 11 Dec 2019 23:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576105959;
        bh=zIr4wfCzPm70JepTVSen7DkYLaPuuCoE5VaW7velGx8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SIBIGInDZ0NyrWydrX3ejGAnp4hx8EGzVlMsi1eIgzd4UIJXXmwG66cKzFBrGOk8q
         wVntzCym0vtZJO5eQVwqRI5Y+drxHs0QrVOzSxdFg+x6M5gMNLqg1O6GTO/O0t/Lhk
         yMCYMO6TDoltu1BaPvqrXVxZX+XdhH8cSeNsnV9A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 50CB435203C6; Wed, 11 Dec 2019 15:12:39 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:12:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH tip/core/rcu 01/12] rcu: Remove rcu_swap_protected()
Message-ID: <20191211231239.GK2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
 <20191210040741.2943-1-paulmck@kernel.org>
 <yq1a77zmt4a.fsf@oracle.com>
 <20191211035122.GC2889@paulmck-ThinkPad-P72>
 <20191211183738.GA5190@paulmck-ThinkPad-P72>
 <1911b7fa-c8d4-e34b-020d-3346a56f29d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1911b7fa-c8d4-e34b-020d-3346a56f29d6@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 08:09:11PM +0100, Matthias Brugger wrote:
> 
> 
> On 11/12/2019 19:37, Paul E. McKenney wrote:
> > On Tue, Dec 10, 2019 at 07:51:22PM -0800, Paul E. McKenney wrote:
> >> On Tue, Dec 10, 2019 at 10:35:49PM -0500, Martin K. Petersen wrote:
> >>>
> >>> Paul,
> >>>
> >>>> Now that the calls to rcu_swap_protected() have been replaced by
> >>>> rcu_replace_pointer(), this commit removes rcu_swap_protected().
> >>>
> >>> It appears there are two callers remaining in Linus' master. Otherwise
> >>> looks good to me.
> >>
> >> I did queue a fix for one of them, and thank you for calling my
> >> attention to the new one.  This commit should hit -next soon, so
> >> hopefully this will discourage further additions.  ;-)
> >>
> >>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> >>
> >> Thank you!
> > 
> > And here is the patch for the new one.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 10699d92c906707d679e28b099cd798a519b4f51
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Wed Dec 11 10:30:21 2019 -0800
> > 
> >     wireless/mediatek: Replace rcu_swap_protected() with rcu_replace_pointer()
> >     
> >     This commit replaces the use of rcu_swap_protected() with the more
> >     intuitively appealing rcu_replace_pointer() as a step towards removing
> >     rcu_swap_protected().
> >     
> >     Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
> >     Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> >     Reported-by: "Martin K. Petersen" <martin.petersen@oracle.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: Felix Fietkau <nbd@nbd.name>
> >     Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> >     Cc: Ryder Lee <ryder.lee@mediatek.com>
> >     Cc: Roy Luo <royluo@google.com>
> >     Cc: Kalle Valo <kvalo@codeaurora.org>
> >     Cc: "David S. Miller" <davem@davemloft.net>
> >     Cc: Matthias Brugger <matthias.bgg@gmail.com>
> >     Cc: <linux-wireless@vger.kernel.org>
> >     Cc: <netdev@vger.kernel.org>
> >     Cc: <linux-arm-kernel@lists.infradead.org>
> >     Cc: <linux-mediatek@lists.infradead.org>
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> > index 53b5a4b..80986ce 100644
> > --- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
> > +++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> > @@ -281,8 +281,8 @@ void mt76_rx_aggr_stop(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tidno)
> >  {
> >  	struct mt76_rx_tid *tid = NULL;
> >  
> > -	rcu_swap_protected(wcid->aggr[tidno], tid,
> > -			   lockdep_is_held(&dev->mutex));
> > +	tid = rcu_swap_protected(wcid->aggr[tidno], tid,
> > +				 lockdep_is_held(&dev->mutex));
> 
> I suppose you meant: rcu_replace_pointer() here.

Indeed I did, and thank you for catching this!  Bad patch day here.  :-/

Update below...

							Thanx, Paul

------------------------------------------------------------------------

commit ad5572b091429a45e863acaa6a36cf396d44f58d
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Dec 11 10:30:21 2019 -0800

    wireless/mediatek: Replace rcu_swap_protected() with rcu_replace_pointer()
    
    This commit replaces the use of rcu_swap_protected() with the more
    intuitively appealing rcu_replace_pointer() as a step towards removing
    rcu_swap_protected().
    
    Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
    Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
    Reported-by: "Martin K. Petersen" <martin.petersen@oracle.com>
    [ paulmck: Apply Matthias Brugger feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Reviewed-by: "Martin K. Petersen" <martin.petersen@oracle.com>
    Cc: Felix Fietkau <nbd@nbd.name>
    Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
    Cc: Ryder Lee <ryder.lee@mediatek.com>
    Cc: Roy Luo <royluo@google.com>
    Cc: Kalle Valo <kvalo@codeaurora.org>
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: Matthias Brugger <matthias.bgg@gmail.com>
    Cc: <linux-wireless@vger.kernel.org>
    Cc: <netdev@vger.kernel.org>
    Cc: <linux-arm-kernel@lists.infradead.org>
    Cc: <linux-mediatek@lists.infradead.org>

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 53b5a4b..59c1878 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -281,8 +281,8 @@ void mt76_rx_aggr_stop(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tidno)
 {
 	struct mt76_rx_tid *tid = NULL;
 
-	rcu_swap_protected(wcid->aggr[tidno], tid,
-			   lockdep_is_held(&dev->mutex));
+	tid = rcu_replace_pointer(wcid->aggr[tidno], tid,
+				  lockdep_is_held(&dev->mutex));
 	if (tid) {
 		mt76_rx_aggr_shutdown(dev, tid);
 		kfree_rcu(tid, rcu_head);
