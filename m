Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96317C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FD32087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfCHPJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:09:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:52642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbfCHPJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:09:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06839AB71;
        Fri,  8 Mar 2019 15:09:14 +0000 (UTC)
Date:   Fri, 8 Mar 2019 16:09:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] printk: Introduce per-console loglevel setting
Message-ID: <20190308150914.ifqp36en3pyd4ljy@pathway.suse.cz>
References: <cover.1551486732.git.calvinowens@fb.com>
 <06cd267ef5439a9391368423b608959f5f1b1a63.1551486732.git.calvinowens@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06cd267ef5439a9391368423b608959f5f1b1a63.1551486732.git.calvinowens@fb.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-01 16:48:17, Calvin Owens wrote:
> Not all consoles are created equal: depending on the actual hardware,
> the latency of a printk() call can vary dramatically. The worst examples
> are serial consoles, where it can spin for tens of milliseconds banging
> the UART to emit a message, which can cause application-level problems
> when the kernel spews onto the console.
> 
> At Facebook we use netconsole to monitor our fleet, but we still have
> serial consoles attached on each host for live debugging, and the latter
> has caused problems. An obvious solution is to disable the kernel
> console output to ttyS0, but this makes live debugging frustrating,
> since crashes become silent and opaque to the ttyS0 user. Enabling it on
> the fly when needed isn't feasible, since boxes you need to debug via
> serial are likely to be borked in ways that make this impossible.

I guess that many other people have similar problem.


> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d3d170374ceb..6ead14f8c2bc 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1164,9 +1164,14 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(ignore_loglevel,
>  		 "ignore loglevel setting (prints all kernel messages to the console)");
>  
> -static bool suppress_message_printing(int level)
> +static int effective_loglevel(struct console *con)
>  {
> -	return (level >= console_loglevel && !ignore_loglevel);
> +	return max(console_loglevel, con ? con->level : LOGLEVEL_EMERG);
> +}
> +
> +static bool suppress_message_printing(int level, struct console *con)
> +{
> +	return (level >= effective_loglevel(con) && !ignore_loglevel);

Hmm, the semantic is cleaner when the per-console level defines
the minimal loglevel. But it is still complicated. Also it is
very confusing that the per-console value is called "level"
or "loglevel" but it is actually minimal loglevel.

It might be even more straightforward when the per-console value
defines the effective console level. I mean the following semantic:

   + "console_loglevel" would define the default loglevel used
     by consoles at runtime.

   + the per-console loglevel could override the default
     console_loglevel.

   + We would need a custom handler for the sysctl "console_loglevel".
     It would write the given value to the global console_loglevel
     variable and for all already registered consoles (con->loglevel).

     The value will be used also for all newly registered consoles
     when they do not have any custom one.


   + The handler for "loglevel" early param should behave the same
     as the sysctl handler.


IMHO, there is no perfect solution. The advantage of the above
proposal is that you "see" and "use" exactly what you "set".


>  }
>  
>  #ifdef CONFIG_BOOT_PRINTK_DELAY
> @@ -1198,7 +1203,7 @@ static void boot_delay_msec(int level)
>  	unsigned long timeout;
>  
>  	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
> -		|| suppress_message_printing(level)) {
> +		|| suppress_message_printing(level, NULL)) {

We should delay the message only when it will really reach the
console. The same check might be used also for formatting
the text as pointed out by Sergey in the other mail.

If the above proposal was accepted, we would have custom
handlers for sysctl. Then we could easily maintain a global
variable with maximal effective console loglevel.

Best Regards,
Petr
