Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C3420830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfCYNJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:09:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:45258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbfCYNJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:09:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 06:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="129980440"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2019 06:09:35 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8PM5-0005ti-3q; Mon, 25 Mar 2019 15:09:33 +0200
Date:   Mon, 25 Mar 2019 15:09:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190325130933.GU9224@smile.fi.intel.com>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:38:54AM +0100, Lukas Wunner wrote:
> On Mon, Mar 25, 2019 at 03:22:23PM +0900, William Breathitt Gray wrote:
> > +/**
> > + * find_next_clump8 - find next 8-bit clump with set bits in a memory region
> > + * @clump: location to store copy of found clump
> > + * @addr: address to base the search on
> > + * @offset: bit offset at which to start searching
> > + * @size: bitmap size in number of bits
> > + *
> > + * Returns the bit offset for the next set clump; the found clump value is
> > + * copied to the location pointed by @clump. If no bits are set, returns @size.
> > + */
> > +unsigned int find_next_clump8(unsigned long *const clump,
> > +			      const unsigned long *const addr,
> > +			      unsigned int offset, const unsigned int size)
> > +{
> > +	for (; offset < size; offset += 8) {
> > +		*clump = bitmap_get_value8(addr, size, offset);
> > +		if (!*clump)
> > +			continue;
> > +
> > +		return offset;
> > +	}
> > +
> > +	return size;
> > +}
> > +EXPORT_SYMBOL(find_next_clump8);
> 
> Just use find_first_bit() / find_next_bit() to use optimized arch-specific
> bitops instead of open-coding the iteration over the bitmap.
> 
> See max3191x_get_multiple() for an example.

Actually a good point.

-- 
With Best Regards,
Andy Shevchenko


