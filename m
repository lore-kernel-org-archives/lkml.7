Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5501FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0272147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDCLYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:24:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:11381 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCLYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:24:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 04:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="220143863"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2019 04:24:15 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hBe06-0001eP-Bu; Wed, 03 Apr 2019 14:24:14 +0300
Date:   Wed, 3 Apr 2019 14:24:14 +0300
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
Subject: Re: [PATCH v3 0/5] lib: rework bitmap_parselist and tests
Message-ID: <20190403112414.GT9224@smile.fi.intel.com>
References: <20190403044540.16322-1-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403044540.16322-1-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 07:45:35AM +0300, Yury Norov wrote:
> bitmap_parselist has been evolved from a pretty simple idea for long and
> now lacks for refactoring. It is not structured, has nested loops and a
> set of opaque-named variables.
> 
> Things are more complicated because bitmap_parselist() is a part of user
> interface, and its behavior should not change.
> 
> In this patchset
>  - bitmap_parselist_user() made a wrapper on bitmap_parselist();
>  - bitmap_parselist() reworked (patch 2);
>  - time measurement in test_bitmap_parselist switched to ktime_get
>    (patch 3);
>  - new tests introduced (patch 4), and
>  - bitmap_parselist_user() testing enabled with the same testset as
>    bitmap_parselist() (patch 5).

Thanks for an update. Result looks good, though few comments per individual patches.

> 
> v1: https://lkml.org/lkml/2018/12/23/50
> v2: https://www.spinics.net/lists/kernel/msg3048976.html
> v3: Implementation of an approach with copying the data to
>     kernel space in bitmap_parselist_user() instead of parsing
>     user data byte by byte. For me, it looks better than v2.
> 
> Yury Norov (5):
>   lib: make bitmap_parselist_user() a wrapper on bitmap_parselist()
>   lib: rework bitmap_parselist
>   lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
>   lib/test_bitmap: add testcases for bitmap_parselist
>   lib/test_bitmap: add tests for bitmap_parselist_user
> 
>  lib/bitmap.c      | 285 ++++++++++++++++++++++++++--------------------
>  lib/test_bitmap.c |  67 ++++++++---
>  2 files changed, 218 insertions(+), 134 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


