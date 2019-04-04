Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1729C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB46620855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfDDLwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:52:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:21597 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfDDLwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:52:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 04:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="334928114"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 04 Apr 2019 04:52:10 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hC0ue-0004xz-Qn; Thu, 04 Apr 2019 14:52:08 +0300
Date:   Thu, 4 Apr 2019 14:52:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        zhuchangchun <zhuchangchun@cvte.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hendychu@aliyun.coma,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
Message-ID: <20190404115208.GR9224@smile.fi.intel.com>
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
 <20190321092330.GK9224@smile.fi.intel.com>
 <140c6ec0-7c11-6aa9-8434-f14d77be9a8c@metux.net>
 <CACRpkdZ1xPJ=NS=o=-PYqCO4d-VVZM1=f=xBZa5Dwx78LFPYtA@mail.gmail.com>
 <cb643914-2c3f-0c63-13e4-8171fa9a37e7@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb643914-2c3f-0c63-13e4-8171fa9a37e7@metux.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:51:35PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 03.04.19 06:13, Linus Walleij wrote:
> 
> > But the chardev on the other hand will protect you from all this.> > If the program crashes, the lines will be free:ed.> > If two scripts
> try to access the same GPIO, they will be denied.
> Right, when you want this concurrency protection and cleanup stiff
> the chardev is the better choice. But I've already had several cases
> where the simplicity of the sysfs interface is a big win - all you need
> few trivial fs operations.
> 
> That's also nice for exporting in a grid, eg. via 9P (eg. nice for
> quickly building up HIL environments)
> 
> ioctls have the bad side effect that they can't be exported via
> network in a generic way - your remote fs protocol must support all of
> them - even worse: it needs to cope with overlapping ioctl-nr's that
> can have entirely different data structures depending on the actual
> device. And now try to do that w/ reasonable effort and w/o creating
> a shared memory between server and client :p
> 
> Another interesting usecase is permission handling:
> 
> a) some ioctls need special privileges (oh, how I hate all these "if
>    (!capable(CAP_SYS_ADMIN)) ..." lines in the drivers), but you wanna
>    give some unprivileged user access to them
> b) you wanna give an unprivileged user access to specific gpio's,
>    but not to all at once.
> 
> With pure filesystem based approach, you can easly define permissions
> for each filesystem object.

Also you may consider gpiod daemon and it's socket interface, for example.
Yes, complicated, but solves above problems AFAICT.

I guess the best person, missed in Cc, Bartosz, can tell more about user space
interaction.

And btw gpiod still a good to have for other even local cases:
https://github.com/brgl/libgpiod/issues/29
https://github.com/brgl/libgpiod/issues/40
...

> Yes, these usecases aren't so common for average Jon Doe, but the gpio
> subsystem is used that way, out there in the field, and it would be bad
> if that functionality would go away someday.

-- 
With Best Regards,
Andy Shevchenko


