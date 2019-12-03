Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7FF206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vnCd5Ull"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLCOCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51844 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xeaoGNbeLV4IoTGE0LnChmhbixf+zW4Mkt39CQg7zFA=; b=vnCd5UllBeBFWZHMxn5QAKVD5
        wbgMX5qycUAYskCv5WyEM6qtJVSzJvE9NW18XjnFTWWY1Vu4MpmJyTsYkq4/hOeKsjZ372Srj2fS7
        rN8+rBRsQTLioxiy9OQYDzQf3/k5GMw3saEOKzFSxxd4/0O2LF86J2MQjtLnQVrgqpOc9EE61j3ao
        trsDsWMWwY1NgcD3PCdbbiWIluvez8ZQBCZmLNxx06MiQBt0vb/Fdw8uY1jlG97PMD62iQ5ro3OT8
        sycHmTowBEnx41TXm7+svDeaXMrok4aIfWcuDR9BNdzzx/8zsE/qisFgdAk6MCT5dR6Fn7KdEsV5X
        Sv5G6EDSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic8kW-0000M4-NB; Tue, 03 Dec 2019 14:01:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5AFE4301A79;
        Tue,  3 Dec 2019 15:00:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7E2B201A401D; Tue,  3 Dec 2019 15:01:53 +0100 (CET)
Date:   Tue, 3 Dec 2019 15:01:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        walken@google.com, dave@stgolabs.net
Subject: Re: Crash in fair scheduler
Message-ID: <20191203140153.GP2844@hirez.programming.kicks-ass.net>
References: <1575364273836.74450@mentor.com>
 <20191203103046.GJ2827@hirez.programming.kicks-ass.net>
 <656260cf50684c11a3122aca88dde0cb@SVR-IES-MBX-03.mgc.mentorg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656260cf50684c11a3122aca88dde0cb@SVR-IES-MBX-03.mgc.mentorg.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:51:46AM +0000, Schmid, Carsten wrote:

> > > struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
> > > {
> > > 	struct rb_node *left = rb_first_cached(&cfs_rq->tasks_timeline);
> > >
> > > 	if (!left)
> > > 		return NULL; <<<<<<<<<< the case
> > >
> > > 	return rb_entry(left, struct sched_entity, run_node);
> > > }
> > 
> > This the problem, for some reason the rbtree code got that rb_leftmost
> > thing wrecked.
> > 
> Any known issue on rbtree code regarding this?

I don't recall ever having seen this before. :/ Adding Davidlohr and
Michel who've poked at the rbtree code 'recently'.

> > > Is this a corner case nobody thought of or do we have cfs_rq data that is
> > unexpected in it's content?
> > 
> > No, the rbtree is corrupt. Your tree has a single node (which matches
> > with nr_running), but for some reason it thinks rb_leftmost is NULL.
> > This is wrong, if the tree is non-empty, it must have a leftmost
> > element.
> Is there a chance to find the left-most element in the core dump?

If there is only one entry in the tree, then that must also be the
leftmost entry. See your own later question :-)

> Maybe i can dig deeper to find the root c ause then.
> Does any of the structs/data in this context point to some memory
> where i can continue to search?

There are only two places where rb_leftmost are updated,
rb_insert_color_cached() and rb_erase_cached() (the scheduler does not
use rb_replace_nod_cached).

We can 'forget' to set leftmost on insertion if @leftmost is somehow
false, and we can eroneously clear leftmost on erase if rb_next()
malfunctions.

No clues on which of those two cases happened.

> Where should rb_leftmost point to if only one node is in the tree?
> To the node itself?

Exatly.


I suppose one approach is to add code to both __enqueue_entity() and
__dequeue_entity() that compares ->rb_leftmost to the result of
rb_first(). That'd incur some overhead but it'd double check the logic.
