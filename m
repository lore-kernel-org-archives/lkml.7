Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9EDECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCBB2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfIKJVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:21:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:3346 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfIKJVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:21:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 02:21:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="360082463"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2019 02:21:43 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1i7yoo-0005Ii-4t; Wed, 11 Sep 2019 12:21:42 +0300
Date:   Wed, 11 Sep 2019 12:21:42 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4 06/14] software node: get rid of property_set_pointer()
Message-ID: <20190911092142.GL2680@smile.fi.intel.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
 <20190911051231.148032-7-dmitry.torokhov@gmail.com>
 <CAHp75Ve5NvhzOQ96OgbPh1LdsAtvk+A=aVu-oXKdhnB4PpL_og@mail.gmail.com>
 <20190911083725.GF145199@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911083725.GF145199@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 01:37:25AM -0700, Dmitry Torokhov wrote:
> On Wed, Sep 11, 2019 at 11:29:10AM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 11, 2019 at 8:15 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Instead of explicitly setting values of integer types when copying
> > > property entries lets just copy entire value union when processing
> > > non-array values.
> > >
> > > When handling array values assign the pointer there using the newly
> > > introduced "raw" pointer union member. This allows us to remove
> > > property_set_pointer().
> > >
> > > In property_get_pointer() we do not need to handle each data type
> > > separately, we can simply return either the raw pointer or pointer to
> > > values union.
> > 
> > Same as before, typechecking is good thing to have for my point of view.
> > Others may have different opinions.
> 
> OK, I'll just point out that typechecking is a red herring here as
> everything was and still is accessed through void pointers, and we
> trusted the type set on property. Users of static properties should use
> PROPERTY_ENTRY_XXX() for initialization and do not poke into struct
> property_entry directly.
> 
> I suppose it is up to Rafael to decide here.

Yes, and perhaps Mika as they were the main authors of the idea and
implementation.

-- 
With Best Regards,
Andy Shevchenko


