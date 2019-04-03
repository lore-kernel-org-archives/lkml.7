Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61E1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B702147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCLP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:15:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:4624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDCLP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:15:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 04:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="157829009"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2019 04:15:24 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hBdrW-0001a8-Ch; Wed, 03 Apr 2019 14:15:22 +0300
Date:   Wed, 3 Apr 2019 14:15:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>, Yury Norov <ynorov@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] lib: make bitmap_parselist_user() a wrapper on
 bitmap_parselist()
Message-ID: <20190403111522.GP9224@smile.fi.intel.com>
References: <20190403044540.16322-1-ynorov@marvell.com>
 <20190403044540.16322-2-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403044540.16322-2-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 07:45:36AM +0300, Yury Norov wrote:
> Currently we parse user data byte after byte which leads to
> overcomplification of parsing algorithm. The only user of
> bitmap_parselist_user() is not performance-critical, and so we
> can copy user data to kernel buffer and simply call
> bitmap_parselist(). This rework lets us unify and simplify
> bitmap_parselist() and bitmap_parselist_user(), which is done
> in the following patch.

> +	buf = kmalloc(ulen + 1, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf[ulen] = 0;
> +
> +	ret = copy_from_user(buf, ubuf, ulen);
> +	if (ret)
> +		goto out;

Why not memdup_user() ?

-- 
With Best Regards,
Andy Shevchenko


