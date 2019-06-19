Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1854BC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDC4214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfFSLMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:12:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbfFSLMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:12:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15634AE74;
        Wed, 19 Jun 2019 11:12:14 +0000 (UTC)
Date:   Wed, 19 Jun 2019 13:12:12 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [RFC][PATCH] module: Propagate MODULE_STATE_COMING notifier
 errors
In-Reply-To: <20190617090335.GX3436@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.1906191251380.23337@pobox.suse.cz>
References: <20190617090335.GX3436@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Peter Zijlstra wrote:

> 
> Some module notifiers; such as jump_label_module_notifier(),
> tracepoint_module_notify(); can fail the MODULE_STATE_COMING callback
> (due to -ENOMEM for example). However module.c:prepare_coming_module()
> ignores all such errors, even though this function can already fail due
> to klp_module_coming().

It does, but there is no change from the pre-prepare_coming_module() 
times. Coming notifiers were called in complete_formation(), their return 
values happily ignored and going notifiers not called to clean up even 
before.

> Therefore, propagate the notifier error and ensure we call the GOING
> notifier when we do fail, to ensure cleanup for all notifiers that
> didn't fail. Auditing all notifiers to make sure calling GOING without
> COMING first is OK found no obvious problems with that, but it did find
> a whole bunch of issues with return values, so clean those up too.

Jessica, do you know why coming notifiers do not return errors without 
this patch (or to be precise, blocking_notifier_call_chain() return value 
is not taken into the account)? We have come across the issue couple of 
times already and I think there was a reason, but I cannot remember 
anything and the code does not help either.

Also the situation around the return values themselves is not completely 
clear. If there is no NOTIFY_STOP_MASK set, only the return value of the 
last notifier called is returned, so good that you checked, Peter.
 
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3638,9 +3638,10 @@ static int prepare_coming_module(struct module *mod)
>  	if (err)
>  		return err;
>  
> -	blocking_notifier_call_chain(&module_notify_list,
> -				     MODULE_STATE_COMING, mod);
> -	return 0;
> +	ret = blocking_notifier_call_chain(&module_notify_list,
> +					   MODULE_STATE_COMING, mod);
> +	ret = notifier_to_errno(ret);
> +	return ret;
>  }
>  
>  static int unknown_module_param_cb(char *param, char *val, const char *modname,
> @@ -3780,7 +3781,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  
>  	err = prepare_coming_module(mod);
>  	if (err)
> -		goto bug_cleanup;
> +		goto coming_cleanup;

Not good. klp_module_going() is not prepared to be called without 
klp_module_coming() succeeding. "Funny" things might happen.

Also destroy_params() might be called without parse_args() first now.

So it calls for more fine-grained error handling.

Miroslav
