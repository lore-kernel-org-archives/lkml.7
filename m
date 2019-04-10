Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39AEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796022133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfDJKJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:09:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:13435 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbfDJKJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:09:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 03:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="134521219"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2019 03:09:01 -0700
Date:   Wed, 10 Apr 2019 18:12:25 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 2/2] panic: Enable to print out all printk msg in buffer
Message-ID: <20190410101225.gs7445svboftdcze@shbuild888>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
 <1554115684-26846-2-git-send-email-feng.tang@intel.com>
 <20190409141430.w2fulp7jnnthojrc@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409141430.w2fulp7jnnthojrc@pathway.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Tue, Apr 09, 2019 at 04:14:30PM +0200, Petr Mladek wrote:
> On Mon 2019-04-01 18:48:04, Feng Tang wrote:
> > Currently on panic, kernel will lower the loglevel and print out
> > new printk msg only. With this patch, user can configure the
> > "panic_print" to see all dmesg in buffer, some of which they may
> > have never seen due to the loglevel setting.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index fb77e01..afe023e 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -51,6 +51,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
> >  #define PANIC_PRINT_TIMER_INFO		0x00000004
> >  #define PANIC_PRINT_LOCK_INFO		0x00000008
> >  #define PANIC_PRINT_FTRACE_INFO		0x00000010
> > +#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
> >  unsigned long panic_print;
> >  
> >  ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> > @@ -134,6 +135,13 @@ EXPORT_SYMBOL(nmi_panic);
> >  
> >  static void panic_print_sys_info(void)
> >  {
> > +	bool flush_all_dmesg = false;
> > +
> > +	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> > +		flush_all_dmesg = true;
> > +
> > +	console_flush_on_panic(flush_all_dmesg);
> 
> We should:
> 
>    + Flush the latest messages before we replay the log.
> 
>    + Show some header line before replaing the log.
> 
> 
> Therefore, I would keep console_flush_on_panic() as is.
> Then I would add:
> 
> int console_replay;
> 
> void console_replay_on_panic(void)
> {
> 	/*
> 	 * If someone else is holding the console lock, trylock will fail
> 	 * and may_schedule may be set.  Ignore and proceed to unlock so
> 	 * that messages are flushed out.  As this can be called from any
> 	 * context and we don't want to get preempted while flushing,
> 	 * ensure may_schedule is cleared.
> 	 */
> 	console_trylock();
> 	console_may_schedule = 0;
> 	console_replay = 1;
> 	console_unlock();
> }

Many thanks for the review and detailed sample codes.

Your code of moving the console_seq and console_index changing
code into concole_unlock() is much safer, which is protected by
the locl.

Initially I thought of adding a new function similar to this, but
was afraid that it is too similar to the console_flush_on_panic() :)

> 
> Then I would update cosole_unlock() with something like:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 02ca827b8fac..14ef4e2431e7 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2386,21 +2386,32 @@ void console_unlock(void)
>  
>  	for (;;) {
>  		struct printk_log *msg;
> +		int reset_idx = 0;
>  		size_t ext_len = 0;
> -		size_t len;
> +		size_t len = 0;
>  
>  		printk_safe_enter_irqsave(flags);
>  		raw_spin_lock(&logbuf_lock);
> +
>  		if (console_seq < log_first_seq) {
>  			len = sprintf(text,
>  				      "** %llu printk messages dropped **\n",
>  				      log_first_seq - console_seq);
>  
>  			/* messages are gone, move to first one */
> +			reset_idx = 1;
> +		}
> +
> +		if (console_replay) {
> +			len += sprintf(text + len,
> +				       "Replaying the entire log:\n");
> +			reset_idx = 1;
> +			console_replay = 0;
> +		}
> +
> +		if (reset_idx) {
>  			console_seq = log_first_seq;
>  			console_idx = log_first_idx;
> -		} else {
> -			len = 0;
>  		}
>  skip:
>  		if (console_seq == log_next_seq)
> 
> 
> Finally, it can get called from panic_print_sys_info(void)
> the following way:
> 
> 	/* Replay existing messages before adding other sys info. */
> 	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> 		console_replay_on_panic();

Yes, it should be the first inside panic_print_sys_info().

Thanks,
Feng

