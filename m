Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F1CC3A59D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D535622CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AvkqA2ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfHUA1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:27:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34085 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfHUA1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:27:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so265663pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ajomM+Tb3ibNiEApsgamZJCzz/2BJZLgWqV9OMg1vM=;
        b=AvkqA2evSsfMSPgL+gvk9MtvmUSh1ZG0z5TyzsNc52/xwA+76++C2C3GkR821zLVWh
         NghIO8tkHNQJHUEe+rmBFhHAXlHu+TWMGLQxk6C15lUiP7CE1rg779sqcEbaGdt8tsNZ
         Dh0ZFmD1r52FhThtj6fQoAiDSxmoz4xyVUSQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ajomM+Tb3ibNiEApsgamZJCzz/2BJZLgWqV9OMg1vM=;
        b=XKD4j27pk2u82Z+/3VExWBuxufMjlG0cNGqZf5HSEUfCzB5MjEuySePIcwHQwRBtYx
         oPQH+spz3b+ABdheWhEKN6QtVbMhqucPp2yfh+4Hs13IVuNcCny09lp64S5Avk83HDdj
         yCKEkJgflIp/8r8SBvTlgDhUGhfu3jH1OM3KhysfKAg/QpzTVg8Et1vv+jcuk5N0BFf9
         CPL5a3spbamBqsy6I28h+LuNJixjyHNwb3dmG+422PmTTBg9Rbv83CC0ep9sLVnO3tTw
         SMRSiFIqyos5cvMy7wOFzhb0dM3hUANb2bYs8r9Rowm9rMtw8yCnBgz4z+VtTlF/m30B
         MrwA==
X-Gm-Message-State: APjAAAXcC3vFsmTriRFGzGFXXruwUZWABTMOASHsELUtHjevHxpoIVoh
        lFJxKalsqGsn5OehldfRAMy6LA==
X-Google-Smtp-Source: APXvYqwPzpB0b37oE4EBclcFAu6lgqLxkG4cZvwYhahvSco5Kzd7IGI07OH/b3wTKIGiaslAnsFYdg==
X-Received: by 2002:a62:1bd5:: with SMTP id b204mr32075355pfb.14.1566347243386;
        Tue, 20 Aug 2019 17:27:23 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id x24sm19622445pgl.84.2019.08.20.17.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 17:27:22 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:27:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com, Rao Shoaib <rao.shoaib@oracle.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 2/2] rcuperf: Add kfree_rcu() performance Tests
Message-ID: <20190821002705.GA212946@google.com>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190814160411.58591-2-joel@joelfernandes.org>
 <20190814225850.GZ28441@linux.ibm.com>
 <20190819193327.GF117548@google.com>
 <20190819222330.GH28441@linux.ibm.com>
 <20190819235123.GA185164@google.com>
 <20190820025056.GL28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820025056.GL28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:50:56PM -0700, Paul E. McKenney wrote:
 
> > > > > > +	do {
> > > > > > +		for (i = 0; i < kfree_alloc_num; i++) {
> > > > > > +			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> > > > > > +			if (!alloc_ptrs[i])
> > > > > > +				return -ENOMEM;
> > > > > > +		}
> > > > > > +
> > > > > > +		for (i = 0; i < kfree_alloc_num; i++) {
> > > > > > +			if (!kfree_no_batch) {
> > > > > > +				kfree_rcu(alloc_ptrs[i], rh);
> > > > > > +			} else {
> > > > > > +				rcu_callback_t cb;
> > > > > > +
> > > > > > +				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> > > > > > +				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
> > > > > > +			}
> > > > > > +		}
> > > > > 
> > > > > The point of allocating a large batch and then kfree_rcu()ing them in a
> > > > > loop is to defeat the per-CPU pool optimization?  Either way, a comment
> > > > > would be very good!
> > > > 
> > > > It was a reasoning like this, added it as a comment:
> > > > 
> > > > 	/* While measuring kfree_rcu() time, we also end up measuring kmalloc()
> > > > 	 * time. So the strategy here is to do a few (kfree_alloc_num) number
> > > > 	 * of kmalloc() and kfree_rcu() every loop so that the current loop's
> > > > 	 * deferred kfree()ing overlaps with the next loop's kmalloc().
> > > > 	 */
> > > 
> > > The thought being that the CPU will be executing the two loops
> > > concurrently?  Up to a point, agreed, but how much of an effect is
> > > that, really?
> > 
> > Yes it may not matter much. It was just a small thought when I added the
> > loop, I had to start somewhere, so I did it this way.
> > 
> > > Or is the idea to time the kfree_rcu() loop separately?  (I don't see
> > > any such separate timing, though.)
> > 
> > The kmalloc() times are included within the kfree loop. The timing of
> > kfree_rcu() is not separate in my patch.
> 
> You lost me on this one.  What happens when you just interleave the
> kmalloc() and kfree_rcu(), without looping, compared to the looping
> above?  Does this get more expensive?  Cheaper?  More vulnerable to OOM?
> Something else?

You mean pairing a single kmalloc() with a single kfree_rcu() and doing this
several times? The results are very similar to doing kfree_alloc_num
kmalloc()s, then do kfree_alloc_num kfree_rcu()s; and repeat the whole thing
kfree_loops times (as done by this rcuperf patch we are reviewing).

Following are some numbers. One change is the case where we are not at all
batching does seem to complete even faster when we fully interleave kmalloc()
with kfree() while the case of batching in the same scenario completes at the
same time as did the "not fully interleaved" scenario. However, the grace
period reduction improvements and the chances of OOM'ing are pretty much the
same in either case.

Fully interleaved, single kmalloc followed by kfree_rcu, do this kfree_alloc_num * kfree_loops times.
=======================
(1) Batching
rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=0 rcuperf.kfree_rcu_test=1

root@(none):/# free -m
              total        used        free      shared  buff/cache   available
Mem:            977         261         675           0          39         674

[   15.635620] Total time taken by all kfree'ers: 14255673998 ns, loops: 20000, batches: 1596

(2) No Batching
rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=1 rcuperf.kfree_rcu_test=1

root@(none):/# free -m
             total        used        free      shared  buff/cache   available
Mem:            977          67         870           0          39         869
Swap:             0           0           0

[   12.365872] Total time taken by all kfree'ers: 10902137101 ns, loops: 20000, batches: 6893


Not fully interleaved: do kfree_alloc_num kmallocs, then do kfree_alloc_num kfree_rcu()s. And repeat this kfree_loops times.
=======================
(1) Batching
rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=0 rcuperf.kfree_rcu_test=1

root@(none):/# free -m
              total        used        free      shared  buff/cache   available
Mem:            977         251         686           0          39         684
Swap:             0           0           0

[   15.574402] Total time taken by all kfree'ers: 14185970787 ns, loops: 20000, batches: 1548

(2) No Batching
rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=1 rcuperf.kfree_rcu_test=1

root@(none):/# free -m
              total        used        free      shared  buff/cache   available
Mem:            977          82         855           0          39         853
Swap:             0           0           0

[   13.724554] Total time taken by all kfree'ers: 12246217291 ns, loops: 20000, batches: 7262


thanks,

 - Joel


