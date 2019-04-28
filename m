Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E7C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDE62067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfD1PlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:41:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:23705 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfD1PlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:41:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 08:41:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,406,1549958400"; 
   d="scan'208";a="138181779"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 28 Apr 2019 08:41:00 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hKlvF-0005io-ED; Sun, 28 Apr 2019 18:40:57 +0300
Date:   Sun, 28 Apr 2019 18:40:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 0/4] lib: rework bitmap_parse
Message-ID: <20190428154057.GS9224@smile.fi.intel.com>
References: <20190428032936.1317-1-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428032936.1317-1-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 08:29:30PM -0700, Yury Norov wrote:
> On top of next-20190418.
> 
> Similarly to recently revisited bitmap_parselist() [1],
> bitmap_parse() is ineffective and overcomplicated.  This
> series reworks it, aligns its interface with bitmap_parselist()
> and makes usage simpler.
> 
> The series also adds a test for the function and fixes usage of it
> in cpumask_parse() according to new design - drops the calculating
> of length of an input string.
> 
> The following users would also consider to drop the length argument,
> if possible:
> drivers/block/drbd/drbd_main.c:2608
> kernel/padata.c:924
> net/core/net-sysfs.c:726
> net/core/net-sysfs.c:1309
> net/core/net-sysfs.c:1391
> 
> bitmap_parse() takes the array of numbers to be put into the map in
> the BE order which is reversed to the natural LE order for bitmaps.
> For example, to construct bitmap containing a bit on the position 42,
> we have to put a line '400,0'. Current implementation reads chunk
> one by one from the beginning ('400' before '0') and makes bitmap
> shift after each successful parse. It makes the complexity of the
> whole process as O(n^2). We can do it in reverse direction ('0'
> before '400') and avoid shifting, but it requires reverse parsing
> helpers.

Shouldn't test ceases pass on existing code base? I would rather start series
with enabling tests and then we will have a proof that before and after at
least tests have not been broken.

> 
> Tested on arm64 and BE mips.
> 
> [1] https://lkml.org/lkml/2019/4/16/66
> 
> Yury Norov (6):
>   lib/string: add strnchrnul()
>   bitops: more BITS_TO_* macros
>   lib/bitmap: make bitmap_parse_user a wrapper on bitmap_parse
>   lib: rework bitmap_parse()
>   lib: add test for bitmap_parse()
>   cpumask: don't calculate length of the input string
> 
>  include/linux/bitmap.h       |   8 +-
>  include/linux/bitops.h       |   3 +
>  include/linux/cpumask.h      |   4 +-
>  include/linux/string.h       |   3 +
>  lib/bitmap.c                 | 197 +++++++++++++++++------------------
>  lib/string.c                 |  20 ++++
>  lib/test_bitmap.c            | 102 +++++++++++++++++-
>  tools/include/linux/bitops.h |   9 +-
>  8 files changed, 230 insertions(+), 116 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


