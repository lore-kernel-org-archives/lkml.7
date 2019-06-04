Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A2CC28D18
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E8E20651
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Zj/4RsKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFDX5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:57:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46292 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfFDX5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:57:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so13658309pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1RoeYwTbHJ5uZrqzOkCL/eOap3xEJq8UUohxtmtls+0=;
        b=Zj/4RsKSPEX80sxrowiW9yJRYHKyPgNTX80646pPhD24cF78L+/cbq0AbaGX9N2dlW
         NbcaJdsi+uqQaXkEEuBCyBbDTXEvFRlnvVcH9GuGiMzwzkWU5HOPuyPDk8tLI4VkyyJv
         /DfRIx8bv02qOCZ6ndDiCIPf3hcKSC8m4VzgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1RoeYwTbHJ5uZrqzOkCL/eOap3xEJq8UUohxtmtls+0=;
        b=pWwuFi3k2lVH+uqysRUOC8r35O/nTpSJb1hx9yw70RTErHjlmvD4bffGkM6MQ0h9j/
         hOhMqF4enbbMm/9oJpEP0h4jJK1mW97TWlZH5OZuD+WY6fgH+BSUeN/yveZ9S5UcX4he
         RYznrhZfDNHjNtEZXQ+Wraue+mQI+k8kjoJQdF1MvItLzF7FNMGq3z9v7/WRAMhpUjHI
         LBQMK+LiGEFpk0RZLUeOFE9K9YDjRYyZzGGHy51PEpYcdqIGwgCKMsfTJvXtKBJ96igt
         TEp382YneaCa5x4bYmI4a9VpcTE3k2P4dpq2ekfnLFFpl6jW22yPK6gBKqwTg4lhOgjj
         oR6Q==
X-Gm-Message-State: APjAAAXHWiLWibbqfy/n7a8nltpVhz/xRZtJMLLRZsX9jK8veObba+VN
        FegL7N43unvVmFa5ClsApI18cg==
X-Google-Smtp-Source: APXvYqwkrc7X/bmQxCzpV30LpH7ErQ3xZfm3AlJzfVuoa5nXjkO6dIGfsOoh599VuAPN4rqorLCkOA==
X-Received: by 2002:a17:90a:a790:: with SMTP id f16mr40544193pjq.27.1559692657614;
        Tue, 04 Jun 2019 16:57:37 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q13sm34687078pjc.1.2019.06.04.16.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 16:57:36 -0700 (PDT)
Date:   Tue, 4 Jun 2019 19:57:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [RFC 1/6] rcu: Add support for consolidated-RCU reader checking
Message-ID: <20190604235735.GA254287@google.com>
References: <20190601222738.6856-1-joel@joelfernandes.org>
 <20190601222738.6856-2-joel@joelfernandes.org>
 <0ff9e0e3-b9fb-8953-1f76-807102f785ee@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff9e0e3-b9fb-8953-1f76-807102f785ee@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 04:01:00PM +0200, Rasmus Villemoes wrote:
> On 02/06/2019 00.27, Joel Fernandes (Google) wrote:
> > This patch adds support for checking RCU reader sections in list
> > traversal macros. Optionally, if the list macro is called under SRCU or
> > other lock/mutex protection, then appropriate lockdep expressions can be
> > passed to make the checks pass.
> > 
> > Existing list_for_each_entry_rcu() invocations don't need to pass the
> > optional fourth argument (cond) unless they are under some non-RCU
> > protection and needs to make lockdep check pass.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  include/linux/rculist.h  | 40 ++++++++++++++++++++++++++++++++++++----
> >  include/linux/rcupdate.h |  7 +++++++
> >  kernel/rcu/update.c      | 26 ++++++++++++++++++++++++++
> >  3 files changed, 69 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > index e91ec9ddcd30..b641fdd9f1a2 100644
> > --- a/include/linux/rculist.h
> > +++ b/include/linux/rculist.h
> > @@ -40,6 +40,25 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> >   */
> >  #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
> >  
> > +/*
> > + * Check during list traversal that we are within an RCU reader
> > + */
> > +#define __list_check_rcu()						\
> > +	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),			\
> > +			 "RCU-list traversed in non-reader section!")
> > +
> > +static inline void __list_check_rcu_cond(int dummy, ...)
> > +{
> > +	va_list ap;
> > +	int cond;
> > +
> > +	va_start(ap, dummy);
> > +	cond = va_arg(ap, int);
> > +	va_end(ap);
> > +
> > +	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),
> > +			 "RCU-list traversed in non-reader section!");
> > +}
> >  /*
> >   * Insert a new entry between two known consecutive entries.
> >   *
> > @@ -338,6 +357,9 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
> >  						  member) : NULL; \
> >  })
> >  
> > +#define SIXTH_ARG(a1, a2, a3, a4, a5, a6, ...) a6
> > +#define COUNT_VARGS(...) SIXTH_ARG(dummy, ## __VA_ARGS__, 4, 3, 2, 1, 0)
> > +>  /**
> >   * list_for_each_entry_rcu	-	iterate over rcu list of given type
> >   * @pos:	the type * to use as a loop cursor.
> > @@ -348,9 +370,14 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
> >   * the _rcu list-mutation primitives such as list_add_rcu()
> >   * as long as the traversal is guarded by rcu_read_lock().
> >   */
> > -#define list_for_each_entry_rcu(pos, head, member) \
> > -	for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
> > -		&pos->member != (head); \
> > +#define list_for_each_entry_rcu(pos, head, member, cond...)		\
> > +	if (COUNT_VARGS(cond) != 0) {					\
> > +		__list_check_rcu_cond(0, ## cond);			\
> > +	} else {							\
> > +		__list_check_rcu();					\
> > +	}								\
> > +	for (pos = list_entry_rcu((head)->next, typeof(*pos), member);	\
> > +		&pos->member != (head);					\
> >  		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
> 
> Wouldn't something as simple as
> 
> #define __list_check_rcu(dummy, cond, ...) \
>        RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(), \
> 			 "RCU-list traversed in non-reader section!");
> 
> for ( ({ __list_check_rcu(junk, ##cond, 0); }), pos = ... )
> 
> work just as well (i.e., no need for two list_check_rcu and
> list_check_rcu_cond variants)? If there's an optional cond, we use that,
> if not, we pick the trailing 0, so !cond disappears and it reduces to
> your __list_check_rcu(). Moreover, this ensures the RCU_LOCKDEP_WARN
> expansion actually picks up the __LINE__ and __FILE__ where the for loop
> is used, and not the __FILE__ and __LINE__ of the static inline function
> from the header file. It also makes it a bit more type safe/type generic
> (if the cond expression happened to have type long or u64 something
> rather odd could happen with the inline vararg function).

This is much better. I will do it this way. Thank you!

 - Joel

