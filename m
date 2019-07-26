Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4259AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2029622CB9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfGZJUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:20:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37342 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZJUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:20:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so28567383wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zEHnLlgAE1F9o6ePfjZnmyUfCv46Keatw9zPZPEqKp8=;
        b=ijLVBWkse1pN0fMXduTA/xB4GXtD4ubH24s9nA+k1XSc52OEjmpMaL1oUvJT5VZXM4
         UbgwF646j8ib04rc4CADRvR3KfEZZc3Jm5w0/X6y5dvxqTpHzabjIFd5SCMZOd51fZeJ
         vwzEFoS3bEHgYrstBAR0vp+HMrGhD6MBsq0py85+cqSwYdu4NJzPlDSZH8iXn86/m44W
         6xePPiEjGtauSi2cQRZhiOUXDbC6X9SB7y5L7OFLV8HQvwM0Pm1hYqttdICIDy1OYNjL
         h91Donl8oQsgzxSnWZZYUA5qo9+GTW9JR8CIx+w+QkM1t7kpm3Xl/rV5CesEPWDJQnYW
         sFzg==
X-Gm-Message-State: APjAAAXckvfJmsTLda5xqMEJhitgW6w35f87PAN4BZiz11g+fo9V/qD8
        e0aqKtVKGiqd9pGUGbMTvotlEA==
X-Google-Smtp-Source: APXvYqy/cMG9VHIDV9npSjUWMW6JbBex3Qa8CdqSnWwfwhAdpogypl9y2wBOqHH8yavf66tDB/Igqg==
X-Received: by 2002:a5d:4a02:: with SMTP id m2mr99040297wrq.78.1564132808208;
        Fri, 26 Jul 2019 02:20:08 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id j10sm52483595wrw.96.2019.07.26.02.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 02:20:07 -0700 (PDT)
Date:   Fri, 26 Jul 2019 11:20:05 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/deadline: Cleanup on_dl_rq() handling
Message-ID: <20190726092005.GO25636@localhost.localdomain>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-5-dietmar.eggemann@arm.com>
 <0f460dba-4677-00de-59a2-5cd31ffe6e4b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f460dba-4677-00de-59a2-5cd31ffe6e4b@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/07/19 09:37, Valentin Schneider wrote:
> On 26/07/2019 09:27, Dietmar Eggemann wrote:
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
> 
> Any idea why a similar error leads to a BUG_ON() in the enqueue path but
> only a silent return on the dequeue path? I would expect the handling to be
> almost identical.
>  

Task could have already been dequeued by update_curr_dl()->throttle
called by dequeue_task_dl() before calling __dequeue_task_dl().

Thanks,

Juri
