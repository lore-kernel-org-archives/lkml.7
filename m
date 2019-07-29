Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EE9206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GarIFwvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfG2Qti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:49:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfG2Qti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xI0s6PYhr6DR7oAWn8RUyWqKiAToRVS5nz7hhing0QI=; b=GarIFwvTlU4x3LbxX3aMpja/+
        PBFiKi94Bzysqmf1a4vfE7V2BZ16AwbtYZW8NG7/dIqhPqBR33fJs8qLBPWV6XuSW1E4xdsx7gpKc
        GxoHAvOQsHQmoGX89IE6qpPwXmoz31Y2RT1GSpVbDsmXP62X/TBPqq4ow5PKaCTL9TICuTno+VEet
        Gq+XbMIXycydWP09FEXynd3XjNfBPCiWFgWCvz0QXLhHbXthtZ8BRzR5daMKMHQyv+Lh3qrUbysAQ
        LFf/5xckqUCJB223/DyGl0wsjwFRmR7UeQz6ncJgu+I13U9L5LvybzuKaT4cPBxg3TlqBIjk84uvD
        iYtVg1rwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs8q6-0004FY-82; Mon, 29 Jul 2019 16:49:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 346C420C7FF01; Mon, 29 Jul 2019 18:49:32 +0200 (CEST)
Date:   Mon, 29 Jul 2019 18:49:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/deadline: Cleanup on_dl_rq() handling
Message-ID: <20190729164932.GN31398@hirez.programming.kicks-ass.net>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726082756.5525-5-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 09:27:55AM +0100, Dietmar Eggemann wrote:
> Remove BUG_ON() in __enqueue_dl_entity() since there is already one in
> enqueue_dl_entity().
> 
> Move the check that the dl_se is not on the dl_rq from
> __dequeue_dl_entity() to dequeue_dl_entity() to align with the enqueue
> side and use the on_dl_rq() helper function.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/deadline.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1fa005f79307..a9cb52ceb761 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1407,8 +1407,6 @@ static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
>  	struct sched_dl_entity *entry;
>  	int leftmost = 1;
>  
> -	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
> -
>  	while (*link) {
>  		parent = *link;
>  		entry = rb_entry(parent, struct sched_dl_entity, rb_node);
> @@ -1430,9 +1428,6 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
>  {
>  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>  
> -	if (RB_EMPTY_NODE(&dl_se->rb_node))
> -		return;
> -
>  	rb_erase_cached(&dl_se->rb_node, &dl_rq->root);
>  	RB_CLEAR_NODE(&dl_se->rb_node);
>  
> @@ -1466,6 +1461,9 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
>  
>  static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
>  {
> +	if (!on_dl_rq(dl_se))
> +		return;

Why allow double dequeue instead of WARN?

> +
>  	__dequeue_dl_entity(dl_se);
>  }
>  
> -- 
> 2.17.1
> 
