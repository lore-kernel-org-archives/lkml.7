Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C3DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B508208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfDXStA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:49:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:56218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbfDXSs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:48:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 980EAACD8;
        Wed, 24 Apr 2019 18:48:58 +0000 (UTC)
Date:   Wed, 24 Apr 2019 20:48:58 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] livepatch: Cleanup message handling in
 klp_try_switch_task()
In-Reply-To: <20190424155532.3uyxyxwm4c5dqsf5@treble>
Message-ID: <alpine.LSU.2.21.1904242045360.30239@pobox.suse.cz>
References: <20190424085550.29612-1-pmladek@suse.com> <20190424085550.29612-4-pmladek@suse.com> <20190424155532.3uyxyxwm4c5dqsf5@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Josh Poimboeuf wrote:

> On Wed, Apr 24, 2019 at 10:55:50AM +0200, Petr Mladek wrote:
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
> > +		}
> > +		return ret;
> > +	}
> 
> We already have a similar printk in patch 1, so is this warning really
> needed?

I don't think so. pr_warn() in klp_enable_patch() should be enough in my 
opinion.

However,

if (ret == -ENOSYS)
	return ret;

would be justified, wouldn't it?

Miroslav
