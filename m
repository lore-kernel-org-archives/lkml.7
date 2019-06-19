Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E9C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106F52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oumpXBB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbfFSKrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:47:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39829 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfFSKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:47:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so2830333wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9nR8Wh0CdKiidPiISewnmk1WY9H1q+Ys3Mc5yu0EUw=;
        b=oumpXBB462l2V+pxeBncy7QQoSPv9B0YeUJD4VIVz63VkWy296qqwaw4aTS5xDQ32s
         dBiK7Ky1y2Rf6Z1xEyrSqd7+u7uIQ0/7mz8B+yIyWOoN5gV1G054c+vUeiXD6YtJRlHL
         dSpmGTUHF/cR9QgFCmZi0OJBa2OiQOVHf/Tjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9nR8Wh0CdKiidPiISewnmk1WY9H1q+Ys3Mc5yu0EUw=;
        b=F/65hdbv7S12u2HSkIJwd7W7K9ZNoIZHtx0jpQ5OkwKEqdnmUvgU91gv1eaaexIDbj
         oIduz9Tw1Li3jjKncm3Wu1GrAHCRK5ZrKI1VVP4PPnMteySa6WMnPu6blhun+qNamEo6
         7On9rNt1dgbOcrpsgVr/QOHJf8Z55Sf/XFouhtSpFcie5BeGXKWtc9Cz2xPOSGhaLdas
         K2to6PtlVbRfW8zh7gsKt8uTZ0KUeaTSSJbNl76NYpW8TS/ukV3qvNkvmF9ci/gkQNHk
         rCfcfAtLIwdHOSBXBsStPZGjzv3+/L8O4fWK0G9JH2hYv0cQV4pUUDT+ZqeAnZi/vvaA
         vi7g==
X-Gm-Message-State: APjAAAUTHDlbURrlGV+HwCz9M/zsH1mIvo/mXh3rU3JGJYkNf11yIVeE
        1fjn/wf+yHFKXro6GGVj56knxQ==
X-Google-Smtp-Source: APXvYqwp0NFYrId99G971IAegUc0j79lDnq1HcEzsL62WGeb71QMGm7R2mqbnEv6aYY06yfZ+bolZw==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr35697997wrv.157.1560941221782;
        Wed, 19 Jun 2019 03:47:01 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id r131sm1275691wmf.4.2019.06.19.03.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 03:47:01 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:46:55 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190619104655.GA6668@andrea>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618112237.GP3436@hirez.programming.kicks-ass.net>
 <87a7eebk71.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7eebk71.fsf@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I would appreciate it if you could point out a source file that
> documents its memory barriers the way you would like to see these memory
> barriers documented.

IMO, you could find some inspiration by looking at the memory barriers
comments from:

  kernel/sched/core.c:try_to_wake_up()
  include/linux/wait.h:waitqueue_active()
  kernel/futex.c [header _and inline annotations]

I'll detail a single example here, and then conclude with some general
guidelines:

---
[from kernel/sched/rt.c]

static inline void rt_set_overload(struct rq *rq)
{
	if (!rq->online)
		return;

	cpumask_set_cpu(rq->cpu, rq->rd->rto_mask);
	/*
	 * Make sure the mask is visible before we set
	 * the overload count. That is checked to determine
	 * if we should look at the mask. It would be a shame
	 * if we looked at the mask, but the mask was not
	 * updated yet.
	 *
	 * Matched by the barrier in pull_rt_task().
	 */
	smp_wmb();
	atomic_inc(&rq->rd->rto_count);
}

static void pull_rt_task(struct rq *this_rq)
{
	int this_cpu = this_rq->cpu, cpu;
	bool resched = false;
	struct task_struct *p;
	struct rq *src_rq;
	int rt_overload_count = rt_overloaded(this_rq);

	if (likely(!rt_overload_count))
		return;

	/*
	 * Match the barrier from rt_set_overloaded; this guarantees that if we
	 * see overloaded we must also see the rto_mask bit.
	 */
	smp_rmb();

	/* If we are the only overloaded CPU do nothing */
	if (rt_overload_count == 1 &&
	    cpumask_test_cpu(this_rq->cpu, this_rq->rd->rto_mask))
		return;

	[...]

}
---

Notice that the comments provide the following information: for _each_
memory barrier primitive,

  1) the _memory accesses_ being ordered

     the store to ->rto_mask and the store to ->rto_count for the smp_wmb()
     the load from ->rto_count and the from ->rto_mask for the smp_rmb()

  2) the _matching barrier_ (and its location)

  3) an informal description of the _underlying guarantee(s)_  (c.f.,
     "if we see overloaded we must also see the rto_mask bit").

One can provide this information by embedding some snippet/pseudo-code
in its comments as illustrated in the examples pointed out above.

I'd suggest to _not be stingy with memory barriers explanations:  this
eases/makes it possible the review itself as well as future changes or
fixes to the implementation.

FWIW (and as anticipated time ago in a private email), when I see code
like this I tend to look elsewhere...  ;-/

Thanks,
  Andrea
