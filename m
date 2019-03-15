Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C66C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0F821871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfCONOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:14:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:24672 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbfCONOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:14:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 06:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="134323309"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2019 06:14:37 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h4mfT-0000Uh-Vz; Fri, 15 Mar 2019 15:14:35 +0200
Date:   Fri, 15 Mar 2019 15:14:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Simon Horman <horms@verge.net.au>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/7] i2c: busses: omap: Add the
 master_xfer_irqless hook
Message-ID: <20190315131435.GE9224@smile.fi.intel.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-6-wsa+renesas@sang-engineering.com>
 <20190315124717.x3do5evok5syipo7@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315124717.x3do5evok5syipo7@verge.net.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 01:47:18PM +0100, Simon Horman wrote:
> On Sat, Mar 02, 2019 at 02:47:33PM +0100, Wolfram Sang wrote:

> > +	if (!polling) {
> > +		timeout = wait_for_completion_timeout(&omap->cmd_complete,
> > +						      OMAP_I2C_TIMEOUT);
> > +	} else {
> > +		do {
> > +			omap_i2c_wait(omap);
> > +			ret = omap_i2c_xfer_data(omap);
> > +		} while (ret == -EAGAIN);
> > +
> > +		if (!ret)
> > +			timeout = 1;
> > +		else
> > +			timeout = 0;
> 
> 
> nit: the following might be cleaner
> 
> 		ret = !!timeout;
> 

Other way around, perhaps,

      timeout = !ret;

> > +	}

-- 
With Best Regards,
Andy Shevchenko


