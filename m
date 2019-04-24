Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48151218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfDXMtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:49:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbfDXMtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:49:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68A15AEC6;
        Wed, 24 Apr 2019 12:49:21 +0000 (UTC)
Date:   Wed, 24 Apr 2019 14:49:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] livepatch: Cleanup message handling in
 klp_try_switch_task()
Message-ID: <20190424124920.wzhr7w7pnon54pqh@pathway.suse.cz>
References: <20190424085550.29612-1-pmladek@suse.com>
 <20190424085550.29612-4-pmladek@suse.com>
 <nycvar.YFH.7.76.1904241239260.9803@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1904241239260.9803@cbobk.fhfr.pm>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-04-24 12:41:00, Jiri Kosina wrote:
> On Wed, 24 Apr 2019, Petr Mladek wrote:
> 
> > WARN_ON_ONCE() could not be called safely under rq lock because
> > of console deadlock issues. Fortunately, simple printk_deferred()
> > is enough because the warning is printed from a well defined
> > location and context.
> > 
> > Also klp_try_switch_task() is called under klp_mutex.
> > Therefore, the buffer for debug messages could be static.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  kernel/livepatch/transition.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > index 9c89ae8b337a..e8183d18227f 100644
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -254,6 +254,7 @@ static int klp_check_stack_func(struct klp_func *func,
> >  static int klp_check_stack(struct task_struct *task, char *err_buf)
> >  {
> >  	static unsigned long entries[MAX_STACK_ENTRIES];
> > +	static int enosys_warned;
> >  	struct stack_trace trace;
> >  	struct klp_object *obj;
> >  	struct klp_func *func;
> > @@ -263,8 +264,16 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
> >  	trace.nr_entries = 0;
> >  	trace.max_entries = MAX_STACK_ENTRIES;
> >  	trace.entries = entries;
> > +
> >  	ret = save_stack_trace_tsk_reliable(task, &trace);
> > -	WARN_ON_ONCE(ret == -ENOSYS);
> > +	if (ret == -ENOSYS) {
> > +		if (!enosys_warned) {
> > +			printk_deferred(KERN_WARNING "%s: save_stack_trace_tsk_reliable() not supported on this architecture.\n",
> > +					__func__);
> > +			enosys_warned = 1;
> 
> ... abusing the fact that you are also printk maintainer :) ... looking at 
> the above, wouldn't it make sense to introduce generic 
> printk_deferred_once() instead?

Yeah, I thought about it. Also pr_debug_deferred() would be useful for
the other messages passed via err_buf.

Sigh, printk_deferred() is whack-a-mole approach. We use it because
we do not have anything better for the deadlocks. I am a bit scared
to add more wrappers because it might encourage people to use it
more widely, e.g. to avoid softlockups or secure fast paths.

On the other hand, it still looks better to find all occurrences
easily instead of hiding them into a custom workarounds.

OK, I am going to prepare new patchset and involve printk
people into it.

Best Regards,
Petr
