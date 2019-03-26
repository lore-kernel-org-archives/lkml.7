Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABBDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D1020823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbfCZNTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:19:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:20074 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfCZNTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:19:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="145350476"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2019 06:18:56 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1h8lyg-0003Gt-Sm; Tue, 26 Mar 2019 15:18:54 +0200
Date:   Tue, 26 Mar 2019 15:18:54 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
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
Message-ID: <20190326131854.GA9224@smile.fi.intel.com>
References: <20190326102843.GA10264@icarus>
 <20190326100743.GA10005@icarus>
 <20190326130319.cwn5zl4e222zh6ak@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326130319.cwn5zl4e222zh6ak@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:03:19PM +0100, Lukas Wunner wrote:
> On Tue, Mar 26, 2019 at 07:08:18PM +0900, William Breathitt Gray wrote:
> > On Tue, Mar 26, 2019 at 10:43:45AM +0100, Lukas Wunner wrote:

> > In this case, bitmap_get_value8 could be simplified to something like
> > this:
> > 
> >         index = BIT_WORD(start);
> >         offset = start % BITS_PER_LONG;
> >         return (bitmap[index] >> offset) & 0xFF;
> 

> Hm, shouldn't that be "offset = round_down(start, 8)" ?

No, the index points to the word, the offset points to the offset inside word.

> (I prefer the multi-line version FWIW.)

+1 here.

> > Would it be better to define bitmap_get_value8 as a macro then?
> 
> Or a static inline.

Please, no macro. It disadvantages in terms of type checking. 

-- 
With Best Regards,
Andy Shevchenko


