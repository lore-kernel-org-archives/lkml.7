Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A37C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748C92176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbfDQGpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:45:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:3863 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfDQGpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:45:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 23:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,360,1549958400"; 
   d="scan'208";a="141342387"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2019 23:45:07 -0700
Date:   Wed, 17 Apr 2019 14:48:44 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, ying.huang@intel.com
Subject: Re: [PATCH v2] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190417064844.ppyqxcx2mgek5455@shbuild888>
References: <20190410153718.22905-1-feng.tang@intel.com>
 <20190416211922.d3c9c6987f0b992da343be52@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416211922.d3c9c6987f0b992da343be52@linux-foundation.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Apr 16, 2019 at 09:19:22PM -0700, Andrew Morton wrote:
> On Wed, 10 Apr 2019 23:37:18 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > Currently on panic, kernel will lower the loglevel and print out
> > new printk msg only with console_flush_on_panic().
> > 
> > Add an option for users to configure the "panic_print" to see
> > all dmesg in buffer, some of which they may have never seen due
> > to the loglevel setting, which will help debugging too.
> > 
> > Thanks to Petr Mladek as somes codes come directly from the sample
> > code in his review comments.
> 
> CONFIG_PRINTK=n:
> 
> kernel/printk/printk.c: In function console_unlock:
> kernel/printk/printk.c:2419:11: warning: __builtin_memcpy writing 27 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
>     len += sprintf(text + len,
>            ^~~~~~~~~~~~~~~~~~~
>             "Replaying the entire log:\n");
>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> because LOG_LINE_MAX=0 and PREFIX_MAX=0.

Thanks for catching this!

> 
> 
> Which is interesting.  The pre-existing
> 
> 			len = sprintf(text,
> 				      "** %llu printk messages dropped **\n",
> 				      log_first_seq - console_seq);
> 
> in console_unlock() has the same issue, but the compiler doesn't seem
> to want to warn.

For this one, I did some check, and it should be related with the
conditional check 
	if (console_seq < log_first_seq) {

Both the console_seq and log_first_seq will not be touched by any code
when CONFIG_PRINTK=n, and compiler will simply skip the whole code block,
as "console_seq < log_first_seq" will never happen.

But code block following "if (console_replay)" will be compiled, that's
why these warning message will be shown.

> 
> (Also, using sprintf() is a bit lame for the new message - could use
> strlcpy()).
> 
> I'll drop the patch for now - we don't want that warning to come out. 
> console_unlock() needs some fixing for the CONFIG_PRINTK=n case.

My instant thought would be put the console_unlcok() and similar funcs
under CONFIG_PRINTK protection, while adding nop functions in the "else"
segment.

But complexer question will be when CONFIG_PRINTK=n, how those console_xxx
functions should consider these to make compiled binary smaller (though it
rarely happens). would wait for Petr/Sergey/Steven's insights.

Thanks,
Feng
