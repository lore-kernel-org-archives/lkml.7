Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D147BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FE2218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfCUJXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:23:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:16889 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfCUJXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:23:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 02:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="scan'208";a="135948047"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 21 Mar 2019 02:23:31 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h6tv8-0001vw-1y; Thu, 21 Mar 2019 11:23:30 +0200
Date:   Thu, 21 Mar 2019 11:23:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     zhuchangchun <zhuchangchun@cvte.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hendychu@aliyun.com
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
Message-ID: <20190321092330.GK9224@smile.fi.intel.com>
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321084420.GG3622@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:44:20AM +0200, Mika Westerberg wrote:
> On Thu, Mar 21, 2019 at 10:35:24AM +0800, zhuchangchun wrote:
> > When we use the gpio to control some peripheral devices,and try to
> > export the gpio first,then unexport the gpio, we test the signal with
> > oscilloscope,and find the signal can't meet the requirements,because
> > after we unexported the gpio,the gpio's register(tx and rx)value can't
> > be recovered,and this will infruence the device work flow.
> 
> After you unexport GPIO it can go back to any previous mode it was. If
> you need to use it as GPIO then why unexport it in the first place?

...and on top of that GPIO sysfs interface is deprecated.

> > We check the gpio's unexport code work flow, then find the gpio's free
> > hook function has not been implemented, After we add pinmux_ops' free
> > function to set exported gpio to recover its original value,the problem
> > is fixed.
> 
> I don't think this is what ->free callback should do (assuming we decide
> to implement it since we don't implement ->release either). It is
> supposed to reverse effects of ->request which is what it currently does ;-)

Exactly!

-- 
With Best Regards,
Andy Shevchenko


