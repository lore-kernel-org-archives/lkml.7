Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E78C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B802186A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UtzECo6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391326AbfEXRDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:03:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41934 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390960AbfEXRDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:03:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so6832009wrn.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlDKP+ImHY8gEo+CL/pDlFa1l6Ab1OQoJ+zrGXUdEuQ=;
        b=UtzECo6Jq5+8H/lMh3ZOFl3Dib0EkSEEtBomTPpK0P2vtMkt99iYEGeHzpCRlDxkR3
         E+aDnO+P7ia9y2hoCdvqqKzf09CgsZ+JPHqOU6AIuFWUQrEa0GtN9ubFAjN1wAeKQtKm
         64EGLy8CuPDsShjCVYyy+vsNPH3QNGJHklAAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlDKP+ImHY8gEo+CL/pDlFa1l6Ab1OQoJ+zrGXUdEuQ=;
        b=KS1GlAnYYNQg3O54GDmOBcC/uNg9Fz1Ewkim+I/T+Tu5f1ZVjH3aN4qMVN3irnv3r3
         AlIH3foXerkArwep6vQoasr7Ns/MXH+AUVwishEIUQ48cYLr+bDz2in5Fv38Zs6lw7yT
         3rnP/SlxIUmCOpixEudgM8UkaNLNcudRdUAncF8uFe0yMD8JCommz0Xl9I1ozxWgFX11
         3ckvp/A1VZvy0Jic3Hh92gp0AzCZtUddtKgL3HrDjVdgdeDQq05rtVxYCBloEP8unlmI
         4WXJ6rcp7w6P7OJfWweQmkof5rhqJzqM1t+s8RNQhdRlGtDVmae2N41hKCWqK9m75H30
         whAg==
X-Gm-Message-State: APjAAAW2yHGucIxvtba2/4h96ppDuKq27CTRkRUw3kXxyrpE2+Aak2z4
        q2yL49s/0wIHUcgIy55s3ZO/Hg==
X-Google-Smtp-Source: APXvYqyuTG315nDS22Lscxx6ZIBoD+gT5JkjezYbuU5OMnDLFpUBOCyFyecPTIzX9NbLTgx81em1YA==
X-Received: by 2002:adf:f909:: with SMTP id b9mr21671891wrr.119.1558717417618;
        Fri, 24 May 2019 10:03:37 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id r4sm1928306wrv.34.2019.05.24.10.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:03:37 -0700 (PDT)
