Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13197C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88EF2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfDINlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:41:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726685AbfDINlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:41:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7489FB13F;
        Tue,  9 Apr 2019 13:41:10 +0000 (UTC)
Date:   Tue, 9 Apr 2019 15:41:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] printk: Add an option to flush all messages on panic
Message-ID: <20190409134109.ounidzwphouqr3w2@pathway.suse.cz>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
 <20190402021419.GA617@jagdpanzerIV>
 <20190402022840.et7sbiamxeutbw2q@shbuild888>
 <20190402022900.GA2219@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402022900.GA2219@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-04-02 11:29:00, Sergey Senozhatsky wrote:
> On (04/02/19 10:28), Feng Tang wrote:
> > > So my first thought was - let's not add a `bool flag', but instead add
> > > an `enum' with clear flag names, e.g. DUMP_ALL/DUMP_PENDING, etc. Something
> > > similar to what ftrace_dump(DUMP_ALL) does. And we already have panic_print
> > > bit-mask and panic_print_sys_info(), which controls what we print when in
> > > panic. So we can move console_flush_on_panic() to panic_print_sys_info()
> > > and handle different types of console_flush_on_panic() there:
> > > 
> > > ---
> > > 
> > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > index 0ae0d7332f12..e142faaebbcd 100644
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -134,6 +134,11 @@ EXPORT_SYMBOL(nmi_panic);
> > >  
> > >  static void panic_print_sys_info(void)
> > >  {
> > > +	if (panic_print & PANIC_PRINT_REPLAY_LOGBUF)
> > > +		console_flush_on_panic(DUMP_ALL);
> > > +	else
> > > +		console_flush_on_panic(DUMP_PENDING);
> > > +
> > >  	if (panic_print & PANIC_PRINT_TASK_INFO)
> > >  		show_state();
> > >  
> > > @@ -277,7 +282,6 @@ void panic(const char *fmt, ...)
> > >  	 * panic() is not being callled from OOPS.
> > >  	 */
> > >  	debug_locks_off();
> > > -	console_flush_on_panic();
> > >  
> > >  	panic_print_sys_info();
> > >  
> > 
> > I guess this is what my 2/2 patch exactly does :)
> 
> Oh, indeed... I didn't check 2/2.

I suggest to merge the two patches into one. It will
still be rather small and easier to review.

Best Regards,
Petr
