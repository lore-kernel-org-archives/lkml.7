Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E507AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43F8218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfDXOt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:49:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:52016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730965AbfDXOt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:49:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0C1FAC61;
        Wed, 24 Apr 2019 14:49:25 +0000 (UTC)
Date:   Wed, 24 Apr 2019 16:49:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/2] printk: lock console_sem before we unregister
 boot consoles
Message-ID: <20190424144924.lw5sgl7qa2yrpxsj@pathway.suse.cz>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-04-23 15:25:10, Sergey Senozhatsky wrote:
> The following pattern is not completely safe:
> 
>      for_each_console(bcon)
>          if (bcon->flags & CON_BOOT)
>              unregister_console(bcon);
> 
> Because, in theory, console drivers list and console drivers
> can be modified concurrently from another CPU. Take console_sem
> lock, which protects console drivers list and console drivers,
> before we start iterating console drivers list.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 17102fd4c136..b0e361ca1bea 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2777,62 +2819,34 @@ void register_console(struct console *newcon)
>  	pr_info("%sconsole [%s%d] enabled\n",
>  		(newcon->flags & CON_BOOT) ? "boot" : "" ,
>  		newcon->name, newcon->index);
> -	if (bcon &&
> -	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
> -	    !keep_bootcon) {
> -		/* We need to iterate through all boot consoles, to make
> +
> +	if (keep_bootcon)
> +		return;
> +
> +	if (bcon && (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV) {
> +		console_lock();
> +		/*
> +		 * We need to iterate through all boot consoles, to make
>  		 * sure we print everything out, before we unregister them.
>  		 */

I wondered if moving the console locking could break the above
statement.

It seems that the comment has been invalid since the commit
8259cf4342029aad37660e ("printk: Ensure that "console
enabled" messages are printed on the console").

Could we remove it in this patch? It touches it indirectly anyway.

Otherwise, the patch looks fine to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

>  		for_each_console(bcon)
>  			if (bcon->flags & CON_BOOT)
> -				unregister_console(bcon);
> +				__unregister_console(bcon);
> +		console_unlock();
> +		console_sysfs_notify();
>  	}
>  }
>  EXPORT_SYMBOL(register_console);

Best Regards,
Petr