Date:   Fri, 24 May 2019 19:03:28 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] rcu: Prevent evaluation of rcu_assign_pointer()
Message-ID: <20190524170328.GA7540@andrea>
References: <1558694197-19295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190524164509.GA197789@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524164509.GA197789@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:45:09PM -0400, Joel Fernandes wrote:
> On Fri, May 24, 2019 at 12:36:37PM +0200, Andrea Parri wrote:
> > Quoting Paul [1]:
> > 
> >  "Given that a quick (and perhaps error-prone) search of the uses
> >   of rcu_assign_pointer() in v5.1 didn't find a single use of the
> >   return value, let's please instead change the documentation and
> >   implementation to eliminate the return value."
> > 
> > [1] https://lkml.kernel.org/r/20190523135013.GL28207@linux.ibm.com
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: rcu@vger.kernel.org
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Sasha Levin <sashal@kernel.org>
> > ---
> > Matthew, Sasha:
> > 
> > The patch is based on -rcu/dev; I took the liberty of applying the
> > same change to your #defines in:
> > 
> >  tools/testing/radix-tree/linux/rcupdate.h
> >  tools/include/linux/rcu.h
> > 
> > but I admit that I'm not familiar with their uses: please shout if
> > you have any objections with it.
> > ---
> >  Documentation/RCU/whatisRCU.txt           |  8 ++++----
> >  include/linux/rcupdate.h                  |  5 ++---
> >  tools/include/linux/rcu.h                 | 11 +++++++++--
> >  tools/testing/radix-tree/linux/rcupdate.h |  5 ++++-
> >  4 files changed, 19 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
> > index 981651a8b65d2..f99a87b9a88fa 100644
> > --- a/Documentation/RCU/whatisRCU.txt
> > +++ b/Documentation/RCU/whatisRCU.txt
> > @@ -212,7 +212,7 @@ synchronize_rcu()
> >  
> >  rcu_assign_pointer()
> >  
> > -	typeof(p) rcu_assign_pointer(p, typeof(p) v);
> > +	rcu_assign_pointer(p, typeof(p) v);
> >  
> >  	Yes, rcu_assign_pointer() -is- implemented as a macro, though it
> >  	would be cool to be able to declare a function in this manner.
> > @@ -220,9 +220,9 @@ rcu_assign_pointer()
> >  
> >  	The updater uses this function to assign a new value to an
> >  	RCU-protected pointer, in order to safely communicate the change
> > -	in value from the updater to the reader.  This function returns
> > -	the new value, and also executes any memory-barrier instructions
> > -	required for a given CPU architecture.
> > +	in value from the updater to the reader.  This macro does not
> > +	evaluate to an rvalue, but it does execute any memory-barrier
> > +	instructions required for a given CPU architecture.
> >  
> >  	Perhaps just as important, it serves to document (1) which
> >  	pointers are protected by RCU and (2) the point at which a
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 915460ec08722..a5f61a08e65fc 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -367,7 +367,7 @@ static inline void rcu_preempt_sleep_check(void) { }
> >   * other macros that it invokes.
> >   */
> >  #define rcu_assign_pointer(p, v)					      \
> > -({									      \
> > +do {									      \
> >  	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
> >  	rcu_check_sparse(p, __rcu);				      \
> >  									      \
> > @@ -375,8 +375,7 @@ static inline void rcu_preempt_sleep_check(void) { }
> >  		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
> >  	else								      \
> >  		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
> > -	_r_a_p__v;							      \
> > -})
> > +} while (0)
> >  
> >  /**
> >   * rcu_swap_protected() - swap an RCU and a regular pointer
> > diff --git a/tools/include/linux/rcu.h b/tools/include/linux/rcu.h
> > index 7d02527e5bcea..01a435ee48cd6 100644
> > --- a/tools/include/linux/rcu.h
> > +++ b/tools/include/linux/rcu.h
> > @@ -19,7 +19,14 @@ static inline bool rcu_is_watching(void)
> >  	return false;
> >  }
> >  
> > -#define rcu_assign_pointer(p, v) ((p) = (v))
> > -#define RCU_INIT_POINTER(p, v) p=(v)
> > +#define rcu_assign_pointer(p, v)				\
> > +do {								\
> > +	(p) = (v);						\
> > +} while (0)
> > +
> > +#define RCU_INIT_POINTER(p, v)					\
> > +do {								\
> > +	(p) = (v);						\
> > +} while (0)
> >  
> >  #endif
> > diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/radix-tree/linux/rcupdate.h
> > index fd280b070fdb1..48212f3a758e6 100644
> > --- a/tools/testing/radix-tree/linux/rcupdate.h
> > +++ b/tools/testing/radix-tree/linux/rcupdate.h
> > @@ -7,6 +7,9 @@
> >  #define rcu_dereference_raw(p) rcu_dereference(p)
> >  #define rcu_dereference_protected(p, cond) rcu_dereference(p)
> >  #define rcu_dereference_check(p, cond) rcu_dereference(p)
> > -#define RCU_INIT_POINTER(p, v)	(p) = (v)
> > +#define RCU_INIT_POINTER(p, v)					\
> > +do {								\
> > +	(p) = (v);						\
> > +} while (0)
> >  
> >  #endif
> > -- 
> > 2.7.4
> > 
> 
> Other than Paul's nits, LGTM. Thanks.

Thank you, Joel!  Will fix those and resend, most likely next week.

  Andrea
