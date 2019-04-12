Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80843C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCF22084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDLIkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:40:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:35657 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfDLIke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:40:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 01:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; 
   d="scan'208";a="135179471"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 12 Apr 2019 01:40:31 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hErjZ-0003Oj-Ko; Fri, 12 Apr 2019 11:40:29 +0300
Date:   Fri, 12 Apr 2019 11:40:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>, Yury Norov <ynorov@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] lib/test_bitmap: add testcases for bitmap_parselist
Message-ID: <20190412084029.GI9224@smile.fi.intel.com>
References: <20190405173211.11373-1-ynorov@marvell.com>
 <20190405173211.11373-5-ynorov@marvell.com>
 <20190411183946.GA13348@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411183946.GA13348@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:39:46AM -0700, Guenter Roeck wrote:
> On Fri, Apr 05, 2019 at 08:32:10PM +0300, Yury Norov wrote:
> > Add tests for non-number character, empty regions, integer overflow.

> >  	{0, "1-31:4/4",			&exp[9 * step], 32, 0},
> >  	{0, "0-31:1/4,32-63:2/4",	&exp[10 * step], 64, 0},
> >  	{0, "0-31:3/4,32-63:4/4",	&exp[11 * step], 64, 0},
> > +	{0, "  ,,  0-31:3/4  ,, 32-63:4/4  ,,  ",	&exp[11 * step], 64, 0},
> >  
> >  	{0, "0-31:1/4,32-63:2/4,64-95:3/4,96-127:4/4",	exp2, 128, 0},
> >  
> >  	{0, "0-2047:128/256", NULL, 2048, PARSE_TIME},
> >  
> > +	{0, "",				&exp[12], 8, 0},
> > +	{0, "\n",			&exp[12], 8, 0},
> > +	{0, ",,  ,,  , ,  ,",		&exp[12], 8, 0},
> > +	{0, " ,  ,,  , ,   ",		&exp[12], 8, 0},
> > +	{0, " ,  ,,  , ,   \n",		&exp[12], 8, 0},
> > +
> 
> This results in error messages such as
> 
> test_bitmap: parselist: 17: input is ,, ,,  , ,  ,, result is 0x0, expected 0x11111111
> test_bitmap: parselist: 18: input is  ,  ,,  , ,   , result is 0x0, expected 0x11111111
> 
> on 32-bit systems. The above should be "&exp[12 * step]".

Nice catch!

-- 
With Best Regards,
Andy Shevchenko


