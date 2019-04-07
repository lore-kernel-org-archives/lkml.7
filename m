Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506ECC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C1D20880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfDGRFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 13:05:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbfDGRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 13:05:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x37H46Nu082018
        for <linux-kernel@vger.kernel.org>; Sun, 7 Apr 2019 13:05:22 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rq9pr4tf6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 13:05:21 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 7 Apr 2019 18:05:20 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 7 Apr 2019 18:05:15 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x37H5E7423527502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Apr 2019 17:05:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AFAFB2065;
        Sun,  7 Apr 2019 17:05:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2B5EB2068;
        Sun,  7 Apr 2019 17:05:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.136.16])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  7 Apr 2019 17:05:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C55D416C0FB0; Sun,  7 Apr 2019 10:05:14 -0700 (PDT)
Date:   Sun, 7 Apr 2019 10:05:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Reply-To: paulmck@linux.ibm.com
References: <20190402152334.GC4102@linux.ibm.com>
 <161156422.1435.1554219247444.JavaMail.zimbra@efficios.com>
 <20190403133243.GE4102@linux.ibm.com>
 <1028306587.504.1554301662374.JavaMail.zimbra@efficios.com>
 <20190403162039.GA14111@linux.ibm.com>
 <20190405232835.GA24702@linux.ibm.com>
 <20190406230613.GA187766@google.com>
 <20190407133941.GC14111@linux.ibm.com>
 <20190407135937.GA30053@linux.ibm.com>
 <20190407154613.GA2770@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407154613.GA2770@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040717-0052-0000-0000-000003A8B565
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010884; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01185722; UDB=6.00620947; IPR=6.00966469;
 MB=3.00026331; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-07 17:05:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040717-0053-0000-0000-0000606A27D0
Message-Id: <20190407170514.GE14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904070160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 03:46:13PM +0000, Joel Fernandes wrote:
> On Sun, Apr 07, 2019 at 06:59:37AM -0700, Paul E. McKenney wrote:
> > On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
> > > On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
> > 
> > [ . . . ]
> > 
> > > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > > > index f8f6f04c4453..c2d919a1566e 100644
> > > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > > @@ -338,6 +338,10 @@
> > > > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> > > > >  		__stop___tracepoints_ptrs = .;				\
> > > > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> > > > > +		. = ALIGN(8);						\
> > > > > +		__start___srcu_struct = .;				\
> > > > > +		*(___srcu_struct_ptrs)					\
> > > > > +		__end___srcu_struct = .;				\
> > > > >  	}								\
> > > > 
> > > > This vmlinux linker modification is not needed. I tested without it and srcu
> > > > torture works fine with rcutorture built as a module. Putting further prints
> > > > in kernel/module.c verified that the kernel is able to find the srcu structs
> > > > just fine. You could squash the below patch into this one or apply it on top
> > > > of the dev branch.
> > > 
> > > Good point, given that otherwise FORTRAN named common blocks would not
> > > work.
> > > 
> > > But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
> > > macro that it can be mapped read-only?  Or am I suffering from excessive
> > > optimism?
> > 
> > And to answer the other question, in the case where I am suffering from
> > excessive optimism, it should be a separate commit.  Please see below
> > for the updated original commit thus far.
> 
> Actually the vmlinux.lds.h file is unused for module building. For ex, if you
> delete include/asm-generic/vmlinux.lds.h , then you can still build
> rcutorture.ko. Did I miss something obvious? In that case the vmlinux.lds.h
> are not needed since the __section annotations automatically place the srcu
> structs in a separate section.

Hard to argue given that I just deleted include/asm-generic/vmlinux.lds.h,
touched kernel/rcu/rcutorture.c, and rebuilt the corresponding .ko
without errors.  ;-)

Hmmm...  Is there some way to place a section into a read-only page,
for example, tagged onto the text section for that module?  That would
get rid of a class of bugs, if nothing else.

> Let me know if you would like me to send a patch separately, or if the
> appended patch for the same in my previous email suffices.

Please do resend as a formal patch with the above in the commit log.
I doubt that I am the only one needing a bit of module-build education!
And thank you for providing that education, by the way!

> > And may I have your Tested-by?
> 
> Absolutely, please do and thanks!

Done, and thank you for giving it a go!

							Thanx, Paul

