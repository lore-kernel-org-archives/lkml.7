Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B29C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BC1222D9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfCXNwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 09:52:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:35993 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfCXNww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 09:52:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 06:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="128204874"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 24 Mar 2019 06:52:48 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h83YN-00029j-JU; Sun, 24 Mar 2019 15:52:47 +0200
Date:   Sun, 24 Mar 2019 15:52:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 10/10] thermal: intel: intel_soc_dts_iosf: Utilize
 for_each_set_clump8 macro
Message-ID: <20190324135247.GG9224@smile.fi.intel.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <a240216a143782e3cfecf6f963578067b68b6007.1552566114.git.vilhelm.gray@gmail.com>
 <20190322190243.GA9224@smile.fi.intel.com>
 <20190324033747.GA7697@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324033747.GA7697@icarus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 12:38:29PM +0900, William Breathitt Gray wrote:
> On Fri, Mar 22, 2019 at 09:02:43PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 14, 2019 at 09:32:57PM +0900, William Breathitt Gray wrote:
> > > Utilize for_each_set_clump8 macro, and the bitmap_set_value8 and
> > > bitmap_get_value8 functions, where appropriate. In addition, remove the
> > > now unnecessary temp_mask and temp_shift members of the
> > > intel_soc_dts_sensor_entry structure.
> > 
> > One comment below, otherwise
> > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Thanks!
> 
> Thank you for testing out the patch. I'll fix the bug your pointed out
> and add the Tested-by line.
> 
> I have a couple minor comments below.

> > >  	u32 store_ptps;

> > > -	out = (store_ptps & ~(0xFF << (thres_index * 8)));
> > > -	out |= (temp_out & 0xFF) << (thres_index * 8);
> > > +	update_ptps = store_ptps;
> > > +	bitmap_set_value8(&update_ptps, 32, temp_out & 0xFF, thres_index * 8);
> 
> I chose to hardcode a bitmap width of 32 here because that is the width
> of the store_ptps variables, but I don't think we necessarily use all 32
> bits here. Would the actual width of store_ptps be the number of
> writable trip count bits (writable_trip_count * 8)?

I think 32 is okay, but sizeof(store_ptps) would be better. It's easy to read
since no need to check what is the actual size inside this variable is used.


Same for below.


-- 
With Best Regards,
Andy Shevchenko


