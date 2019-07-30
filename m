Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9337DC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B94820644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfG3GlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:41:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42605 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfG3GlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:41:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so14496697wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 23:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7vdnLGgCJYtbW7FK96EXzyS9jXfM/zfzKmdlAEa+8Qs=;
        b=SkWjIdd9t2CUJNMsihvHjrfmaDGF7hhtjBVV1lAADxucSco1/8Q46rtb21hs+bEdor
         wJaSqlZwzOOy0GTlSDlvJOMvovA0tzZYNZiT/EH7XCNu82NUqcX5ABGVFcx+C8Ij7vC1
         BAJoHpRL8BgnErcZYJwYEdG5OILbQDtVia/E/bI5BLE6ERKQYTSyd6LQWQxZA92rFdJl
         4y6XVyzFAkW9J87l0A8Bqut5tLVViIw9Z55ZSWggwyOBa1JBWkDjVIvQjvvWtUswLnCU
         SoJGQsH0uoGDyM7UsEyBIxzL1hpruaVyADtkxXmEH7nrKKnd/2L4W6aVj4PxMexdggJL
         +U1Q==
X-Gm-Message-State: APjAAAULtlhdIdumjtRFucCYpnf5rhVsvqDPVuNJeE+DOKxwVbm9hatp
        DSr3ZCAGt31aF/PgNEFILqx1wQ==
X-Google-Smtp-Source: APXvYqw6cYwqFlT7bSdzLL4hAIbbaB/qVTksL5NpJ3Bm3t0suy+bS3ljZmOYsCCa6LEkhg03rmNRug==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr129745861wrs.93.1564468878561;
        Mon, 29 Jul 2019 23:41:18 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id i66sm105876293wmi.11.2019.07.29.23.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 23:41:17 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:41:15 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/deadline: Cleanup on_dl_rq() handling
Message-ID: <20190730064115.GC8927@localhost.localdomain>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-5-dietmar.eggemann@arm.com>
 <20190729164932.GN31398@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729164932.GN31398@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 18:49, Peter Zijlstra wrote:
> On Fri, Jul 26, 2019 at 09:27:55AM +0100, Dietmar Eggemann wrote:
> > Remove BUG_ON() in __enqueue_dl_entity() since there is already one in
> > enqueue_dl_entity().
> > 
> > Move the check that the dl_se is not on the dl_rq from
> > __dequeue_dl_entity() to dequeue_dl_entity() to align with the enqueue
> > side and use the on_dl_rq() helper function.
> > 
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
> >  kernel/sched/deadline.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 1fa005f79307..a9cb52ceb761 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1407,8 +1407,6 @@ static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
> >  	struct sched_dl_entity *entry;
> >  	int leftmost = 1;
> >  
> > -	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
> > -
> >  	while (*link) {
> >  		parent = *link;
> >  		entry = rb_entry(parent, struct sched_dl_entity, rb_node);
> > @@ -1430,9 +1428,6 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
> >  {
> >  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
> >  
> > -	if (RB_EMPTY_NODE(&dl_se->rb_node))
> > -		return;
> > -
> >  	rb_erase_cached(&dl_se->rb_node, &dl_rq->root);
> >  	RB_CLEAR_NODE(&dl_se->rb_node);
> >  
> > @@ -1466,6 +1461,9 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
> >  
> >  static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
> >  {
> > +	if (!on_dl_rq(dl_se))
> > +		return;
> 
> Why allow double dequeue instead of WARN?

As I was saying to Valentin, it can currently happen that a task could
have already been dequeued by update_curr_dl()->throttle called by
dequeue_task_dl() before calling __dequeue_task_dl(). Do you think we
should check for this condition before calling into dequeue_dl_entity()?
