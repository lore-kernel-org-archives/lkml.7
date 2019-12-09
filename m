Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE320C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51082073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfLIQkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:40:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:32749 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfLIQkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:40:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 08:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="206950895"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2019 08:40:49 -0800
Received: from andy by smile with local (Exim 4.93-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ieM5Z-00013h-HF; Mon, 09 Dec 2019 18:40:49 +0200
Date:   Mon, 9 Dec 2019 18:40:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2 4/4] usb: host: xhci-tegra: Switch to use %ptT
Message-ID: <20191209164049.GM32742@smile.fi.intel.com>
References: <20191001134717.81282-1-andriy.shevchenko@linux.intel.com>
 <20191001134717.81282-5-andriy.shevchenko@linux.intel.com>
 <20191002113923.GP3716706@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002113923.GP3716706@ulmo>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 01:39:23PM +0200, Thierry Reding wrote:
> On Tue, Oct 01, 2019 at 04:47:17PM +0300, Andy Shevchenko wrote:
> > Use %ptT instead of open coded variant to print content of
> > time64_t type in human readable format.

> >  	timestamp = le32_to_cpu(header->fwimg_created_time);
> > -	time64_to_tm(timestamp, 0, &time);
> >  
> > -	dev_info(dev, "Firmware timestamp: %ld-%02d-%02d %02d:%02d:%02d UTC\n",
> > -		 time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
> > -		 time.tm_hour, time.tm_min, time.tm_sec);
> > +	dev_info(dev, "Firmware timestamp: %ptT UTC\n", &timestamp);
> 
> Can you please switch this to "Firmware timestamp: %ptTd %ptTt UTC\n" so
> that the string stays the same? As discussed earlier there may be issues
> if this string is changed. It may be unwise for someone to rely on the
> exact format of this kernel log string, but why risk potentially causing
> annoying changes in behaviour if we can easily avoid it?

I don't think it's worth to do, though if you are insisting...

-- 
With Best Regards,
Andy Shevchenko


