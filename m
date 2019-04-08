Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536A120883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfDHKJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:09:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:16373 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDHKJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:09:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 03:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="138453667"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2019 03:09:48 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hDRDn-0006e0-HG; Mon, 08 Apr 2019 13:09:47 +0300
Date:   Mon, 8 Apr 2019 13:09:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Chris Chiu <chiu@endlessm.com>, heikki.krogerus@linux.intel.com,
        drake@endlessm.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: Re: [PATCH] pinctrl:intel: Retain HOSTSW_OWN for requested gpio pin
Message-ID: <20190408100947.GI9224@smile.fi.intel.com>
References: <20190408042103.3804-1-chiu@endlessm.com>
 <20190408074106.GC3622@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408074106.GC3622@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:41:06AM +0300, Mika Westerberg wrote:
> On Mon, Apr 08, 2019 at 12:21:03PM +0800, Chris Chiu wrote:
> > +static void

static u32

(see below why)

> > +intel_gpio_update_pad_mode(void __iomem *hostown, u32 mask, u32 value)
> > +{
> > +	u32 curr = readl(hostown);
> > +	u32 updated = (curr & ~mask) | (value & mask);
> 
> I think here we should first complain if the expected ownership is not
> correct. Warning or info level probably enough.

It is easy to achieve, something like

if ((value ^ saved) & requeted)
	dev_warn(...);

See also below.

(I had mentioned this earlier)

> > +	return writel(updated, hostown);

writel() is a void function, this is wrong. We need to return curr instead to
make above working to issue a warning message.

> Also if the pin is not requested and not changed we should not touch the
> register.

I don't think it brings any value here, if mask is 0 we will write back the
same value we read.

> Otherwise this looks good to me.

-- 
With Best Regards,
Andy Shevchenko


