Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4406CC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8F520665
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfFSL4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfFSL4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:56:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39582AF7C;
        Wed, 19 Jun 2019 11:56:43 +0000 (UTC)
Date:   Wed, 19 Jun 2019 13:56:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, rostedt@goodmis.org,
        ast@kernel.org, daniel@iogearbox.net
Subject: Re: [RFC][PATCH] module: Propagate MODULE_STATE_COMING notifier
 errors
Message-ID: <20190619115642.xzemjebbbl2llabu@pathway.suse.cz>
References: <20190617090335.GX3436@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.1906191251380.23337@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1906191251380.23337@pobox.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-06-19 13:12:12, Miroslav Benes wrote:
> On Mon, 17 Jun 2019, Peter Zijlstra wrote:
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -3638,9 +3638,10 @@ static int prepare_coming_module(struct module *mod)
> >  	if (err)
> >  		return err;
> >  
> > -	blocking_notifier_call_chain(&module_notify_list,
> > -				     MODULE_STATE_COMING, mod);
> > -	return 0;
> > +	ret = blocking_notifier_call_chain(&module_notify_list,
> > +					   MODULE_STATE_COMING, mod);
> > +	ret = notifier_to_errno(ret);
> > +	return ret;
> >  }
> >  
> >  static int unknown_module_param_cb(char *param, char *val, const char *modname,
> > @@ -3780,7 +3781,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >  
> >  	err = prepare_coming_module(mod);
> >  	if (err)
> > -		goto bug_cleanup;
> > +		goto coming_cleanup;
> 
> Not good. klp_module_going() is not prepared to be called without 
> klp_module_coming() succeeding. "Funny" things might happen.

We have discussed it with Miroslav. The best solution seems to
be to allow to call klp_module_going() even when
klp_module_comming() failed. Something like:

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index c4ce08f43bd6..42d72b62edb2 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1188,6 +1188,10 @@ void klp_module_going(struct module *mod)
                return;
 
        mutex_lock(&klp_mutex);
+
+       /* Nope when klp_module_comming failed */
+       if (!mod->klp_alive)
+               goto out;
        /*
         * Each module has to know that klp_module_going()
         * has been called. We never know what module will
@@ -1196,7 +1200,7 @@ void klp_module_going(struct module *mod)
        mod->klp_alive = false;
 
        klp_cleanup_module_patches_limited(mod, NULL);
-
+out:
        mutex_unlock(&klp_mutex);
 }

Peter's patch actually allows to convert the klp hooks into
proper module notifiers. But we could do it later once this
patch is upstream or queued.

Best Regards,
Petr
