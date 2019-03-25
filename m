Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBDAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2E520850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfCYLsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:48:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:4584 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbfCYLsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:48:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 04:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="331757868"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2019 04:48:13 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8O5M-00058N-GF; Mon, 25 Mar 2019 13:48:12 +0200
Date:   Mon, 25 Mar 2019 13:48:12 +0200
From:   "andriy.shevchenko" <andriy.shevchenko@linux.intel.com>
To:     "zhuchangchun@cvte.com" <zhuchangchun@cvte.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linus.walleij" <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        hendychu <hendychu@aliyun.com>
Subject: Re: Re: [PATCH] pinctrl: intel: Implements gpio free function
Message-ID: <20190325114812.GO9224@smile.fi.intel.com>
References: <20190321120324.GI3622@lahna.fi.intel.com>
 <2019032120213955866649@cvte.com>
 <20190321123637.GJ3622@lahna.fi.intel.com>
 <2019032121342663125658@cvte.com>
 <20190321135642.GK3622@lahna.fi.intel.com>
 <2019032211131426883268@cvte.com>
 <20190322104242.GV3622@lahna.fi.intel.com>
 <2019032314505202825175@cvte.com>
 <20190323164810.GE9224@smile.fi.intel.com>
 <2019032517511048990383@cvte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2019032517511048990383@cvte.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:52:10PM +0800, zhuchangchun@cvte.com wrote:
> On Sat, Mar 23, 2019 at 02:51:52PM +0800, zhuchangchun@cvte.com wrote:
> > On Fri, Mar 22, 2019 at 11:14:14AM +0800, zhuchangchun@cvte.com wrote:
>  
> > >    From above,you can kown when you export a GPIO ,it will do request,
> > >
> > >    and there will set TX and RX register at the time same time.
> > >
> > >    when you try to set direction in and set value, TX register value can
> > >    roll back
> > >
> > >    the value,but RX register was not set, so who will set RX value back??
> > 
> > I think you are looking at some older code. There is now function
> > __intel_gpio_set_direction() that is supposed to set both buffers
> > depending on the direction. It was introduced with commit 17fab473693e
> > ("pinctrl: intel: Set pin direction properly").
> >
> >
> > --> Yes ,I see the latest master branch, the __intel_gpio_set_direction will
> > set RX and TX, but I still think we need to implement free function,cause
> > it will help many other engineers,especailly for some manufactories use some
> > module,and this modules embeded its own driver but not can be modified,
> > if they want use the gpio control the module, they may meet the same problem.
>  
> What problem?
> Is it reproducible on latest vanilla kernel?
> 
> --> Not yet, I mean if someone use export GPIO ,then forget to set direction in, 
> and then set GPIO unexport directly, the GPIO buffer status may influence 
> the device work flow.

If you would like to return pin back to the previous state, it should be done
in generic way in the pin control subsystem.

Since there is no problem, nothing to fix then.

-- 
With Best Regards,
Andy Shevchenko


