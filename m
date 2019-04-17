Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C873C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F72420835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfDQJSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:18:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:48496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfDQJSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:18:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5CB4BAE92;
        Wed, 17 Apr 2019 09:18:33 +0000 (UTC)
Date:   Wed, 17 Apr 2019 11:18:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, ying.huang@intel.com
Subject: Re: [PATCH v2] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190417091832.z252cvcf4ktxeamv@pathway.suse.cz>
References: <20190410153718.22905-1-feng.tang@intel.com>
 <20190416211922.d3c9c6987f0b992da343be52@linux-foundation.org>
 <20190417064844.ppyqxcx2mgek5455@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417064844.ppyqxcx2mgek5455@shbuild888>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-04-17 14:48:44, Feng Tang wrote:
> Hi Andrew,
> 
> On Tue, Apr 16, 2019 at 09:19:22PM -0700, Andrew Morton wrote:
> > On Wed, 10 Apr 2019 23:37:18 +0800 Feng Tang <feng.tang@intel.com> wrote:
> > 
> > > Currently on panic, kernel will lower the loglevel and print out
> > > new printk msg only with console_flush_on_panic().
> > > 
> > > Add an option for users to configure the "panic_print" to see
> > > all dmesg in buffer, some of which they may have never seen due
> > > to the loglevel setting, which will help debugging too.
> > > 
> > > Thanks to Petr Mladek as somes codes come directly from the sample
> > > code in his review comments.
> > 
> > CONFIG_PRINTK=n:
> > 
> > kernel/printk/printk.c: In function console_unlock:
> > kernel/printk/printk.c:2419:11: warning: __builtin_memcpy writing 27 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
> >     len += sprintf(text + len,
> >            ^~~~~~~~~~~~~~~~~~~
> >             "Replaying the entire log:\n");
> >             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > because LOG_LINE_MAX=0 and PREFIX_MAX=0.
> 
> Thanks for catching this!
> 
> > 
> > 
> > Which is interesting.  The pre-existing
> > 
> > 			len = sprintf(text,
> > 				      "** %llu printk messages dropped **\n",
> > 				      log_first_seq - console_seq);
> > 
> > in console_unlock() has the same issue, but the compiler doesn't seem
> > to want to warn.
> 
> For this one, I did some check, and it should be related with the
> conditional check 
> 	if (console_seq < log_first_seq) {
> 
> Both the console_seq and log_first_seq will not be touched by any code
> when CONFIG_PRINTK=n, and compiler will simply skip the whole code block,
> as "console_seq < log_first_seq" will never happen.
> 
> But code block following "if (console_replay)" will be compiled, that's
> why these warning message will be shown.
> 
> > 
> > (Also, using sprintf() is a bit lame for the new message - could use
> > strlcpy()).
> > 
> > I'll drop the patch for now - we don't want that warning to come out. 
> > console_unlock() needs some fixing for the CONFIG_PRINTK=n case.
> 
> My instant thought would be put the console_unlcok() and similar funcs
> under CONFIG_PRINTK protection, while adding nop functions in the "else"
> segment.
> 
> But complexer question will be when CONFIG_PRINTK=n, how those console_xxx
> functions should consider these to make compiled binary smaller (though it
> rarely happens). would wait for Petr/Sergey/Steven's insights.

I guess that it is because console_sem is historically used to
synchronize some unrelated things, espcially in tty code.
Unfortunately, it is not easy to clean this up.

For this patch, the best solution seems to be using scnprintf()
instead of sprintf().

Please, note the difference between snprintf() and scnprintf().
We need the "scn*" variant the returns the number of really
printed characters.

Best Regards,
Petr
