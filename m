Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2086BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E051120644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CDdpZoer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfHSXvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:51:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41123 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfHSXvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:51:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so2140230pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b7CfMX7Mh9+U+Y6oqsr98sIYNBzxAmNxx1S6zWZHlKQ=;
        b=CDdpZoeryfHviUntBEV+0llYMNjpJxnMU49k3qgcjNQmtHjTb9h0yj8m/hjbpAtDSO
         TfaFXZISN9mkDlVCqWWPrxQjT9NzmNuR8kZnujoXUtRaj5ItsS9kWOLRDwlxIFA/3gT8
         OJVXcFKROLSQYFfPgXvu5eEr+SIDbAJRNZ6J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b7CfMX7Mh9+U+Y6oqsr98sIYNBzxAmNxx1S6zWZHlKQ=;
        b=RewDdoGSyN6Ducw0KWPcI96sneq0Bb2T8/a9iiV09hXbeoDII7veD/rpZgJZxEAf8H
         9Ar/34NMtevgdzRJJ+1aI3mMSb6VD1vcyHEm2t+JjxRXSUQG6+N3pXVEFeCGbXFqGYYO
         8SFfnEVPYFs/LrdaBjM0DU4KBTcs0fdvke73PKqKGoXqM4I3NCPIHK55lhNUjNFtO1X3
         DawpuxCErb5HqHhj4ylXdT4MtX79pS9w2vwZRG6XMI0fF5e4ShmoMhjFBdaQC0bFDn4u
         x8FDWRreg0tMiW7tUCHMSSI2naPxR88XfkSWXPQa7HYm4jQpY2k81BqDuhE7+s5/+z1q
         3UpA==
X-Gm-Message-State: APjAAAWGmtQfoyWoL7+oZlnHUH4CKYMwPjMqB/4EIOAM37fsULhiCanV
        hvnlLfRos3H/9mEm90dcRddswQ==
X-Google-Smtp-Source: APXvYqyxM2CqAYJuRKA+AZvnZOw8TUxw9NYwMWVwHw+0eucB/hTiFueMrFzjy7WInnSoLakiECHe6Q==
X-Received: by 2002:a63:29c7:: with SMTP id p190mr21722966pgp.124.1566258700526;
        Mon, 19 Aug 2019 16:51:40 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id 185sm19316354pfd.125.2019.08.19.16.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:51:39 -0700 (PDT)
Date:   Mon, 19 Aug 2019 19:51:23 -0400
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
Message-ID: <20190819235123.GA185164@google.com>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190814160411.58591-2-joel@joelfernandes.org>
 <20190814225850.GZ28441@linux.ibm.com>
 <20190819193327.GF117548@google.com>
 <20190819222330.GH28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819222330.GH28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 03:23:30PM -0700, Paul E. McKenney wrote:
[snip]
> > [snip]
> > > > @@ -592,6 +593,175 @@ rcu_perf_shutdown(void *arg)
> > > >  	return -EINVAL;
> > > >  }
> > > >  
> > > > +/*
> > > > + * kfree_rcu performance tests: Start a kfree_rcu loop on all CPUs for number
> > > > + * of iterations and measure total time and number of GP for all iterations to complete.
> > > > + */
> > > > +
> > > > +torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
> > > > +torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
> > > > +torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> > > > +torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu.");
> > > > +
> > > > +static struct task_struct **kfree_reader_tasks;
> > > > +static int kfree_nrealthreads;
> > > > +static atomic_t n_kfree_perf_thread_started;
> > > > +static atomic_t n_kfree_perf_thread_ended;
> > > > +
> > > > +struct kfree_obj {
> > > > +	char kfree_obj[8];
> > > > +	struct rcu_head rh;
> > > > +};
> > > 
> > > (Aside from above, no need to change this part of the patch, at least not
> > > that I know of at the moment.)
> > > 
> > > 24 bytes on a 64-bit system, 16 on a 32-bit system.  So there might
> > > have been 10 million extra objects awaiting free in the batching case
> > > given the 400M-50M=350M excess for the batching approach.  If freeing
> > > each object took about 100ns, that could account for the additional
> > > wall-clock time for the batching approach.
> > 
> > Makes sense, and this comes down to 200-220MB range with the additional list.
> 
> Which might even match the observed numbers?

Yes, they would. Since those *are* the observed numbers :-D ;-) ;-)

> > > > +	do {
> > > > +		for (i = 0; i < kfree_alloc_num; i++) {
> > > > +			alloc_ptrs[i] = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> > > > +			if (!alloc_ptrs[i])
> > > > +				return -ENOMEM;
> > > > +		}
> > > > +
> > > > +		for (i = 0; i < kfree_alloc_num; i++) {
> > > > +			if (!kfree_no_batch) {
> > > > +				kfree_rcu(alloc_ptrs[i], rh);
> > > > +			} else {
> > > > +				rcu_callback_t cb;
> > > > +
> > > > +				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
> > > > +				kfree_call_rcu_nobatch(&(alloc_ptrs[i]->rh), cb);
> > > > +			}
> > > > +		}
> > > 
> > > The point of allocating a large batch and then kfree_rcu()ing them in a
> > > loop is to defeat the per-CPU pool optimization?  Either way, a comment
> > > would be very good!
> > 
> > It was a reasoning like this, added it as a comment:
> > 
> > 	/* While measuring kfree_rcu() time, we also end up measuring kmalloc()
> > 	 * time. So the strategy here is to do a few (kfree_alloc_num) number
> > 	 * of kmalloc() and kfree_rcu() every loop so that the current loop's
> > 	 * deferred kfree()ing overlaps with the next loop's kmalloc().
> > 	 */
> 
> The thought being that the CPU will be executing the two loops
> concurrently?  Up to a point, agreed, but how much of an effect is
> that, really?

Yes it may not matter much. It was just a small thought when I added the
loop, I had to start somewhere, so I did it this way.

> Or is the idea to time the kfree_rcu() loop separately?  (I don't see
> any such separate timing, though.)

The kmalloc() times are included within the kfree loop. The timing of
kfree_rcu() is not separate in my patch.

thanks,

 - Joel

