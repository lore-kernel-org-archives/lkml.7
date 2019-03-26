Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38349C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FF120863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfCZKTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:19:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:21429 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCZKTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:19:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 03:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="145311682"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2019 03:19:35 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1h8jB7-0001ER-Ln; Tue, 26 Mar 2019 12:19:33 +0200
Date:   Tue, 26 Mar 2019 12:19:33 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326101933.GW9224@smile.fi.intel.com>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
 <20190326031422.GB3356@icarus>
 <20190326094345.v7l7xjvfs2scbvbv@wunner.de>
 <20190326100743.GA10005@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326100743.GA10005@icarus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 07:08:18PM +0900, William Breathitt Gray wrote:
> On Tue, Mar 26, 2019 at 10:43:45AM +0100, Lukas Wunner wrote:
> > On Tue, Mar 26, 2019 at 12:14:22PM +0900, William Breathitt Gray wrote:

> > Why is it so complicated, does it allow passing in a start value
> > that's not a multiple of 8?  Do you really need that?  I imagine
> > a simplification is possible if that assumption can be made (and
> > is spelled out in the kerneldoc).
> 
> That's a good point. Originally, I had envisioned the possibility of
> calling bitmap_get_value8/bitmap_set_value8 at odd start offsets; this
> would open up the possibility of a clump landing as a split between 2
> words, thus requiring this complicated case handling code. However, I'm
> not sure how often users would need this case; none of the drivers right
> now require clumps at odd offsets.
> 
> Andy, would you have any objection to restricting the start offset
> values for bitmap_get_value8/bitmap_set_value8 to multiples of 8? That
> would prevent the split word case, and thus allow the implementation for
> those functions to be a lot simpler.

No, I have no objection.

-- 
With Best Regards,
Andy Shevchenko


