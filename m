Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51047C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279BD2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDCMgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:36:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:12809 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfDCMgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:36:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 05:36:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="139641380"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 03 Apr 2019 05:36:49 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hBf8K-0002Pk-1D; Wed, 03 Apr 2019 15:36:48 +0300
Date:   Wed, 3 Apr 2019 15:36:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>, Yury Norov <ynorov@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] lib: make bitmap_parselist_user() a wrapper on
 bitmap_parselist()
Message-ID: <20190403123648.GC9224@smile.fi.intel.com>
References: <20190403044540.16322-1-ynorov@marvell.com>
 <20190403044540.16322-2-ynorov@marvell.com>
 <20190403111522.GP9224@smile.fi.intel.com>
 <20190403111745.GQ9224@smile.fi.intel.com>
 <8408fada-5fcc-9a45-9631-685505ed14f0@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8408fada-5fcc-9a45-9631-685505ed14f0@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 02:17:39PM +0200, Rasmus Villemoes wrote:
> On 03/04/2019 13.17, Andy Shevchenko wrote:
> > On Wed, Apr 03, 2019 at 02:15:22PM +0300, Andy Shevchenko wrote:
> >> On Wed, Apr 03, 2019 at 07:45:36AM +0300, Yury Norov wrote:
> >>> Currently we parse user data byte after byte which leads to
> >>> overcomplification of parsing algorithm. The only user of
> >>> bitmap_parselist_user() is not performance-critical, and so we
> >>> can copy user data to kernel buffer and simply call
> >>> bitmap_parselist(). This rework lets us unify and simplify
> >>> bitmap_parselist() and bitmap_parselist_user(), which is done
> >>> in the following patch.
> >>
> >>> +	buf = kmalloc(ulen + 1, GFP_KERNEL);
> >>> +	if (!buf)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	buf[ulen] = 0;
> >>> +
> >>> +	ret = copy_from_user(buf, ubuf, ulen);
> >>> +	if (ret)
> >>> +		goto out;
> >>
> >> Why not memdup_user() ?
> > 
> > Even more precisely (for strings) strndup_user().
> > 
> 
> But the user buffer is not nul-terminated, i.e. it's not a string. 

Missed that. I stand corrected.

> What
> you want is memdup_user_nul() - take a length-delimited user buffer and
> turn it into a nul-terminated string in kernel memory.

Good, we have a helper.

-- 
With Best Regards,
Andy Shevchenko


