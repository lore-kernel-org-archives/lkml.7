Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AECC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346D72084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfEONez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:34:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:38618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbfEONey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:34:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89FDCAD36;
        Wed, 15 May 2019 13:34:53 +0000 (UTC)
Date:   Wed, 15 May 2019 15:34:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 1/4] printk: factor out __unregister_console() code
Message-ID: <20190515133452.o4dvf4p6dxzggvoa@pathway.suse.cz>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
 <20190426053302.4332-2-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426053302.4332-2-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-04-26 14:32:59, Sergey Senozhatsky wrote:
> The following pattern in register_console() is not completely safe:
> 
>      for_each_console(bcon)
>          if (bcon->flags & CON_BOOT)
>              unregister_console(bcon);
> 
> Because, in theory, console drivers list and console drivers
> can be modified concurrently from another CPU. We need to grab
> console_sem lock, which protects console drivers list and console
> drivers, before we start iterating console drivers list.
> 
> Factor out __unregister_console(), which will be called from
> unregister_console() and register_console(), in both cases
> under console_sem lock.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 17102fd4c136..b0e361ca1bea 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2605,6 +2605,48 @@ static int __init keep_bootcon_setup(char *str)
>  
>  early_param("keep_bootcon", keep_bootcon_setup);
>  
> +static int __unregister_console(struct console *console)
> +{
> +	struct console *a, *b;
> +	int res;
> +
> +	pr_info("%sconsole [%s%d] disabled\n",
> +		(console->flags & CON_BOOT) ? "boot" : "",
> +		console->name, console->index);
> +
> +	res = _braille_unregister_console(console);

It looks safe to call _braille_unregister_console() under
console_lock().

Therefore this patch looks fine and make sense, so:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
