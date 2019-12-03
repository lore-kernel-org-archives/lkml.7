Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0363C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8672054F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pjJDdnHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCKaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:30:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50526 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfLCKaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rna2JaW2M6WY+wWsRwUd4SfBNEf14oDaBk5RQKMA9hg=; b=pjJDdnHT+AUhQe+9+Mdn8NFb0
        vOqy8/jX7I+kbZrJPaPBfN8LcK3afWqNHTnEUwy2JTe9agZ8sz80sPhtcpW/3DVijarJUtpp/SYBE
        fAawQaC/dPFVGExiRkIMSpLX7T+b88IC9ufnNPjrS6Awg7t54s0ti0Odtv/VcmIBp/1miFqmh7OBD
        VTh1WnSIAbdaCVAOPiytgFL8wKSboB/EInhh2f4GzvsP632cDSTDw11glWvR9ob3lg9IY16ZzEJHe
        lwwdvimjxPLjPeQ1FnkS1v2FH0w7EfDqTzPrw/vqFrHMBZfH449nH3opiyW9ZxAg+QuWfAQ8263n6
        gzyvSuMVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic5SC-0006Kd-HL; Tue, 03 Dec 2019 10:30:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABB3B303144;
        Tue,  3 Dec 2019 11:29:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E53BC2061BAF9; Tue,  3 Dec 2019 11:30:46 +0100 (CET)
Date:   Tue, 3 Dec 2019 11:30:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Crash in fair scheduler
Message-ID: <20191203103046.GJ2827@hirez.programming.kicks-ass.net>
References: <1575364273836.74450@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575364273836.74450@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 09:11:14AM +0000, Schmid, Carsten wrote:
> Hi maintainers of the fair scheduler,
> 
> we had a crash in the fair scheduler and analysis shows that this could happen again.
> Happened on 4.14.86 (LTS series) but failing code path still exists in 5.4-rc2 (and 4.14.147 too).

Please, do try if you can reproduce with Linus' latest git. I've no idea
what is, or is not, in those stable trees.

> crash> * cfs_rq ffff99a96dda9800
> struct cfs_rq {
>   load = {  weight = 1048576,  inv_weight = 0  }, 
>   nr_running = 1, 
>   h_nr_running = 1, 
>   exec_clock = 0, 
>   min_vruntime = 190894920101, 
>   tasks_timeline = {  rb_root = {    rb_node = 0xffff99a9502e0d10  },   rb_leftmost = 0x0  }, 
>   curr = 0x0, 
>   next = 0x0, 
>   last = 0x0, 
>   skip = 0x0, 


> &cfs_rq->tasks_timeline->rb_leftmost
>   tasks_timeline = {
>     rb_root = {
>       rb_node = 0xffff99a9502e0d10
>     }, 
>     rb_leftmost = 0x0
>   }, 

> include/linux/rbtree.h:91:#define rb_first_cached(root) (root)->rb_leftmost

> struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
> {
> 	struct rb_node *left = rb_first_cached(&cfs_rq->tasks_timeline);
> 
> 	if (!left)
> 		return NULL; <<<<<<<<<< the case
> 
> 	return rb_entry(left, struct sched_entity, run_node);
> }

This the problem, for some reason the rbtree code got that rb_leftmost
thing wrecked.

> Is this a corner case nobody thought of or do we have cfs_rq data that is unexpected in it's content?

No, the rbtree is corrupt. Your tree has a single node (which matches
with nr_running), but for some reason it thinks rb_leftmost is NULL.
This is wrong, if the tree is non-empty, it must have a leftmost
element.

Can you reproduce at will? If so, can you please try the latest kernel,
and or share the reproducer?
