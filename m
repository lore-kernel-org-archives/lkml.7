Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4AAECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D6721920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbfJAMft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:35:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:54020 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJAMfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:35:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 05:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="197841640"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2019 05:35:46 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iFHNZ-0000G9-Dp; Tue, 01 Oct 2019 15:35:45 +0300
Date:   Tue, 1 Oct 2019 15:35:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 4/4] usb: host: xhci-tegra: Switch to use %ptT
Message-ID: <20191001123545.GM32742@smile.fi.intel.com>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190104193009.30907-4-andriy.shevchenko@linux.intel.com>
 <20191001115640.GJ32742@smile.fi.intel.com>
 <99fa90e8-3188-6781-dcbd-89e29e8509eb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99fa90e8-3188-6781-dcbd-89e29e8509eb@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 03:20:46PM +0300, Mathias Nyman wrote:
> On 1.10.2019 14.56, Andy Shevchenko wrote:
> > On Fri, Jan 04, 2019 at 09:30:09PM +0200, Andy Shevchenko wrote:
> > > Use %ptT instead of open coded variant to print content of
> > > time64_t type in human readable format.
> > 
> > Any comments on this?
> 
> Untested, but looks ok to me.

Thanks!

> xhci-tegra.c is written by Thierry Reding, so its more up to him

Thierry, do you have any objections here?

> 
> > 
> > > 
> > > Cc: Mathias Nyman <mathias.nyman@intel.com>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >   drivers/usb/host/xhci-tegra.c | 6 +-----
> > >   1 file changed, 1 insertion(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> > > index 938ff06c0349..ed3eea3876e2 100644
> > > --- a/drivers/usb/host/xhci-tegra.c
> > > +++ b/drivers/usb/host/xhci-tegra.c
> > > @@ -820,7 +820,6 @@ static int tegra_xusb_load_firmware(struct tegra_xusb *tegra)
> > >   	const struct firmware *fw;
> > >   	unsigned long timeout;
> > >   	time64_t timestamp;
> > > -	struct tm time;
> > >   	u64 address;
> > >   	u32 value;
> > >   	int err;
> > > @@ -925,11 +924,8 @@ static int tegra_xusb_load_firmware(struct tegra_xusb *tegra)
> > >   	}
> > >   	timestamp = le32_to_cpu(header->fwimg_created_time);
> > > -	time64_to_tm(timestamp, 0, &time);
> > > -	dev_info(dev, "Firmware timestamp: %ld-%02d-%02d %02d:%02d:%02d UTC\n",
> > > -		 time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
> > > -		 time.tm_hour, time.tm_min, time.tm_sec);
> > > +	dev_info(dev, "Firmware timestamp: %ptT UTC\n", &timestamp);
> > >   	return 0;
> > >   }
> > > -- 
> > > 2.19.2
> > > 
> > 
> 

-- 
With Best Regards,
Andy Shevchenko


