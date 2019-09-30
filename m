Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18139C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA1822500
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nRXpD4f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfI3Un1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:43:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33774 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3Un0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:43:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so6275662pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ej+NLOn65SqylH82xQqCy7VCcHeNjBUvrxVEbfvpBwo=;
        b=nRXpD4f7KWqFbQyFMyCsm1kAi0MDUjJ/OzE5NbdzsMl7Npj1TDqhnMyaNMO76wTz4P
         kalwczUBiqPNefZ098dmk6+zMm8OhNWOKBFu/zxZcPg9u+XvivmZiqk66jmAjeK1y98J
         UkOoc8VX83B/EWiMfrD3mzJeuVixZ9PKtJCdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ej+NLOn65SqylH82xQqCy7VCcHeNjBUvrxVEbfvpBwo=;
        b=SX7mw6KQz2LoXXOwT1OSGEan2YaXM+V9bISE0y8pgyBisFjo+wpZ1TDQ82kiZnlHtG
         MMuXwMuWkKcQ3Isgflo9qL6DyduQKvE57/Szr9ayCxNAKCwZaywWqsyweBkMsSZv8Pf8
         MuCAgyOfgf2lzXU0teXTnak6rWsTwcWY5+Z7fhjpRm/cBgK2G9SzrlJl1aHzqoS/hUHX
         OuUET+E31AiNWiIggLRCAtvmXbK09DjWZD2JcNmGK3RiSdzxBZhA4Nq9fVrNQCgTj1Ji
         VH2kjhPK3uu/e6YycAZHirHU5Zl8CCy+OtYsWa09liGOc8qHCYmA5wIHNfyn5UM4eI/r
         7XOQ==
X-Gm-Message-State: APjAAAVwTaDgNzKUi3etgcbs3+xp8wotbZM7zaspA5pyOFokS/+gbMut
        HbkRCQ97ePbDfK77KMVlAVLTrg==
X-Google-Smtp-Source: APXvYqy7dW2o3ZI1PqcNwk7CVJMuSg+Y4R9Ba2CAdv/Lg7XCe/An85hWd/2CXf4MDHUcB/SJzu1KbA==
X-Received: by 2002:a17:90a:8c15:: with SMTP id a21mr1083385pjo.99.1569874585032;
        Mon, 30 Sep 2019 13:16:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h2sm22067824pfq.108.2019.09.30.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 13:16:24 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:16:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel-team@lge.com, Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Message-ID: <20190930201623.GA134859@google.com>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190918095811.GA25821@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918095811.GA25821@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:58:11AM +0200, Uladzislau Rezki wrote:
> > Recently a discussion about stability and performance of a system
> > involving a high rate of kfree_rcu() calls surfaced on the list [1]
> > which led to another discussion how to prepare for this situation.
> > 
> > This patch adds basic batching support for kfree_rcu(). It is "basic"
> > because we do none of the slab management, dynamic allocation, code
> > moving or any of the other things, some of which previous attempts did
> > [2]. These fancier improvements can be follow-up patches and there are
> > different ideas being discussed in those regards. This is an effort to
> > start simple, and build up from there. In the future, an extension to
> > use kfree_bulk and possibly per-slab batching could be done to further
> > improve performance due to cache-locality and slab-specific bulk free
> > optimizations. By using an array of pointers, the worker thread
> > processing the work would need to read lesser data since it does not
> > need to deal with large rcu_head(s) any longer.
> > 
> > Torture tests follow in the next patch and show improvements of around
> > 5x reduction in number of  grace periods on a 16 CPU system. More
> > details and test data are in that patch.
> > 
> > There is an implication with rcu_barrier() with this patch. Since the
> > kfree_rcu() calls can be batched, and may not be handed yet to the RCU
> > machinery in fact, the monitor may not have even run yet to do the
> > queue_rcu_work(), there seems no easy way of implementing rcu_barrier()
> > to wait for those kfree_rcu()s that are already made. So this means a
> > kfree_rcu() followed by an rcu_barrier() does not imply that memory will
> > be freed once rcu_barrier() returns.
> > 
> > Another implication is higher active memory usage (although not
> > run-away..) until the kfree_rcu() flooding ends, in comparison to
> > without batching. More details about this are in the second patch which
> > adds an rcuperf test.
> > 
> > Finally, in the near future we will get rid of kfree_rcu() special casing
> > within RCU such as in rcu_do_batch and switch everything to just
> > batching. Currently we don't do that since timer subsystem is not yet up
> > and we cannot schedule the kfree_rcu() monitor as the timer subsystem's
> > lock are not initialized. That would also mean getting rid of
> > kfree_call_rcu_nobatch() entirely.
> > 
> Hello, Joel.
> 
> First of all thank you for improving it. I also noticed a high pressure
> on RCU-machinery during performing some vmalloc tests when kfree_rcu()
> flood occurred. Therefore i got rid of using kfree_rcu() there.

Replying a bit late due to overseas conference travel and vacation.

When you say 'high pressure', do you mean memory pressure or just system
load?

Memory pressure slightly increases with the kfree_rcu() rework with the
benefit of much fewer grace periods.

> I have just a small question related to workloads and performance evaluation.
> Are you aware of any specific workloads which benefit from it for example
> mobile area, etc? I am asking because i think about backporting of it and
> reuse it on our kernel. 

I am not aware of a mobile usecase that benefits but there are server
workloads that make system more stable in the face of a kfree_rcu() flood.

For the KVA allocator work, I see it is quite similar to the way binder
allocates blocks. See function: binder_alloc_new_buf_locked(). Is there are
any chance to reuse any code? For one thing, binder also has an rbtree for
allocated blocks for fast lookup of allocated blocks. Does the KVA allocator
not have the need for that?

And, nice LPC presentation! I was there ;)

thanks,

 - Joel

