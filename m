Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DEDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2192173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfDQMZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:25:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729522AbfDQMZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:25:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EE4DAF8D;
        Wed, 17 Apr 2019 12:25:00 +0000 (UTC)
Date:   Wed, 17 Apr 2019 14:24:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, ying.huang@intel.com
Subject: Re: [PATCH v2] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190417122458.mhl3orevzha7sp6h@pathway.suse.cz>
References: <20190410153718.22905-1-feng.tang@intel.com>
 <20190416211922.d3c9c6987f0b992da343be52@linux-foundation.org>
 <20190417064844.ppyqxcx2mgek5455@shbuild888>
 <20190417091832.z252cvcf4ktxeamv@pathway.suse.cz>
 <20190417094614.GB4260@jagdpanzerIV>
 <20190417105010.GA8492@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417105010.GA8492@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-04-17 19:50:10, Sergey Senozhatsky wrote:
> On (04/17/19 18:46), Sergey Senozhatsky wrote:
> > 
> > Does not look too complex/ugly.
> 
> Looks simpler than adding one more global state to the
> console_unlock() printing loop.
> 
> // Not tested at all //
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index cd73af35ec66..50eacfc9bc7e 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -51,6 +51,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
>  #define PANIC_PRINT_TIMER_INFO		0x00000004
>  #define PANIC_PRINT_LOCK_INFO		0x00000008
>  #define PANIC_PRINT_FTRACE_INFO		0x00000010
> +#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
>  unsigned long panic_print;
>  
>  ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> @@ -148,6 +149,9 @@ static void panic_print_sys_info(void)
>  
>  	if (panic_print & PANIC_PRINT_FTRACE_INFO)
>  		ftrace_dump(DUMP_ALL);
> +
> +	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +		console_flush_on_panic(CONSOLE_FLUSH_ALL);

The console must be replayed as the first thing in
panic_print_sys_info(). Otherwise, the original messages
are replaced by the other dumps. Especially ftrace_dump()
might be pretty long.

Also the names of the function and the parameter are misleading.
All messages are already flushed when this is called.

>  }
>  
>  /**
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 17102fd4c136..da60a185dbbb 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2549,6 +2549,14 @@ void console_flush_on_panic(void)
>  	 */
>  	console_trylock();
>  	console_may_schedule = 0;
> +	if (flush_mode == CONSOLE_FLUSH_ALL) {
> +		/*
> +		 * Can be done under logbuf lock, but it's unlikely that
> +		 * we will have any race conditions here.
> +		 */
> +		console_seq = log_first_seq;
> +		console_idx = log_first_idx;

I agree that it is easier. The cost is that the same messages are
printed again without any explanation.

I still think that it would be convenient to write a header line.
It would help to understand the log for any, even 3rd-party, reader.
Also it would help to find the beginning in a very long log.

If the complexity of console_unlock() is the concern, we could
refactor the code, e.g. put this "reset log" code into a separate
function.

Best Regards,
Petr
