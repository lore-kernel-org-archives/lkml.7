Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52173C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF7F2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfDZNCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:02:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:19974 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfDZNCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:02:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 06:02:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="319201866"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 26 Apr 2019 06:02:05 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hK0UO-0004El-E7; Fri, 26 Apr 2019 16:02:04 +0300
Date:   Fri, 26 Apr 2019 16:02:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] vsprintf: Prevent silent crashes and
 consolidate error handling
Message-ID: <20190426130204.GS9224@smile.fi.intel.com>
References: <20190417115350.20479-1-pmladek@suse.com>
 <20190419015112.GA18748@jagdpanzerIV>
 <20190424135306.xiuhj6dmzrgytulp@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424135306.xiuhj6dmzrgytulp@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:53:06PM +0200, Petr Mladek wrote:
> On Fri 2019-04-19 10:51:12, Sergey Senozhatsky wrote:
> > On (04/17/19 13:53), Petr Mladek wrote:
> > > Crash in vsprintf() might be silent when it happens under logbuf_lock
> > > in vprintk_emit(). This patch set prevents most of the crashes by probing
> > > the address. The check is done only by %s and some %p* specifiers that need
> > > to dereference the address.
> > >
> > > Only the first byte of the address is checked to keep it simple. It should
> > > be enough to catch most problems.
> > >
> > > The check is explicitly done in each function that does the dereference.
> > > It helps to avoid the questionable strchr() of affected specifiers. This
> > > change motivated me to do some preparation patches that consolidated
> > > the error handling and cleaned the code a bit.
> > 
> > The patch set looks OK to me.
> > 
> > I got confused by 'pC?' error string, but once you start looking
> > at it as a regex (? - zero or one occurrences) things look OK.
> > Regex in dmesg/serial output might be something very new to people,
> > stack traces, after all, is a rather common error reporting mechanism.
> > So the previous "WARN_ON() + exact unrecognized fmt[N] char" was not
> > totally awful or wrong (well, it was, before we introduced printk_safe()),
> > but I don't have strong objections against that new regex thing.
> > 
> > FWIW,
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> Thanks a lot for review.
> 
> I have pushed the entire patchset into printk.git,
> branch for-5.2-vsprintf-hardening to get some
> test coverage via linux-next.
> 
> I still expect some feedback, especially from Andy
> who seems to have a vacation these days.
> I think that Andy wanted these changes rather sooner
> than later, so I hope that he would be fine with it.
> I could take it back in case of disagreement.

They are good enough to me, thanks!
FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


