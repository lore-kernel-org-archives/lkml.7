Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23606CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0089021929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394464AbfJYKrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:47:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:28335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390754AbfJYKrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:47:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 03:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="197991873"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 25 Oct 2019 03:47:18 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNx7l-00047J-4S; Fri, 25 Oct 2019 13:47:17 +0300
Date:   Fri, 25 Oct 2019 13:47:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Zhizhikin <andrey.z@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, lgirdwood@gmail.com,
        broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 1/2] regulator: add support for Intel Cherry Whiskey Cove
 regulator
Message-ID: <20191025104717.GQ32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com>
 <20191025080129.GE32742@smile.fi.intel.com>
 <CAHtQpK7e-W9cGyCan=yxM7sSN=L_SKaFy8DSNE4vQGrc_pFdQw@mail.gmail.com>
 <20191025091430.GJ32742@smile.fi.intel.com>
 <CAHtQpK4r6ELeT78y8+hrYYDuuhqVx9Xj2=t=D+0X9UF_cOpYFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHtQpK4r6ELeT78y8+hrYYDuuhqVx9Xj2=t=D+0X9UF_cOpYFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:31:50AM +0200, Andrey Zhizhikin wrote:
> On Fri, Oct 25, 2019 at 11:14 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Oct 25, 2019 at 10:58:05AM +0200, Andrey Zhizhikin wrote:
> > > On Fri, Oct 25, 2019 at 10:01 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
> > > > > Add regulator driver for Intel Cherry Trail Whiskey Cove PMIC, which
> > > > > supplies various voltage rails.
> > > > >
> > > > > This initial version supports only vsdio, which is required to source
> > > > > vqmmc for sd card interface.
> > > >
> > > > This patch has some style issues. I will wait for Adrian and Hans to comment on
> > > > the approach as a whole and then we will see how to improve the rest.
> > >
> > > Agreed, styling issues are coming from definition of CHT_WC_REGULATOR
> > > elements in regulators_info array, and they are mainly related to 80
> > > characters per line. I decided to leave it like this since it is more
> > > readable. But if the 80 characters rule is to be enforced here - I can
> > > go with something like this for every element:
> > > CHT_WC_REGULATOR(V3P3A,    3000, 3350, 0x00, 0x07,\
> > >                                      50, 0x01, 0x01, 0x0, true,  NULL),
> >
> > No, I'm not talking about these. Actually I hate this 80 limit in 21st century.
> > But let's not discuss it right now.
> 
> I just ran a checkpatch and I think I know what you're referring to:
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> In this case I really have to wait what others have to say, since I do
> not know who and how the maintainer would be assigned.

Neither this :-) Whoever it's an interesting warning from checkpatch.

-- 
With Best Regards,
Andy Shevchenko


