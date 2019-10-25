Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C517CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A65121929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394496AbfJYKt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:49:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:28492 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392179AbfJYKt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:49:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 03:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="201777176"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 03:49:26 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNx9p-00048m-Gv; Fri, 25 Oct 2019 13:49:25 +0300
Date:   Fri, 25 Oct 2019 13:49:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Zhizhikin <andrey.z@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 2/2] mfd: add regulator cell to Cherry Trail Whiskey Cove
 PMIC
Message-ID: <20191025104925.GR32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-3-andrey.zhizhikin@leica-geosystems.com>
 <20191025080655.GF32742@smile.fi.intel.com>
 <CAHtQpK7P2X42WxZzok+XVZESV7O_JWK3Th7JMnMQsaq6f0gELw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHtQpK7P2X42WxZzok+XVZESV7O_JWK3Th7JMnMQsaq6f0gELw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:16:22AM +0200, Andrey Zhizhikin wrote:
> On Fri, Oct 25, 2019 at 10:07 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 24, 2019 at 02:29:39PM +0000, Andrey Zhizhikin wrote:
> > > Add a regulator mfd cell to Whiskey Cove PMIC driver, which is used to
> > > supply various voltage rails.
> > >
> > > In addition, make the initialization of this mfd driver early enough in
> > > order to provide regulator cell to mmc sub-system when it is initialized.
> >
> > Doesn't deferred probe mechanism work for you?
> > MMC core returns that error till we have the driver initialized.
> 
> This would work for mmc sub-system, but my idea was that later when
> more cells are added to this mfd - it might turn out that we would
> require an early initialization anyway. So I decided to take an
> opportunity to adjust it with this patch as well, and this is what I
> roughly explained in the commit message. When I'm reading it now,
> exactly this point was not mentioned in commit message at all, and I
> rather coupled the early init with mmc sub-system, which creates a
> source of confusion here. I guess if there would be no other
> objections about early init - I'd go with v2 of this patch, where I
> would clean-up the point below and adjust the commit description.
> 
> Thanks a lot for pointing this out!

> > > -static struct i2c_driver cht_wc_driver = {
> > > +static struct i2c_driver cht_wc_i2c_driver = {
> >
> > Renaming is not explained in the commit message.
> 
> True, this point I forgot to mention. Actually, this is tightly
> coupled with the fact that mfd driver has been moved to an earlier
> init stage and since it does belong to I2C sub-system (and represented
> by i2c_device structure) - I decided to make a name sound more
> logical.

So, seems you have three changes in one patch. Please, split accordingly.

In v2 also Cc all stakeholders I mentioned.

-- 
With Best Regards,
Andy Shevchenko


