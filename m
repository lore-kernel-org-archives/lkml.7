Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA6EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AE421655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561133935;
	bh=jyGfkM7fG0S/eAAkUrWXJbodam78wsdfmSe5B1MG8jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bd/7igd85l8o4IQJxSTG+22IABMiJ2tJ6pTabzo+1im/baU/ApJkXFWpuU4/kU+4C
	 AI1voqoFIjVgq3a4E6bJ4yM3RrAdwR1BCzxHlw+jR+gKPHLVPKRm8zn/DVPZ+dKXn/
	 +tKQQKxjfoDhyvHa7gNcCpLU5w/3XlG9qdZfry6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfFUQSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUQSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:18:53 -0400
Received: from linux-8ccs (ip5f5adbc0.dynamic.kabel-deutschland.de [95.90.219.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE782089E;
        Fri, 21 Jun 2019 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133932;
        bh=jyGfkM7fG0S/eAAkUrWXJbodam78wsdfmSe5B1MG8jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAhb2x17lxtWO0twvsUAQP7iZlj46V3TEYU1mEmAXkwXDPIhrbDVFnkp2gNRqxleU
         8+6aVGqSDuSHplh0QOOGNSDMvdfP7fDRsCbuw0UYmblHK3QoW0lNa7ljEndxyJ6J4L
         lQlqQwyAO2dNnl04U3YYnxpytNlqZPj5cF3F9s48=
Date:   Fri, 21 Jun 2019 18:18:47 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        ast@kernel.org, daniel@iogearbox.net
Subject: Re: [RFC][PATCH] module: Propagate MODULE_STATE_COMING notifier
 errors
Message-ID: <20190621161847.GA24038@linux-8ccs>
References: <20190617090335.GX3436@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.1906191251380.23337@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1906191251380.23337@pobox.suse.cz>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [19/06/19 13:12 +0200]:
>On Mon, 17 Jun 2019, Peter Zijlstra wrote:
>
>>
>> Some module notifiers; such as jump_label_module_notifier(),
>> tracepoint_module_notify(); can fail the MODULE_STATE_COMING callback
>> (due to -ENOMEM for example). However module.c:prepare_coming_module()
>> ignores all such errors, even though this function can already fail due
>> to klp_module_coming().
>
>It does, but there is no change from the pre-prepare_coming_module()
>times. Coming notifiers were called in complete_formation(), their return
>values happily ignored and going notifiers not called to clean up even
>before.
>
>> Therefore, propagate the notifier error and ensure we call the GOING
>> notifier when we do fail, to ensure cleanup for all notifiers that
>> didn't fail. Auditing all notifiers to make sure calling GOING without
>> COMING first is OK found no obvious problems with that, but it did find
>> a whole bunch of issues with return values, so clean those up too.
>
>Jessica, do you know why coming notifiers do not return errors without
>this patch (or to be precise, blocking_notifier_call_chain() return value
>is not taken into the account)? We have come across the issue couple of
>times already and I think there was a reason, but I cannot remember
>anything and the code does not help either.

I tried to do some digging but did not find a specific reason why the
return value is not taken into account. I don't think it was ever
considered. I traced it back to a commit in 2003 that introduced the
coming notifier (84486c2e135 "module load notification" in the history
repo), but even there the return value is ignored. After grepping
around it seems most usages of blocking_notifier_call_chain() just
ignore the return value.

>Also the situation around the return values themselves is not completely
>clear. If there is no NOTIFY_STOP_MASK set, only the return value of the
>last notifier called is returned, so good that you checked, Peter.
>
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3638,9 +3638,10 @@ static int prepare_coming_module(struct module *mod)
>>  	if (err)
>>  		return err;
>>
>> -	blocking_notifier_call_chain(&module_notify_list,
>> -				     MODULE_STATE_COMING, mod);
>> -	return 0;
>> +	ret = blocking_notifier_call_chain(&module_notify_list,
>> +					   MODULE_STATE_COMING, mod);
>> +	ret = notifier_to_errno(ret);
>> +	return ret;
>>  }
>>
>>  static int unknown_module_param_cb(char *param, char *val, const char *modname,
>> @@ -3780,7 +3781,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>
>>  	err = prepare_coming_module(mod);
>>  	if (err)
>> -		goto bug_cleanup;
>> +		goto coming_cleanup;
>
>Not good. klp_module_going() is not prepared to be called without
>klp_module_coming() succeeding. "Funny" things might happen.
>
>Also destroy_params() might be called without parse_args() first now.
>
>So it calls for more fine-grained error handling.

I would not mind if prepare_coming_module() was taken apart to handle the more
fine-grained error handling. Maybe something like (untested and unreviewed):

diff --git a/kernel/module.c b/kernel/module.c
index c1517053e9d6..9e470f9ae0a5 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3799,10 +3799,16 @@ static int load_module(struct load_info *info, const char __user *uargs,
        if (err)
                goto ddebug_cleanup;
 
-       err = prepare_coming_module(mod);
+       ftrace_module_enable(mod);
+       err = klp_module_coming(mod);
        if (err)
                goto bug_cleanup;
 
+       err = blocking_notifier_call_chain(&module_notify_list,
+                                    MODULE_STATE_COMING, mod);
+       if (err)
+               goto notifier_cleanup;
+
        /* Module is ready to execute: parsing args may do that. */
        after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
                                  -32768, 32767, mod,
@@ -3837,8 +3843,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
  sysfs_cleanup:
        mod_sysfs_teardown(mod);
  coming_cleanup:
-       mod->state = MODULE_STATE_GOING;
        destroy_params(mod->kp, mod->num_kp);
+notifier_cleanup:
+       mod->state = MODULE_STATE_GOING;
        blocking_notifier_call_chain(&module_notify_list,
                                     MODULE_STATE_GOING, mod);
        klp_module_going(mod);


But I think we could also still keep everything in prepare_coming_module() if
the klp hooks do get converted to notifiers.

Thanks,

Jessica
