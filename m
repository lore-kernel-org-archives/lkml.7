Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7493EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502A3218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfGCOhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:37:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:45840 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCOhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:37:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 07:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="157989074"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 07:37:29 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1higO0-0006g5-E3; Wed, 03 Jul 2019 17:37:28 +0300
Date:   Wed, 3 Jul 2019 17:37:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 1/2] kernel.h: Update comment about
 simple_strto<foo>() functions
Message-ID: <20190703143728.GS9224@smile.fi.intel.com>
References: <20190626093943.49780-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWm7ftYNVQfjLdPxvzZQLa6mWQvjE8vGo98-QOGeyjZFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWm7ftYNVQfjLdPxvzZQLa6mWQvjE8vGo98-QOGeyjZFQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 01:00:45PM +0200, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Wed, Jun 26, 2019 at 11:39 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > There were discussions in the past about use cases for
> > simple_strto<foo>() functions and in some rare cases they have a benefit
> > on kstrto<foo>() ones.
> 
> over

Will fix.

> > Update a comment to reduce confusing about special use cases.
> 
> confusion

Will fix.

> > Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> 
> > @@ -437,7 +435,15 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
> >         return kstrtoint_from_user(s, count, base, res);
> >  }
> >
> > -/* Obsolete, do not use.  Use kstrto<foo> instead */
> > +/*
> > + * Use kstrto<foo> instead.
> > + *
> > + * NOTE: The simple_strto<foo> does not check for overflow and,
> > + *      depending on the input, may give interesting results.
> > + *
> > + * Use these functions if and only if the code will need in place
> > + * conversion and otherwise looks very ugly. Keep in mind above caveat.
> 
> What do you mean by "in place conversion"?
> The input buffer is const, and not modified by the callee.
> Do you mean that these functions do not require NUL termination (just
> after the number), and the characters making up the number don't have to
> be copied to a separate buffer to make them NUL-terminated?

The second one, could you propose better wording for that?

> > + */
> >
> >  extern unsigned long simple_strtoul(const char *,char **,unsigned int);
> >  extern long simple_strtol(const char *,char **,unsigned int);
> 
> Yeah, they're still very useful.

Thanks for review.

-- 
With Best Regards,
Andy Shevchenko


