Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B797FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDB72148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfDXPNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:13:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbfDXPNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:13:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBFE5ABB1;
        Wed, 24 Apr 2019 15:13:06 +0000 (UTC)
Date:   Wed, 24 Apr 2019 17:13:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 2/2] printk: take console_sem when accessing console
 drivers list
Message-ID: <20190424151306.jcmygibltizcorgk@pathway.suse.cz>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-3-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423062511.1118-3-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-04-23 15:25:11, Sergey Senozhatsky wrote:
> We need to take console_sem lock when we iterate console
> drivers list. Otherwise, another CPU can concurrently
> modify console drivers list or console drivers.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  kernel/printk/printk.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b0e361ca1bea..c2bccf58d03e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2674,12 +2674,17 @@ void register_console(struct console *newcon)
>  	struct console_cmdline *c;
>  	static bool has_preferred;
>  
> -	if (console_drivers)
> -		for_each_console(bcon)
> -			if (WARN(bcon == newcon,
> -					"console '%s%d' already registered\n",
> -					bcon->name, bcon->index))
> -				return;
> +	console_lock();
> +	if (console_drivers) {
> +		for_each_console(bcon) {
> +			if (bcon != newcon)
> +				continue;
> +			WARN(1, "console '%s%d' already registered\n",
> +			     bcon->name, bcon->index);
> +			console_unlock();
> +			return;
> +		}
> +	}
>  
>  	/*
>  	 * before we register a new CON_BOOT console, make sure we don't
> @@ -2691,6 +2696,7 @@ void register_console(struct console *newcon)
>  			if (!(bcon->flags & CON_BOOT)) {
>  				pr_info("Too late to register bootconsole %s%d\n",
>  					newcon->name, newcon->index);
> +				console_unlock();
>  				return;
>  			}
>  		}
> @@ -2701,6 +2707,7 @@ void register_console(struct console *newcon)
>  
>  	if (!has_preferred || bcon || !console_drivers)
>  		has_preferred = preferred_console >= 0;
> +	console_unlock();

We should keep it until the console is added into the list. Otherwise
there are races with accessing the static has_preferred and
the global preferred_console variables.

Also the value of bcon should stay synchronized until we decide
about replaying the log.

IMHO, the only danger might be when con->match() or con->setup()
would want to take console_lock() as well. I checked few drivers
and they looked safe. But I did not check all of them.

What do you think, please?

Best Regards,
Petr
