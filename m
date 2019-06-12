Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321AFC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136A3208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfFLLTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:19:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39559 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfFLLTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:19:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so13813554wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2DY9BNuwvWwHmPyKTH7LGXdzKvzCIaqNI7kWqlmuhvc=;
        b=hI8dj441BY+nSdqyQWpYVwsJ4r0V1tI8u7JHPljqueG0Da6STcc3e2kAFbEQkWKtYd
         JLxhpyRd1rOX4IOk2ri2L06hT7pyUUDSTplrZ6kLqB0mD8X4X2uUakWqs5uCQEaC2u3/
         fkRygTk5kwE1Edt5vv4X4z/CP/JKTqh0BgnDQDhpjCuNy8NnPo15uQGrD1RELdwINFKx
         DHrKuye64GLUL2Oh6dunNI/bk8hcRRpeU4S+b0p7cZeH36OWZvxCwmPWRoTJiQXo4xsh
         8o5qvYdMOh2mySK+DNkQw7G6HletxD5n89NQJTRmt9Lc1TJDxtM+3mf97U+wEmhZjIuT
         k4Ww==
X-Gm-Message-State: APjAAAURPXmIG0NDmprLJUt/iCPv2T0xokDbHtXUUBJ4Wkeym0wbaHUM
        syzMaD0w+TUgBC0Sk5TJrHLtCQ==
X-Google-Smtp-Source: APXvYqy/37Y6CvQfxqtHse3Rk+em+nImH5GtIIV1i2YZ9vY5x/E8azVs6GhTTo5OHfW1RpK9PFD6Ig==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr42236505wrq.72.1560338362423;
        Wed, 12 Jun 2019 04:19:22 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m21sm4710436wmc.1.2019.06.12.04.19.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 04:19:21 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:19:20 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, hdanton@sina.com,
        lizeb@google.com
Subject: Re: [PATCH v2 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190612111920.evedpmre63ivnxkz@butterfly.localdomain>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190612105945.GA16442@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612105945.GA16442@amd>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:59:45PM +0200, Pavel Machek wrote:
> > - Problem
> > 
> > Naturally, cached apps were dominant consumers of memory on the system.
> > However, they were not significant consumers of swap even though they are
> > good candidate for swap. Under investigation, swapping out only begins
> > once the low zone watermark is hit and kswapd wakes up, but the overall
> > allocation rate in the system might trip lmkd thresholds and cause a cached
> > process to be killed(we measured performance swapping out vs. zapping the
> > memory by killing a process. Unsurprisingly, zapping is 10x times faster
> > even though we use zram which is much faster than real storage) so kill
> > from lmkd will often satisfy the high zone watermark, resulting in very
> > few pages actually being moved to swap.
> 
> Is it still faster to swap-in the application than to restart it?

It's the same type of question I was addressing earlier in the remote
KSM discussion: making applications aware of all the memory management stuff
or delegate the decision to some supervising task.

In this case, we cannot rewrite all the application to handle imaginary
SIGRESTART (or whatever you invent to handle restarts gracefully). SIGTERM
may require more memory to finish stuff to not lose your data (and I guess
you don't want to lose your data, right?), and SIGKILL is pretty much
destructive.

Offloading proactive memory management to a process that knows how to do
it allows to handle not only throwaway containers/microservices, but also
usual desktop/mobile workflow.

> > This approach is similar in spirit to madvise(MADV_WONTNEED), but the
> > information required to make the reclaim decision is not known to the app.
> > Instead, it is known to a centralized userspace daemon, and that daemon
> > must be able to initiate reclaim on its own without any app involvement.
> > To solve the concern, this patch introduces new syscall -
> > 
> >     struct pr_madvise_param {
> >             int size;               /* the size of this structure */
> >             int cookie;             /* reserved to support atomicity */
> >             int nr_elem;            /* count of below arrary fields */
> >             int __user *hints;      /* hints for each range */
> >             /* to store result of each operation */
> >             const struct iovec __user *results;
> >             /* input address ranges */
> >             const struct iovec __user *ranges;
> >     };
> >     
> >     int process_madvise(int pidfd, struct pr_madvise_param *u_param,
> >                             unsigned long flags);
> 
> That's quite a complex interface.
> 
> Could we simply have feel_free_to_swap_out(int pid) syscall? :-).

I wonder for how long we'll go on with adding new syscalls each time we need
some amendment to existing interfaces. Yes, clone6(), I'm looking at
you :(.

In case of process_madvise() keep in mind it will be focused not only on
MADV_COLD, but also, potentially, on other MADV_ flags as well. I can
hardly imagine we'll add one syscall per each flag.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
