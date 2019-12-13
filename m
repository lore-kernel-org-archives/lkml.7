Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39812C3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F1A246B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLMLQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:16:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:3016 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfLMLQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:16:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 03:16:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="216609003"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2019 03:16:50 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ifiwD-00080o-R0; Fri, 13 Dec 2019 13:16:49 +0200
Date:   Fri, 13 Dec 2019 13:16:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: WARNING: lib/test_bitmap.o(.text.unlikely+0x5c): Section
 mismatch in reference from the function bitmap_copy_clear_tail() to the
 variable .init.rodata:clump_exp
Message-ID: <20191213111649.GU32742@smile.fi.intel.com>
References: <201912100401.fDYi5lhU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912100401.fDYi5lhU%lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:17:03AM +0800, kbuild test robot wrote:

+Cc: Max for xtensa matters, perhaps he has an idea.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e42617b825f8073569da76dc4510bfa019b1c35a
> commit: 30544ed5de431fe25d3793e4dd5a058d877c4d77 lib/bitmap: introduce bitmap_replace() helper
> date:   5 days ago
> config: xtensa-randconfig-a001-20191209 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 30544ed5de431fe25d3793e4dd5a058d877c4d77
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=xtensa 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):

I'm not sure I got this (esp. relation to my patch).
The mentioned code definitely compiled for 32-bit (since only then mentioned
bitmap API is in use). I have tried to reproduce on i386 compilation (gcc 9.x),
but can't.

> >> WARNING: lib/test_bitmap.o(.text.unlikely+0x5c): Section mismatch in reference from the function bitmap_copy_clear_tail() to the variable .init.rodata:clump_exp
>    The function bitmap_copy_clear_tail() references
>    the variable __initconst clump_exp.
>    This is often because bitmap_copy_clear_tail lacks a __initconst
>    annotation or the annotation of clump_exp is wrong.
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation



-- 
With Best Regards,
Andy Shevchenko