>  - Joel
> 
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit a365bb5f6eafb220a1448674054b05c250829313
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Fri Apr 5 16:15:00 2019 -0700
> > 
> >     srcu: Allocate per-CPU data for DEFINE_SRCU() in modules
> >     
> >     Adding DEFINE_SRCU() or DEFINE_STATIC_SRCU() to a loadable module requires
> >     that the size of the reserved region be increased, which is not something
> >     we want to be doing all that often.  One approach would be to require
> >     that loadable modules define an srcu_struct and invoke init_srcu_struct()
> >     from their module_init function and cleanup_srcu_struct() from their
> >     module_exit function.  However, this is more than a bit user unfriendly.
> >     
> >     This commit therefore creates an ___srcu_struct_ptrs linker section,
> >     and pointers to srcu_struct structures created by DEFINE_SRCU() and
> >     DEFINE_STATIC_SRCU() within a module are placed into that module's
> >     ___srcu_struct_ptrs section.  The required init_srcu_struct() and
> >     cleanup_srcu_struct() functions are then automatically invoked as needed
> >     when that module is loaded and unloaded, thus allowing modules to continue
> >     to use DEFINE_SRCU() and DEFINE_STATIC_SRCU() while avoiding the need
> >     to increase the size of the reserved region.
> >     
> >     Many of the algorithms and some of the code was cheerfully cherry-picked
> >     from other code making use of linker sections, perhaps most notably from
> >     tracepoints.  All bugs are nevertheless the sole property of the author.
> >     
> >     Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >     [ paulmck: Use __section() and use "default" in srcu_module_notify()'s
> >       "switch" statement as suggested by Joel Fernandes. ]
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index f8f6f04c4453..c2d919a1566e 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -338,6 +338,10 @@
> >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> >  		__stop___tracepoints_ptrs = .;				\
> >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> > +		. = ALIGN(8);						\
> > +		__start___srcu_struct = .;				\
> > +		*(___srcu_struct_ptrs)					\
> > +		__end___srcu_struct = .;				\
> >  	}								\
> >  									\
> >  	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 5bf5dcd91009..921443a026dd 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -21,6 +21,7 @@
> >  #include <linux/rbtree_latch.h>
> >  #include <linux/error-injection.h>
> >  #include <linux/tracepoint-defs.h>
> > +#include <linux/srcu.h>
> >  
> >  #include <linux/percpu.h>
> >  #include <asm/module.h>
> > @@ -448,6 +449,10 @@ struct module {
> >  	unsigned int num_tracepoints;
> >  	tracepoint_ptr_t *tracepoints_ptrs;
> >  #endif
> > +#ifdef CONFIG_TREE_SRCU
> > +	unsigned int num_srcu_structs;
> > +	struct srcu_struct **srcu_struct_ptrs;
> > +#endif
> >  #ifdef CONFIG_BPF_EVENTS
> >  	unsigned int num_bpf_raw_events;
> >  	struct bpf_raw_event_map *bpf_raw_events;
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 7f7c8c050f63..8af1824c46a8 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -120,9 +120,17 @@ struct srcu_struct {
> >   *
> >   * See include/linux/percpu-defs.h for the rules on per-CPU variables.
> >   */
> > -#define __DEFINE_SRCU(name, is_static)					\
> > -	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);\
> > -	is_static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name##_srcu_data)
> > +#ifdef MODULE
> > +# define __DEFINE_SRCU(name, is_static)					\
> > +	is_static struct srcu_struct name;				\
> > +	struct srcu_struct *__srcu_struct_##name			\
> > +		__section("___srcu_struct_ptrs") = &name
> > +#else
> > +# define __DEFINE_SRCU(name, is_static)					\
> > +	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
> > +	is_static struct srcu_struct name =				\
> > +		__SRCU_STRUCT_INIT(name, name##_srcu_data)
> > +#endif
> >  #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
> >  #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
> >  
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 0b9aa8ab89f0..524da609c884 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -3093,6 +3093,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
> >  					     sizeof(*mod->tracepoints_ptrs),
> >  					     &mod->num_tracepoints);
> >  #endif
> > +#ifdef CONFIG_TREE_SRCU
> > +	mod->srcu_struct_ptrs = section_objs(info, "___srcu_struct_ptrs",
> > +					     sizeof(*mod->srcu_struct_ptrs),
> > +					     &mod->num_srcu_structs);
> > +#endif
> >  #ifdef CONFIG_BPF_EVENTS
> >  	mod->bpf_raw_events = section_objs(info, "__bpf_raw_tp_map",
> >  					   sizeof(*mod->bpf_raw_events),
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 9b761e546de8..2ded2614a2f4 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1310,3 +1310,68 @@ void __init srcu_init(void)
> >  		queue_work(rcu_gp_wq, &ssp->work.work);
> >  	}
> >  }
> > +
> > +#ifdef CONFIG_MODULES
> > +
> > +/* Initialize any global-scope srcu_struct structures used by this module. */
> > +static int srcu_module_coming(struct module *mod)
> > +{
> > +	int i;
> > +	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> > +	int ret;
> > +
> > +	for (i = 0; i < mod->num_srcu_structs; i++) {
> > +		ret = init_srcu_struct(*(sspp++));
> > +		if (WARN_ON_ONCE(ret))
> > +			return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/* Clean up any global-scope srcu_struct structures used by this module. */
> > +static void srcu_module_going(struct module *mod)
> > +{
> > +	int i;
> > +	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> > +
> > +	for (i = 0; i < mod->num_srcu_structs; i++)
> > +		cleanup_srcu_struct(*(sspp++));
> > +}
> > +
> > +/* Handle one module, either coming or going. */
> > +static int srcu_module_notify(struct notifier_block *self,
> > +			      unsigned long val, void *data)
> > +{
> > +	struct module *mod = data;
> > +	int ret = 0;
> > +
> > +	switch (val) {
> > +	case MODULE_STATE_COMING:
> > +		ret = srcu_module_coming(mod);
> > +		break;
> > +	case MODULE_STATE_GOING:
> > +		srcu_module_going(mod);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	return ret;
> > +}
> > +
> > +static struct notifier_block srcu_module_nb = {
> > +	.notifier_call = srcu_module_notify,
> > +	.priority = 0,
> > +};
> > +
> > +static __init int init_srcu_module_notifier(void)
> > +{
> > +	int ret;
> > +
> > +	ret = register_module_notifier(&srcu_module_nb);
> > +	if (ret)
> > +		pr_warn("Failed to register srcu module notifier\n");
> > +	return ret;
> > +}
> > +late_initcall(init_srcu_module_notifier);
> > +
> > +#endif /* #ifdef CONFIG_MODULES */
> > 
> 

