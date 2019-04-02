Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF78C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28822070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfDBCZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:25:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:30765 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDBCZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:25:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 19:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="scan'208";a="139188473"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by orsmga003.jf.intel.com with ESMTP; 01 Apr 2019 19:25:33 -0700
Date:   Tue, 2 Apr 2019 10:28:40 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] printk: Add an option to flush all messages on panic
Message-ID: <20190402022840.et7sbiamxeutbw2q@shbuild888>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
 <20190402021419.GA617@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402021419.GA617@jagdpanzerIV>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thanks for the review.

On Tue, Apr 02, 2019 at 11:14:19AM +0900, Sergey Senozhatsky wrote:
> On (04/01/19 18:48), Feng Tang wrote:
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index 1fd45a8..58d9580 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -179,7 +179,7 @@ extern void panic_flush_kmsg_end(void)
> >  	kmsg_dump(KMSG_DUMP_PANIC);
> >  	bust_spinlocks(0);
> >  	debug_locks_off();
> > -	console_flush_on_panic();
> > +	console_flush_on_panic(false);
> >  }
> [..]
> > @@ -277,7 +277,7 @@ void panic(const char *fmt, ...)
> >  	 * panic() is not being callled from OOPS.
> >  	 */
> >  	debug_locks_off();
> > -	console_flush_on_panic();
> > +	console_flush_on_panic(false);
> [..]
> > -void console_flush_on_panic(void)
> > +void console_flush_on_panic(bool flush_all)
> >  {
> >  	/*
> >  	 * If someone else is holding the console lock, trylock will fail
> > @@ -2539,6 +2540,12 @@ void console_flush_on_panic(void)
> >  	 */
> >  	console_trylock();
> >  	console_may_schedule = 0;
> > +
> > +	/* User may want to see all the printk messages on panic */
> > +	if (flush_all) {
> > +		console_seq = log_first_seq;
> > +		console_idx = log_first_idx;
> > +	}
> >  	console_unlock();
> 
> So my first thought was - let's not add a `bool flag', but instead add
> an `enum' with clear flag names, e.g. DUMP_ALL/DUMP_PENDING, etc. Something
> similar to what ftrace_dump(DUMP_ALL) does. And we already have panic_print
> bit-mask and panic_print_sys_info(), which controls what we print when in
> panic. So we can move console_flush_on_panic() to panic_print_sys_info()
> and handle different types of console_flush_on_panic() there:
> 
> ---
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 0ae0d7332f12..e142faaebbcd 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -134,6 +134,11 @@ EXPORT_SYMBOL(nmi_panic);
>  
>  static void panic_print_sys_info(void)
>  {
> +	if (panic_print & PANIC_PRINT_REPLAY_LOGBUF)
> +		console_flush_on_panic(DUMP_ALL);
> +	else
> +		console_flush_on_panic(DUMP_PENDING);
> +
>  	if (panic_print & PANIC_PRINT_TASK_INFO)
>  		show_state();
>  
> @@ -277,7 +282,6 @@ void panic(const char *fmt, ...)
>  	 * panic() is not being callled from OOPS.
>  	 */
>  	debug_locks_off();
> -	console_flush_on_panic();
>  
>  	panic_print_sys_info();
>  

I guess this is what my 2/2 patch exactly does :)


> ---
> 
> After looking at this more - DUMP_ALL/DUMP_PENDING clearly depend
> on panic_print. So... May be we can move panic_print_sys_info() to
> printk.c, and for PANIC_PRINT_REPLAY_LOGBUF case just reset console
> seq/idx (console seq/idx are internal to printk) before we
> flush_on_panic. This way we would not need to modify
> console_flush_on_panic() prototype at all.

My thought is panic_print_sys_info() may be more related to panic, but
I'm fine with either way.

Thanks,
Feng

> 
> Let's hear from people.
> 
> 	-ss
