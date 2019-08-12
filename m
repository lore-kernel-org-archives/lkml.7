Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46240C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173B020684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XuHwYpVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfHLNIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:08:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34678 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfHLNIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:08:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so43236420pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 06:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0+d7JiE4ALvh+vozWgQX9WRuAWwlUlbg0HRlo3FMVKM=;
        b=XuHwYpVy4YKDtkBncgZgarepVoaPreVCKt5pefACP+j1hsGxvnUD3UAc7zX6MEHqRz
         sSvzKE9SEErpR8GuW7cCSDvttY5W8YiCTLbu+Io2+tbPcN87ElV3LqukcHrdDGUv9vtT
         DCaNaiazekE/y9Ng3AM/qvYGjeWum23ndyYDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0+d7JiE4ALvh+vozWgQX9WRuAWwlUlbg0HRlo3FMVKM=;
        b=njz9Fv3R4DADVzhk0J8bRNYnFMblrG4v/Zdk686vfWUu32FYNi2qNFtjI2OiBwX9ig
         hO94DIzn1Fh549ylOWh0Zvmevdk1T0yynUMP76/W0MVoYacDMDb+6AdolhWY6wbKaihE
         bAdcl7HrqcuGMYv1acRHG7Ad8QTA2lWKCQqa7YXgU4eLivxUVKEJfHv1PlRIMqJqawyZ
         n+jqLTmSF8irLmYfiaEVJXMqs1EnknWYVZScEPKDHzQsqTDNVGwSbipH9lrWTSwLuInn
         6a+/nKNPHjG/fowpYCa7xhf1Dn14YtwjHspz0XH4dmtET4MfkpXUTC6luni8NIhT4oTZ
         Y3XQ==
X-Gm-Message-State: APjAAAVdcyJlR26a4oRoqfpuDwTHBjQl4QjIOE+iFMURv+OIV4QToWPX
        izYHML5u+KWHo/8ANzesfdgV7Q==
X-Google-Smtp-Source: APXvYqwzwSNMzkoGkoKrM7gC6Kss7FrU3+9YPzxEYeGpsPCnpjpC2W6CZwZrbnKkmicR5H8Ki5UIqA==
X-Received: by 2002:a17:90a:a896:: with SMTP id h22mr1309321pjq.1.1565615291134;
        Mon, 12 Aug 2019 06:08:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v14sm113161991pfm.164.2019.08.12.06.08.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 06:08:10 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:08:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] rcu/tree: Add basic support for kfree_rcu batching
Message-ID: <20190812130809.GB27552@google.com>
References: <20190811024957.233650-1-joel@joelfernandes.org>
 <20190812102917.GA10624@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812102917.GA10624@X58A-UD3R>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 07:29:17PM +0900, Byungchul Park wrote:
[snip]
> > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > index 8e727f57d814..383f2481750f 100644
> > --- a/include/linux/rcutiny.h
> > +++ b/include/linux/rcutiny.h
> > @@ -39,6 +39,11 @@ static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	call_rcu(head, func);
> >  }
> >  
> > +static inline void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +	call_rcu(head, func);
> > +}
> > +
> >  void rcu_qs(void);
> >  
> >  static inline void rcu_softirq_qs(void)
> > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > index 735601ac27d3..7e38b39ec634 100644
> > --- a/include/linux/rcutree.h
> > +++ b/include/linux/rcutree.h
> > @@ -34,6 +34,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
> >  
> >  void synchronize_rcu_expedited(void);
> >  void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> > +void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
> >  
> >  void rcu_barrier(void);
> >  bool rcu_eqs_special_set(int cpu);
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a14e5fbbea46..102a5f606d78 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2593,17 +2593,204 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  }
> >  EXPORT_SYMBOL_GPL(call_rcu);
> >  
> > +
> > +/* Maximum number of jiffies to wait before draining a batch. */
> > +#define KFREE_DRAIN_JIFFIES (HZ / 50)
> 
> JFYI, I also can see oom with a larger value of this. I hope this magic
> value works well for all kind of systems.

It seems to work well in my testing. I am glad you could not perceive OOMs at
this value, either.

> > - * Queue an RCU callback for lazy invocation after a grace period.
> > - * This will likely be later named something like "call_rcu_lazy()",
> > - * but this change will require some way of tagging the lazy RCU
> > - * callbacks in the list of pending callbacks. Until then, this
> > - * function may only be called from __kfree_rcu().
> > + * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
> > + * kfree(s) is queued for freeing after a grace period, right away.
> >   */
> > -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > +struct kfree_rcu_cpu {
> > +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> > +	 * is done after a grace period.
> > +	 */
> > +	struct rcu_work rcu_work;
> > +
> > +	/* The list of objects being queued in a batch but are not yet
> > +	 * scheduled to be freed.
> > +	 */
> > +	struct rcu_head *head;
> > +
> > +	/* The list of objects that have now left ->head and are queued for
> > +	 * freeing after a grace period.
> > +	 */
> > +	struct rcu_head *head_free;
> > +
> > +	/* Protect concurrent access to this structure. */
> > +	spinlock_t lock;
> > +
> > +	/* The delayed work that flushes ->head to ->head_free incase ->head
> > +	 * did not reach a length of KFREE_MAX_BATCH within KFREE_DRAIN_JIFFIES.
> > +	 * In case flushing cannot be done if RCU is busy, then ->head just
> > +	 * continues to grow beyond KFREE_MAX_BATCH and we retry flushing later.
> 
> Minor one. We don't use KFREE_MAX_BATCH anymore.

Sorry for leaving these KFREE_MAX_BATCH comments stale, I cleaned up many of
them already but some where still left behind. I will fix these in the v3.

thanks for review!

 - Joel

[snip]
