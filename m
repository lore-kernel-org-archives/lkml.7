Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC61C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 15:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CA820B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 15:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hf+jiQCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDGPqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 11:46:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38708 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDGPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 11:46:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id g1so6569459qki.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4GIJB955PzZfXeP+EuyrEPWc7wpuSZVjSPd4xpMTPCg=;
        b=hf+jiQCNmNoGfDBJmXNO+a281p71AWgV8Eb9gCXrZ9u8pySB7ySIaVob+K0uxCaZF7
         eiagIXY3bk9akIOg+zp2zm26a05QjJ/LeIzR486bqjlHVjYqfhBoG5ieZCcQLHwiJ5dl
         2699BWvQKu5pbSD9TclCZq8v840xxfODsB7W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4GIJB955PzZfXeP+EuyrEPWc7wpuSZVjSPd4xpMTPCg=;
        b=Ss5RT5W8nukqzoFcjt0VnaGoFvl3QGSzxVC6r72jcJdR/Wnt3oWMxAcnctx9AFgCOT
         WdruG26ovIeQTyVapBUjBHeH22BNct5FLG8FZpXWNUqTU//vqCuxp2KIg8gAlmjUzjV+
         1YpgOx/+H1gGxQL73oO+rIf9Ng/RzqdzgG3nXfLMMHM8o7+/m3tLIZav3XC+aDA2Sjkn
         1KbubO1AUK5pHkoRsSatD3T+oTk6Vigu4t1UKrYkwpq+65ycwXXf4vsZIwi9AMUhheG9
         Vl408UQN3HELnlXOws5n8dUAN+eBXIHRpAT8gGc/WseAcTeqsA5NBe68wIOi/qOaqDFP
         3HyA==
X-Gm-Message-State: APjAAAWlgq7AcXGqKUDwEun5/f/QAnwCJwY2f3gLYmesAhpsZAfLzYJM
        LRVQIf6qxFvgaRDxIrZOu6wAmg==
X-Google-Smtp-Source: APXvYqzKea+GLCWCXj2YDBsSVfygt4sMYpYyUFE5waBBltFTzsfzufc6kOafPuc+LnRQYlttULJXiQ==
X-Received: by 2002:ae9:f44a:: with SMTP id z10mr19446400qkl.223.1554651976758;
        Sun, 07 Apr 2019 08:46:16 -0700 (PDT)
Received: from localhost (c-73-216-90-110.hsd1.va.comcast.net. [73.216.90.110])
        by smtp.gmail.com with ESMTPSA id x15sm13712804qkh.13.2019.04.07.08.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 08:46:15 -0700 (PDT)
Date:   Sun, 7 Apr 2019 15:46:13 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Message-ID: <20190407154613.GA2770@localhost>
References: <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com>
 <20190402152334.GC4102@linux.ibm.com>
 <161156422.1435.1554219247444.JavaMail.zimbra@efficios.com>
 <20190403133243.GE4102@linux.ibm.com>
 <1028306587.504.1554301662374.JavaMail.zimbra@efficios.com>
 <20190403162039.GA14111@linux.ibm.com>
 <20190405232835.GA24702@linux.ibm.com>
 <20190406230613.GA187766@google.com>
 <20190407133941.GC14111@linux.ibm.com>
 <20190407135937.GA30053@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407135937.GA30053@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 06:59:37AM -0700, Paul E. McKenney wrote:
> On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
> > On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
> 
> [ . . . ]
> 
> > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > > index f8f6f04c4453..c2d919a1566e 100644
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > @@ -338,6 +338,10 @@
> > > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> > > >  		__stop___tracepoints_ptrs = .;				\
> > > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> > > > +		. = ALIGN(8);						\
> > > > +		__start___srcu_struct = .;				\
> > > > +		*(___srcu_struct_ptrs)					\
> > > > +		__end___srcu_struct = .;				\
> > > >  	}								\
> > > 
> > > This vmlinux linker modification is not needed. I tested without it and srcu
> > > torture works fine with rcutorture built as a module. Putting further prints
> > > in kernel/module.c verified that the kernel is able to find the srcu structs
> > > just fine. You could squash the below patch into this one or apply it on top
> > > of the dev branch.
> > 
> > Good point, given that otherwise FORTRAN named common blocks would not
> > work.
> > 
> > But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
> > macro that it can be mapped read-only?  Or am I suffering from excessive
> > optimism?
> 
> And to answer the other question, in the case where I am suffering from
> excessive optimism, it should be a separate commit.  Please see below
> for the updated original commit thus far.
>

Actually the vmlinux.lds.h file is unused for module building. For ex, if you
delete include/asm-generic/vmlinux.lds.h , then you can still build
rcutorture.ko. Did I miss something obvious? In that case the vmlinux.lds.h
are not needed since the __section annotations automatically place the srcu
structs in a separate section.

Let me know if you would like me to send a patch separately, or if the
appended patch for the same in my previous email suffices.

> And may I have your Tested-by?

Absolutely, please do and thanks!

 - Joel


> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit a365bb5f6eafb220a1448674054b05c250829313
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Fri Apr 5 16:15:00 2019 -0700
> 
>     srcu: Allocate per-CPU data for DEFINE_SRCU() in modules
>     
>     Adding DEFINE_SRCU() or DEFINE_STATIC_SRCU() to a loadable module requires
>     that the size of the reserved region be increased, which is not something
>     we want to be doing all that often.  One approach would be to require
>     that loadable modules define an srcu_struct and invoke init_srcu_struct()
>     from their module_init function and cleanup_srcu_struct() from their
>     module_exit function.  However, this is more than a bit user unfriendly.
>     
>     This commit therefore creates an ___srcu_struct_ptrs linker section,
>     and pointers to srcu_struct structures created by DEFINE_SRCU() and
>     DEFINE_STATIC_SRCU() within a module are placed into that module's
>     ___srcu_struct_ptrs section.  The required init_srcu_struct() and
>     cleanup_srcu_struct() functions are then automatically invoked as needed
>     when that module is loaded and unloaded, thus allowing modules to continue
>     to use DEFINE_SRCU() and DEFINE_STATIC_SRCU() while avoiding the need
>     to increase the size of the reserved region.
>     
>     Many of the algorithms and some of the code was cheerfully cherry-picked
>     from other code making use of linker sections, perhaps most notably from
>     tracepoints.  All bugs are nevertheless the sole property of the author.
>     
>     Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>     [ paulmck: Use __section() and use "default" in srcu_module_notify()'s
>       "switch" statement as suggested by Joel Fernandes. ]
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index f8f6f04c4453..c2d919a1566e 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -338,6 +338,10 @@
>  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>  		__stop___tracepoints_ptrs = .;				\
>  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> +		. = ALIGN(8);						\
> +		__start___srcu_struct = .;				\
> +		*(___srcu_struct_ptrs)					\
> +		__end___srcu_struct = .;				\
>  	}								\
>  									\
>  	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 5bf5dcd91009..921443a026dd 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -21,6 +21,7 @@
>  #include <linux/rbtree_latch.h>
>  #include <linux/error-injection.h>
>  #include <linux/tracepoint-defs.h>
> +#include <linux/srcu.h>
>  
>  #include <linux/percpu.h>
>  #include <asm/module.h>
> @@ -448,6 +449,10 @@ struct module {
>  	unsigned int num_tracepoints;
>  	tracepoint_ptr_t *tracepoints_ptrs;
>  #endif
> +#ifdef CONFIG_TREE_SRCU
> +	unsigned int num_srcu_structs;
> +	struct srcu_struct **srcu_struct_ptrs;
> +#endif
>  #ifdef CONFIG_BPF_EVENTS
>  	unsigned int num_bpf_raw_events;
>  	struct bpf_raw_event_map *bpf_raw_events;
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 7f7c8c050f63..8af1824c46a8 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -120,9 +120,17 @@ struct srcu_struct {
>   *
>   * See include/linux/percpu-defs.h for the rules on per-CPU variables.
>   */
> -#define __DEFINE_SRCU(name, is_static)					\
> -	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);\
> -	is_static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name##_srcu_data)
> +#ifdef MODULE
> +# define __DEFINE_SRCU(name, is_static)					\
> +	is_static struct srcu_struct name;				\
> +	struct srcu_struct *__srcu_struct_##name			\
> +		__section("___srcu_struct_ptrs") = &name
> +#else
> +# define __DEFINE_SRCU(name, is_static)					\
> +	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
> +	is_static struct srcu_struct name =				\
> +		__SRCU_STRUCT_INIT(name, name##_srcu_data)
> +#endif
>  #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
>  #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
>  
> diff --git a/kernel/module.c b/kernel/module.c
> index 0b9aa8ab89f0..524da609c884 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3093,6 +3093,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  					     sizeof(*mod->tracepoints_ptrs),
>  					     &mod->num_tracepoints);
>  #endif
> +#ifdef CONFIG_TREE_SRCU
> +	mod->srcu_struct_ptrs = section_objs(info, "___srcu_struct_ptrs",
> +					     sizeof(*mod->srcu_struct_ptrs),
> +					     &mod->num_srcu_structs);
> +#endif
>  #ifdef CONFIG_BPF_EVENTS
>  	mod->bpf_raw_events = section_objs(info, "__bpf_raw_tp_map",
>  					   sizeof(*mod->bpf_raw_events),
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 9b761e546de8..2ded2614a2f4 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1310,3 +1310,68 @@ void __init srcu_init(void)
>  		queue_work(rcu_gp_wq, &ssp->work.work);
>  	}
>  }
> +
> +#ifdef CONFIG_MODULES
> +
> +/* Initialize any global-scope srcu_struct structures used by this module. */
> +static int srcu_module_coming(struct module *mod)
> +{
> +	int i;
> +	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> +	int ret;
> +
> +	for (i = 0; i < mod->num_srcu_structs; i++) {
> +		ret = init_srcu_struct(*(sspp++));
> +		if (WARN_ON_ONCE(ret))
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +/* Clean up any global-scope srcu_struct structures used by this module. */
> +static void srcu_module_going(struct module *mod)
> +{
> +	int i;
> +	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> +
> +	for (i = 0; i < mod->num_srcu_structs; i++)
> +		cleanup_srcu_struct(*(sspp++));
> +}
> +
> +/* Handle one module, either coming or going. */
> +static int srcu_module_notify(struct notifier_block *self,
> +			      unsigned long val, void *data)
> +{
> +	struct module *mod = data;
> +	int ret = 0;
> +
> +	switch (val) {
> +	case MODULE_STATE_COMING:
> +		ret = srcu_module_coming(mod);
> +		break;
> +	case MODULE_STATE_GOING:
> +		srcu_module_going(mod);
> +		break;
> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static struct notifier_block srcu_module_nb = {
> +	.notifier_call = srcu_module_notify,
> +	.priority = 0,
> +};
> +
> +static __init int init_srcu_module_notifier(void)
> +{
> +	int ret;
> +
> +	ret = register_module_notifier(&srcu_module_nb);
> +	if (ret)
> +		pr_warn("Failed to register srcu module notifier\n");
> +	return ret;
> +}
> +late_initcall(init_srcu_module_notifier);
> +
> +#endif /* #ifdef CONFIG_MODULES */
> 
