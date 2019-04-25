Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AB7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5996F214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfDYLFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:05:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfDYLFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:05:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEA73AD14;
        Thu, 25 Apr 2019 11:05:19 +0000 (UTC)
Date:   Thu, 25 Apr 2019 13:05:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190425110517.cafkeexdr6r4b25v@pathway.suse.cz>
References: <1556095872-36838-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556095872-36838-1-git-send-email-feng.tang@intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-04-24 16:51:12, Feng Tang wrote:
> Currently on panic, kernel will lower the loglevel and print out
> pending printk msg only with console_flush_on_panic().
> 
> Add an option for users to configure the "panic_print" to replay
> all dmesg in buffer, some of which they may have never seen due
> to the loglevel setting, which will help panic debugging .
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index b9f004e..b9c0eb3 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -53,6 +53,7 @@ int panic_suppress_printk;
>  #define PANIC_PRINT_TIMER_INFO		0x00000004
>  #define PANIC_PRINT_LOCK_INFO		0x00000008
>  #define PANIC_PRINT_FTRACE_INFO		0x00000010
> +#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
>  unsigned long panic_print;
>  
>  ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> @@ -136,6 +137,11 @@ EXPORT_SYMBOL(nmi_panic);
>  
>  static void panic_print_sys_info(void)
>  {
> +	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +	else
> +		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> +
>  	if (panic_print & PANIC_PRINT_TASK_INFO)
>  		show_state();
>  
> @@ -279,8 +285,6 @@ void panic(const char *fmt, ...)
>  	 * panic() is not being callled from OOPS.
>  	 */
>  	debug_locks_off();
> -	console_flush_on_panic();

I would prefer if we keep it here. It is a very important
operation that plays a role in many panic/printk related
bugs. We should not hide it in an "unrelated"
function.

The name "panic_print_sys_info" suggests that it
just shows some additional information.

I guess that you wanted to avoid flushing some messages
twice. IMHO, it is not a big deal. In many situations,
console_flush_on_panic(CONSOLE_FLUSH_PENDING) will
do nothing or it would handle just few lines.

Also people might decide to do a forced reboot when
the console is slow and it takes ages to print
everything. Then it might be useful to handle
the few "most" important lines before starting
from beginning.

Other than that I am fine with the patch. I give up
on bike shedding about the header line ;-)

Best Regards,
Petr
